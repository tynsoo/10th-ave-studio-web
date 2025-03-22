<%@ Page Title="" Language="C#" MasterPageFile="~/10thAveStudio.Master" AutoEventWireup="true" CodeBehind="login.aspx.cs" Inherits="_10thAveStudioWeb.WebForm8" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <link href="https://fonts.googleapis.com/css2?family=Anuphan:wght@700&display=swap" rel="stylesheet">
        <style type="text/css">
        .auto-style4 {
            color: #FFF;
            text-align: center;
            font-family: 'Anuphan', sans-serif;
            font-style: normal;
            font-weight: 700;
            line-height: 121.392%;
            letter-spacing: 2.4px;
            background-color: #000000;
        }
        .auto-style5 { 
            background: #1E1E1E;
            border-radius: 8px;
            color: #FFF;
            font-family: 'Anuphan', sans-serif;
            font-style: normal;
            font-weight: 700;
            padding: 10px;
            border: none;
        }
        .auto-style6 {
            font-size: 48px;
        }
        </style>
    <div class="auto-style4">
        <br /><br />
        <span class="auto-style6">LOG IN</span><br /><br />
        <asp:TextBox ID="TextBox1" runat="server" Height="50px" Width="164px" CssClass="auto-style5" placeholder="E-mail"></asp:TextBox>
        <br />
        <asp:TextBox ID="TextBox2" runat="server" Height="50px" Width="164px" CssClass="auto-style5" placeholder="Password" TextMode="Password"></asp:TextBox>
        <br />
    </div>
</asp:Content>