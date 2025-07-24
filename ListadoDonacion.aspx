<%@ Page Title="Listado de Donaciones" Language="C#" MasterPageFile="~/Site.Master"
    AutoEventWireup="true" CodeBehind="ListadoDonacion.aspx.cs"
    Inherits="WebApplication2.ListadoDonacion" %>

<asp:Content ID="C1" ContentPlaceHolderID="MainContent" runat="server">
<style>
  .hero-wrap { display: none !important; }
</style>

<div class="container-fluid">
    <h2 class="text-center mb-4">Donaciones</h2>

    <div class="mb-3">
        <asp:Button ID="btnAgregar" runat="server" CssClass="btn btn-primary"
            Text="Registrar Donación" OnClick="btnAgregar_Click" />
    </div>
    <div class="table-responsive">
        <asp:GridView ID="gvDonacion" runat="server" ClientIDMode="Static"
            AutoGenerateColumns="False" DataKeyNames="id_donacion"
            CssClass="table table-striped"
            OnRowCommand="gvDonacion_RowCommand"
            OnRowDataBound="gvDonacion_RowDataBound">
            <Columns>
                <asp:BoundField DataField="id_donacion" HeaderText="ID" />
                <asp:BoundField DataField="donante" HeaderText="Donante" />
                <asp:BoundField DataField="monto" HeaderText="Monto" DataFormatString="{0:C2}" />
                <asp:BoundField DataField="descripcion" HeaderText="Descripción" />
                <asp:BoundField DataField="fecha" HeaderText="Fecha" />
                <asp:TemplateField HeaderText="Acciones" HeaderStyle-CssClass="acciones-columna"
                    ItemStyle-CssClass="acciones-columna" Visible="false">
                    <ItemTemplate>
                        <div class="d-flex gap-2 justify-content-center">
                            <asp:Button ID="btnEditar" runat="server" Text="Editar"
                                CommandName="Editar" CommandArgument='<%# Eval("id_donacion") %>'
                                CssClass="btn btn-warning btn-sm" />
                            <asp:Button ID="btnEliminar" runat="server" Text="Eliminar"
                                CommandName="Eliminar" CommandArgument='<%# Eval("id_donacion") %>'
                                CssClass="btn btn-danger btn-sm"
                                OnClientClick="return confirm('¿Eliminar esta donación?');" />
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
        $('#gvDonacion').DataTable({
            language: { url: "//cdn.datatables.net/plug-ins/1.13.6/i18n/es-ES.json" },
            columnDefs: [{ orderable: false, targets: -1 }]
        });
    });
</script>
</asp:Content>
