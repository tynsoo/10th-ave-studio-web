<%@ Page Title="" Language="C#" MasterPageFile="~/10thAveStudio.Master" AutoEventWireup="true" CodeBehind="Rentals.aspx.cs" Inherits="_10thAveStudioWeb.WebForm7" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
<style>
        .rental-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 40px 15px;
        }
        .rental-card {
            background-color: #1E1E1E;
            border-radius: 12px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
            overflow: hidden;
        }
        .rental-header {
            background-color: #800000;
            color: white;
            padding: 20px;
            text-align: center;
        }
        .rental-body {
            display: flex;
            flex-wrap: wrap;
        }
        .calendar-section {
            flex: 0 0 60%;
            padding: 20px;
        }
        .booking-section {
            flex: 0 0 40%;
            background-color: #800000;
            padding: 20px;
            color: white;
        }
        .calendar-custom {
            width: 100%;
            background-color: #1E1E1E;
            color: white;
        }
        .calendar-custom th {
            background-color: #800000;
            color: white;
            padding: 10px;
            text-align: center;
        }
        .calendar-custom td {
            padding: 8px;
            text-align: center;
            border: 1px solid #333;
        }
        .booking-form .form-group {
            margin-bottom: 15px;
        }
        .booking-form label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }
        .booking-form input[type="text"],
        .booking-form input[type="time"] {
            width: 100%;
            padding: 10px;
            background-color: #2E2E2E;
            border: 1px solid #444;
            color: white;
            border-radius: 6px;
        }
        .booking-btn {
            width: 100%;
            padding: 12px;
            background-color: #D9D9D9;
            color: black;
            border: none;
            border-radius: 8px;
            font-weight: bold;
            text-transform: uppercase;
            letter-spacing: 2px;
            margin-top: 15px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }
        .booking-btn:hover {
            background-color: #FFFFFF;
        }
        .validation-error {
            color: #FF4136;
            font-size: 0.9em;
            margin-top: 5px;
        }
        @media (max-width: 768px) {
            .rental-body {
                flex-direction: column;
            }
            .calendar-section,
            .booking-section {
                flex: 0 0 100%;
            }
        }
        .calendar-custom .available-date {
            background-color: white;
            color: black;
            cursor: pointer;
        }
        .calendar-custom .unavailable-date {
            background-color: #808080;  /* Gray background */
            color: white;
            cursor: not-allowed;
            opacity: 0.7;
        }

        /* Hover effects */
        .calendar-custom .available-date:hover {
            background-color: #333;
        }
        .calendar-custom .unavailable-date:hover,
        .calendar-custom .past-date:hover {
            background-color: #666;
        }
</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div class="rental-container">
<div class="rental-card">
<div class="rental-header">
<h1>Studio Rental Booking</h1>
</div>
<div class="rental-body">
<div class="calendar-section">
<asp:Calendar ID="RentalCalendarControl" runat="server" 
                        CssClass="calendar-custom"
                        DayNameFormat="Full"
                        SelectionMode="Day"
                        ShowGridLines="true"
                        OnDayRender="RentalCalendarControl_DayRender" 
                        OnSelectionChanged="RentalCalendarControl_SelectionChanged">
</asp:Calendar>
</div>
<div class="booking-section">
<asp:Panel ID="BookingPanel" runat="server" Visible="false" CssClass="booking-form">
<div class="form-group">
<asp:Label ID="lblEventTitle" runat="server" Text="Event Title" />
<asp:TextBox ID="txtEventTitle" runat="server" placeholder="Enter Event Title" />
<asp:RequiredFieldValidator ID="rfvEventTitle" runat="server" 
                                ControlToValidate="txtEventTitle" 
                                ErrorMessage="Event Title is required" 
                                Display="Dynamic" 
                                CssClass="validation-error" />
</div>
<div class="form-group">
<asp:Label ID="lblEventTime" runat="server" Text="Event Time" />
<asp:TextBox ID="txtEventTime" runat="server" TextMode="Time" />
<asp:RequiredFieldValidator ID="rfvEventTime" runat="server" 
                                ControlToValidate="txtEventTime" 
                                ErrorMessage="Event Time is required" 
                                Display="Dynamic" 
                                CssClass="validation-error" />
</div>
<asp:Button ID="btnBookRental" runat="server" Text="Book Rental" 
                            CssClass="booking-btn" OnClick="BookRental_Click" />
<asp:Label ID="lblMessage" runat="server" CssClass="d-block mt-3 text-center" />
</asp:Panel>
</div>
</div>
</div>
</div>
</asp:Content>