<%@ Page Title="" Language="C#" MasterPageFile="~/10thAveStudio.Master" AutoEventWireup="true" CodeBehind="login.aspx.cs" Inherits="_10thAveStudioWeb.WebForm8" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <link href="https://fonts.googleapis.com/css2?family=Anuphan:wght@400;600;700&display=swap" rel="stylesheet">
        <style type="text/css">
        .container {
            background-color: #000000;
            color: #FFF;
            text-align: center;
            font-family: 'Anuphan', sans-serif;
            padding: 40px 20px;
        }
        .login-title {
            font-size: 48px;
            font-weight: 700;
            line-height: 121.392%;
            letter-spacing: 2.4px;
            margin-bottom: 30px;
        }
        .input-field {
            background: #1E1E1E;
            border-radius: 8px;
            color: #FFF;
            font-family: 'Anuphan', sans-serif;
            font-size: 18px;
            padding: 15px 20px;
            width: 100%;
            max-width: 400px;
            border: none;
            text-align: left;
            margin-bottom: 15px;
        }
        .forgot-password {
            color: #FFF;
            text-align: center;
            font-family: 'Anuphan', sans-serif;
            font-size: 15px;
            font-style: normal;
            font-weight: 400;
            line-height: 121.392%;
            letter-spacing: 0.75px;
            text-decoration-line: underline;
            display: inline-block;
            margin-bottom: 25px;
        }
        .login-button {
            width: 170px;
            height: 44px;
            flex-shrink: 0;
            border-radius: 8px;
            background: #D9D9D9;
            border: none;
            cursor: pointer;
            margin-top: 20px;
            color: #000;
            font-family: 'Anuphan', sans-serif;
            font-size: 15px;
            font-style: normal;
            font-weight: 600;
            line-height: normal;
            letter-spacing: 4.8px;
            text-transform: uppercase;
        }
        .error-message {
            color: #FF6B6B;
            margin-top: 10px;
            font-size: 14px;
        }
        </style>
    <div class="container">
        <div class="login-title">LOG IN</div>
        
        <asp:TextBox ID="EmailInput" runat="server" CssClass="input-field" placeholder="Email" TextMode="Email"></asp:TextBox>
        <br />
        <asp:TextBox ID="PasswordInput" runat="server" CssClass="input-field" placeholder="Password" TextMode="Password"></asp:TextBox>
        <br />
        <a href="ForgotPassword.aspx" class="forgot-password">Forgot your password?</a>
        <br />
        <asp:Button ID="LoginButton" runat="server" Text="LET ME IN!" CssClass="login-button" OnClick="LoginButton_Click" />
        <br />
        <a href="signup.aspx" class="forgot-password">Create Account</a>
        <br>
        <asp:Label ID="ErrorMessage" runat="server" CssClass="error-message" Visible="false"></asp:Label>
    </div>
</asp:Content>