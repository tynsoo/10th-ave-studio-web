<%@ Page Title="" Language="C#" MasterPageFile="~/10thAveStudio.Master" AutoEventWireup="true" CodeBehind="forgotpassword1.aspx.cs" Inherits="_10thAveStudioWeb.WebForm18" %>
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
        .submit-button {
            background-color: #D12026;
            color: white;
            border: none;
            padding: 12px 20px;
            font-weight: 600;
            text-transform: uppercase;
            border-radius: 4px;
            cursor: pointer;
            font-size: 14px;
            letter-spacing: 1px;
        }
        .submit-button:hover {
            background-color: #B01B20;
        }
        .error-message {
            color: #FF6B6B;
            margin-top: 10px;
            font-size: 14px;
        }
        .message {
            padding: 15px;
            margin-bottom: 20px;
            border-radius: 4px;
        }
        </style>
    <div class="container">
        <div class="login-title">UPDATE YOUR PASSWORD</div>
        <br />
        New password<br />
        <asp:TextBox ID="PasswordInput1" runat="server" CssClass="input-field" placeholder="Password" TextMode="Password"></asp:TextBox>
        <br />
        Confirm new password<br />
        <asp:TextBox ID="PasswordInput2" runat="server" CssClass="input-field" placeholder="Re-type password" TextMode="Password"></asp:TextBox>
        <br />
        <asp:Label ID="lblMessage" runat="server" CssClass="message" Visible="false"></asp:Label><br />
        <asp:Button ID="SubmitButton" runat="server" Text="UPDATE PASSWORD" CssClass="submit-button" OnClick="SubmitButton_Click" />
    </div>
</asp:Content>
