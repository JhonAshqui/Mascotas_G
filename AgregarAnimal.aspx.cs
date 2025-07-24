using System;
using System.Configuration;
using MySql.Data.MySqlClient;

namespace WebApplication2
{
    public partial class AgregarAnimal : System.Web.UI.Page
    {
        private readonly string cadena =
            ConfigurationManager.ConnectionStrings["conexionDatos"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            // Protección: solo administradores logueados pueden entrar
            if (Session["usuario"] == null || Session["rol"] == null || Session["rol"].ToString() != "administrador")
            {
                Response.Redirect("login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                // Cargar dropdown de refugios
                using (var cn = new MySqlConnection(cadena))
                using (var cmd = new MySqlCommand("SELECT id_refugio, nombre FROM refugio", cn))
                {
                    cn.Open();
                    ddlRefugio.DataSource = cmd.ExecuteReader();
                    ddlRefugio.DataTextField = "nombre";
                    ddlRefugio.DataValueField = "id_refugio";
                    ddlRefugio.DataBind();
                }
            }
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            // 1) Procesar subida de imagen
            string rutaFoto = "";
            if (fuFoto.HasFile)
            {
                string ext = System.IO.Path.GetExtension(fuFoto.FileName).ToLower();
                string nombre = Guid.NewGuid() + ext;
                string carpeta = Server.MapPath("~/Uploads/Animals/");
                if (!System.IO.Directory.Exists(carpeta))
                    System.IO.Directory.CreateDirectory(carpeta);
                fuFoto.SaveAs(System.IO.Path.Combine(carpeta, nombre));
                rutaFoto = "/Uploads/Animals/" + nombre;
            }

            // 2) Llamar SP para insertar
            using (var cn = new MySqlConnection(cadena))
            using (var cmd = new MySqlCommand("sp_crear_animal", cn))
            {
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("p_nombre", txtNombre.Text.Trim());
                cmd.Parameters.AddWithValue("p_especie", txtEspecie.Text.Trim());
                cmd.Parameters.AddWithValue("p_raza", txtRaza.Text.Trim());
                cmd.Parameters.AddWithValue("p_edad", txtEdad.Text.Trim());
                cmd.Parameters.AddWithValue("p_sexo", ddlSexo.SelectedValue);
                cmd.Parameters.AddWithValue("p_estado_salud", txtEstadoSalud.Text.Trim());
                cmd.Parameters.AddWithValue("p_fecha_ingreso", txtFechaIngreso.Text.Trim());
                cmd.Parameters.AddWithValue("p_estado", ddlEstado.SelectedValue);
                cmd.Parameters.AddWithValue("p_foto_url", rutaFoto);
                cmd.Parameters.AddWithValue("p_id_refugio", ddlRefugio.SelectedValue);

                cn.Open();
                cmd.ExecuteNonQuery();
            }

            Session["mensaje"] = "Animal agregado correctamente.";
            Response.Redirect("ListadoAnimal.aspx", true);
        }

        protected void btnCancelar_Click(object sender, EventArgs e)
            => Response.Redirect("ListadoAnimal.aspx", true);
    }
}
