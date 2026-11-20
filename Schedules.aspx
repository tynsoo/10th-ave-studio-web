<%@ Page Title="" Language="C#" MasterPageFile="~/10thAveStudio.Master" AutoEventWireup="true" CodeBehind="Schedules.aspx.cs" Inherits="_10thAveStudioWeb.WebForm3" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .schedules-container {
            width: 90%;
            max-width: 1200px;
            margin: 2rem auto;
            padding: 20px;
            background-color: #000;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(255,255,255,0.1);
        }

        .schedules-title {
            color: #fff;
            margin-bottom: 1.5rem;
            font-size: 2.2rem;
            text-align: center;
            border-bottom: 3px solid #800000;
            padding-bottom: 12px;
        }

        .schedules-subtitle {
            text-align: center;
            color: #ccc;
            margin-bottom: 2rem;
            font-style: italic;
        }

        .grid-container {
            width: 100%;
            overflow-x: auto;
        }

        .schedule-grid {
            width: 100%;
            border-collapse: collapse;
            margin-top: 10px;
            box-shadow: 0 1px 3px rgba(255,255,255,0.1);
        }

        .schedule-grid th {
            background-color: #800000;
            color: white;
            padding: 14px;
            text-align: left;
            font-weight: 600;
            letter-spacing: 0.5px;
        }

        .schedule-grid tr:nth-child(even) {
            background-color: #222;
        }

        .schedule-grid tr:hover {
            background-color: #333;
            transition: background-color 0.2s ease;
        }

        .schedule-grid td {
            padding: 14px;
            border-bottom: 1px solid #444;
            vertical-align: middle;
            color: #fff;
        }

        .message {
            padding: 15px;
            border-radius: 4px;
            margin-bottom: 15px;
        }

        .error-message {
            background-color: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }

        .info-message {
            background-color: #e2e3e5;
            color: #383d41;
            border: 1px solid #d6d8db;
            text-align: center;
            font-size: 1.1rem;
            padding: 20px;
        }

        .class-name {
            font-weight: bold;
            color: #800000;
        }

        .day-cell {
            font-weight: 600;
        }

        .time-cell {
            color: #6c757d;
        }

        .price-cell {
            font-weight: bold;
            color: #28a745;
        }

        .location-badge {
            display: inline-block;
            padding: 3px 8px;
            border-radius: 12px;
            font-size: 0.8rem;
            font-weight: 600;
            text-align: center;
        }

        .location-1 {
            background-color: #28a745;
            color: white;
        }

        .location-2 {
            background-color: #007bff;
            color: white;
        }
        
        .instructor-name {
            color: #6c757d;
            font-style: italic;
        }

        .filter-container {
            display: flex;
            flex-wrap: wrap;
            gap: 15px;
            margin-bottom: 20px;
            align-items: center;
            background-color: #222;
            padding: 15px;
            border-radius: 8px;
        }

        .filter-label {
            color: #fff;
            margin-right: 5px;
            font-weight: 600;
        }

        .filter-dropdown {
            padding: 8px 12px;
            border-radius: 4px;
            background-color: #333;
            color: #fff;
            border: 1px solid #444;
        }

        .filter-button {
            padding: 8px 16px;
            background-color: #800000;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .filter-button:hover {
            background-color: #a00000;
        }

        .book-button {
            padding: 6px 12px;
            background-color: #800000;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .book-button:hover {
            background-color: #a00000;
        }

        @media (max-width: 768px) {
            .schedules-container {
                width: 95%;
                padding: 15px;
            }
            
            .schedules-title {
                font-size: 1.8rem;
            }
            
            .schedule-grid td, .schedule-grid th {
                padding: 10px;
            }
            
            .filter-container {
                flex-direction: column;
                align-items: flex-start;
            }
            
            .filter-group {
                width: 100%;
                margin-bottom: 10px;
            }
            
            .filter-dropdown {
                width: 100%;
            }
            .capacity-display {
                margin-left: 8px;
                color: #ddd;
                font-size: 0.9rem;
                display: inline-block;
            }

            .disabled-button {
                background-color: #666 !important;
                cursor: not-allowed !important;
            }

            /* Update your existing book-button style to include this */
            .book-button {
                display: inline-block;
                /* Keep all your existing styles here */
            }
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="schedules-container">
        <h1 class="schedules-title">10th Avenue Studio Class Schedule</h1>
        <p class="schedules-subtitle">Find the perfect time for your next class</p>
        
        <asp:Panel ID="pnlError" runat="server" CssClass="message error-message" Visible="false">
            <asp:Label ID="lblError" runat="server" />
        </asp:Panel>
        
        <div class="filter-container">
            <div class="filter-group">
                <span class="filter-label">Day:</span>
                <asp:DropDownList ID="ddlDay" runat="server" CssClass="filter-dropdown" AutoPostBack="false">
                    <asp:ListItem Text="All Days" Value="" Selected="True" />
                    <asp:ListItem Text="Monday" Value="Monday" />
                    <asp:ListItem Text="Tuesday" Value="Tuesday" />
                    <asp:ListItem Text="Wednesday" Value="Wednesday" />
                    <asp:ListItem Text="Thursday" Value="Thursday" />
                    <asp:ListItem Text="Friday" Value="Friday" />
                    <asp:ListItem Text="Saturday" Value="Saturday" />
                    <asp:ListItem Text="Sunday" Value="Sunday" />
                </asp:DropDownList>
            </div>
            
            <div class="filter-group">
                <span class="filter-label">Location:</span>
                <asp:DropDownList ID="ddlLocation" runat="server" CssClass="filter-dropdown" AutoPostBack="false">
                    <asp:ListItem Text="All Locations" Value="" Selected="True" />
                    <asp:ListItem Text="Studio 1" Value="1" />
                    <asp:ListItem Text="Studio 2" Value="2" />
                </asp:DropDownList>
            </div>
            
            <asp:Button ID="btnFilter" runat="server" Text="Apply Filters" CssClass="filter-button" OnClick="btnFilter_Click" />
            <asp:Button ID="btnClear" runat="server" Text="Clear Filters" CssClass="filter-button" OnClick="btnClear_Click" />
        </div>
        
        <div class="grid-container">
            <asp:Label ID="lblNoSchedules" runat="server" Text="No schedules are currently available. Please check back soon for our upcoming schedule." CssClass="message info-message" Visible="false"></asp:Label>
            
            <asp:GridView ID="gvSchedules" runat="server" AutoGenerateColumns="false" 
                CssClass="schedule-grid" GridLines="None"
                EmptyDataText="" OnRowDataBound="gvSchedules_RowDataBound">
                <Columns>
                    <asp:BoundField DataField="ClassName" HeaderText="Class" ItemStyle-CssClass="class-name" />
                    <asp:BoundField DataField="InstructorName" HeaderText="Instructor" ItemStyle-CssClass="instructor-name" />
                    <asp:BoundField DataField="Schedule_Day" HeaderText="Day" ItemStyle-CssClass="day-cell" />
                    <asp:BoundField DataField="Schedule_Time" HeaderText="Time" ItemStyle-CssClass="time-cell" />
                    <asp:TemplateField HeaderText="Location">
                        <ItemTemplate>
                            <span class='location-badge location-<%# Eval("Location") %>'>
                                Studio <%# Eval("Location") %>
                            </span>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="Price" HeaderText="Price" ItemStyle-CssClass="price-cell" />
                    <asp:TemplateField HeaderText="Booking">
                        <ItemTemplate>
                            <asp:Button ID="btnBookNow" runat="server" Text="Book Now" 
                                CssClass="book-button" 
                                CommandName="BookClass" 
                                CommandArgument='<%# Eval("Schedule_ID") %>' 
                                OnClick="btnBookNow_Click" />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>
    </div>
</asp:Content>

