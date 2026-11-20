<%@ Page Title="" Language="C#" MasterPageFile="~/10thAveAdmin.Master" AutoEventWireup="true" CodeBehind="addclass.aspx.cs" Inherits="_10thAveStudioWeb.WebForm14" %>
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
    .title {
        font-size: 48px;
        font-weight: 700;
        line-height: 121.392%;
        letter-spacing: 2.4px;
        margin-bottom: 30px;
    }
    .login-button:disabled {
        background: #555555;
        color: #aaa;
        opacity: 0.6;
        cursor: not-allowed;
    }
    .back-button {
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
    .gridview {
        width: 90%;
        margin-bottom: 20px;
        background-color: #1E1E1E;
        color: #FFF;
        margin-left: auto;
        margin-right: auto;
    }
    .gridview th {
        background-color: #800000;
        padding: 10px;
        text-align: center;
    }
    .gridview td {
        padding: 10px;
        border-bottom: 1px solid #444;
    }
    </style>
    <asp:Button ID="Button1" CssClass="back-button" runat="server" Text="<-- Back" PostbackUrl="~/AdminClasses.aspx"/>
    
    <div class="container">
        <asp:GridView ID="InstructorGridView" runat="server" AutoGenerateColumns="False" CssClass="gridview" 
            OnRowDataBound="InstructorGridView_RowDataBound" GridLines="Horizontal">
            <Columns>
                <asp:BoundField DataField="Instructor_ID" HeaderText="Instructor ID" />
                <asp:BoundField DataField="FullName" HeaderText="Full Name" />
                <asp:BoundField DataField="Specialty" HeaderText="Specialty" />
            </Columns>
        </asp:GridView>

        <div class="title">
            ADD NEW CLASS
        </div>
        <asp:TextBox ID="Class_Name" runat="server" CssClass="input-field" placeholder="Class Name"></asp:TextBox>
        <br />
        <asp:TextBox ID="Class_desc" runat="server" CssClass="input-field" placeholder="Class Description"></asp:TextBox>
        <br />
        <asp:TextBox ID="Instructor_ID" runat="server" CssClass="input-field" placeholder="Instructor ID"></asp:TextBox>
        <br />
        <asp:TextBox ID="Price" runat="server" CssClass="input-field" placeholder="Class Price"></asp:TextBox>
        <br />
        <asp:TextBox ID="MaxStudents" runat="server" CssClass="input-field" placeholder="Max Students"></asp:TextBox>
        <br />
        <asp:Button ID="submit" runat="server" Text="SUBMIT" CssClass="login-button" OnClick="submit_Click" />
    </div>
</asp:Content>