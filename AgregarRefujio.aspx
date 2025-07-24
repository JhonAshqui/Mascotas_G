<%@ Page Title="Agregar Refugio" Language="C#" MasterPageFile="~/Site.Master"
    AutoEventWireup="true" CodeBehind="AgregarRefugio.aspx.cs"
    Inherits="WebApplication2.AgregarRefugio" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
   <!-- Oculta el hero-banner sólo en esta página -->
  <style>
    .hero-wrap { display: none !important; }
  </style>
  <div class="d-flex justify-content-center align-items-center vh-100">
    <div class="container" style="max-width: 450px;">
      <h3 class="text-center mb-4">Agregar Refugio</h3>

      <!-- Nombre -->
      <div class="mb-3">
        <asp:TextBox ID="txtNombre" runat="server" CssClass="form-control mb-2"
            Placeholder="Nombre del refugio" />
      </div>

      <!-- Dirección -->
      <div class="mb-3">
        <asp:TextBox ID="txtDireccion" runat="server" TextMode="MultiLine"
            CssClass="form-control mb-2" Placeholder="Dirección" Rows="2" />
      </div>

      <!-- Teléfono -->
      <div class="mb-3">
        <asp:TextBox ID="txtTelefono" runat="server" CssClass="form-control mb-2"
            Placeholder="Teléfono" />
      </div>

      <!-- Email -->
      <div class="mb-3">
        <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control mb-2"
            Placeholder="Email" />
      </div>

      <!-- Responsable -->
      <div class="mb-4">
        <asp:TextBox ID="txtResponsable" runat="server" CssClass="form-control"
            Placeholder="Responsable" />
      </div>

      <!-- Botones -->
      <div class="text-center">
        <asp:Button ID="btnGuardar" runat="server" Text="Guardar"
          CssClass="btn btn-primary me-2"
          OnClientClick="return validarFormulario();"
          OnClick="btnGuardar_Click" />

        <asp:Button ID="btnCancelar" runat="server" Text="Cancelar"
          CssClass="btn btn-secondary"
          OnClick="btnCancelar_Click" />
      </div>
    </div>
  </div>

  <!-- jQuery para validación -->
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <script type="text/javascript">
      function validarFormulario() {
          var n = $('#<%= txtNombre.ClientID %>').val().trim();
      var d = $('#<%= txtDireccion.ClientID %>').val().trim();
        var t = $('#<%= txtTelefono.ClientID %>').val().trim();
        var e = $('#<%= txtEmail.ClientID %>').val().trim();
        var r = $('#<%= txtResponsable.ClientID %>').val().trim();

          var reEm = /^[\w\.\-]+@([\w\-]+\.)+[A-Za-z]{2,4}$/;
          var reNum = /^[\d\s()+-]+$/;

          if (!n) { alert('Nombre obligatorio'); return false; }
          if (!d) { alert('Dirección obligatoria'); return false; }
          if (t && !reNum.test(t)) { alert('Teléfono inválido'); return false; }
          if (e && !reEm.test(e)) { alert('Email inválido'); return false; }
          if (!r) { alert('Responsable obligatorio'); return false; }
          return true;
      }
  </script>
</asp:Content>
