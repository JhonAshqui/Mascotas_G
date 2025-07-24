using System;
using System.Configuration;
using System.Data;
using MySql.Data.MySqlClient;

namespace WebApplication2
{
    public partial class EditarRefugio : System.Web.UI.Page
    {
        private readonly string cadena =
            ConfigurationManager.ConnectionStrings["conexionDatos"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack && Request.QueryString["id"] != null)
            {
                // guarda el id en el HiddenField
                hdnId.Value = Request.QueryString["id"];
                CargarDatos(int.Parse(hdnId.Value));
            }
        }

        private void CargarDatos(int id)
        {
            using (var cn = new MySqlConnection(cadena))
            using (var cmd = new MySqlCommand("sp_consultar_refugio_por_id", cn))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("p_id", id);
                cn.Open();
                using (var dr = cmd.ExecuteReader())
                {
                    if (dr.Read())
                    {
                        txtNombre.Text = dr["nombre"].ToString();
                        txtDireccion.Text = dr["direccion"].ToString();
                        txtTelefono.Text = dr["telefono"].ToString();
                        txtEmail.Text = dr["email"].ToString();
                        txtResponsable.Text = dr["responsable"].ToString();
                    }
                }
            }
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            int id = int.Parse(hdnId.Value);
            using (var cn = new MySqlConnection(cadena))
            using (var cmd = new MySqlCommand("sp_actualizar_refugio", cn))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("p_id", id);
                cmd.Parameters.AddWithValue("p_nombre", txtNombre.Text.Trim());
                cmd.Parameters.AddWithValue("p_direccion", txtDireccion.Text.Trim());
                cmd.Parameters.AddWithValue("p_telefono", txtTelefono.Text.Trim());
                cmd.Parameters.AddWithValue("p_email", txtEmail.Text.Trim());
                cmd.Parameters.AddWithValue("p_responsable", txtResponsable.Text.Trim());

                cn.Open();
                cmd.ExecuteNonQuery();
            }

            Session["mensaje"] = "Refugio actualizado correctamente.";
            Response.Redirect("ListadoRefujio.aspx", true);
        }

        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            Response.Redirect("ListadoRefugio.aspx", true);
        }
    }
}
