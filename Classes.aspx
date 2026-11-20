<%@ Page Title="" Language="C#" MasterPageFile="~/10thAveStudio.Master" AutoEventWireup="true" CodeBehind="Classes.aspx.cs" Inherits="_10thAveStudioWeb.WebForm2" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
<style>
        .classes-container {
            width: 90%;
            max-width: 1200px;
            margin: 2rem auto;
            padding: 20px;
            background-color: #000; /* Changed to black to match the dark theme in your screenshot */
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(255,255,255,0.1); /* Adjusted for dark theme */
        }
 
        .classes-title {
            color: #fff; /* Changed to white for better visibility on dark background */
            margin-bottom: 1.5rem;
            font-size: 2.2rem;
            text-align: center;
            border-bottom: 3px solid #800000;
            padding-bottom: 12px;
        }
 
        .classes-subtitle {
            text-align: center;
            color: #ccc; /* Lightened to be visible on dark background */
            margin-bottom: 2rem;
            font-style: italic;
        }
 
        .grid-container {
            width: 100%;
            overflow-x: auto;
        }
 
        .class-grid {
            width: 100%;
            border-collapse: collapse;
            margin-top: 10px;
            box-shadow: 0 1px 3px rgba(255,255,255,0.1); /* Adjusted for dark theme */
        }
 
        .class-grid th {
            background-color: #800000;
            color: white;
            padding: 14px;
            text-align: left;
            font-weight: 600;
            letter-spacing: 0.5px;
        }
 
        .class-grid tr:nth-child(even) {
            background-color: #222;
        }
 
        .class-grid tr:hover {
            background-color: #333;
            transition: background-color 0.2s ease;
        }
 
        .class-grid td {
            padding: 14px;
            border-bottom: 1px solid #444; /* Darker border */
            vertical-align: middle;
            color: #fff; /* Making all text white by default */
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
 
        .description-cell {
            max-width: 300px; /* Limit width of description */
            color: #fff; /* Explicitly making description text white */
        }
 
        .price-cell {
            font-weight: 600;
            color: #28a745;
            text-align: right;
        }
 
        .instructor-cell {
            color: #6c757d;
        }
 
        .specialty-badge {
            display: inline-block;
            background-color: #6c757d;
            color: white;
            padding: 3px 8px;
            border-radius: 12px;
            font-size: 0.8rem;
            margin-left: 5px;
        }
 
        @media (max-width: 768px) {
            .classes-container {
                width: 95%;
                padding: 15px;
            }
            .classes-title {
                font-size: 1.8rem;
            }
            .class-grid td, .class-grid th {
                padding: 10px;
            }
            .description-cell {
                max-width: 200px;
            }
        }
</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div class="classes-container">
<h1 class="classes-title">10th Avenue Studio Classes</h1>
<p class="classes-subtitle">Discover our range of classes designed to inspire and develop your talents</p>
<asp:Panel ID="pnlError" runat="server" CssClass="message error-message" Visible="false">
<asp:Label ID="lblError" runat="server" />
</asp:Panel>
<div class="grid-container">
<asp:Label ID="lblNoClasses" runat="server" Text="No classes are currently available. Please check back soon for our upcoming schedule." CssClass="message info-message" Visible="false"></asp:Label>
<asp:GridView ID="gvClasses" runat="server" AutoGenerateColumns="false" 
                CssClass="class-grid" GridLines="None"
                EmptyDataText="" OnRowDataBound="gvClasses_RowDataBound">
<Columns>
<asp:BoundField DataField="Name" HeaderText="Class" ItemStyle-CssClass="class-name" />
<asp:BoundField DataField="Class_Description" HeaderText="Description" ItemStyle-CssClass="description-cell" HtmlEncode="false" />
<asp:TemplateField HeaderText="Instructor">
<ItemTemplate>
<span class="instructor-cell"><%# Eval("Instructor_Name") %></span>
</ItemTemplate>
</asp:TemplateField>
<asp:BoundField DataField="Price" HeaderText="Price" DataFormatString="₱{0:N2}" ItemStyle-CssClass="price-cell" />
</Columns>
</asp:GridView>
</div>
</div>
</asp:Content>