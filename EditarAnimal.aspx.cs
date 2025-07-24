using System;
using System.Configuration;
using MySql.Data.MySqlClient;

namespace WebApplication2
{
    public partial class EditarAnimal : System.Web.UI.Page
    {
        private readonly string cadena =
            ConfigurationManager.ConnectionStrings["conexionDatos"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack && Request.QueryString["id"] != null)
            {
                hdnId.Value = Request.QueryString["id"];
                CargarRefugios();
                CargarDatos(int.Parse(hdnId.Value));
            }
        }

        private void CargarRefugios()
        {
            using (var cn = new MySqlConnection(cadena))
            using (var cmd = new MySqlCommand("SELECT id_refugio, nombre FROM refugio", cn))
            {
                cn.Open();
                ddlRefugio.DataSource = cmd.ExecuteReader();
                ddlRefugio.DataBind();
            }
        }

        private void CargarDatos(int id)
        {
            using (var cn = new MySqlConnection(cadena))
            using (var cmd = new MySqlCommand("sp_consultar_animal_por_id", cn))
            {
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("p_id", id);
                cn.Open();
                using (var dr = cmd.ExecuteReader())
                {
                    if (dr.Read())
                    {
                        txtNombre.Text = dr["nombre"].ToString();
                        txtEspecie.Text = dr["especie"].ToString();
                        txtRaza.Text = dr["raza"].ToString();
                        txtEdad.Text = dr["edad"].ToString();
                        ddlSexo.SelectedValue = dr["sexo"].ToString();
                        txtEstadoSalud.Text = dr["estado_salud"].ToString();
                        txtFechaIngreso.Text = Convert.ToDateTime(
                            dr["fecha_ingreso"]).ToString("yyyy-MM-dd");
                        ddlEstado.SelectedValue = dr["estado"].ToString();
                        imgActual.ImageUrl = dr["foto_url"].ToString();
                        ddlRefugio.SelectedValue = dr["id_refugio"].ToString();
                    }
                }
            }
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            // Ruta por defecto = actual
            string rutaFoto = imgActual.ImageUrl;
            // Si cargó nueva foto...
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

            // Actualizar SP
            int id = int.Parse(hdnId.Value);
            using (var cn = new MySqlConnection(cadena))
            using (var cmd = new MySqlCommand("sp_actualizar_animal", cn))
            {
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("p_id", id);

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

            Session["mensaje"] = "Animal actualizado correctamente.";
            Response.Redirect("ListadoAnimal.aspx", true);
        }

        protected void btnCancelar_Click(object sender, EventArgs e)
            => Response.Redirect("ListadoAnimal.aspx", true);
    }
}
