<%@ Page Title="Agregar Adopción" Language="C#" MasterPageFile="~/Site.Master"
    AutoEventWireup="true" CodeBehind="AgregarAdopcion.aspx.cs"
    Inherits="WebApplication2.AgregarAdopcion" %>

<asp:Content ID="C1" ContentPlaceHolderID="MainContent" runat="server">
        <!-- Oculta el hero-banner sólo en esta página -->
<style>
  .hero-wrap { display: none !important; }
</style>
  <div class="container" style="max-width:500px; margin-top:2rem;">
    <h3 class="text-center mb-4">Registrar Adopción</h3>

    <!-- Animal -->
    <div class="mb-3">
      <asp:DropDownList ID="ddlAnimal" runat="server" CssClass="form-select"
          AppendDataBoundItems="True">
        <asp:ListItem Text="-- Seleccione animal --" Value="" />
      </asp:DropDownList>
    </div>

    <!-- Usuario (solo Adoptantes) -->
    <div class="mb-3">
      <asp:DropDownList ID="ddlUsuario" runat="server" CssClass="form-select"
          AppendDataBoundItems="True">
        <asp:ListItem Text="-- Seleccione adoptante --" Value="" />
      </asp:DropDownList>
    </div>

    <!-- Fecha -->
    <div class="mb-3">
      <asp:TextBox ID="txtFecha" runat="server" CssClass="form-control"
        placeholder="Fecha de adopción (YYYY-MM-DD)" />
    </div>

    <!-- Estado -->
    <div class="mb-3">
      <asp:DropDownList ID="ddlEstado" runat="server" CssClass="form-select">
        <asp:ListItem Text="Pendiente" Value="Pendiente" />
        <asp:ListItem Text="Completa"   Value="Completa" />
        <asp:ListItem Text="Cancelada"  Value="Cancelada" />
      </asp:DropDownList>
    </div>

    <!-- Comentarios -->
    <div class="mb-4">
      <asp:TextBox ID="txtComentarios" runat="server" TextMode="MultiLine"
        CssClass="form-control" Rows="3" Placeholder="Comentarios (opcional)" />
    </div>

    <!-- Botones -->
    <div class="text-center">
      <asp:Button ID="btnGuardar" runat="server" CssClass="btn btn-primary me-2"
        Text="Guardar" OnClick="btnGuardar_Click"
        OnClientClick="return validar();" />
      <asp:Button ID="btnCancelar" runat="server" CssClass="btn btn-secondary"
        Text="Cancelar" OnClick="btnCancelar_Click" />
    </div>
  </div>

  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <script type="text/javascript">
      function validar() {
          if (!$('#<%= ddlAnimal.ClientID %>').val()) { alert('Seleccione animal'); return false; }
        if (!$('#<%= ddlUsuario.ClientID %>').val())  { alert('Seleccione adoptante');  return false; }
      var f = $('#<%= txtFecha.ClientID %>').val().trim(),
              re = /^\d{4}-\d{2}-\d{2}$/;
          if (!re.test(f)) { alert('Fecha inválida'); return false; }
          return true;
      }
  </script>
</asp:Content>
