 <%@ Page Title="" Language="C#" MasterPageFile="~/10thAveStudio.Master" AutoEventWireup="true" CodeBehind="HomePage.aspx.cs" Inherits="_10thAveStudioWeb.WebForm1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
<style type="text/css">
        .hero-section {
            background-image: url('img/main.jpg');
            background-size: cover;
            background-position: center;
            height: 70vh;
            display: flex;
            align-items: center;
            justify-content: center;
            text-align: center;
            color: #FFFFFF;
            position: relative;
        }
 
        .hero-overlay {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0,0,0,0.6); /* Slightly darker overlay for better text readability */
            z-index: 1;
        }
 
        .hero-content {
            position: relative;
            z-index: 2;
            max-width: 800px;
            padding: 0 20px;
        }
 
        .hero-content h1 {
            font-size: 3rem;
            margin-bottom: 20px;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.5);
        }
 
        .hero-content p {
            font-size: 1.2rem;
            margin-bottom: 30px;
            text-shadow: 1px 1px 2px rgba(0,0,0,0.5);
        }
 
        .cta-buttons {
            display: flex;
            justify-content: center;
            gap: 20px;
        }
 
        .cta-button {
            background-color: #800000;
            color: #000000;
            padding: 12px 24px;
            text-decoration: none;
            font-weight: bold;
            border-radius: 5px;
            transition: all 0.3s ease;
        }
 
        .cta-button:hover {
            background-color: #F0F0F0;
            transform: scale(1.05);
        }
 
        .featured-sections {
            display: flex;
            justify-content: space-between;
            padding: 50px 5%;
            background-color: #111111;
            gap: 20px;
        }
 
        .featured-section {
            flex: 0 0 30%;
            text-align: center;
            padding: 20px;
            background-color: #222222;
            border-radius: 10px;
            transition: transform 0.3s ease;
        }
 
        .featured-section:hover {
            transform: scale(1.05);
        }
 
        .featured-section-image-container {
            width: 100%;
            height: 300px;
            margin-bottom: 20px;
            overflow: hidden;
            border-radius: 10px;
        }
 
        .featured-section img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.3s ease;
        }
 
        .featured-section:hover img {
            transform: scale(1.1);
        }
 
        .featured-section h2 {
            margin-bottom: 15px;
            color: #FFFFFF;
        }
 
        .featured-section p {
            color: #CCCCCC;
        }
 
        .highlight-section {
            background-color: #000000;
            color: #FFFFFF;
            padding: 50px 10%;
            display: flex;
            align-items: center;
            gap: 50px;
        }
 
        .highlight-image {
            flex: 0 0 50%;
        }
 
        .highlight-image img {
            width: 100%;
            border-radius: 10px;
        }
 
        .highlight-content {
            flex: 0 0 50%;
        }
 
        @media (max-width: 992px) {
            .featured-sections {
                flex-direction: column;
            }
 
            .featured-section {
                margin-bottom: 20px;
                width: 100%;
            }
 
            .highlight-section {
                flex-direction: column;
            }
 
            .highlight-image, .highlight-content {
                flex: 0 0 100%;
            }
        }
</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<section class="hero-section">
<div class="hero-overlay"></div>
<div class="hero-content">  
<h1>Elevate Your Dance Journey at 10th Avenue Studio</h1>
<p>Your premier destination for dance classes, studio rentals, and creative expression</p>
<div class="cta-buttons">
<asp:HyperLink ID="ViewClassesButton" runat="server" NavigateUrl="~/Classes.aspx" CssClass="cta-button">View Classes</asp:HyperLink>
<asp:HyperLink ID="BookStudioButton" runat="server" NavigateUrl="~/Rentals.aspx" CssClass="cta-button">Rent Studio</asp:HyperLink>
</div>
</div>
</section>
 
    <!-- Featured Sections -->
<section class="featured-sections">
<div class="featured-section">
<div class="featured-section-image-container">
<img src="img/Classes.jpg" alt="Dance Classes">
</div>
<h2>Diverse Classes</h2>
<p>From hip-hop to contemporary, we offer classes for all skill levels and styles.</p>
</div>
<div class="featured-section">
<div class="featured-section-image-container">
<img src="img/Studio.jpg" alt="Studio Rentals">
</div>
<h2>Professional Spaces</h2>
<p>State-of-the-art studios perfect for rehearsals, shoots, and performances.</p>
</div>
<div class="featured-section">
<div class="featured-section-image-container">
<img src="img/Coaches.jpg" alt="Experienced Instructors">
</div>
<h2>Expert Instructors</h2>
<p>Learn from industry professionals with years of performance experience.</p>
</div>
</section>
 
</asp:Content>
