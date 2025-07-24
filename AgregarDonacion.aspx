<%@ Page Title="Registrar Donación" Language="C#" MasterPageFile="~/Site.Master"
    AutoEventWireup="true" CodeBehind="AgregarDonacion.aspx.cs"
    Inherits="WebApplication2.AgregarDonacion" %>

<asp:Content ID="C1" ContentPlaceHolderID="MainContent" runat="server">
     <!-- Oculta el hero-banner sólo en esta página -->
 <style>
   .hero-wrap { display: none !important; }
 </style>
  <div class="container" style="max-width:500px; margin-top:2rem;">
    <h3 class="text-center mb-4">Registrar Donación</h3>

    <!-- Donante -->
    <div class="mb-3">
      <label>Donante:</label>
      <asp:DropDownList ID="ddlUsuario" runat="server" CssClass="form-select"
          AppendDataBoundItems="True">
        <asp:ListItem Text="-- Seleccione donante --" Value="" />
      </asp:DropDownList>
    </div>

    <!-- Monto -->
    <div class="mb-3">
      <label>Monto:</label>
      <asp:TextBox ID="txtMonto" runat="server" CssClass="form-control"
        Placeholder="Ej. 50.00" />
    </div>

    <!-- Descripción -->
    <div class="mb-3">
      <label>Descripción:</label>
      <asp:TextBox ID="txtDescripcion" runat="server" CssClass="form-control"
        Placeholder="Descripción (opcional)" />
    </div>

    <!-- Fecha -->
    <div class="mb-4">
      <label>Fecha:</label>
      <asp:TextBox ID="txtFecha" runat="server" CssClass="form-control"
        Placeholder="YYYY-MM-DD" />
    </div>

    <!-- Botones -->
    <div class="text-center">
      <asp:Button ID="btnGuardar" runat="server" CssClass="btn btn-primary me-2"
        Text="Guardar" OnClick="btnGuardar_Click" OnClientClick="return validar();" />
      <asp:Button ID="btnCancelar" runat="server" CssClass="btn btn-secondary"
        Text="Cancelar" OnClick="btnCancelar_Click" />
    </div>
  </div>

  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <script>
    function validar() {
      if (!$('#<%= ddlUsuario.ClientID %>').val()) {
        alert('Seleccione un donante'); return false;
      }
      var m = $('#<%= txtMonto.ClientID %>').val().trim(),
          reM = /^\d+(\.\d{1,2})?$/;
      if (!reM.test(m)) { alert('Monto inválido'); return false; }
      var f = $('#<%= txtFecha.ClientID %>').val().trim(),
          reF = /^\d{4}-\d{2}-\d{2}$/;
      if (!reF.test(f)) { alert('Fecha inválida'); return false; }
      return true;
    }
  </script>
</asp:Content>
