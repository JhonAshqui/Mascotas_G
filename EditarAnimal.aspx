<%@ Page Title="Editar Animal" Language="C#" MasterPageFile="~/Site.Master"
    AutoEventWireup="true" CodeBehind="EditarAnimal.aspx.cs"
    Inherits="WebApplication2.EditarAnimal" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
 <!-- Oculta el hero-banner sólo en esta página -->
<style>
  .hero-wrap { display: none !important; }
</style>
  <div class="container" style="max-width:600px">
    <h3 class="text-center mb-3">Editar Animal</h3>
    <asp:HiddenField ID="hdnId" runat="server" />

    <!-- Nombre -->
    <div class="mb-3">
      <label>Nombre:</label>
      <asp:TextBox ID="txtNombre" runat="server" CssClass="form-control" />
    </div>

    <!-- Especie -->
    <div class="mb-3">
      <label>Especie:</label>
      <asp:TextBox ID="txtEspecie" runat="server" CssClass="form-control" />
    </div>

    <!-- Raza -->
    <div class="mb-3">
      <label>Raza:</label>
      <asp:TextBox ID="txtRaza" runat="server" CssClass="form-control" />
    </div>

    <!-- Edad -->
    <div class="mb-3">
      <label>Edad:</label>
      <asp:TextBox ID="txtEdad" runat="server" CssClass="form-control" />
    </div>

    <!-- Sexo -->
    <div class="mb-3">
      <label>Sexo:</label>
      <asp:DropDownList ID="ddlSexo" runat="server" CssClass="form-select">
        <asp:ListItem Value="Macho">Macho</asp:ListItem>
        <asp:ListItem Value="Hembra">Hembra</asp:ListItem>
      </asp:DropDownList>
    </div>

    <!-- Estado de salud -->
    <div class="mb-3">
      <label>Estado de salud:</label>
      <asp:TextBox ID="txtEstadoSalud" runat="server" CssClass="form-control" />
    </div>

    <!-- Fecha de ingreso -->
    <div class="mb-3">
      <label>Fecha de ingreso:</label>
      <asp:TextBox ID="txtFechaIngreso" runat="server" CssClass="form-control" />
    </div>

    <!-- Estado -->
    <div class="mb-3">
      <label>Estado:</label>
      <asp:DropDownList ID="ddlEstado" runat="server" CssClass="form-select">
        <asp:ListItem Value="Disponible">Disponible</asp:ListItem>
        <asp:ListItem Value="No disponible">No disponible</asp:ListItem>
      </asp:DropDownList>
    </div>

    <!-- Foto actual -->
    <div class="mb-3">
      <label>Foto actual:</label><br />
      <asp:Image ID="imgActual" runat="server" Width="100px" />
    </div>

    <!-- Subir nueva foto -->
    <div class="mb-3">
      <asp:FileUpload ID="fuFoto" runat="server" CssClass="form-control mb-2" />
      <small class="text-muted">Deja vacío para no cambiar imagen</small>
    </div>

    <!-- Refugio -->
    <div class="mb-4">
      <label>Refugio:</label>
      <asp:DropDownList ID="ddlRefugio" runat="server" CssClass="form-select"
          DataTextField="nombre" DataValueField="id_refugio" />
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
