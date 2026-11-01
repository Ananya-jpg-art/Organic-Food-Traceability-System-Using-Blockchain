<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="Organic_food.Login" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
     <style>
        .tbox {
            height: 40px;
            width: 100%;
            border: 1px solid black;
            border-radius: 10px;
            font-weight: bold;
            color: black;
            padding: 8px;
            box-sizing: border-box;
            font-size: 15px;
        }

        .logbtn {
            height: 40px;
            width: 50%;
            font-weight: bold;
            font-size: 18px;
            color: white;
            background-color: #28a745;
            border: none;
            border-radius: 10px;
            cursor: pointer;
            transition: 0.3s ease-in-out;
        }

        .logbtn:hover {
            background-color: #218838;
        }

        .card {
            width: 35%;
            background-color: whitesmoke;
            border-radius: 20px;
            opacity: 0.9;
            padding: 20px;
            box-shadow: 0px 0px 10px rgba(0,0,0,0.2);
            text-align: center;
            margin-top:5%;
        }

        hr {
            border: 1px solid #28a745;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
      <center>
            <div id="userDiv" runat="server" class="card">
                <h3 style="color: darkgreen; font-family: Cambria, Cochin, Georgia, Times, Times New Roman, serif; font-size: 28px;">
                    <strong><u>Login</u></strong>
                </h3>
                <h6><strong>Login with your Credntials.</strong></h6>
                <hr /><br />
                <asp:TextBox ID="txtid" CssClass="tbox" runat="server" PlaceHolder="Enter Your Email"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtid" ErrorMessage="EmailId is required" ForeColor="Red">*Enter EmailId is required</asp:RequiredFieldValidator>
                <br />
                <asp:TextBox ID="txtpass" CssClass="tbox" runat="server" TextMode="Password" PlaceHolder="Enter Password"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="txtpass" ErrorMessage="password is required" ForeColor="Red">*Enter password is required</asp:RequiredFieldValidator>
                <center>
                    <asp:Button ID="btn_userlog" CssClass="logbtn" runat="server" Text="Login" OnClick="User_login" CausesValidation="true"/>
                </center>
                <br />
                <div>
                    <h6>If you don't have account please<a href="Register.aspx"> Register</a> here!</h6>
                </div>
            </div>
        </center>

</asp:Content>
