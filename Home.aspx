<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="Organic_food.Home" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <br /><br />
    <div id="organicSlider" class="carousel slide" data-bs-ride="carousel">
        <div class="carousel-inner">
            <!-- Slide 1 -->
            <div class="carousel-item active" data-bs-interval="3000">
                <img src="Images/organic1.jpg" class="d-block w-100" alt="Organic Farm">
            </div>
            <!-- Slide 2 -->
            <div class="carousel-item" data-bs-interval="3000">
                <img src="Images/organic2.jpeg" class="d-block w-100" alt="Fresh Organic Vegetables">
            </div>
            <!-- Slide 3 -->
            <div class="carousel-item" data-bs-interval="3000">
                <img src="Images/organic4.png" class="d-block w-100" alt="Healthy Organic Fruits">
            </div>
        </div>

        <!-- Controls (Optional) -->
        <a class="carousel-control-prev" href="#organicSlider" role="button" data-bs-slide="prev">
            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
        </a>
        <a class="carousel-control-next" href="#organicSlider" role="button" data-bs-slide="next">
            <span class="carousel-control-next-icon" aria-hidden="true"></span>
        </a>
    </div>
</asp:Content>
