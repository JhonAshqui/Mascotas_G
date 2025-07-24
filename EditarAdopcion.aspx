<%@ Page Title="Editar Adopción" Language="C#" MasterPageFile="~/Site.Master"
    AutoEventWireup="true" CodeBehind="EditarAdopcion.aspx.cs"
    Inherits="WebApplication2.EditarAdopcion" %>

<asp:Content ID="C1" ContentPlaceHolderID="MainContent" runat="server">
    <!-- Oculta el hero-banner sólo en esta página -->
<style>
  .hero-wrap { display: none !important; }
</style>
  <div class="container" style="max-width:500px; margin-top:2rem;">
    <h3 class="text-center mb-4">Editar Adopción</h3>
    <asp:HiddenField ID="hdnId" runat="server" />

    <!-- Animal -->
    <div class="mb-3">
      <asp:DropDownList ID="ddlAnimal" runat="server" CssClass="form-select" />
    </div>

    <!-- Usuario -->
    <div class="mb-3">
      <asp:DropDownList ID="ddlUsuario" runat="server" CssClass="form-select" />
    </div>

    <!-- Fecha -->
    <div class="mb-3">
      <asp:TextBox ID="txtFecha" runat="server" CssClass="form-control" />
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
        CssClass="form-control" Rows="3" />
    </div>

    <!-- Botones -->
    <div class="text-center">
      <asp:Button ID="btnGuardar" runat="server" CssClass="btn btn-primary me-2"
        Text="Guardar" OnClick="btnGuardar_Click" />
      <asp:Button ID="btnCancelar" runat="server" CssClass="btn btn-secondary"
        Text="Cancelar" OnClick="btnCancelar_Click" />
    </div>
  </div>
</asp:Content>
