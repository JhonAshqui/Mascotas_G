<%@ Page Title="Agregar Voluntario" Language="C#" MasterPageFile="~/Site.Master"
    AutoEventWireup="true" CodeBehind="AgregarVoluntario.aspx.cs"
    Inherits="WebApplication2.AgregarVoluntario" %>

<asp:Content ID="C1" ContentPlaceHolderID="MainContent" runat="server">
     <!-- Oculta el hero-banner sólo en esta página -->
 <style>
   .hero-wrap { display: none !important; }
 </style>
  <div class="container" style="max-width:500px; margin-top:2rem;">
    <h3 class="text-center mb-4">Registrar Voluntario</h3>

    <!-- Usuario (solo tipo 'Voluntario') -->
    <div class="mb-3">
      <asp:DropDownList ID="ddlUsuario" runat="server" CssClass="form-select"
          AppendDataBoundItems="True">
        <asp:ListItem Text="-- Seleccione usuario --" Value="" />
      </asp:DropDownList>
    </div>

    <!-- Refugio -->
    <div class="mb-3">
      <asp:DropDownList ID="ddlRefugio" runat="server" CssClass="form-select"
          AppendDataBoundItems="True">
        <asp:ListItem Text="-- Seleccione refugio --" Value="" />
      </asp:DropDownList>
    </div>

    <!-- Actividad -->
    <div class="mb-3">
      <asp:TextBox ID="txtActividad" runat="server" CssClass="form-control"
        Placeholder="Actividad (ej. Alimentación)" />
    </div>

    <!-- Frecuencia -->
    <div class="mb-3">
      <asp:TextBox ID="txtFrecuencia" runat="server" CssClass="form-control"
        Placeholder="Frecuencia (ej. Semanal)" />
    </div>

    <!-- Horario -->
    <div class="mb-4">
      <asp:TextBox ID="txtHorario" runat="server" TextMode="MultiLine"
        CssClass="form-control" Rows="2" Placeholder="Horario disponible" />
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
      if (!$('#<%= ddlUsuario.ClientID %>').val())  { alert('Seleccione usuario');    return false; }
      if (!$('#<%= ddlRefugio.ClientID %>').val()) { alert('Seleccione refugio');    return false; }
      if (!$('#<%= txtActividad.ClientID %>').val().trim())  { alert('Actividad requerida'); return false; }
      if (!$('#<%= txtFrecuencia.ClientID %>').val().trim()) { alert('Frecuencia requerida');return false; }
      return true;
    }
  </script>
</asp:Content>
