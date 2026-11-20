<%@ Page Title="" Language="C#" MasterPageFile="~/10thAveStudio.Master" AutoEventWireup="true" CodeBehind="FAQs.aspx.cs" Inherits="_10thAveStudioWeb.WebForm5" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
<style>
        .faq-container {
            max-width: 600px;
            margin: 50px auto;
            color: white;
            font-family: Arial, sans-serif;
        }
 
        .faq-header {
            text-align: center;
            font-size: 32px;
            font-weight: bold;
            margin-bottom: 30px;
        }
 
        .faq-item {
            border-bottom: 1px solid #555;
            padding: 15px 0;
        }
 
        .faq-question {
            display: flex;
            justify-content: space-between;
            cursor: pointer;
            font-weight: bold;
            text-transform: uppercase;
        }
 
        .faq-answer {
            display: none;
            padding-top: 10px;
        }
 
        .faq-item.open .faq-answer {
            display: block;
        }
</style>
 
    <script type="text/javascript">
        function toggleFAQ(element) {
            var item = element.closest('.faq-item');
            item.classList.toggle('open');
        }
</script>
</asp:Content>
 
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div class="faq-container">
<div class="faq-header">FAQs</div>
 
        <div class="faq-item">
<div class="faq-question" onclick="toggleFAQ(this)">
                Location
<span>&#9662;</span>
</div>
<div class="faq-answer">
                10th Avenue Studio is located at 3rd Floor, Angelica Bldg., Rizal Blvd., Brgy. Tagapo, Santa Rosa, Philippines.
</div>
</div>
 
        <div class="faq-item">
<div class="faq-question" onclick="toggleFAQ(this)">
                How long is a class?
<span>&#9662;</span>
</div>
<div class="faq-answer">
                Beginners Femme, Beginners Choreo, KPOP, and PPOP classes will run for 1 hour and 30 minutes, while Femme Class and Open Style sessions will have a duration of 2 hours.
</div>
</div>
 
        <div class="faq-item">
<div class="faq-question" onclick="toggleFAQ(this)">
                Are walk-ins allowed?
<span>&#9662;</span>
</div>
<div class="faq-answer">
                Walk-ins are welcome and permitted.
</div>
</div>
 
        <div class="faq-item">
<div class="faq-question" onclick="toggleFAQ(this)">
                Required age for dance classes
<span>&#9662;</span>
</div>
<div class="faq-answer">
                There are no age restrictions for the dance classes; they are open to individuals of all ages.
</div>
</div>
</div>
<div style="text-align: center;">
<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3865.8560895853634!2d121.09825050974513!3d14.319790686076106!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3397d93d30f586e5%3A0x1df3bf7435424520!2s10th%20Ave.%20Studio!5e0!3m2!1sen!2sph!4v1742716340095!5m2!1sen!2sph" 
                width="600" 
                height="450" 
                style="border:0;" 
                allowfullscreen="" 
                loading="lazy" 
                referrerpolicy="no-referrer-when-downgrade">
</iframe>
</div>
</asp:Content>