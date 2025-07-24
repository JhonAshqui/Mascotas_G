using System;
using System.Configuration;
using MySql.Data.MySqlClient;

namespace WebApplication2
{
    public partial class AgregarVoluntario : System.Web.UI.Page
    {
        private readonly string cadena =
            ConfigurationManager.ConnectionStrings["conexionDatos"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            // Validar si el usuario está logueado y es administrador
            if (Session["usuario"] == null || Session["rol"] == null || Session["rol"].ToString() != "administrador")
            {
                // Redirigir a login o página pública
                Response.Redirect("login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                CargarUsuarios();
                CargarRefugios();
            }
        }

        private void CargarUsuarios()
        {
            using (var cn = new MySqlConnection(cadena))
            using (var cmd = new MySqlCommand(
                "SELECT id_usuario,nombre FROM usuario " +
                "WHERE tipo_usuario = 'Voluntario' ORDER BY nombre", cn))
            {
                cn.Open();
                ddlUsuario.DataSource = cmd.ExecuteReader();
                ddlUsuario.DataTextField = "nombre";
                ddlUsuario.DataValueField = "id_usuario";
                ddlUsuario.DataBind();
            }
        }

        private void CargarRefugios()
        {
            using (var cn = new MySqlConnection(cadena))
            using (var cmd = new MySqlCommand(
                "SELECT id_refugio,nombre FROM refugio ORDER BY nombre", cn))
            {
                cn.Open();
                ddlRefugio.DataSource = cmd.ExecuteReader();
                ddlRefugio.DataTextField = "nombre";
                ddlRefugio.DataValueField = "id_refugio";
                ddlRefugio.DataBind();
            }
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            using (var cn = new MySqlConnection(cadena))
            using (var cmd = new MySqlCommand("sp_crear_voluntario", cn))
            {
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("p_id_usuario", ddlUsuario.SelectedValue);
                cmd.Parameters.AddWithValue("p_id_refugio", ddlRefugio.SelectedValue);
                cmd.Parameters.AddWithValue("p_actividad", txtActividad.Text.Trim());
                cmd.Parameters.AddWithValue("p_frecuencia", txtFrecuencia.Text.Trim());
                cmd.Parameters.AddWithValue("p_horario", txtHorario.Text.Trim());

                cn.Open();
                cmd.ExecuteNonQuery();
            }

            Session["mensaje"] = "Voluntario agregado correctamente.";
            Response.Redirect("ListadoVoluntario.aspx", true);
        }

        protected void btnCancelar_Click(object sender, EventArgs e)
            => Response.Redirect("ListadoVoluntario.aspx", true);
    }
}
