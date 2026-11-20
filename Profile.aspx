<%@ Page Title="" Language="C#" MasterPageFile="~/10thAveStudio.Master" AutoEventWireup="true" CodeBehind="Profile.aspx.cs" Inherits="_10thAveStudioWeb.WebForm20" %>
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
        width: 250px;
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
    .qr-container {
        margin-top: 30px;
        display: flex;
        flex-direction: column;
        align-items: center;
        justify-content: center;
    }
    .qr-code {
        background-color: #FFF;
        padding: 20px;
        border-radius: 10px;
        margin-bottom: 20px;
    }
    .download-qr-button {
        width: 200px;
        height: 44px;
        border-radius: 8px;
        background: #800000;
        border: none;
        cursor: pointer;
        color: #FFF;
        font-family: 'Anuphan', sans-serif;
        font-size: 15px;
        font-weight: 600;
        letter-spacing: 4.8px;
        text-transform: uppercase;
    }
    </style>
    <asp:Button ID="Button1" CssClass="back-button" runat="server" Text="<-- Back" PostbackUrl="~/HomePage.aspx"/>
    
    <div class="container">
        <div class="title">
            PROFILE
        </div>
        <asp:TextBox ID="FName" runat="server" CssClass="input-field" placeholder="First Name"></asp:TextBox>
        <br />
        <asp:TextBox ID="LName" runat="server" CssClass="input-field" placeholder="Last Name"></asp:TextBox>
        <br />
        <asp:TextBox ID="PhoneNum" runat="server" CssClass="input-field" placeholder="Phone Number" MaxLength="11"></asp:TextBox>
        <br />
        <asp:TextBox ID="FBLink" runat="server" CssClass="input-field" placeholder="Facebook Profile URL"></asp:TextBox>
        <br />
        <asp:TextBox ID="Email" runat="server" CssClass="input-field" placeholder="Email" TextMode="Email"></asp:TextBox>
        <br />
        <asp:TextBox ID="Role" runat="server" CssClass="input-field" placeholder="Role" Enabled="False"></asp:TextBox>
        <br />
        <asp:Button ID="submit" runat="server" Text="SAVE" CssClass="login-button" OnClick="submit_Click" />
        <br />
        <asp:Button ID="Button2" runat="server" Text="CHANGE PASSWORD" CssClass="login-button" PostbackURL="~/forgotpassword1.aspx" />
        <br />
        <asp:Button ID="btnLogout" runat="server" Text="LOGOUT" CssClass="login-button" OnClick="btnLogout_Click" BackColor="#C62828" ForeColor="White" />
        <div class="qr-container">
            <div class="title">QR CODE</div>
            <div class="qr-code">
                <asp:Image ID="imgQRCode" runat="server" AlternateText="User QR Code" />
            </div>
            <asp:Button ID="btnDownloadQR" runat="server" Text="DOWNLOAD QR" CssClass="download-qr-button" OnClick="btnDownloadQR_Click" />
        </div>
    </div>
</asp:Content>
