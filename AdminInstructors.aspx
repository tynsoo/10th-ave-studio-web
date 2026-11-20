<%@ Page Title="" Language="C#" MasterPageFile="~/10thAveAdmin.Master" AutoEventWireup="true" CodeBehind="AdminInstructors.aspx.cs" Inherits="_10thAveStudioWeb.WebForm15" %>
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
        .grid-center {
            margin-left: auto;
            margin-right: auto;
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
        ALL REGISTERED INSTRUCTORS
    </h1>
    <br />
    <div class="container">
        <asp:Button ID="newInstructorBtn" runat="server" Text="+ Add New Instructor" CssClass="login-button" PostBackUrl="~/AddInstructor.aspx" />
    </div>
    <asp:GridView ID="ScheduleGridView" runat="server" AutoGenerateColumns="False" 
        CssClass="grid-center" Width="90%" GridLines="Horizontal">
        <Columns>
            <asp:BoundField DataField="Name" HeaderText="Instructor Name"> <ItemStyle HorizontalAlign="Center" /></asp:BoundField>
            <asp:BoundField DataField="Specialty" HeaderText="Dance Specialty"> <ItemStyle HorizontalAlign="Center" /></asp:BoundField>
            <asp:BoundField DataField="Experience" HeaderText="Years of Experience" > <ItemStyle HorizontalAlign="Center" /></asp:BoundField>
        </Columns>
        <HeaderStyle BackColor="#800000" Font-Bold="True" ForeColor="White" />
    </asp:GridView>
</asp:Content>