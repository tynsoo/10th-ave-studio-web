<%@ Page Title="" Language="C#" MasterPageFile="~/10thAveAdmin.Master" AutoEventWireup="true" CodeBehind="AdminContact.aspx.cs" Inherits="_10thAveStudioWeb.WebForm21" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="https://fonts.googleapis.com/css2?family=Anuphan:wght@400;600;700&display=swap" rel="stylesheet">
    <style type="text/css">
        .container {
            background-color: #000000;
            color: #FFF;
            font-family: 'Anuphan', sans-serif;
            padding: 40px 20px;
        }
        .contact-grid {
            width: 100%;
            border-collapse: collapse;
        }
        .contact-grid th {
            background-color: #800000;
            color: white;
            padding: 10px;
            text-align: center;
        }
        .contact-grid td {
            padding: 10px;
            border-bottom: 1px solid #333;
            text-align: center;
        }
        .message-preview {
            max-width: 300px;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }
        .modal {
            display: none;
            position: fixed;
            z-index: 1000;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgba(0,0,0,0.7);
        }
        .modal-content {
            background-color: #fefefe;
            margin: 15% auto;
            padding: 20px;
            border: 1px solid #888;
            width: 80%;
            max-width: 500px;
            color: black;
            text-align: left;
        }
        .close-modal {
            color: #aaa;
            float: right;
            font-size: 28px;
            font-weight: bold;
            cursor: pointer;
        }
        .close-modal:hover {
            color: black;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">
        <h1 style="color: #FFF; text-align: center; font-family: Anuphan; font-size: 32px; font-weight: 700; letter-spacing: 1.6px;">
            CONTACT MESSAGES
        </h1>
        <br />

        <asp:GridView ID="ContactsGridView" runat="server" AutoGenerateColumns="False" 
            CssClass="contact-grid" OnRowCommand="ContactsGridView_RowCommand" GridLines="Horizontal">
            <Columns>
                <asp:BoundField DataField="Name" HeaderText="Name" 
                    ItemStyle-HorizontalAlign="Center" />
                <asp:BoundField DataField="Email" HeaderText="Email" 
                    ItemStyle-HorizontalAlign="Center" />
                <asp:TemplateField HeaderText="Message">
                    <ItemTemplate>
                        <div style="max-width: 300px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;">
                            <%# Eval("MessagePreview") %>
                        </div>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="CreatedAt" HeaderText="Date" 
                    DataFormatString="{0:MM/dd/yyyy}" 
                    ItemStyle-HorizontalAlign="Center" />
                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:Button ID="btnViewMessage" runat="server" Text="View" 
                            CommandName="ViewMessage" 
                            CommandArgument='<%# Eval("Contacts_Id") %>' 
                            CssClass="login-button" 
                            style="width: 100px; height: 35px; font-size: 12px;" />
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>

        <!-- Modal for Full Message -->
        <div id="messageModal" class="modal">
            <div class="modal-content">
                <span class="close-modal" onclick="closeModal()">&times;</span>
                <h2>Full Message</h2>
                <p id="modalName"></p>
                <p id="modalEmail"></p>
                <p id="modalMessage"></p>
                <p id="modalDate"></p>
            </div>
        </div>
    </div>

    <script type="text/javascript">
        function openModal(name, email, message, date) {
            document.getElementById('modalName').innerHTML = '<strong>Name:</strong> ' + name;
            document.getElementById('modalEmail').innerHTML = '<strong>Email:</strong> ' + email;
            document.getElementById('modalMessage').innerHTML = '<strong>Message:</strong> ' + message;
            document.getElementById('modalDate').innerHTML = '<strong>Date:</strong> ' + date;
            document.getElementById('messageModal').style.display = 'block';
        }

        function closeModal() {
            document.getElementById('messageModal').style.display = 'none';
        }

        // Close modal if user clicks outside of it
        window.onclick = function(event) {
            var modal = document.getElementById('messageModal');
            if (event.target == modal) {
                modal.style.display = 'none';
            }
        }
    </script>
</asp:Content>
