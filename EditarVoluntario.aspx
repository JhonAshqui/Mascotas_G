<%@ Page Title="Editar Voluntario" Language="C#" MasterPageFile="~/Site.Master"
    AutoEventWireup="true" CodeBehind="EditarVoluntario.aspx.cs"
    Inherits="WebApplication2.EditarVoluntario" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
     <!-- Oculta el hero-banner sólo en esta página -->
 <style>
   .hero-wrap { display: none !important; }
 </style>
  <!-- HiddenField para almacenar el ID que llega por querystring -->
  <asp:HiddenField ID="hdnId" runat="server" />

  <div class="container" style="max-width:500px; margin-top:2rem;">
    <h3 class="text-center mb-4">Editar Voluntario</h3>

    <!-- Usuario (sólo tipo 'Voluntario') -->
    <div class="mb-3">
      <label for="<%= ddlUsuario.ClientID %>">Usuario:</label>
      <asp:DropDownList 
        ID="ddlUsuario" 
        runat="server" 
        CssClass="form-select" />
    </div>

    <!-- Refugio -->
    <div class="mb-3">
      <label for="<%= ddlRefugio.ClientID %>">Refugio:</label>
      <asp:DropDownList 
        ID="ddlRefugio" 
        runat="server" 
        CssClass="form-select" />
    </div>

    <!-- Actividad -->
    <div class="mb-3">
      <label for="<%= txtActividad.ClientID %>">Actividad:</label>
      <asp:TextBox 
        ID="txtActividad" 
        runat="server" 
        CssClass="form-control" />
    </div>

    <!-- Frecuencia -->
    <div class="mb-3">
      <label for="<%= txtFrecuencia.ClientID %>">Frecuencia:</label>
      <asp:TextBox 
        ID="txtFrecuencia" 
        runat="server" 
        CssClass="form-control" />
    </div>

    <!-- Horario -->
    <div class="mb-4">
      <label for="<%= txtHorario.ClientID %>">Horario:</label>
      <asp:TextBox 
        ID="txtHorario" 
        runat="server" 
        TextMode="MultiLine"
        CssClass="form-control" 
        Rows="2" />
    </div>

    <!-- Botones -->
    <div class="text-center">
      <asp:Button 
        ID="btnGuardar" 
        runat="server" 
        CssClass="btn btn-primary me-2"
        Text="Guardar" 
        OnClick="btnGuardar_Click" />
      <asp:Button 
        ID="btnCancelar" 
        runat="server" 
        CssClass="btn btn-secondary"
        Text="Cancelar" 
        OnClick="btnCancelar_Click" />
    </div>
  </div>
</asp:Content>
