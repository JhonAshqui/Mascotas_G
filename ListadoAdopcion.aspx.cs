using System;
using System.Configuration;
using System.Data;
using System.Web.UI.WebControls;
using MySql.Data.MySqlClient;

namespace WebApplication2
{
    public partial class ListadoAdopcion : System.Web.UI.Page
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

            // Mostrar u ocultar la columna de acciones
            if (gvAdopcion.Columns.Count > 0)
            {
                gvAdopcion.Columns[gvAdopcion.Columns.Count - 1].Visible = esAdmin;
            }

            if (!IsPostBack)
            {
                CargarAdopciones();

                if (Session["mensaje"] != null)
                {
                    Response.Write($"<script>alert('{Session["mensaje"]}');</script>");
                    Session.Remove("mensaje");
                }
            }
        }

        private void CargarAdopciones()
        {
            var dt = new DataTable();
            using (var cn = new MySqlConnection(cadena))
            using (var cmd = new MySqlCommand("sp_consultar_adopcion", cn))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                using (var da = new MySqlDataAdapter(cmd))
                    da.Fill(dt);
            }

            gvAdopcion.DataSource = dt;
            gvAdopcion.DataBind();

            if (gvAdopcion.HeaderRow != null)
            {
                gvAdopcion.UseAccessibleHeader = true;
                gvAdopcion.HeaderRow.TableSection = TableRowSection.TableHeader;
            }
        }

        protected void btnAgregar_Click(object sender, EventArgs e)
        {
            Response.Redirect("AgregarAdopcion.aspx", true);
        }

        protected void gvAdopcion_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            bool esAdmin = ViewState["EsAdmin"] != null && (bool)ViewState["EsAdmin"];
            if (!esAdmin) return;

            int id = Convert.ToInt32(e.CommandArgument);

            if (e.CommandName == "Editar")
            {
                Response.Redirect($"EditarAdopcion.aspx?id={id}", true);
            }
            else if (e.CommandName == "Eliminar")
            {
                using (var cn = new MySqlConnection(cadena))
                using (var cmd = new MySqlCommand("sp_eliminar_adopcion", cn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("p_id", id);
                    cn.Open();
                    cmd.ExecuteNonQuery();
                }

                CargarAdopciones();
            }
        }

        protected void gvAdopcion_RowDataBound(object sender, GridViewRowEventArgs e)
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
