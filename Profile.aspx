<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="Profile.aspx.cs" Inherits="Organic_food.Profile" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <!-- Link to Font Awesome for Icons -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet" />
    <script type="text/javascript">
        function toggleEdit() {
            var isReadOnly = document.getElementById('<%= TextBox2.ClientID %>').readOnly;
            document.getElementById('<%= TextBox2.ClientID %>').readOnly = !isReadOnly;
            document.getElementById('<%= TextBox3.ClientID %>').readOnly = !isReadOnly;
            document.getElementById('<%= TextBox4.ClientID %>').readOnly = !isReadOnly;
            document.getElementById('<%= TextBox5.ClientID %>').readOnly = !isReadOnly;

            var btn = document.getElementById('<%= ButtonEdit.ClientID %>');
            if (isReadOnly) {
                btn.value = "Update";
            } else {
                btn.value = "Edit";
            }
        }

        function isNumberKey(evt) {
            var charCode = (evt.which) ? evt.which : event.keyCode;
            if (charCode < 48 || charCode > 57) {
                return false;
            }
            return true;
        }
    </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <center>
        <br />
        <h2 style="color:darkgreen">Profile</h2>
        <div class="container" style="margin-top:30px;width:50%; padding: 30px; border-radius: 15px; background-color: #4CAF50; box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2); color: white;">
             <h2 style="text-align:center; font-size: 25px; font-weight: bold;">
                <asp:Image ID="ProfileImage" runat="server" Width="100px" Height="90px" Style="margin-right: 10px; border-radius: 50%;" />
                <asp:Label ID="ProfileTitle" runat="server" Text="User" ForeColor="White" Font-Bold="true"></asp:Label>
            </h2>
            <table style="width:90%; margin-top: 10px;">
                <tr>
                    <td style="text-align:left; padding: 10px; font-size: 16px; font-weight: bold;">Id:</td>
                    <td>
                        <asp:TextBox ID="TextBox1" runat="server" CssClass="form-control" ReadOnly="true" style="width: 100%; padding: 10px; border-radius: 5px;height:35px"></asp:TextBox>
                        <br />
                    </td>
                </tr>
                <tr>
                    <td style="text-align:left; padding: 10px; font-size: 16px; font-weight: bold;">Company Name:</td>
                    <td>
                        <asp:TextBox ID="TextBox2" runat="server" CssClass="form-control" ReadOnly="true" style="width: 100%; padding: 10px; border-radius: 5px;height:35px"></asp:TextBox>
                        <br />
                    </td>
                </tr>
                <tr>
                    <td style="text-align:left; padding: 10px; font-size: 16px; font-weight: bold;">Address:</td>
                    <td>
                        <asp:TextBox ID="TextBox3" runat="server" CssClass="form-control" ReadOnly="true" style="width: 100%; padding: 10px; border-radius: 5px;height:35px"></asp:TextBox>
                        <br />
                    </td>
                </tr>
                <tr>
                    <td style="text-align:left; padding: 10px; font-size: 16px; font-weight: bold;">Email:</td>
                    <td>
                        <asp:TextBox ID="TextBox4" runat="server" CssClass="form-control" ReadOnly="true" TextMode="Email" style="width: 100%; padding: 10px; border-radius: 5px;height:35px"></asp:TextBox>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="TextBox4" ValidationExpression="^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$" ErrorMessage="Invalid email format" ForeColor="Red">*Invalid email format</asp:RegularExpressionValidator>
                    </td>
                
                </tr>
                <tr>
                    <td style="text-align:left; padding: 10px; font-size: 16px; font-weight: bold;">Contact:</td>
                    <td>
                        <asp:TextBox ID="TextBox5" runat="server" CssClass="form-control" ReadOnly="true" onkeypress="return isNumberKey(event)" MaxLength="10" style="width: 100%; padding: 10px; border-radius: 5px;height:35px"></asp:TextBox>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ValidationExpression="^\d{10}$" ControlToValidate="TextBox5" ErrorMessage="Invalid contact number" ForeColor="Red">*Invalid contact number</asp:RegularExpressionValidator>
                    </td>
                </tr>
            </table>
            <asp:Button ID="ButtonEdit" runat="server" Text="Edit" CssClass="btn btn-warning" OnClientClick="toggleEdit();" style="background-color:darkgreen; border: none; padding: 10px 20px; font-size: 16px; border-radius: 5px; color: white; width:100px; margin-top:2%;" OnClick="ButtonEdit_Click"/>
        </div>
        <br /><br />
    </center>
</asp:Content>
