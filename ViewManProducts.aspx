<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="ViewManProducts.aspx.cs" Inherits="Organic_food.ViewManProducts" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .merchant-card {
            border: 1px solid #ccc;
            padding: 7px;
            margin: 10px;
            width: 300px;
            height: 320px;
            text-align: center;
            float: left;
            color: black;
            background-color: whitesmoke;
            opacity: 0.9;
            border-radius:3%;
        }       
    </style>

    <script>
        function showOrderCardModal() {
            $('#OrderCardModal').modal('show');
        }
    </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div>
        <h1 align="center" style="text-decoration: underline; color: darkcyan; font-family: cursive">Products</h1>
        <br />
        <div class="row" style="width: 100%; margin-left: 5px">
            <div align="center" class="col-md-2"></div>
            <div align="left" class="col-md-6"></div>
            <div class="col-md-3">
                <asp:TextBox ID="txtsearch" runat="server" Placeholder="Search by Product Name" CssClass="form-control" Height="40px"></asp:TextBox>
            </div>
            <div class="col-md-1" align="left">
                <asp:LinkButton ID="lbtnsearch" runat="server" CssClass="btn btn-primary" Height="38px" BackColor="#228B22" OnClick="lbtnsearch_Click">
                    <span class="fas fa-search" style="color:white; margin-top:4px;"></span>
                </asp:LinkButton>
            </div>
        </div>
        <br />
        <center>
            <div>
                <asp:DataList ID="DataList1" runat="server" RepeatColumns="4" CellPadding="5">
                    <ItemTemplate>
                        <div class="merchant-card">
                            <h4><b><%# Eval("mProductName") %></b></h4>
                            <hr />
                            <img src='<%# Eval("mPhoto") %>' alt='<%# Eval("mPhoto") %>' style="width: 90%; height: 60%; border: 1px solid black;" />                           
                            <asp:LinkButton ID="orderbtn" runat="server" type="button" class="btn btn-info" CommandArgument='<%# Eval("mPid") %>' style="width: 90%; border: 1px ridge black; margin-top:5%; margin-bottom:3%; background-color:forestgreen; color:white; font-weight:bold;" OnClick="orderbtn_Click">Order</asp:LinkButton>
                        </div>
                    </ItemTemplate>
                </asp:DataList>
            </div>
            <br />
            <br />
        </center>
    </div>

    <!-- Order ModalPopUp -->
    <div class="modal fade" id="OrderCardModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="OrderCardModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content" style="border-radius: 12px; border: none; box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.2);">
                <div class="modal-header"  style="background-color: #228B22; color: white; border-top-left-radius: 12px; border-top-right-radius: 12px;">
                    <h3 id="H1" runat="server" class="title"><strong>Order Product</strong></h3>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div style="display: flex; align-items: center; gap: 30px; width: 100%;">
                        <div style="width: 70%;">
                            <div style="display: flex; gap: 10px;">
                                <asp:Label ID="Label2" runat="server" Text="Product Id :" Font-Size="Medium" Font-Bold="true" Width="35%"></asp:Label>
                                <asp:TextBox ID="otxtpid" runat="server" CssClass="form-control" Style="border-style: outset;" ReadOnly="true"></asp:TextBox>
                            </div>
                            <br />
                            <div style="display: flex; gap: 10px;">
                                <asp:Label ID="Label1" runat="server" Text="Product Name :" Font-Size="Medium" Font-Bold="true" Width="35%"></asp:Label>
                                <asp:TextBox ID="otxtpname" runat="server" CssClass="form-control" Style="border-style: outset;" ReadOnly="true"></asp:TextBox>
                            </div>
                            <br />
                            <div style="display: flex; gap: 10px;">
                                <asp:Label ID="Label3" runat="server" Text="Shelf Life(Days) :" Font-Size="Medium" Font-Bold="true" Width="35%"></asp:Label>
                                <asp:TextBox ID="otxtduration" runat="server" CssClass="form-control" Style="border-style: outset;" ReadOnly="true"></asp:TextBox>
                            </div>
                            <br />
                            <div style="display: flex; gap: 10px;">
                                <asp:Label ID="Label4" runat="server" Text="Description :" Font-Size="Medium" Font-Bold="true" Width="35%"></asp:Label>
                                <asp:TextBox ID="otxtdisc" runat="server" CssClass="form-control" TextMode="MultiLine" Style="border-style: outset;" ReadOnly="true"></asp:TextBox>
                            </div>
                            <br />
                        </div>
                        <div>
                            <center>
                                <asp:Image ID="oImage2" runat="server" Height="200px" Width="200px" BorderStyle="Ridge" BorderWidth="1px" BorderColor="Black" />
                            </center>                           
                        </div>
                    </div>
                    <hr />
                    <div style="display: flex; gap: 20px;">
                        <asp:Label ID="Label5" runat="server" Text="Select Company :" Font-Size="Medium" Font-Bold="true" Width="30%"></asp:Label>
                        <asp:DropDownList ID="ocompDropdown" runat="server" CssClass="form-control" AppendDataBoundItems="true" Style="border-style: outset;">
                            <asp:ListItem Value="" Selected="True" Disabled="True">--Select Company--</asp:ListItem>                         
                        </asp:DropDownList>
                        <asp:HiddenField ID="hiddenCompanyID" runat="server" />
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator8" ValidationGroup="sreg" runat="server" ErrorMessage="Select Company is Required" ControlToValidate="ocompDropdown" ForeColor="Red" SetFocusOnError="True">*Select Company is Required</asp:RequiredFieldValidator>
                    </div>
                    <br />
                    <div style="display: flex; gap: 10px;">
                        <asp:Label ID="Label6" runat="server" Text="Quantity :" Font-Size="Medium" Font-Bold="true" Width="30%"></asp:Label>
                        <asp:TextBox ID="otxtquantity" runat="server" CssClass="form-control" Style="border-style: outset;" OnTextChanged="otxtquantity_TextChanged" AutoPostBack="true"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ValidationGroup="sreg" runat="server" ErrorMessage="Quantity is Required" ControlToValidate="otxtquantity" ForeColor="Red" SetFocusOnError="True">*Quantity is Required</asp:RequiredFieldValidator>
                    </div>
                    <br />
                    <div style="display: flex; gap: 10px;">
                        <asp:Label ID="Label8" runat="server" Text="Total Price :" Font-Size="Medium" Font-Bold="true" Width="30%"></asp:Label>
                        <asp:TextBox ID="otxtprice" runat="server" CssClass="form-control" Style="border-style: outset;"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" ValidationGroup="sreg" runat="server" ErrorMessage="Price is Required" ControlToValidate="otxtprice" ForeColor="Red" SetFocusOnError="True">*Price is Required</asp:RequiredFieldValidator>
                    </div>
                    <br />
                </div>

                <div class="modal-footer" style="align-items:center;">
                    <asp:Button ID="ordbtn" runat="server" Text="Order" CssClass="btn btn-success btn-lg" ValidationGroup="sreg" OnClick="ordbtn_Click"/>
                </div>
            </div>
        </div>
    </div>

</asp:Content>
