using System;
using System.Configuration;
using System.Data;
using MySql.Data.MySqlClient;

namespace WebApplication2
{
    public partial class AgregarRefugio : System.Web.UI.Page
    {
        private readonly string cadena =
            ConfigurationManager.ConnectionStrings["conexionDatos"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["usuario"] == null || Session["rol"] == null || Session["rol"].ToString() != "administrador")
            {
                Response.Redirect("login.aspx");
                return;
            }
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            using (var cn = new MySqlConnection(cadena))
            using (var cmd = new MySqlCommand("sp_crear_refugio", cn))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("p_nombre", txtNombre.Text.Trim());
                cmd.Parameters.AddWithValue("p_direccion", txtDireccion.Text.Trim());
                cmd.Parameters.AddWithValue("p_telefono", txtTelefono.Text.Trim());
                cmd.Parameters.AddWithValue("p_email", txtEmail.Text.Trim());
                cmd.Parameters.AddWithValue("p_responsable", txtResponsable.Text.Trim());

                cn.Open();
                cmd.ExecuteNonQuery();
            }

            Session["mensaje"] = "Refugio agregado correctamente.";
            Response.Redirect("ListadoRefujio.aspx", true);
        }

        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            Response.Redirect("ListadoRefujio.aspx", true);
        }
    }
}
