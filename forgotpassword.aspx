<%@ Page Title="" Language="C#" MasterPageFile="~/10thAveStudio.Master" AutoEventWireup="true" CodeBehind="ForgotPassword.aspx.cs" Inherits="_10thAveStudioWeb.ForgotPassword" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <link href="https://fonts.googleapis.com/css2?family=Anuphan:wght@400;600;700&display=swap" rel="stylesheet">
    <style type="text/css">
        .container {
            font-family: 'Anuphan', sans-serif;
            max-width: 800px;
            margin: 40px auto;
            padding: 20px;
        }
        .title {
            font-size: 32px;
            font-weight: 700;
            margin-bottom: 20px;
            color: #000;
        }
        .description {
            font-size: 16px;
            line-height: 1.5;
            margin-bottom: 30px;
            color: #333;
        }
        .label {
            display: block;
            font-weight: 600;
            margin-bottom: 10px;
            color: #000;
        }
        .input-field {
            width: 100%;
            padding: 12px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 16px;
            margin-bottom: 25px;
            box-sizing: border-box;
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
        .support-link {
            color: #2D7BB7;
            text-decoration: none;
        }
        .support-link:hover {
            text-decoration: underline;
        }
        .message {
            padding: 15px;
            margin-bottom: 20px;
            border-radius: 4px;
        }
        .success-message {
            background-color: #E8F5E9;
            color: #2E7D32;
            border: 1px solid #C8E6C9;
        }
        .error-message {
            background-color: #FFEBEE;
            color: #C62828;
            border: 1px solid #FFCDD2;
        }
    </style>

    <div class="container">
        <h1 class="title">Forgot your password?</h1>
        <p class="description">
            Enter your email address for verification. If you have forgotten your email address, please contact <a href="mailto:support@10thavestudio.com" class="support-link">support</a>.
        </p>

        <asp:Label ID="lblMessage" runat="server" CssClass="message" Visible="false"></asp:Label>
        <br/ >
        <div id="forgotPasswordForm" runat="server">
            <label for="EmailInput" class="label">Username or Email</label>
            <asp:TextBox ID="EmailInput" runat="server" CssClass="input-field" placeholder="Enter your username or email"></asp:TextBox>
            
            <asp:Button ID="SubmitButton" runat="server" Text="NEXT" CssClass="submit-button" OnClick="SubmitButton_Click" />
        </div>
    </div>
</asp:Content>