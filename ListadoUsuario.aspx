<%@ Page Title="Listado de Usuarios" Language="C#" MasterPageFile="~/Site.Master"
    AutoEventWireup="true" CodeBehind="ListadoUsuario.aspx.cs"
    Inherits="WebApplication2.ListadoUsuario" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<style>
  .hero-wrap { display: none !important; }
</style>

<div class="container-fluid">
    <h2 class="text-center mb-4">Lista de Usuarios</h2>

    <div class="mb-3">
        <asp:Button ID="btnAgregar" runat="server" CssClass="btn btn-primary"
            Text="Agregar Usuario" OnClick="btnAgregar_Click" />
    </div>

    <div class="table-responsive">
        <asp:GridView ID="gvUsuario" runat="server" ClientIDMode="Static"
            AutoGenerateColumns="False" DataKeyNames="id_usuario"
            CssClass="table table-striped"
            OnRowCommand="gvUsuario_RowCommand"
            OnRowDataBound="gvUsuario_RowDataBound">
            <Columns>
                <asp:BoundField DataField="id_usuario" HeaderText="ID" />
                <asp:BoundField DataField="nombre" HeaderText="Nombre" />
                <asp:BoundField DataField="email" HeaderText="Email" />
                <asp:BoundField DataField="telefono" HeaderText="Teléfono" />
                <asp:BoundField DataField="direccion" HeaderText="Dirección" />
                <asp:BoundField DataField="tipo_usuario" HeaderText="Tipo" />
                <asp:TemplateField HeaderText="Acciones" HeaderStyle-CssClass="acciones-columna"
                    ItemStyle-CssClass="acciones-columna" Visible="false">
                    <ItemTemplate>
                        <div class="d-flex justify-content-center gap-2">
                            <asp:Button ID="btnEditar" runat="server" Text="Editar"
                                CommandName="Editar" CommandArgument='<%# Eval("id_usuario") %>'
                                CssClass="btn btn-warning btn-sm" />
                            <asp:Button ID="btnEliminar" runat="server" Text="Eliminar"
                                CommandName="Eliminar" CommandArgument='<%# Eval("id_usuario") %>'
                                CssClass="btn btn-danger btn-sm"
                                OnClientClick="return confirm('¿Eliminar este usuario?');" />
                        </div>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    </div>

</div>

<!-- DataTables -->
<link rel="stylesheet"
    href="https://cdn.datatables.net/1.13.6/css/jquery.dataTables.min.css" />
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>
<script>
    $(function () {
        $('#gvUsuario').DataTable({
            language: { url: "//cdn.datatables.net/plug-ins/1.13.6/i18n/es-ES.json" },
            columnDefs: [{ orderable: false, targets: -1 }]
        });
    });
</script>
</asp:Content>
