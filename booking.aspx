<%@ Page Title="" Language="C#" MasterPageFile="~/10thAveStudio.Master" AutoEventWireup="true" CodeBehind="booking.aspx.cs" Inherits="_10thAveStudioWeb.WebForm17" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .booking-container {
            width: 90%;
            max-width: 800px;
            margin: 2rem auto;
            padding: 20px;
            background-color: #000;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(255,255,255,0.1);
        }

        .booking-title {
            color: #fff;
            margin-bottom: 1.5rem;
            font-size: 2.2rem;
            text-align: center;
            border-bottom: 3px solid #800000;
            padding-bottom: 12px;
        }

        .booking-subtitle {
            text-align: center;
            color: #ccc;
            margin-bottom: 2rem;
            font-style: italic;
        }

        .class-details {
            background-color: #222;
            padding: 20px;
            border-radius: 8px;
            margin-bottom: 25px;
            color: #fff;
        }

        .detail-row {
            display: flex;
            margin-bottom: 15px;
        }

        .detail-label {
            flex: 0 0 120px;
            font-weight: bold;
            color: #800000;
        }

        .detail-value {
            flex: 1;
        }

        .price-value {
            font-weight: bold;
            color: #28a745;
            font-size: 1.2rem;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-label {
            display: block;
            margin-bottom: 8px;
            color: #fff;
            font-weight: 600;
        }

        .form-control {
            width: 100%;
            padding: 10px;
            border-radius: 4px;
            border: 1px solid #444;
            background-color: #333;
            color: #fff;
        }

        .form-control:focus {
            outline: none;
            border-color: #800000;
        }

        .form-row {
            display: flex;
            flex-wrap: wrap;
            margin: 0 -10px;
        }

        .form-col {
            flex: 1;
            padding: 0 10px;
            min-width: 200px;
        }

        .button-group {
            display: flex;
            justify-content: space-between;
            margin-top: 30px;
        }

        .btn {
            padding: 12px 24px;
            border-radius: 4px;
            cursor: pointer;
            font-weight: 600;
            transition: background-color 0.3s;
            border: none;
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

        .success-message {
            background-color: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }

        @media (max-width: 768px) {
            .booking-container {
                width: 95%;
                padding: 15px;
            }
            
            .booking-title {
                font-size: 1.8rem;
            }
            
            .form-row {
                flex-direction: column;
            }
            
            .form-col {
                margin-bottom: 15px;
            }
            
            .button-group {
                flex-direction: column;
                gap: 10px;
            }
            
            .btn {
                width: 100%;
            }
            .form-control[type="file"] {
                padding: 8px;
                background-color: #444;
            }

            .upload-instructions {
                font-size: 0.85rem;
                color: #ccc;
                margin-top: 5px;
            }
            .booking-container {
            width: 90%;
            max-width: 800px;
            margin: 2rem auto;
            padding: 20px;
            background-color: #000;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(255,255,255,0.1);
        }
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <div class="booking-container">
        <h1 class="booking-title">Book Your Class</h1>
        <p class="booking-subtitle">Complete your booking details</p>
        
        <asp:Panel ID="pnlMessage" runat="server" CssClass="message" Visible="false">
            <asp:Label ID="lblMessage" runat="server" />
        </asp:Panel>
        
        <!-- Class Details Section -->
        <div class="class-details">
            <h3>Class Details</h3>
            <div class="detail-row">
                <div class="detail-label">Class:</div>
                <div class="detail-value"><asp:Label ID="lblClassName" runat="server" /></div>
            </div>
            <div class="detail-row">
                <div class="detail-label">Instructor:</div>
                <div class="detail-value"><asp:Label ID="lblInstructor" runat="server" /></div>
            </div>
            <div class="detail-row">
                <div class="detail-label">Day:</div>
                <div class="detail-value"><asp:Label ID="lblDay" runat="server" /></div>
            </div>
            <div class="detail-row">
                <div class="detail-label">Time:</div>
                <div class="detail-value"><asp:Label ID="lblTime" runat="server" /></div>
            </div>
            <div class="detail-row">
                <div class="detail-label">Location:</div>
                <div class="detail-value"><asp:Label ID="lblLocation" runat="server" /></div>
            </div>
            <div class="detail-row">
                <div class="detail-label">Price:</div>
                <div class="detail-value price-value"><asp:Label ID="lblPrice" runat="server" /></div>
            </div>
        </div>
        
        <!-- Booking Form -->
        <div class="booking-form">
            <h3 style="color: #fff; margin-bottom: 20px;">Booking Information</h3>
            
            <div class="form-group">
                <asp:Label ID="lblPaymentRef" runat="server" Text="Payment Reference Number" CssClass="form-label" AssociatedControlID="txtPaymentRef" />
                <asp:TextBox ID="txtPaymentRef" runat="server" CssClass="form-control" placeholder="Enter your payment reference number" />
                <asp:RequiredFieldValidator ID="rfvPaymentRef" runat="server" 
                    ControlToValidate="txtPaymentRef" 
                    ErrorMessage="Payment reference number is required" 
                    Display="Dynamic" ForeColor="#FF3300" />
            </div>

            <div class="form-group">
                <asp:Label ID="lblPaymentProof" runat="server" Text="Payment Confirmation Screenshot" CssClass="form-label" AssociatedControlID="filePaymentProof" />
                <asp:FileUpload ID="filePaymentProof" runat="server" CssClass="form-control" />
                <asp:RequiredFieldValidator ID="rfvPaymentProof" runat="server" 
                    ControlToValidate="filePaymentProof" 
                    ErrorMessage="Payment confirmation screenshot is required" 
                    Display="Dynamic" ForeColor="#FF3300" />
            </div>
            
            <div class="button-group">
                <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btn btn-secondary" OnClick="btnCancel_Click" CausesValidation="false" />
                <asp:Button ID="btnBookNow" runat="server" Text="Complete Booking" CssClass="btn btn-primary" OnClick="btnBookNow_Click" />
            </div>
        </div>
    </div>
</asp:Content>

