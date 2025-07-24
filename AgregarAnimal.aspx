<%@ Page Title="Agregar Animal" Language="C#" MasterPageFile="~/Site.Master"
    AutoEventWireup="true" CodeBehind="AgregarAnimal.aspx.cs"
    Inherits="WebApplication2.AgregarAnimal" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
  <!-- Oculta el hero-banner sólo en esta página -->
 <style>
   .hero-wrap { display: none !important; }
 </style>
  <div class="d-flex justify-content-center align-items-center vh-100">
    <div class="container" style="max-width:500px;">
      <h3 class="text-center mb-4">Agregar Animal</h3>

      <!-- Nombre -->
      <div class="mb-3">
        <asp:TextBox ID="txtNombre" runat="server" CssClass="form-control mb-2"
            Placeholder="Nombre" />
      </div>

      <!-- Especie -->
      <div class="mb-3">
        <asp:TextBox ID="txtEspecie" runat="server" CssClass="form-control mb-2"
            Placeholder="Especie" />
      </div>

      <!-- Raza -->
      <div class="mb-3">
        <asp:TextBox ID="txtRaza" runat="server" CssClass="form-control mb-2"
            Placeholder="Raza" />
      </div>

      <!-- Edad -->
      <div class="mb-3">
        <asp:TextBox ID="txtEdad" runat="server" CssClass="form-control mb-2"
            Placeholder="Edad (años)" />
      </div>

      <!-- Sexo -->
      <div class="mb-3">
        <asp:DropDownList ID="ddlSexo" runat="server" CssClass="form-select mb-2">
          <asp:ListItem Value="">-- Sexo --</asp:ListItem>
          <asp:ListItem Value="Macho">Macho</asp:ListItem>
          <asp:ListItem Value="Hembra">Hembra</asp:ListItem>
        </asp:DropDownList>
      </div>

      <!-- Estado de salud -->
      <div class="mb-3">
        <asp:TextBox ID="txtEstadoSalud" runat="server" CssClass="form-control mb-2"
            Placeholder="Estado de salud" />
      </div>

      <!-- Fecha de ingreso -->
      <div class="mb-3">
        <asp:TextBox ID="txtFechaIngreso" runat="server" CssClass="form-control mb-2"
            Placeholder="Fecha de ingreso (YYYY-MM-DD)" />
      </div>

      <!-- Estado -->
      <div class="mb-3">
        <asp:DropDownList ID="ddlEstado" runat="server" CssClass="form-select mb-2">
          <asp:ListItem Value="Disponible">Disponible</asp:ListItem>
          <asp:ListItem Value="No disponible">No disponible</asp:ListItem>
        </asp:DropDownList>
      </div>

      <!-- Foto -->
      <div class="mb-3">
        <asp:FileUpload ID="fuFoto" runat="server" CssClass="form-control mb-2" />
        <small class="text-muted">Sube una imagen (.jpg/.png)</small>
      </div>

      <!-- Refugio -->
     <div class="mb-4">
      <asp:DropDownList 
        ID="ddlRefugio" 
        runat="server" 
        CssClass="form-select mb-2"
        DataTextField="nombre" 
        DataValueField="id_refugio"
        AppendDataBoundItems="True">
        <asp:ListItem Text="-- Seleccione el refugio --" Value="" />
      </asp:DropDownList>
    </div>

      <!-- Botones -->
      <div class="text-center">
        <asp:Button ID="btnGuardar" runat="server" Text="Guardar"
            CssClass="btn btn-primary me-2"
            OnClientClick="return validarFormulario();" 
            OnClick="btnGuardar_Click" />
        <asp:Button ID="btnCancelar" runat="server" Text="Cancelar"
            CssClass="btn btn-secondary" OnClick="btnCancelar_Click" />
      </div>
    </div>
  </div>

  <!-- jQuery para validación -->
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <script type="text/javascript">
      function validarFormulario() {
          var n = $('#<%= txtNombre.ClientID %>').val().trim();
        var e = $('#<%= txtEspecie.ClientID %>').val().trim();
        var r = $('#<%= txtRaza.ClientID %>').val().trim();
        var ed = $('#<%= txtEdad.ClientID %>').val().trim();
        var s = $('#<%= ddlSexo.ClientID %>').val();
      var es = $('#<%= txtEstadoSalud.ClientID %>').val().trim();
      var fi = $('#<%= txtFechaIngreso.ClientID %>').val().trim();
      var es2= $('#<%= ddlEstado.ClientID %>').val();
      var rf = $('#<%= ddlRefugio.ClientID %>').val();

          var reNum = /^\d+$/;
          var reF = /^\d{4}-\d{2}-\d{2}$/;
          if (!n) { alert('Nombre obligatorio'); return false; }
          if (!e) { alert('Especie obligatoria'); return false; }
          if (ed && !reNum.test(ed)) { alert('Edad inválida'); return false; }
          if (!s) { alert('Sexo obligatorio'); return false; }
          if (!es) { alert('Estado de salud obligatorio'); return false; }
          if (fi && !reF.test(fi)) { alert('Fecha inválida'); return false; }
          if (!es2) { alert('Estado obligatorio'); return false; }
          if (!rf) { alert('Seleccione un refugio'); return false; }
          return true;
      }
  </script>
</asp:Content>
