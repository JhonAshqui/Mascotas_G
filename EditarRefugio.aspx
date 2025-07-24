<%@ Page Title="Editar Refugio" Language="C#" MasterPageFile="~/Site.Master"
    AutoEventWireup="true" CodeBehind="EditarRefugio.aspx.cs"
    Inherits="WebApplication2.EditarRefugio" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
  <div class="container" style="max-width:600px">
    <h3 class="text-center mb-3">Editar Refugio</h3>

    <!-- Guarda el id para el postback -->
    <asp:HiddenField ID="hdnId" runat="server" />

    <!-- Nombre -->
    <div class="mb-3">
      <label for="<%= txtNombre.ClientID %>">Nombre:</label>
      <asp:TextBox ID="txtNombre" runat="server" CssClass="form-control" />
    </div>

    <!-- Dirección -->
    <div class="mb-3">
      <label for="<%= txtDireccion.ClientID %>">Dirección:</label>
      <asp:TextBox ID="txtDireccion" runat="server" TextMode="MultiLine"
          CssClass="form-control" Rows="2" />
    </div>

    <!-- Teléfono -->
    <div class="mb-3">
      <label for="<%= txtTelefono.ClientID %>">Teléfono:</label>
      <asp:TextBox ID="txtTelefono" runat="server" CssClass="form-control" />
    </div>

    <!-- Email -->
    <div class="mb-3">
      <label for="<%= txtEmail.ClientID %>">Email:</label>
      <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" />
    </div>

    <!-- Responsable -->
    <div class="mb-4">
      <label for="<%= txtResponsable.ClientID %>">Responsable:</label>
      <asp:TextBox ID="txtResponsable" runat="server" CssClass="form-control" />
    </div>

    <!-- Botones -->
    <div class="text-center mt-4">
      <asp:Button ID="btnGuardar" runat="server" Text="Guardar"
          CssClass="btn btn-primary me-2" OnClick="btnGuardar_Click" />
      <asp:Button ID="btnCancelar" runat="server" Text="Cancelar"
          CssClass="btn btn-secondary" OnClick="btnCancelar_Click" />
    </div>
  </div>
</asp:Content>
