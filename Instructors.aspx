<%@ Page Title="" Language="C#" MasterPageFile="~/10thAveStudio.Master" AutoEventWireup="true" CodeBehind="Instructors.aspx.cs" Inherits="_10thAveStudioWeb.WebForm4" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .instructors-container {
            width: 90%;
            max-width: 1200px;
            margin: 2rem auto;
            padding: 20px;
            background-color: #000;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(255,255,255,0.1);
        }

        .instructors-title {
            color: #fff;
            margin-bottom: 1.5rem;
            font-size: 2.2rem;
            text-align: center;
            border-bottom: 3px solid #800000;
            padding-bottom: 12px;
        }

        .instructors-subtitle {
            text-align: center;
            color: #ccc;
            margin-bottom: 2rem;
            font-style: italic;
        }

        .grid-container {
            width: 100%;
            overflow-x: auto;
        }

        .instructor-grid {
            width: 100%;
            border-collapse: collapse;
            margin-top: 10px;
            box-shadow: 0 1px 3px rgba(255,255,255,0.1);
        }

        .instructor-grid th {
            background-color: #800000;
            color: white;
            padding: 14px;
            text-align: left;
            font-weight: 600;
            letter-spacing: 0.5px;
        }

        .instructor-grid tr:nth-child(even) {
            background-color: #222;
        }

        .instructor-grid tr:hover {
            background-color: #333;
            transition: background-color 0.2s ease;
        }

        .instructor-grid td {
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

        .instructor-name {
            font-weight: bold;
            color: #800000;
        }

        .experience-cell {
            max-width: 300px;
            color: #fff;
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

        .email-cell {
            color: #6c757d;
        }

        @media (max-width: 768px) {
            .instructors-container {
                width: 95%;
                padding: 15px;
            }
            
            .instructors-title {
                font-size: 1.8rem;
            }
            
            .instructor-grid td, .instructor-grid th {
                padding: 10px;
            }
            
            .experience-cell {
                max-width: 200px;
            }
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="instructors-container">
        <h1 class="instructors-title">10th Avenue Studio Instructors</h1>
        <p class="instructors-subtitle">Meet our talented instructors who are passionate about sharing their expertise</p>
        
        <asp:Panel ID="pnlError" runat="server" CssClass="message error-message" Visible="false">
            <asp:Label ID="lblError" runat="server" />
        </asp:Panel>
        
        <div class="grid-container">
            <asp:Label ID="lblNoInstructors" runat="server" Text="No instructors are currently available. Please check back soon for our updated team." CssClass="message info-message" Visible="false"></asp:Label>
            
            <asp:GridView ID="gvInstructors" runat="server" AutoGenerateColumns="false" 
                CssClass="instructor-grid" GridLines="None"
                EmptyDataText="" OnRowDataBound="gvInstructors_RowDataBound">
                <Columns>
                    <asp:BoundField DataField="InstructorName" HeaderText="Instructor" ItemStyle-CssClass="instructor-name" />
                    <asp:TemplateField HeaderText="Specialty">
                        <ItemTemplate>
                            <span class="specialty-badge"><%# Eval("Specialty") %></span>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="Experience" HeaderText="Experience" ItemStyle-CssClass="experience-cell" HtmlEncode="false" />
                    <asp:BoundField DataField="Email" HeaderText="Contact" ItemStyle-CssClass="email-cell" />
                </Columns>
            </asp:GridView>
        </div>
    </div>
</asp:Content>
