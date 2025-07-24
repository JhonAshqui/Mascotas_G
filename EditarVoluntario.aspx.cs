using System;
using System.Configuration;
using MySql.Data.MySqlClient;

namespace WebApplication2
{
    public partial class EditarVoluntario : System.Web.UI.Page
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
            // Usuarios tipo 'Voluntario'
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

            // Refugios
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

        private void CargarDatos(int id)
        {
            using (var cn = new MySqlConnection(cadena))
            using (var cmd = new MySqlCommand("sp_consultar_voluntario_por_id", cn))
            {
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("p_id_voluntario", id);
                cn.Open();
                using (var dr = cmd.ExecuteReader())
                {
                    if (dr.Read())
                    {
                        ddlUsuario.SelectedValue = dr["id_usuario"].ToString();
                        ddlRefugio.SelectedValue = dr["id_refugio"].ToString();
                        txtActividad.Text = dr["actividad"].ToString();
                        txtFrecuencia.Text = dr["frecuencia"].ToString();
                        txtHorario.Text = dr["horario"].ToString();
                    }
                }
            }
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            int id = int.Parse(hdnId.Value);
            using (var cn = new MySqlConnection(cadena))
            using (var cmd = new MySqlCommand("sp_actualizar_voluntario", cn))
            {
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("p_id_voluntario", id);
                cmd.Parameters.AddWithValue("p_id_usuario", ddlUsuario.SelectedValue);
                cmd.Parameters.AddWithValue("p_id_refugio", ddlRefugio.SelectedValue);
                cmd.Parameters.AddWithValue("p_actividad", txtActividad.Text.Trim());
                cmd.Parameters.AddWithValue("p_frecuencia", txtFrecuencia.Text.Trim());
                cmd.Parameters.AddWithValue("p_horario", txtHorario.Text.Trim());

                cn.Open();
                cmd.ExecuteNonQuery();
            }

            Session["mensaje"] = "Voluntario actualizado correctamente.";
            Response.Redirect("ListadoVoluntario.aspx", true);
        }

        protected void btnCancelar_Click(object sender, EventArgs e)
            => Response.Redirect("ListadoVoluntario.aspx", true);
    }
}
