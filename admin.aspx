<%@ Page Title="" Language="C#" MasterPageFile="~/10thAveAdmin.Master" AutoEventWireup="true" CodeBehind="admin.aspx.cs" Inherits="_10thAveStudioWeb.WebForm10" %>
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
            margin-top: 10px;
        }
        .grid-center {
            margin-left: auto;
            margin-right: auto;
        }
        .attendance-buttons {
            display: flex;
            justify-content: space-between;
            margin: 15px auto;
            max-width: 90%;
        }
        .btn-attendance {
            background-color: #800000;
            color: white;
            padding: 5px 10px;
            text-decoration: none;
            border-radius: 5px;
            font-family: Anuphan, sans-serif;
            display: inline-block;
            font-size: 14px;
        }
        .btn-attendance:hover {
            background-color: #600000;
        }
    </style>
    <br />
    <br />
    <div style="text-align: center; top: 50%; left: 50%;">
        <img alt="10th Avenue Studio Logo" src="img/altlogo.png" width="120px" height="auto" 
             style="box-shadow: 10px 12px 11.2px 0px rgba(182, 9, 9, 0.58);" />
    </div>
    <div style="text-align: center; margin: 20px 0;">
    <h1 style="color: #FFF; 
               text-align: center; 
               font-family: Anuphan; 
               font-size: 32px; 
               font-style: normal; 
               font-weight: 700; 
               line-height: 121.392%; 
               letter-spacing: 1.6px;">
        WEEKLY SCHEDULE
    </h1>
</div>
<div>
   <asp:GridView ID="ScheduleGridView" runat="server" AutoGenerateColumns="False" 
    CssClass="grid-center" Width="90%" GridLines="Horizontal">
           <HeaderStyle BackColor="#800000" Font-Bold="True" ForeColor="White" />
    <Columns>
        <asp:BoundField DataField="Class_Name" HeaderText="Class" > <ItemStyle HorizontalAlign="Center" /></asp:BoundField>
        <asp:BoundField DataField="Date" HeaderText="Date" > <ItemStyle HorizontalAlign="Center" /></asp:BoundField>
        <asp:BoundField DataField="Time" HeaderText="Time" > <ItemStyle HorizontalAlign="Center" /></asp:BoundField>
        <asp:BoundField DataField="Location" HeaderText="Location" > <ItemStyle HorizontalAlign="Center" /></asp:BoundField>
        <asp:BoundField DataField="Instructor" HeaderText="Instructor" > <ItemStyle HorizontalAlign="Center" /></asp:BoundField>
        <asp:BoundField DataField="CurrentAttendance" HeaderText="Attendance" > <ItemStyle HorizontalAlign="Center" /></asp:BoundField>
        <asp:BoundField DataField="Sales" HeaderText="Sales (₱)" DataFormatString="{0:N2}">
            <ItemStyle HorizontalAlign="Center" />
        </asp:BoundField>

        <asp:TemplateField HeaderText="Actions">
            <ItemTemplate>
                <asp:HyperLink ID="lnkScanAttendance" runat="server" 
            NavigateUrl='<%# "QRCodeScanner.aspx?Schedule_ID=" + Eval("Schedule_ID") %>' 
            CssClass="btn-attendance">Scan Attendance</asp:HyperLink>
            </ItemTemplate>
            <ItemStyle HorizontalAlign="Center" />
        </asp:TemplateField>
    </Columns>
</asp:GridView>
</div>
    <div class="attendance-buttons">
        <asp:HyperLink ID="HyperLink7" runat="server" NavigateUrl="~/AdminSchedules.aspx" CssClass="btn-attendance">Check all Schedules</asp:HyperLink>
    </div>
</asp:Content>