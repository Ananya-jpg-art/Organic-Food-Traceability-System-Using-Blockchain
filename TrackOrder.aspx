<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="TrackOrder.aspx.cs" Inherits="Organic_food.TrackOrder" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .pimg {
            height: 6%;
            width: 6%;
            border: 1px ridge black;
            border-radius: 50%;
        }

        /* Centered container */
        .tracking-container {
            display: flex;
            /*justify-content: center;*/
            /*align-items: center;*/
            height: 100vh;
        }   

        /* Card Styling */
        .tracking-card {
            width: 100%; /* Responsive width */
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.15);
            background-color: #ffffff; /* White Card */
            border: 2px solid #155724; /* Dark Green Border */
        }

        /* Header Styling */
        .card-header {
            background-color: #155724; /* Dark Green */
            color: white;
            text-align: center;
            font-size: 20px;
            font-weight: bold;
        }

        /* Tracking timeline container */
        .tracking-timeline {
            display: flex;
            justify-content: space-between;
            align-items: center;
            width: 100%; /* 82% of the card width */
            margin: 0 auto; /* Center it */
            position: relative;
        }

        /* Circle styling */
        .circle {
            width: 40px;
            height: 40px;
            border: 3px solid #228B22; /* Forest Green */
            border-radius: 50%;
            background-color: #28a745;
            display: flex;
            align-items: center;
            justify-content: center;
            position: relative;
            z-index: 2;
            font-size: 24px;
            color: white;
        }

        .filled {
            background-color: #28a745; /* Green when filled */
            border-color: #28a745;
             color: white;
        }

        .fa-check {
            font-size: 18px;
            color:white;
        }

        /* Step container */
        .tracking-step {
            display: flex;
            flex-direction: column;
            align-items: center;
            text-align: center;
            position: relative;
            width: 100%;
        }

        /* Connecting lines */
        .tracking-timeline::before {
            content: "";
            position: absolute;
            top: 12px;
            left: 0;
            width: 100%;
            height: 7px;
            background-color: #228B22; /* Forest Green */
            z-index: 1;
        }

        /* Step labels */
        .step-label {
            margin-top: 8px;
            font-size: 17px;
            color: #155724; /* Dark Green */
            font-weight: bold;
        }

        .step-date {
            margin-top: 4px;
            font-size: 17px;
            color: #74C365; /* Mantis */
            font-weight: bold;
        }
        /* Time Label Below Date */
        .step-time {
            font-size: 14px;
            color: #6c757d;
            font-weight:bold;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <center>
        <h2 align="center" style="text-decoration: underline; color: darkcyan; font-weight: bold;">Track My Order</h2>
        <br />
    </center>

    <div style="display: flex; gap: 10px; width: 70%; align-content: center; align-items: center; text-align: center;">
        <asp:Label ID="lboid" runat="server" Text="Order Id :" Font-Size="Medium" Font-Bold="true" Width="10%"></asp:Label>
        <asp:TextBox ID="txtoid" runat="server" CssClass="form-control" Style="border-style: outset;" Width="20%"></asp:TextBox>
        <asp:LinkButton ID="oidsearch" runat="server" type="button" class="btn btn-info" CommandArgument='<%# Eval("Oid") %>' Style="width: 10%; border: 1px ridge black; background-color: forestgreen; color: white; font-weight: bold;" OnClick="oidsearch_Click">Search</asp:LinkButton>
    </div>
    <br />

    <center>
        <div style="display: flex; gap: 25px; align-content: center; align-items: center; text-align: left;">
            <div class="card" style="width: 50%; height: 50%; border-radius: 10px; border: 1px ridge black; padding: 2%;">
                <center>
                    <h3 style="color: darkgreen;">
                        <img src="Images/Product.png" alt="Product" class="pimg">
                        Product Details</h3>
                </center>
                <hr />
                <div style="display: flex; gap: 30px; width: 100%;">
                    <div style="width: 70%;">
                        <div style="display: flex; gap: 10px; margin-bottom:5px;">
                            <asp:Label ID="label2" runat="server" Text="🆔 Product Id :" Font-Size="medium" Font-Bold="true" Width="35%"></asp:Label>
                            <asp:Label ID="lbpid" runat="server"></asp:Label>
                        </div>
                        <div style="display: flex; gap: 10px; margin-bottom:5px;">
                            <asp:Label ID="Label1" runat="server" Text="🏷️ Name :" Font-Size="Medium" Font-Bold="true" Width="35%"></asp:Label>
                            <asp:Label ID="lbpname" runat="server"></asp:Label>
                        </div>
                        <div style="display: flex; gap: 10px; margin-bottom:5px;">
                            <asp:Label ID="Label5" runat="server" Text="🔢 Quantity :" Font-Size="Medium" Font-Bold="true" Width="35%"></asp:Label>
                            <asp:Label ID="lbquantity" runat="server"></asp:Label>
                        </div>
                        <div style="display: flex; gap: 10px; margin-bottom:5px;">
                            <asp:Label ID="Label6" runat="server" Text="💲 Total Price :" Font-Size="Medium" Font-Bold="true" Width="35%"></asp:Label>
                            <asp:Label ID="lbprice" runat="server"></asp:Label>
                        </div>
                        <div style="display: flex; gap: 10px; margin-bottom:5px;">
                            <asp:Label ID="Label3" runat="server" Text="⏳ Shelf Life :" Font-Size="Medium" Font-Bold="true" Width="35%"></asp:Label>
                            <asp:Label ID="lbduration" runat="server"></asp:Label>Days
                        </div>
                        <div style="display: flex; gap: 10px;">
                            <asp:Label ID="Label4" runat="server" Text="📝 Description :" Font-Size="Medium" Font-Bold="true" Width="35%"></asp:Label>
                            <asp:Label ID="lbdisc" runat="server"></asp:Label>
                        </div>
                    </div>
                    <div>
                        <center>
                            <asp:Image ID="oImage2" runat="server" Height="200px" Width="200px" BorderStyle="Ridge" BorderWidth="1px" BorderColor="Black" />
                        </center>
                    </div>
                </div>
            </div>

            <div class="card" style="width: 50%; height: 50%; border-radius: 10px; border: 1px ridge black; padding: 2%;">
                <center>
                    <h3 style="color: darkgreen;">
                        <img src="Images/Produce.png" alt="Product" class="pimg">
                        Product Produce Details</h3>
                </center>

                <hr />
                <div style="width: 70%;">
                    <div style="display: flex; gap: 10px; margin-bottom:5px;">
                        <asp:Label ID="label7" runat="server" Text="🌿 Produce Id :" Font-Size="medium" Font-Bold="true" Width="40%"></asp:Label>
                        <asp:Label ID="lbproid" runat="server"></asp:Label>
                    </div>
                    <div style="display: flex; gap: 10px; margin-bottom:5px;">
                        <asp:Label ID="Label9" runat="server" Text="📦 Batch No :" Font-Size="Medium" Font-Bold="true" Width="40%"></asp:Label>
                        <asp:Label ID="lbbatchno" runat="server"></asp:Label>
                    </div>
                    <div style="display: flex; gap: 10px; margin-bottom:5px;">
                        <asp:Label ID="Label11" runat="server" Text="🚜 Farming Practice :" Font-Size="Medium" Font-Bold="true" Width="40%"></asp:Label>
                        <asp:Label ID="lbfarmpract" runat="server"></asp:Label>
                    </div>
                    <div style="display: flex; gap: 10px; margin-bottom:5px;">
                        <asp:Label ID="Label13" runat="server" Text="🌾 Soil Detail :" Font-Size="Medium" Font-Bold="true" Width="40%"></asp:Label>
                        <asp:Label ID="lbsoil" runat="server"></asp:Label>
                    </div>
                    <div style="display: flex; gap: 10px; margin-bottom:5px;">
                        <asp:Label ID="Label8" runat="server" Text="🌱 Crop Detail :" Font-Size="Medium" Font-Bold="true" Width="40%"></asp:Label>
                        <asp:Label ID="lbcrop" runat="server"></asp:Label>
                    </div>
                    <div style="display: flex; gap: 10px; margin-bottom:5px;">
                        <asp:Label ID="Label15" runat="server" Text="🌍 Sowing Date :" Font-Size="Medium" Font-Bold="true" Width="40%"></asp:Label>
                        <asp:Label ID="lbsdate" runat="server"></asp:Label>
                    </div>
                    <div style="display: flex; gap: 10px; margin-bottom:5px;">
                        <asp:Label ID="Label17" runat="server" Text="🍂 Harvest Date :" Font-Size="Medium" Font-Bold="true" Width="40%"></asp:Label>
                        <asp:Label ID="lbhdate" runat="server"></asp:Label>
                    </div>
                </div>
            </div>
        </div>
    </center>

    <br />
    <div class="card" style="margin-top:0;">
        <div class="card tracking-card">
            <div class="card-header">
                Order Tracking
            </div>
            <div class="card-body">
                <!-- Horizontal Tracking Timeline -->
                <div class="tracking-timeline">
                    <div class="tracking-step">
                        <div class="circle" id="circleFarmer">
                            <i class="fa fa-seedling" id="iconFarmer"></i>
                        </div>
                        <asp:Label ID="lblFarmCompany" runat="server" CssClass="step-label"></asp:Label>
                        <asp:Label ID="lblFarmDate" runat="server" CssClass="step-date"></asp:Label>
                        <asp:Label ID="lblFarmTime" runat="server" CssClass="step-time" Text="--"></asp:Label>
                        <asp:HiddenField ID="hfFarmType" runat="server"/>
                    </div>
                    <div class="tracking-step">
                        <div class="circle" id="circleManufacturer">
                            <i class="fa fa-industry" id="iconManufacturer"></i>
                        </div>
                        <asp:Label ID="lblManCompany" runat="server" CssClass="step-label"></asp:Label>
                        <asp:Label ID="lblManDate" runat="server" CssClass="step-date"></asp:Label>
                        <asp:Label ID="lblManTime" runat="server" CssClass="step-time"></asp:Label>
                        <asp:HiddenField ID="hfManType" runat="server"/>
                        <asp:HiddenField ID="hfManToId" runat="server"/>
                        <asp:HiddenField ID="hfManOidlink" runat="server"/>
                    </div>
                    <div class="tracking-step">
                        <div class="circle" id="circleDistributor">
                            <i class="fa fa-box" id="iconDistributor"></i>
                        </div>
                        <asp:Label ID="lblDistCompany" runat="server" CssClass="step-label"></asp:Label>
                        <asp:Label ID="lblDistDate" runat="server" CssClass="step-date"></asp:Label>
                        <asp:Label ID="lblDistTime" runat="server" CssClass="step-time"></asp:Label>
                        <asp:HiddenField ID="hfDistType" runat="server"/>
                        <asp:HiddenField ID="hfDistToId" runat="server"/>
                    </div>
                    <div class="tracking-step">
                        <div class="circle" id="circleUserType">
                            <i class="fa fa-home" id="iconUserType"></i>
                        </div>
                        <asp:Label ID="lblRCType" runat="server" CssClass="step-label"></asp:Label>
                        <asp:Label ID="lblRCTypeDate" runat="server" CssClass="step-date"></asp:Label>
                        <asp:Label ID="lblRCTypeTime" runat="server" CssClass="step-time"></asp:Label>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <br /><br />

    <asp:HiddenField ID="hfFromId" runat="server"/>
    <asp:HiddenField ID="hfFromType" runat="server"/>
    <asp:HiddenField ID="hfToId" runat="server"/>
    <asp:HiddenField ID="hfToType" runat="server"/>
    <asp:HiddenField ID="hfDate" runat="server"/>
    <asp:HiddenField ID="hfTime" runat="server"/>
    <asp:HiddenField ID="hfOidlink" runat="server"/>

</asp:Content>
