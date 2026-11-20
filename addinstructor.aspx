<%@ Page Title="" Language="C#" MasterPageFile="~/10thAveAdmin.Master" AutoEventWireup="true" CodeBehind="addinstructor.aspx.cs" Inherits="_10thAveStudioWeb.WebForm19" %>
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
        align-items: center;
        justify-content: center;
        padding: 40px 20px;
    }
    .title {
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
    .grid-center {
        margin-left: auto;
        margin-right: auto;
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
    .login-button:disabled {
            background: #555555;
            color: #aaa;
            opacity: 0.6;
            cursor: not-allowed;
    }
    .back-button
    {
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
        margin-left: 100px;
        text-transform: uppercase;
    }
    </style>
    <asp:Button ID="Button1" cssclass="back-button" runat="server" Text="<-- Back" PostbackUrl="~/AdminInstructors.aspx"/>
<div class="container">
    <br />
        <div class="title">ADD NEW INSTRUCTOR</div>
        <asp:TextBox ID="FirstNameInput" runat="server" CssClass="input-field" placeholder="First Name"></asp:TextBox>
        <br />
        <asp:TextBox ID="LastNameInput" runat="server" CssClass="input-field" placeholder="Last Name"></asp:TextBox>
        <br />
        <asp:TextBox ID="EmailInput" runat="server" CssClass="input-field" placeholder="Email" TextMode="Email"></asp:TextBox>
        <br />
        <asp:TextBox ID="PhoneNum" runat="server" CssClass="input-field" placeholder="Phone Number" TextMode="Phone" MaxLength="11"></asp:TextBox>
        <br />
        <asp:TextBox ID="SocMedInput" runat="server" CssClass="input-field" placeholder="Facebook Profile Link" TextMode="Url"></asp:TextBox>
        <br />
        <asp:TextBox ID="PasswordInput" runat="server" CssClass="input-field" placeholder="Password" TextMode="Password"></asp:TextBox>
        <br />
        <asp:TextBox ID="Specialty" runat="server" CssClass="input-field" placeholder="Specialty"></asp:TextBox>
        <br />
        <asp:TextBox ID="Experience" runat="server" CssClass="input-field" placeholder="Experience"></asp:TextBox>
        <br />
        <asp:Button ID="submit" runat="server" Text="SUBMIT" CssClass="login-button" OnClick="submit_Click" />
</div>
</asp:Content>
