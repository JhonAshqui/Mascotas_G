using System;
using System.Configuration;
using MySql.Data.MySqlClient;

namespace WebApplication2
{
    public partial class AgregarAdopcion : System.Web.UI.Page
    {
        private readonly string cadena =
            ConfigurationManager.ConnectionStrings["conexionDatos"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            // Validación de sesión y rol
            if (Session["usuario"] == null || Session["rol"] == null || Session["rol"].ToString() != "administrador")
            {
                Response.Redirect("login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                CargarAnimales();
                CargarAdoptantes();
            }
        }

        private void CargarAnimales()
        {
            using (var cn = new MySqlConnection(cadena))
            using (var cmd = new MySqlCommand(
                "SELECT id_animal,nombre FROM animal ORDER BY nombre", cn))
            {
                cn.Open();
                ddlAnimal.DataSource = cmd.ExecuteReader();
                ddlAnimal.DataTextField = "nombre";
                ddlAnimal.DataValueField = "id_animal";
                ddlAnimal.DataBind();
            }
        }

        private void CargarAdoptantes()
        {
            // Si usas el SP:
            // using (var cmd = new MySqlCommand("sp_consultar_usuarios_adoptantes", cn))
            // { cmd.CommandType = CommandType.StoredProcedure; ... }

            using (var cn = new MySqlConnection(cadena))
            using (var cmd = new MySqlCommand(
                "SELECT id_usuario,nombre FROM usuario " +
                "WHERE tipo_usuario = 'Adoptante' ORDER BY nombre", cn))
            {
                cn.Open();
                ddlUsuario.DataSource = cmd.ExecuteReader();
                ddlUsuario.DataTextField = "nombre";
                ddlUsuario.DataValueField = "id_usuario";
                ddlUsuario.DataBind();
            }
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            using (var cn = new MySqlConnection(cadena))
            using (var cmd = new MySqlCommand("sp_crear_adopcion", cn))
            {
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("p_id_animal", ddlAnimal.SelectedValue);
                cmd.Parameters.AddWithValue("p_id_usuario", ddlUsuario.SelectedValue);
                cmd.Parameters.AddWithValue("p_fecha", txtFecha.Text.Trim());
                cmd.Parameters.AddWithValue("p_estado", ddlEstado.SelectedValue);
                cmd.Parameters.AddWithValue("p_comentarios", txtComentarios.Text.Trim());

                cn.Open();
                cmd.ExecuteNonQuery();
            }

            Session["mensaje"] = "Adopción registrada correctamente.";
            Response.Redirect("ListadoAdopcion.aspx", true);
        }

        protected void btnCancelar_Click(object sender, EventArgs e)
            => Response.Redirect("ListadoAdopcion.aspx", true);
    }
}
