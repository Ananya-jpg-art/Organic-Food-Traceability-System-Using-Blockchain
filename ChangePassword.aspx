<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="ChangePassword.aspx.cs" Inherits="Organic_food.Change_Password" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <!-- Link to Font Awesome for Icons (if needed) -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <center>
        <div class="container" style="margin-top:50px;width:50%; padding: 30px; border-radius: 15px; background-color: #2196F3; box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2); color: white;">
            <h2 style="text-align:center; font-size: 25px; font-weight: bold;">
                <i class="fas fa-key" style="margin-right: 10px;"></i> Change Password
            </h2>
            <table style="width:100%; margin-top: 20px;">
                <tr>
                    <td style="text-align:left; padding: 10px; font-size: 16px; font-weight: bold;width:40%">Current Password:</td>
                    <td>
                        <asp:TextBox ID="TextBoxCurrentPassword" runat="server" TextMode="Password" CssClass="form-control" style="width: 100%; padding: 6px; font-size: 14px; border-radius: 5px;height:35px"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="TextBoxCurrentPassword" ErrorMessage="Current password is required" ForeColor="Red">*Current password is required</asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:left; padding: 10px; font-size: 16px; font-weight: bold;">New Password:</td>
                    <td>
                        <asp:TextBox ID="TextBoxNewPassword" runat="server" TextMode="Password" CssClass="form-control" style="width: 100%; padding: 6px; font-size: 14px; border-radius: 5px;height:35px"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="TextBoxNewPassword" ErrorMessage="New password is required" ForeColor="Red">*New password is required</asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:left; padding: 10px; font-size: 16px; font-weight: bold;">Confirm New Password:</td>
                    <td>
                        <asp:TextBox ID="TextBoxConfirmPassword" runat="server" TextMode="Password" CssClass="form-control" style="width: 100%; padding: 6px; font-size: 14px; border-radius: 5px;height:35px"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="TextBoxConfirmPassword" ErrorMessage="Confirm password is required" ForeColor="Red">*Confirm password is required</asp:RequiredFieldValidator>                
                    </td>
                </tr>
                <tr>
                    <td colspan="2" style="text-align:center; padding-top: 20px;">
                        <asp:Button ID="ButtonChangePassword" runat="server" Text="Change Password" CssClass="btn btn-primary" style="background-color: #28a745; border: none; padding: 10px 20px; font-size: 16px; border-radius: 5px;" OnClick="ButtonChangePassword_Click" /> <%--OnClick="ButtonChangePassword_Click" />--%>
                    </td>
                </tr>
            </table>
        </div>
    </center>
</asp:Content>


