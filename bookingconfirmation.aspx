<%@ Page Title="" Language="C#" MasterPageFile="~/10thAveStudio.Master" AutoEventWireup="true" CodeBehind="bookingconfirmation.aspx.cs" Inherits="_10thAveStudioWeb.WebForm16" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .confirmation-container {
            width: 90%;
            max-width: 700px;
            margin: 3rem auto;
            padding: 30px;
            background-color: #000;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(255,255,255,0.1);
            text-align: center;
        }

        .confirmation-icon {
            font-size: 3rem;
            color: #28a745;
            margin-bottom: 1rem;
        }

        .confirmation-title {
            color: #fff;
            margin-bottom: 1.5rem;
            font-size: 2.2rem;
            text-align: center;
            border-bottom: 3px solid #800000;
            padding-bottom: 12px;
        }

        .confirmation-message {
            color: #ccc;
            font-size: 1.1rem;
            margin-bottom: 2rem;
            line-height: 1.6;
        }

        .btn {
            padding: 12px 24px;
            border-radius: 4px;
            cursor: pointer;
            font-weight: 600;
            transition: background-color 0.3s;
            border: none;
            margin: 0 10px;
            display: inline-block;
            text-decoration: none;
        }

        .btn-primary {
            background-color: #800000;
            color: white;
        }

        .btn-primary:hover {
            background-color: #a00000;
        }

        .btn-secondary {
            background-color: #444;
            color: white;
        }

        .btn-secondary:hover {
            background-color: #555;
        }

    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="confirmation-container">
        <div class="confirmation-icon">✓</div>
        <h1 class="confirmation-title">Booking Confirmed!</h1>
        <p class="confirmation-message">
            Thank you for booking a class with 10th Avenue Studio. Your booking has been successfully processed.
            <br /><br />
            We've sent a confirmation email to the address you provided with all the details.
            <br /><br />
            We look forward to seeing you in class!
        </p>
        
        <div>
            <a href="Schedules.aspx" class="btn btn-secondary">View All Classes</a>
            <a href="HomePage.aspx" class="btn btn-primary">Return to Home</a>
        </div>
    </div>
</asp:Content>

