<%@ Page Title="Listado de Voluntarios" Language="C#" MasterPageFile="~/Site.Master"
    AutoEventWireup="true" CodeBehind="ListadoVoluntario.aspx.cs"
    Inherits="WebApplication2.ListadoVoluntario" %>

<asp:Content ID="C1" ContentPlaceHolderID="MainContent" runat="server">
<style>
  .hero-wrap { display: none !important; }
</style>

<div class="container-fluid">
    <h2 class="text-center mb-4">Voluntarios</h2>

    <div class="mb-3">
        <asp:Button ID="btnAgregar" runat="server" CssClass="btn btn-primary"
            Text="Agregar Voluntario" OnClick="btnAgregar_Click" />
    </div>

    <div class="table-responsive">
        <asp:GridView ID="gvVoluntario" runat="server" ClientIDMode="Static"
            AutoGenerateColumns="False" DataKeyNames="id_voluntario"
            CssClass="table table-striped"
            OnRowCommand="gvVoluntario_RowCommand"
            OnRowDataBound="gvVoluntario_RowDataBound">
            <Columns>
                <asp:BoundField DataField="id_voluntario" HeaderText="ID" />
                <asp:BoundField DataField="usuario" HeaderText="Usuario" />
                <asp:BoundField DataField="refugio" HeaderText="Refugio" />
                <asp:BoundField DataField="actividad" HeaderText="Actividad" />
                <asp:BoundField DataField="frecuencia" HeaderText="Frecuencia" />
                <asp:BoundField DataField="horario" HeaderText="Horario" />
                <asp:TemplateField HeaderText="Acciones" HeaderStyle-CssClass="acciones-columna"
                    ItemStyle-CssClass="acciones-columna" Visible="false">
                    <ItemTemplate>
                        <div class="d-flex gap-2 justify-content-center">
                            <asp:Button ID="btnEditar" runat="server" Text="Editar"
                                CommandName="Editar" CommandArgument='<%# Eval("id_voluntario") %>'
                                CssClass="btn btn-warning btn-sm" />
                            <asp:Button ID="btnEliminar" runat="server" Text="Eliminar"
                                CommandName="Eliminar" CommandArgument='<%# Eval("id_voluntario") %>'
                                CssClass="btn btn-danger btn-sm"
                                OnClientClick="return confirm('¿Eliminar este voluntario?');" />
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
        $('table.table').DataTable({
            language: {
                url: "//cdn.datatables.net/plug-ins/1.13.6/i18n/es-ES.json"
            },
            columnDefs: [{ orderable: false, targets: -1 }]
        });
    });
</script>
</asp:Content>
