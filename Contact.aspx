<%@ Page Title="" Language="C#" MasterPageFile="~/10thAveStudio.Master" AutoEventWireup="true" CodeBehind="Contact.aspx.cs" Inherits="_10thAveStudioWeb.WebForm6" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
<style>
    .message-container {
    max-width: 400px; /* Adjust to match the inquiry box width */
    margin: 0 auto; /* Center the form horizontally */
    display: flex;
    flex-direction: column;
    gap: 12px; /* Space between inputs */
    padding: 20px;
    border-radius: 12px; /* Match the rounded corners */
    background: black; /* Match the background */
    text-align: left; /* Align text to the left */
    }
 
    /* Heading style */
    h3 {
        color: white;
        font-size: 18px;
        font-weight: bold;
        margin-bottom: 10px;
        text-align: center; /* Center the heading */
    }
 
    /* Input box styling */
    .input-box {
        width: 100%; /* Full width of the container */
        padding: 14px 20px; /* Bigger padding for better appearance */
        border: none; /* No border for clean look */
        border-radius: 12px; /* Rounded corners */
        background: #111; /* Dark input background */
        color: white; /* Input text color */
        font-size: 14px; /* Text size */
        box-sizing: border-box; /* Ensure padding fits within width */
    }
 
    /* Placeholder text styling */
    .input-box::placeholder {
        color: #aaa; /* Light grey placeholder */
    }
 
    /* Send button styling */
    .send-btn {
        align-self: center; /* Center the button */
        padding: 10px 30px; /* Padding for the button */
        border-radius: 30px; /* Rounded pill shape */
        background: white; /* White button background */
        color: black; /* Black text on button */
        font-weight: bold;
        cursor: pointer; /* Pointer on hover */
        border: none; /* No border */
        transition: background 0.3s; /* Smooth hover effect */
    }
 
    /* Button hover effect */
    .send-btn:hover {
        background: #ddd; /* Light grey on hover */
    }
    .contacts-container {
        width: 600px;
        margin: 50px auto;
        color: white;
        font-family: Arial, sans-serif;
        text-align: center;
    }
 
    .contacts-header {
        font-size: 32px;
        font-weight: bold;
        margin-bottom: 30px;
    }
 
    .contact-card {
        background-color: #1a1a1a;
        border-radius: 12px;
        padding: 20px;
        margin-bottom: 20px;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.3);
    }
 
    .contact-title {
        font-size: 18px;
        font-weight: bold;
        margin-bottom: 10px;
        text-transform: uppercase;
    }
 
    .contact-info {
        line-height: 1.8;
    }
 
    .icon {
        margin-right: 8px;
    }
 
    .email-info {
        margin-top: 10px;
        font-size: 14px;
    }
</style>
</asp:Content>
 
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div class="contacts-container">
<div class="contacts-header">CONTACTS</div>
 
        <!-- Rentals Section -->
<div class="contact-card">
<div class="contact-title">Rentals</div>
<div class="contact-info">
                Aldrin La Madrid <br />
<span class="icon">
<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="grey" viewBox="0 0 24 24">
<path d="M21.95 16.56c-1.12-1.11-2.53-1.33-3.86-.68-.56.27-1.19.62-1.82.98-2.41-1.19-4.37-3.15-5.56-5.56.36-.63.71-1.26.98-1.82.65-1.33.43-2.74-.68-3.86l-1.53-1.53c-.88-.88-2.28-.88-3.16 0l-1 1c-.85.85-1.2 2.02-1 3.22.27 1.6 1.02 3.78 3.17 6.92 2.08 3.04 4.15 5.08 6.92 6.41 1.48.75 2.91 1.2 4.26 1.33.13.01.26.02.39.02 1.02 0 1.97-.39 2.83-1.24l1-1c.88-.88.88-2.28 0-3.16l-1.53-1.53z"/>
</svg>
</span> 0916-656-0947 <br />
<span class="icon">
<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="white" viewBox="0 0 24 24">
<path d="M24 12a12 12 0 1 0-13.875 11.875v-8.406h-2.875V12h2.875V9.562c0-2.85 1.688-4.438 4.281-4.438 1.242 0 2.531.219 2.531.219v2.75h-1.437c-1.416 0-1.875.875-1.875 1.75V12h3.188l-.5 3.469h-2.688v8.406A12.003 12.003 0 0 0 24 12z"/>
</svg>
<a href="https://www.facebook.com/aldrinlamadrid" target="_blank" class="fb-link">
                    Aldrin La Madrid
</a>
</div>
</div>
 
        <!-- Partnerships Section -->
<div class="contact-card">
<div class="contact-title">Partnerships</div>
<div class="contact-info">
                Ralph Yanza <br />
<span class="icon">
<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="white" viewBox="0 0 24 24">
<path d="M24 12a12 12 0 1 0-13.875 11.875v-8.406h-2.875V12h2.875V9.562c0-2.85 1.688-4.438 4.281-4.438 1.242 0 2.531.219 2.531.219v2.75h-1.437c-1.416 0-1.875.875-1.875 1.75V12h3.188l-.5 3.469h-2.688v8.406A12.003 12.003 0 0 0 24 12z"/>
</svg>  
<a href="https://www.facebook.com/ralphyanza19.11" target="_blank" class="fb-link">
                Ralph Cornelia Yanza
</a>
</div>
</div>
 
        <!-- Inquiries Section -->
<div class="contact-card">
<div class="contact-title">Inquiries</div>
<div class="email-info"> 
                For general inquiries, use the contact form below or email us at:<br />
<a href="https://mail.google.com/mail/?view=cm&fs=1&to=10thavedancestudio@gmail.com" style="color: white; text-decoration: underline;">
                    10thavedancestudio@gmail.com
</a>
</div>
</div>
</div>
 
    <div class="message-container">
<h3>SEND US A MESSAGE</h3>
 
<asp:TextBox ID="txtComment" runat="server" CssClass="input-box" TextMode="MultiLine" placeholder="Comment" Rows="3" />
 
    <asp:Button ID="btnSend" runat="server" Text="SEND" CssClass="send-btn" OnClick="btnSend_Click" />
</div>
</asp:Content>
