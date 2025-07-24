<%@ Page Title="Agregar Usuario" Language="C#" MasterPageFile="~/Site.Master"
    AutoEventWireup="true" CodeBehind="AgregarUsuario.aspx.cs"
    Inherits="WebApplication2.AgregarUsuario" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <!-- Oculta el hero-banner sólo en esta página -->
<style>
  .hero-wrap { display: none !important; }
</style>
  <div class="d-flex justify-content-center align-items-center vh-100">
    <div class="container" style="max-width:500px;">
      <h3 class="text-center mb-4">Agregar Usuario</h3>

      <!-- Nombre -->
      <div class="mb-3">
        <asp:TextBox ID="txtNombre" runat="server" CssClass="form-control mb-2"
            Placeholder="Nombre completo" />
      </div>

      <!-- Email -->
      <div class="mb-3">
        <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control mb-2"
            Placeholder="Email" />
      </div>

      <!-- Teléfono -->
      <div class="mb-3">
        <asp:TextBox ID="txtTelefono" runat="server" CssClass="form-control mb-2"
            Placeholder="Teléfono" />
      </div>

      <!-- Dirección -->
      <div class="mb-3">
        <asp:TextBox ID="txtDireccion" runat="server" TextMode="MultiLine"
            CssClass="form-control mb-2" Placeholder="Dirección" Rows="2" />
      </div>

      <!-- Tipo de usuario -->
      <div class="mb-4">
        <asp:DropDownList ID="ddlTipo" runat="server" CssClass="form-select"
            AppendDataBoundItems="True">
          <asp:ListItem Text="-- Seleccione tipo --" Value="" />
          <asp:ListItem Value="Donante">Donante</asp:ListItem>
          <asp:ListItem Value="Adoptante">Adoptante</asp:ListItem>
          <asp:ListItem Value="Voluntario">Voluntario</asp:ListItem>
        </asp:DropDownList>
      </div>

      <!-- Botones -->
      <div class="text-center">
        <asp:Button ID="btnGuardar" runat="server" Text="Guardar"
            CssClass="btn btn-primary me-2"
            OnClientClick="return validar();" OnClick="btnGuardar_Click" />
        <asp:Button ID="btnCancelar" runat="server" Text="Cancelar"
            CssClass="btn btn-secondary" OnClick="btnCancelar_Click" />
      </div>
    </div>
  </div>

  <!-- Validación JS -->
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <script type="text/javascript">
    function validar() {
      var n = $('#<%= txtNombre.ClientID %>').val().trim();
      var e = $('#<%= txtEmail.ClientID %>').val().trim();
      var t = $('#<%= txtTelefono.ClientID %>').val().trim();
      var d = $('#<%= txtDireccion.ClientID %>').val().trim();
      var ty= $('#<%= ddlTipo.ClientID %>').val();

      var reEm = /^[\w\.\-]+@([\w\-]+\.)+[A-Za-z]{2,4}$/;
      var reNum= /^\d+$/;

      if (!n)    { alert('Nombre es obligatorio'); return false; }
      if (!e||!reEm.test(e)) { alert('Email inválido'); return false; }
      if (t && !reNum.test(t)) { alert('Teléfono inválido'); return false; }
      if (!d)    { alert('Dirección obligatoria'); return false; }
      if (!ty)   { alert('Seleccione tipo de usuario'); return false; }
      return true;
    }
  </script>
</asp:Content>
