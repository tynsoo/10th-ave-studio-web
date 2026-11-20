<%@ Page Title="" Language="C#" MasterPageFile="~/10thAveAdmin.Master" AutoEventWireup="true" CodeBehind="AdminSchedules.aspx.cs" Inherits="_10thAveStudioWeb.WebForm12" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
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
        .grid-container {
            overflow-x: auto;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
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
        ALL SCHEDULED DANCE CLASSES
    </h1>
    <br />
    <div class="container">
        <asp:Button ID="newclassbtn" runat="server" Text="+ Schedule new class" CssClass="login-button" PostBackUrl="~/newclass.aspx" />
    </div>
    <div class="grid-container">
        <asp:GridView ID="ScheduleGridView" runat="server" AutoGenerateColumns="False" 
            CssClass="grid-center" Width="90%" GridLines="Horizontal">
            <Columns>
                <asp:BoundField DataField="ClassName" HeaderText="Class"> 
                    <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="Date" HeaderText="Date"> 
                    <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="Time" HeaderText="Time" > 
                    <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="Location" HeaderText="Location" > 
                    <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="Instructor" HeaderText="Instructor" > 
                    <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
            </Columns>
            <HeaderStyle BackColor="#800000" Font-Bold="True" ForeColor="White" />
            <EmptyDataTemplate>
                <div style="text-align:center; color:white;">No classes scheduled.</div>
            </EmptyDataTemplate>
        </asp:GridView>
    </div>
</asp:Content>