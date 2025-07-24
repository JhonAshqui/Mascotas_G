<%@ Page Title="Listado de Adopciones" Language="C#" MasterPageFile="~/Site.Master"
    AutoEventWireup="true" CodeBehind="ListadoAdopcion.aspx.cs"
    Inherits="WebApplication2.ListadoAdopcion" %>

<asp:Content ID="C1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        .hero-wrap { display: none !important; }
    </style>

    <div class="container-fluid">
        <h2 class="text-center mb-4">Lista de Adopciones</h2>

        <div class="mb-3">
            <asp:Button ID="btnAgregar" runat="server" CssClass="btn btn-primary"
                Text="Registrar Adopción" OnClick="btnAgregar_Click" />
        </div>
        <div class="table-responsive">
            <asp:GridView ID="gvAdopcion" runat="server" ClientIDMode="Static"
                AutoGenerateColumns="False" DataKeyNames="id_adopcion"
                CssClass="table table-striped"
                OnRowCommand="gvAdopcion_RowCommand"
                OnRowDataBound="gvAdopcion_RowDataBound">
                <Columns>
                    <asp:BoundField DataField="id_adopcion" HeaderText="ID" />
                    <asp:BoundField DataField="animal" HeaderText="Animal" />
                    <asp:BoundField DataField="usuario" HeaderText="Usuario" />
                    <asp:BoundField DataField="fecha_adopcion" HeaderText="Fecha" />
                    <asp:BoundField DataField="estado" HeaderText="Estado" />
                    <asp:BoundField DataField="comentarios" HeaderText="Comentarios" />
                    <asp:TemplateField HeaderText="Acciones" HeaderStyle-CssClass="acciones-columna"
                        ItemStyle-CssClass="acciones-columna" Visible="false">
                        <ItemTemplate>
                            <div class="d-flex gap-2 justify-content-center">
                                <asp:Button ID="btnEditar" runat="server" Text="Editar"
                                    CommandName="Editar" CommandArgument='<%# Eval("id_adopcion") %>'
                                    CssClass="btn btn-warning btn-sm" />
                                <asp:Button ID="btnEliminar" runat="server" Text="Eliminar"
                                    CommandName="Eliminar" CommandArgument='<%# Eval("id_adopcion") %>'
                                    CssClass="btn btn-danger btn-sm"
                                    OnClientClick="return confirm('¿Eliminar esta adopción?');" />
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>
    </div>

    <link rel="stylesheet" href="https://cdn.datatables.net/1.13.6/css/jquery.dataTables.min.css" />
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>
    <script>
        $(function () {
            $('#gvAdopcion').DataTable({
                language: { url: "//cdn.datatables.net/plug-ins/1.13.6/i18n/es-ES.json" },
                columnDefs: [{ orderable: false, targets: -1 }]
            });
        });
    </script>
</asp:Content>
