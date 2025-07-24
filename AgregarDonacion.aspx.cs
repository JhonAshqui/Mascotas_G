using System;
using System.Configuration;
using MySql.Data.MySqlClient;

namespace WebApplication2
{
    public partial class AgregarDonacion : System.Web.UI.Page
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

            if (!IsPostBack) CargarDonantes();
        }

        private void CargarDonantes()
        {
            using (var cn = new MySqlConnection(cadena))
            using (var cmd = new MySqlCommand(
                "SELECT id_usuario,nombre FROM usuario " +
                "WHERE tipo_usuario='Donante' ORDER BY nombre", cn))
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
            using (var cmd = new MySqlCommand("sp_crear_donacion", cn))
            {
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("p_id_usuario", ddlUsuario.SelectedValue);
                cmd.Parameters.AddWithValue("p_monto", txtMonto.Text.Trim());
                cmd.Parameters.AddWithValue("p_descripcion", txtDescripcion.Text.Trim());
                cmd.Parameters.AddWithValue("p_fecha", txtFecha.Text.Trim());
                cn.Open();
                cmd.ExecuteNonQuery();
            }
            Session["mensaje"] = "Donación registrada.";
            Response.Redirect("ListadoDonacion.aspx", true);
        }

        protected void btnCancelar_Click(object sender, EventArgs e)
            => Response.Redirect("ListadoDonacion.aspx", true);
    }
}
