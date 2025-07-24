using System;
using System.Configuration;
using MySql.Data.MySqlClient;

namespace WebApplication2
{
    public partial class EditarDonacion : System.Web.UI.Page
    {
        private readonly string cadena =
            ConfigurationManager.ConnectionStrings["conexionDatos"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack && Request.QueryString["id"] != null)
            {
                hdnId.Value = Request.QueryString["id"];
                CargarDonantes();
                CargarDatos(int.Parse(hdnId.Value));
            }
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

        private void CargarDatos(int id)
        {
            using (var cn = new MySqlConnection(cadena))
            using (var cmd = new MySqlCommand("sp_consultar_donacion_por_id", cn))
            {
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("p_id", id);
                cn.Open();
                using (var dr = cmd.ExecuteReader())
                {
                    if (dr.Read())
                    {
                        ddlUsuario.SelectedValue = dr["id_usuario"].ToString();
                        txtMonto.Text = dr["monto"].ToString();
                        txtDescripcion.Text = dr["descripcion"].ToString();
                        txtFecha.Text = Convert.ToDateTime(
                            dr["fecha"]).ToString("yyyy-MM-dd");
                    }
                }
            }
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            int id = int.Parse(hdnId.Value);
            using (var cn = new MySqlConnection(cadena))
            using (var cmd = new MySqlCommand("sp_actualizar_donacion", cn))
            {
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("p_id", id);
                cmd.Parameters.AddWithValue("p_id_usuario", ddlUsuario.SelectedValue);
                cmd.Parameters.AddWithValue("p_monto", txtMonto.Text.Trim());
                cmd.Parameters.AddWithValue("p_descripcion", txtDescripcion.Text.Trim());
                cmd.Parameters.AddWithValue("p_fecha", txtFecha.Text.Trim());
                cn.Open();
                cmd.ExecuteNonQuery();
            }
            Session["mensaje"] = "Donación actualizada.";
            Response.Redirect("ListadoDonacion.aspx", true);
        }

        protected void btnCancelar_Click(object sender, EventArgs e)
            => Response.Redirect("ListadoDonacion.aspx", true);
    }
}
