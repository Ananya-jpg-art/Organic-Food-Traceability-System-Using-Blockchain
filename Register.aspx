<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="Organic_food.Register" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    
    <style>
        .regbtn {
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

            .regbtn:hover {
                background-color: #218838;
            }

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

        .labtxt {
            font-weight: bold;
            font-size: 18px;
            color: black;
        }

        .td1 {
            width: 30%;
            text-align: left;
            padding: 5px;
        }

        .td2 {
            width: 70%;
            text-align: left;
            padding: 5px;
        }

        .card {
            width: 55%;
            background-color: whitesmoke;
            border-radius: 20px;
            opacity: 0.9;
            padding: 20px;
            box-shadow: 0px 0px 10px rgba(0,0,0,0.2);
            text-align:center;
            margin-top:1%;
            margin-bottom:1%;
        }

        hr {
            border: 1px solid #28a745;
        }

       
</style>

    <script type="text/javascript">
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
            <div id="Reg" runat="server" class="card">
                <h3 style="color: darkgreen; font-family: Cambria, Cochin, Georgia, Times, Times New Roman, serif; font-size: 28px;">
                    <strong><u>Register</u></strong>
                </h3>
                <hr />
                <center>
                    <table style="width: 90%;">
                    <tr>
                        <td class="td1">
                            <asp:Label ID="utype" CssClass="labtxt" runat="server" Text="User Type: "></asp:Label>
                        </td>
                        <td class="td2">
                            <asp:DropDownList ID="utypeDropDown" runat="server" CssClass="tbox" AppendDataBoundItems="true">
                                <asp:ListItem Value="" Selected="True" Disabled="True">--Select User Type--</asp:ListItem>
                                <asp:ListItem>Farmer</asp:ListItem>
                                <asp:ListItem>Manufacturer</asp:ListItem>
                                <asp:ListItem>Distributor</asp:ListItem>
                                <asp:ListItem>Retailer</asp:ListItem>
                                <asp:ListItem>Customer</asp:ListItem>
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="utypeDropDown" InitialValue="" ErrorMessage="Select user type is required" ForeColor="Red">*Select user type is required</asp:RequiredFieldValidator>
                        </td>
                    </tr>

                    <tr>
                        <td class="td1">
                            <asp:Label ID="compName" CssClass="labtxt" runat="server" Text="Company Name: "></asp:Label>
                        </td>
                        <td class="td2">
                            <asp:TextBox ID="txt_compName" CssClass="tbox" runat="server" PlaceHolder="Enter your company name"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txt_compName" ErrorMessage="Company name is required" ForeColor="Red">*Company name is required</asp:RequiredFieldValidator>
                        </td>
                    </tr>

                    <tr>
                        <td class="td1">
                            <asp:Label ID="address" CssClass="labtxt" runat="server" Text="Address: "></asp:Label>
                        </td>
                        <td class="td2">
                            <asp:TextBox ID="txt_address" CssClass="tbox" runat="server" TextMode="MultiLine" Height="50" PlaceHolder="Enter Address"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txt_address" ErrorMessage="Address is required" ForeColor="Red">*Address is required</asp:RequiredFieldValidator>
                        </td>
                    </tr>

                    <tr>
                        <td class="td1">
                            <asp:Label ID="email" CssClass="labtxt" runat="server" Text="Email ID: "></asp:Label>
                        </td>
                        <td class="td2">
                            <asp:TextBox ID="txt_email" CssClass="tbox" runat="server" PlaceHolder="Enter Email ID"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="txt_email" ErrorMessage="Email is required" ForeColor="Red">*Email is required</asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txt_email" ValidationExpression="^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$" ErrorMessage="Invalid email format" ForeColor="Red">*Invalid email format</asp:RegularExpressionValidator>
                        </td>
                    </tr>

                    <tr>
                        <td class="td1">
                            <asp:Label ID="contact" CssClass="labtxt" runat="server" Text="Contact Number: "></asp:Label>
                        </td>
                        <td class="td2">
                            <asp:TextBox ID="txt_contact" CssClass="tbox" runat="server" PlaceHolder="Enter Contact Number" onkeypress="return isNumberKey(event)" MaxLength="10"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="txt_contact" ErrorMessage="Contact number is required" ForeColor="Red">*Contact number is required</asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ValidationExpression="^\d{10}$" ControlToValidate="txt_contact" ErrorMessage="Invalid contact number" ForeColor="Red">*Invalid contact number</asp:RegularExpressionValidator>
                        </td>
                    </tr>

                    <tr>
                        <td class="td1">
                            <asp:Label ID="pass" CssClass="labtxt" runat="server" Text="Password: "></asp:Label>
                        </td>
                        <td class="td2">
                            <asp:TextBox ID="txt_pass" CssClass="tbox" runat="server" TextMode="Password" PlaceHolder="Enter Password"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="txt_pass" ErrorMessage="Password is required" ForeColor="Red">*Password is required</asp:RequiredFieldValidator>
                        </td>
                    </tr>

                    <tr>
                        <td class="td1">
                            <asp:Label ID="cpass" CssClass="labtxt" runat="server" Text="Confirm Password: "></asp:Label>
                        </td>
                        <td class="td2">
                            <asp:TextBox ID="txt_cpass" CssClass="tbox" runat="server" TextMode="Password" PlaceHolder="Enter Confirm Password"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ControlToValidate="txt_cpass" ErrorMessage="Confirm password is required" ForeColor="Red">*Confirm password is required</asp:RequiredFieldValidator>
                            <asp:CompareValidator ID="CompareValidator2" runat="server" ControlToCompare="txt_pass" ControlToValidate="txt_cpass" ErrorMessage="Password not match" ForeColor="Red">*Password not match</asp:CompareValidator>                      
                        </td>
                    </tr>

                </table>

                <h6>If you already have an account, <a href="Login.aspx">Log In</a> here!</h6>
                <br />
                <asp:Button ID="btn_reg" CssClass="regbtn" runat="server" Text="Register" OnClick="btn_Regclick" CausesValidation="true"/>
                </center>
                
            </div>
        <br />
        </center>
</asp:Content>
