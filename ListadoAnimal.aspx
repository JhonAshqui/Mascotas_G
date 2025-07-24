<%@ Page Title="Listado de Animales" Language="C#" MasterPageFile="~/Site.Master"
    AutoEventWireup="true" CodeBehind="ListadoAnimal.aspx.cs"
    Inherits="WebApplication2.ListadoAnimal" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        .hero-wrap { display: none !important; }
    </style>

    <div class="container-fluid">
        <h2 class="text-center mb-4">Lista de Animales</h2>

        <div class="mb-3">
            <asp:Button ID="btnAgregar" runat="server" CssClass="btn btn-primary"
                Text="Agregar Animal" OnClick="btnAgregar_Click" />
        </div>
        <div class="table-responsive">
            <asp:GridView ID="gvAnimal" runat="server" ClientIDMode="Static"
                AutoGenerateColumns="False" DataKeyNames="id_animal"
                CssClass="table table-striped"
                OnRowCommand="gvAnimal_RowCommand"
                OnRowDataBound="gvAnimal_RowDataBound">
                <Columns>
                    <asp:BoundField DataField="id_animal" HeaderText="ID" />
                    <%-- <asp:TemplateField HeaderText="Foto">
                        <ItemTemplate>
                            <asp:Image ID="imgFoto" runat="server"
                                ImageUrl='<%# Eval("foto_url") %>'
                                Width="80px" CssClass="img-thumbnail" />
                        </ItemTemplate>
                    </asp:TemplateField>--%>
                    <asp:BoundField DataField="nombre" HeaderText="Nombre" />
                    <asp:BoundField DataField="especie" HeaderText="Especie" />
                    <asp:BoundField DataField="raza" HeaderText="Raza" />
                    <asp:BoundField DataField="edad" HeaderText="Edad" />
                    <asp:BoundField DataField="sexo" HeaderText="Sexo" />
                    <asp:BoundField DataField="estado_salud" HeaderText="Salud" />
                    <asp:BoundField DataField="fecha_ingreso" HeaderText="Ingreso" />
                    <asp:BoundField DataField="estado" HeaderText="Estado" />
                    <asp:BoundField DataField="refugio" HeaderText="Refugio" />

                    <asp:TemplateField HeaderText="Acciones" HeaderStyle-CssClass="acciones-columna"
                        ItemStyle-CssClass="acciones-columna" Visible="false">
                        <ItemTemplate>
                            <div class="d-flex justify-content-center gap-2">
                                <asp:Button ID="btnEditar" runat="server" Text="Editar"
                                    CommandName="Editar" CommandArgument='<%# Eval("id_animal") %>'
                                    CssClass="btn btn-warning btn-sm" />
                                <asp:Button ID="btnEliminar" runat="server" Text="Eliminar"
                                    CommandName="Eliminar" CommandArgument='<%# Eval("id_animal") %>'
                                    CssClass="btn btn-danger btn-sm"
                                    OnClientClick="return confirm('¿Eliminar este animal?');" />
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>
    </div>

    <!-- DataTables -->
    <link rel="stylesheet" href="https://cdn.datatables.net/1.13.6/css/jquery.dataTables.min.css" />
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>
    <script>
        $(function () {
            $('#gvAnimal').DataTable({
                language: { url: "//cdn.datatables.net/plug-ins/1.13.6/i18n/es-ES.json" },
                columnDefs: [{ orderable: false, targets: -1 }]
            });
        });
    </script>
</asp:Content>
