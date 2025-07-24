using System;
using System.Configuration;
using MySql.Data.MySqlClient;

namespace WebApplication2
{
    public partial class EditarAdopcion : System.Web.UI.Page
    {
        private readonly string cadena =
            ConfigurationManager.ConnectionStrings["conexionDatos"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack && Request.QueryString["id"] != null)
            {
                hdnId.Value = Request.QueryString["id"];
                CargarListas();
                CargarDatos(int.Parse(hdnId.Value));
            }
        }

        private void CargarListas()
        {
            // animales
            using (var cn = new MySqlConnection(cadena))
            using (var cmd = new MySqlCommand("SELECT id_animal,nombre FROM animal", cn))
            {
                cn.Open();
                ddlAnimal.DataSource = cmd.ExecuteReader();
                ddlAnimal.DataTextField = "nombre";
                ddlAnimal.DataValueField = "id_animal";
                ddlAnimal.DataBind();
            }
            // usuarios
            using (var cn = new MySqlConnection(cadena))
            using (var cmd = new MySqlCommand("SELECT id_usuario,nombre FROM usuario", cn))
            {
                cn.Open();
                ddlUsuario.DataSource = cmd.ExecuteReader();
                ddlUsuario.DataTextField = "nombre";
                ddlUsuario.DataValueField = "id_usuario";
                ddlUsuario.DataBind();
            }
        }

        private void CargarDatos(int id)
        {
            using (var cn = new MySqlConnection(cadena))
            using (var cmd = new MySqlCommand("sp_consultar_adopcion_por_id", cn))
            {
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("p_id", id);
                cn.Open();
                using (var dr = cmd.ExecuteReader())
                {
                    if (dr.Read())
                    {
                        ddlAnimal.SelectedValue = dr["id_animal"].ToString();
                        ddlUsuario.SelectedValue = dr["id_usuario"].ToString();
                        txtFecha.Text = Convert.ToDateTime(
                          dr["fecha_adopcion"]).ToString("yyyy-MM-dd");
                        ddlEstado.SelectedValue = dr["estado"].ToString();
                        txtComentarios.Text = dr["comentarios"].ToString();
                    }
                }
            }
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            int id = int.Parse(hdnId.Value);
            using (var cn = new MySqlConnection(cadena))
            using (var cmd = new MySqlCommand("sp_actualizar_adopcion", cn))
            {
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("p_id", id);
                cmd.Parameters.AddWithValue("p_id_animal", ddlAnimal.SelectedValue);
                cmd.Parameters.AddWithValue("p_id_usuario", ddlUsuario.SelectedValue);
                cmd.Parameters.AddWithValue("p_fecha", txtFecha.Text.Trim());
                cmd.Parameters.AddWithValue("p_estado", ddlEstado.SelectedValue);
                cmd.Parameters.AddWithValue("p_comentarios", txtComentarios.Text.Trim());

                cn.Open();
                cmd.ExecuteNonQuery();
            }

            Session["mensaje"] = "Adopción actualizada correctamente.";
            Response.Redirect("ListadoAdopcion.aspx", true);
        }

        protected void btnCancelar_Click(object sender, EventArgs e)
            => Response.Redirect("ListadoAdopcion.aspx", true);
    }
}
