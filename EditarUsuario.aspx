<%@ Page Title="Editar Usuario" Language="C#" MasterPageFile="~/Site.Master"
    AutoEventWireup="true" CodeBehind="EditarUsuario.aspx.cs"
    Inherits="WebApplication2.EditarUsuario" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <!-- Oculta el hero-banner sólo en esta página -->
<style>
  .hero-wrap { display: none !important; }
</style>
  <div class="container" style="max-width:600px">
    <h3 class="text-center mb-3">Editar Usuario</h3>
    <asp:HiddenField ID="hdnId" runat="server" />

    <!-- Nombre -->
    <div class="mb-3">
      <label>Nombre:</label>
      <asp:TextBox ID="txtNombre" runat="server" CssClass="form-control" />
    </div>
    <!-- Email -->
    <div class="mb-3">
      <label>Email:</label>
      <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" />
    </div>
    <!-- Teléfono -->
    <div class="mb-3">
      <label>Teléfono:</label>
      <asp:TextBox ID="txtTelefono" runat="server" CssClass="form-control" />
    </div>
    <!-- Dirección -->
    <div class="mb-3">
      <label>Dirección:</label>
      <asp:TextBox ID="txtDireccion" runat="server" TextMode="MultiLine"
          CssClass="form-control" Rows="2" />
    </div>
    <!-- Tipo de usuario -->
    <div class="mb-4">
      <label>Tipo de usuario:</label>
      <asp:DropDownList ID="ddlTipo" runat="server" CssClass="form-select">
        <asp:ListItem Value="Donante">Donante</asp:ListItem>
        <asp:ListItem Value="Adoptante">Adoptante</asp:ListItem>
        <asp:ListItem Value="Voluntario">Voluntario</asp:ListItem>
      </asp:DropDownList>
    </div>

    <div class="text-center mt-4">
      <asp:Button ID="btnGuardar" runat="server" Text="Guardar"
          CssClass="btn btn-primary me-2" OnClick="btnGuardar_Click" />
      <asp:Button ID="btnCancelar" runat="server" Text="Cancelar"
          CssClass="btn btn-secondary" OnClick="btnCancelar_Click" />
    </div>
  </div>
</asp:Content>
