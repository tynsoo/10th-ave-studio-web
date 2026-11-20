<%@ Page Title="" Language="C#" MasterPageFile="~/10thAveAdmin.Master" AutoEventWireup="true" CodeBehind="QRCodeScanner.aspx.cs" Inherits="_10thAveStudioWeb.WebForm23" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="https://rawgit.com/schmich/instascan-builds/master/instascan.min.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <link href="https://fonts.googleapis.com/css2?family=Anuphan:wght@400;600;700&display=swap" rel="stylesheet">
    <style type="text/css">
        .scanner-container {
            max-width: 600px;
            margin: 20px auto;
            text-align: center;
            background-color: #f4f4f4;
            padding: 20px;
            border-radius: 10px;
        }
        .video-container {
            max-width: 500px;
            margin: 0 auto;
            position: relative;
            border: 3px solid #800000;
            border-radius: 10px;
        }
        #scanner-video {
            width: 100%;
            border-radius: 7px;
        }
        .attendance-result {
            margin-top: 20px;
            font-family: Anuphan, sans-serif;
        }
        .success-message {
            color: green;
            font-weight: bold;
        }
        .error-message {
            color: red;
            font-weight: bold;
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
        .auto-style4 {
            color: #000000;
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
    </style>
        <asp:Button ID="Button1" CssClass="back-button" runat="server" Text="<-- Back" PostbackUrl="~/admin.aspx"/>
<div class="scanner-container">
    <h2 style="color: #800000; font-family: Anuphan, sans-serif;">QR Code Attendance Scanner</h2>

    
    <div class="video-container">
        <video id="scanner-video"></video>
    </div>
    
    <asp:HiddenField ID="hdnScheduleID" runat="server" />
    
    <div class="attendance-result">
        <asp:Label ID="lblScanResult" runat="server" CssClass=""></asp:Label>
    </div>
    
    <!-- Alternative manual input -->
    <div class="manual-input">
        <label for="txtUserID"><span class="auto-style4">Enter User ID manually</span>:</label>
        <asp:TextBox ID="txtUserID" runat="server" CssClass="manual-textbox"></asp:TextBox>
        <asp:Button ID="btnManualSubmit" runat="server" Text="Submit" OnClick="SubmitAttendance_Click" CssClass="login-button" />
    </div>
</div>

<script type="text/javascript">
    document.addEventListener('DOMContentLoaded', function () {
        var scheduleId = document.getElementById('<%= hdnScheduleID.ClientID %>').value;
        let scanner = new Instascan.Scanner({ video: document.getElementById('scanner-video') });

        scanner.addListener('scan', function (content) {
            __doPostBack('ScanQRCode', content + '|' + scheduleId);
        });

        Instascan.Camera.getCameras().then(function (cameras) {
            if (cameras.length > 0) {
                scanner.start(cameras[0]);
            } else {
                alert('No cameras found. Use manual input instead.');
            }
        }).catch(function (e) {
            console.error(e);
        });
    });
</script>
</asp:Content>
