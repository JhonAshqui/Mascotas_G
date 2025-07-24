<%@ Page Title="Editar Donación" Language="C#" MasterPageFile="~/Site.Master"
    AutoEventWireup="true" CodeBehind="EditarDonacion.aspx.cs"
    Inherits="WebApplication2.EditarDonacion" %>

<asp:Content ID="C1" ContentPlaceHolderID="MainContent" runat="server">
     <!-- Oculta el hero-banner sólo en esta página -->
 <style>
   .hero-wrap { display: none !important; }
 </style>
  <asp:HiddenField ID="hdnId" runat="server" />

  <div class="container" style="max-width:500px; margin-top:2rem;">
    <h3 class="text-center mb-4">Editar Donación</h3>

    <!-- Donante -->
    <div class="mb-3">
      <label>Donante:</label>
      <asp:DropDownList ID="ddlUsuario" runat="server" CssClass="form-select" />
    </div>

    <!-- Monto -->
    <div class="mb-3">
      <label>Monto:</label>
      <asp:TextBox ID="txtMonto" runat="server" CssClass="form-control" />
    </div>

    <!-- Descripción -->
    <div class="mb-3">
      <label>Descripción:</label>
      <asp:TextBox ID="txtDescripcion" runat="server" CssClass="form-control" />
    </div>

    <!-- Fecha -->
    <div class="mb-4">
      <label>Fecha:</label>
      <asp:TextBox ID="txtFecha" runat="server" CssClass="form-control" />
    </div>

    <div class="text-center">
      <asp:Button ID="btnGuardar" runat="server" CssClass="btn btn-primary me-2"
        Text="Guardar" OnClick="btnGuardar_Click" />
      <asp:Button ID="btnCancelar" runat="server" CssClass="btn btn-secondary"
        Text="Cancelar" OnClick="btnCancelar_Click" />
    </div>
  </div>
</asp:Content>
