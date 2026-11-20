<%@ Page Title="" Language="C#" MasterPageFile="~/10thAveAdmin.Master" AutoEventWireup="true" CodeBehind="AdminRentals.aspx.cs" Inherits="_10thAveStudioWeb.WebForm22" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="https://fonts.googleapis.com/css2?family=Anuphan:wght@400;600;700&display=swap" rel="stylesheet">
    <style type="text/css">
        .container {
            background-color: #000000;
            color: #FFF;
            font-family: 'Anuphan', sans-serif;
            padding: 40px 20px;
        }
        .rental-grid {
            width: 100%;
            border-collapse: collapse;
        }
        .rental-grid th {
            background-color: #800000;
            color: white;
            padding: 10px;
            text-align: center;
        }
        .rental-grid td {
            padding: 10px;
            border-bottom: 1px solid #333;
            text-align: center;
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
            RENTAL BOOKINGS
        </h1>
        <br />

        <asp:GridView ID="RentalsGridView" runat="server" AutoGenerateColumns="False" 
            CssClass="rental-grid" OnRowCommand="RentalsGridView_RowCommand" GridLines="Horizontal">
            <Columns>
                <asp:BoundField DataField="FullName" HeaderText="Name" 
                    ItemStyle-HorizontalAlign="Center" />
                <asp:BoundField DataField="EventTitle" HeaderText="Event Title" 
                    ItemStyle-HorizontalAlign="Center" />
                <asp:BoundField DataField="RentalDate" HeaderText="Date" 
                    DataFormatString="{0:MM/dd/yyyy}" 
                    ItemStyle-HorizontalAlign="Center" />
                <asp:BoundField DataField="RentalTime" HeaderText="Time" 
                    ItemStyle-HorizontalAlign="Center" />
                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:Button ID="btnViewRental" runat="server" Text="View" 
                            CommandName="ViewRental" 
                            CommandArgument='<%# Eval("Rental_ID") %>' 
                            CssClass="login-button" 
                            style="width: 100px; height: 35px; font-size: 12px;" />
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>

        <!-- Modal for Full Rental Details -->
        <div id="rentalModal" class="modal">
            <div class="modal-content">
                <span class="close-modal" onclick="closeModal()">&times;</span>
                <h2>Rental Details</h2>
                <p id="modalName"></p>
                <p id="modalEmail"></p>
                <p id="modalPhone"></p>
                <p id="modalFBLink"></p>
                <p id="modalEventTitle"></p>
                <p id="modalDate"></p>
                <p id="modalTime"></p>
            </div>
        </div>
    </div>

    <script type="text/javascript">
        function openModal(name, email, phone, fbLink, eventTitle, date, time) {
            // Add extra escaping and sanitization
            document.getElementById('modalName').innerHTML = '<strong>Name:</strong> ' +
                escapeHtml(name);
            document.getElementById('modalEmail').innerHTML = '<strong>Email:</strong> ' +
                escapeHtml(email);
            document.getElementById('modalPhone').innerHTML = '<strong>Phone:</strong> ' +
                escapeHtml(phone);
            document.getElementById('modalFBLink').innerHTML = '<strong>Facebook:</strong> ' +
                escapeHtml(fbLink);
            document.getElementById('modalEventTitle').innerHTML = '<strong>Event Title:</strong> ' +
                escapeHtml(eventTitle);
            document.getElementById('modalDate').innerHTML = '<strong>Date:</strong> ' +
                escapeHtml(date);
            document.getElementById('modalTime').innerHTML = '<strong>Time:</strong> ' +
                escapeHtml(time);
            document.getElementById('rentalModal').style.display = 'block';
        }

        // Add HTML escaping function to prevent XSS
        function escapeHtml(unsafe) {
            return unsafe
                .replace(/&/g, "&amp;")
                .replace(/</g, "&lt;")
                .replace(/>/g, "&gt;")
                .replace(/"/g, "&quot;")
                .replace(/'/g, "&#039;");
        }

        function closeModal() {
            document.getElementById('rentalModal').style.display = 'none';
        }

        // Close modal if user clicks outside of it
        window.onclick = function (event) {
            var modal = document.getElementById('rentalModal');
            if (event.target == modal) {
                modal.style.display = 'none';
            }
        }
    </script>
</asp:Content>