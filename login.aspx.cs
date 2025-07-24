using System;
using System.Data;
using System.Configuration; // necesario para leer Web.config
using MySql.Data.MySqlClient;

namespace WebApplication2
{
    public partial class login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string usuario = txtUsuario.Text.Trim();
            string clave = txtClave.Text.Trim();

            // Usar la cadena del Web.config
            string connectionString = ConfigurationManager.ConnectionStrings["conexionDatos"].ConnectionString;

            using (MySqlConnection conn = new MySqlConnection(connectionString))
            {
                conn.Open();
                string query = "SELECT * FROM usuarioss WHERE usuario=@usuario AND clave=@clave AND estado=1";
                using (MySqlCommand cmd = new MySqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@usuario", usuario);
                    cmd.Parameters.AddWithValue("@clave", clave);

                    using (MySqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            Session["usuario"] = reader["usuario"].ToString();
                            Session["rol"] = reader["rol"].ToString();
                            Response.Redirect("dashboard.aspx");
                        }
                        else
                        {
                            lblMensaje.Text = "Usuario o contraseña incorrectos.";
                        }
                    }
                }
            }
        }
    }
}
