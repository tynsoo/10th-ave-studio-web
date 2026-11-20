<%@ Page Title="" Language="C#" MasterPageFile="~/10thAveAdmin.Master" AutoEventWireup="true" CodeBehind="AdminClasses.aspx.cs" Inherits="_10thAveStudioWeb.WebForm11" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <link href="https://fonts.googleapis.com/css2?family=Anuphan:wght@400;600;700&display=swap" rel="stylesheet">
    <style type="text/css">
        .admin-panel {
            padding: 20px;
            max-width: 1200px;
            margin: 0 auto;
            position: relative;
        }

        .auto-style4 {
            text-align: right;
        }
        .grid-center {
            margin-left: auto;
            margin-right: auto;
        }
        .login-button {
            width: 350px;
            height: 50px;
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
        .container {
            background-color: #000000;
            color: #FFF;
            text-align: center;
            font-family: 'Anuphan', sans-serif;
            padding: 40px 20px;
            align-items: center;
            justify-content: center;
        }        

    </style>
    <br />
     <br />
        <h1 style="color: #FFF; 
               text-align: center; 
               font-family: Anuphan; 
               font-size: 32px; 
               font-style: normal; 
               font-weight: 700; 
               line-height: 121.392%; 
               letter-spacing: 1.6px;">
        DANCE STYLES OFFERED
    </h1>
    <br />
    <div class="container"><asp:Button ID="addclassbtn" runat="server" Text="+ Add new class" CssClass="login-button" PostBackUrl="~/addclass.aspx" /><br /><br />
    <asp:GridView ID="GridView1" runat="server" Width="80%" CssClass="grid-center" GridLines="Horizontal">
            <HeaderStyle BackColor="#800000" Font-Bold="True" ForeColor="White" />
    </asp:GridView>
</div>
</asp:Content>
