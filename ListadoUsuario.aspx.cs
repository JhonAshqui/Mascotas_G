using System;
using System.Configuration;
using System.Data;
using System.Web.UI.WebControls;
using MySql.Data.MySqlClient;

namespace WebApplication2
{//listausuarios.aspx
    public partial class ListadoUsuario : System.Web.UI.Page
    {
        private readonly string cadena =
            ConfigurationManager.ConnectionStrings["conexionDatos"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            bool esAdmin = Session["usuario"] != null &&
                           Session["rol"] != null &&
                           Session["rol"].ToString() == "administrador";

            ViewState["EsAdmin"] = esAdmin;
            btnAgregar.Visible = esAdmin;

            if (gvUsuario.Columns.Count > 0)
            {
                gvUsuario.Columns[gvUsuario.Columns.Count - 1].Visible = esAdmin;
            }

            if (!IsPostBack)
            {
                CargarUsuarios();
                if (Session["mensaje"] != null)
                {
                    Response.Write($"<script>alert('{Session["mensaje"]}');</script>");
                    Session.Remove("mensaje");
                }
            }
        }

        private void CargarUsuarios()
        {
            var dt = new DataTable();
            using (var cn = new MySqlConnection(cadena))
            using (var cmd = new MySqlCommand("sp_consultar_usuario", cn))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                using (var da = new MySqlDataAdapter(cmd))
                    da.Fill(dt);
            }

            gvUsuario.DataSource = dt;
            gvUsuario.DataBind();

            if (gvUsuario.HeaderRow != null)
            {
                gvUsuario.UseAccessibleHeader = true;
                gvUsuario.HeaderRow.TableSection = TableRowSection.TableHeader;
            }
        }

        protected void btnAgregar_Click(object sender, EventArgs e)
        {
            Response.Redirect("AgregarUsuario.aspx", true);
        }

        protected void gvUsuario_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            bool esAdmin = ViewState["EsAdmin"] != null && (bool)ViewState["EsAdmin"];
            if (!esAdmin) return;

            int id = Convert.ToInt32(e.CommandArgument);

            if (e.CommandName == "Editar")
            {
                Response.Redirect($"EditarUsuario.aspx?id={id}", true);
            }
            else if (e.CommandName == "Eliminar")
            {
                using (var cn = new MySqlConnection(cadena))
                using (var cmd = new MySqlCommand("sp_eliminar_usuario", cn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("p_id", id);
                    cn.Open();
                    cmd.ExecuteNonQuery();
                }
                CargarUsuarios();
            }
        }

        protected void gvUsuario_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                bool esAdmin = ViewState["EsAdmin"] != null && (bool)ViewState["EsAdmin"];

                if (!esAdmin)
                {
                    var btnEditar = e.Row.FindControl("btnEditar") as Button;
                    var btnEliminar = e.Row.FindControl("btnEliminar") as Button;

                    if (btnEditar != null) btnEditar.Visible = false;
                    if (btnEliminar != null) btnEliminar.Visible = false;
                }
            }
        }
    }
}
