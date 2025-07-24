<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="login.aspx.cs" Inherits="WebApplication2.login" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title>Iniciar Sesión</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
</head>
<body class="bg-light">
    <form id="form1" runat="server" class="container mt-5">
        <div class="card p-4 shadow mx-auto" style="max-width: 400px;">
            <h3 class="text-center mb-3">Login</h3>
            <div class="form-group mb-3">
                <label for="txtUsuario">Usuario</label>
                <asp:TextBox ID="txtUsuario" runat="server" CssClass="form-control" />
            </div>
            <div class="form-group mb-3">
                <label for="txtClave">Contraseña</label>
                <asp:TextBox ID="txtClave" runat="server" TextMode="Password" CssClass="form-control" />
            </div>
            <asp:Button ID="btnLogin" runat="server" Text="Iniciar sesión" CssClass="btn btn-primary w-100" OnClick="btnLogin_Click" />
            <asp:Label ID="lblMensaje" runat="server" ForeColor="Red" CssClass="mt-2 d-block text-center"></asp:Label>
        </div>
    </form>
</body>
</html>
