<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="ManProducts.aspx.cs" Inherits="Organic_food.ManProducts" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <style>
        .merchant-card {
            border: 1px solid #ccc;
            padding: 1%;
            margin: 10px;
            width: 300px;
            height: 310px;
            text-align: center;
            float: left;
            color: black;
            background-color: whitesmoke;
            opacity: 0.9;
            border-radius:3%;
        }
        .modal-dialog {
            width: 100%;  /* Makes the modal responsive */
            /*background-color: whitesmoke;*/
        }
        .modal-content{
            /*background-color: whitesmoke;*/
        }
        .btn-close{
            color:red;
        }
    </style>

    <script>

        // Enable Bootstrap tooltips
        document.addEventListener("DOMContentLoaded", function () {
            var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'))
            var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
                return new bootstrap.Tooltip(tooltipTriggerEl)
            })
        });

        function showAddUpCardModal() {
            $('#addUpCardModal').modal('show');
        }

        function showUpCardModal() {
            $('#UpCardModal').modal('show');
        }

        function showViewCardModal() {
            $('#ViewCardModal').modal('show');
        }

    </script>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div>
        <h1 align="center" style="text-decoration: underline; color: darkcyan; font-family: cursive">Manage Products</h1>
        <br />
        <div class="row" style="width: 100%; margin-left: 5px">
            <div align="center" class="col-md-2">
                <asp:LinkButton ID="lbtnaddnew" runat="server" CssClass="btn btn-primary btn-lg" OnClick="lbtnaddnew_Click" Font-Size="Medium" BackColor="#228B22"><i class="fa fa-solid fa-plus" style="color:white; font-size:medium; font-weight:bold"></i> Add New Products</asp:LinkButton>
            </div>
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
            <%-- <div id="contentDiv" runat="server" style="height: auto; width: 98%; margin-left: 3%;"></div>--%>
            <div>
                <asp:DataList ID="DataList1" runat="server" RepeatColumns="4" CellPadding="5">
                    <ItemTemplate>
                        <div class="merchant-card">
                            <h4><b><%# Eval("mProductName") %></b></h4>
                            <hr />
                            <img src='<%# Eval("mPhoto") %>' alt='<%# Eval("mPhoto") %>' style="width: 90%; height: 60%; border: 1px solid black;" />
                            <center>
                                 <div class="d-flex justify-content-between mt-3" style="width:60%; margin-bottom:0;">
                                    <asp:LinkButton ID="btnEdit" runat="server" CssClass="btn btn-warning" data-bs-toggle="tooltip" data-bs-placement="bottom" title="Edit" OnClick="lbtedit_Click" CommandArgument='<%# Eval("mPid") %>'>
                                        <i class="fas fa-edit"></i> <!-- Font Awesome Edit Icon -->
                                    </asp:LinkButton>

                                    <asp:LinkButton ID="btnView" runat="server" CssClass="btn btn-primary" data-bs-toggle="tooltip" data-bs-placement="bottom" title="View" OnClick="lbtview_Click" CommandArgument='<%# Eval("mPid") %>'>
                                        <i class="fas fa-eye"></i> <!-- Font Awesome View Icon -->
                                    </asp:LinkButton>

                                    <asp:LinkButton ID="btnDelete" runat="server" CssClass="btn btn-danger" data-bs-toggle="tooltip" data-bs-placement="bottom" title="Delete" OnClick="lbtdelete_Click" CommandArgument='<%# Eval("mPid") %>'>
                                        <i class="fas fa-trash"></i> <!-- Font Awesome Delete Icon -->
                                    </asp:LinkButton>
                                </div>
                            </center>                           
                        </div>
                    </ItemTemplate>
                </asp:DataList>
            </div>
            <br />
        </center>
    </div>



    <!-- Add ModalPopUp -->
    <div class="modal fade" id="addUpCardModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="addUpCardModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg" role="dialog">
            <div class="modal-content" style="border-radius: 12px; border: none; box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.2);">
                <div class="modal-header" style="background-color: #228B22; color: white; border-top-left-radius: 12px; border-top-right-radius: 12px;">
                    <h3 id="H1" runat="server" class="title"><strong>Add Product Details</strong></h3>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div>
                        <asp:Label ID="Label9" runat="server" Text="Product Name :" Font-Size="Medium" Font-Bold="true"></asp:Label>
                        <asp:TextBox ID="txtpname" runat="server" CssClass="form-control" Placeholder="Enter a Product Name" Style="border-style: outset;"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator7" ValidationGroup="sreg" runat="server" ErrorMessage="Product Name is Required" ControlToValidate="txtpname" ForeColor="Red" SetFocusOnError="True">*Product Name is Required</asp:RequiredFieldValidator><br />
                    </div>

                    <div>
                        <asp:Label ID="Label10" runat="server" Text="Quantity :" Font-Size="Medium" Font-Bold="true"></asp:Label>
                        <asp:TextBox ID="txtquantity" runat="server" CssClass="form-control" Placeholder="Enter a Product Quantity" Style="border-style: outset;"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator8" ValidationGroup="sreg" runat="server" ErrorMessage="Quantity is Required" ControlToValidate="txtquantity" ForeColor="Red" SetFocusOnError="True">*Quantity is Required </asp:RequiredFieldValidator>
                    </div>

                    <div>
                        <asp:Label ID="Label11" runat="server" Text="Price :" Font-Size="Medium" Font-Bold="true"></asp:Label>
                        <asp:TextBox ID="txtprice" runat="server" CssClass="form-control" Placeholder="Enter a Price" Style="border-style: outset;"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator9" ValidationGroup="sreg" runat="server" ErrorMessage="Price is Required" ControlToValidate="txtprice" ForeColor="Red" SetFocusOnError="True">*Price is Required</asp:RequiredFieldValidator>
                    </div>

                    <div>
                        <asp:Label ID="Label12" runat="server" Text="Discription :" Font-Size="Medium" Font-Bold="true"></asp:Label>
                        <asp:TextBox ID="txtdisc" runat="server" CssClass="form-control" Placeholder="Enter a Discription" Style="border-style: outset;"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator10" ValidationGroup="sreg" runat="server" ErrorMessage="Discription is Required" ControlToValidate="txtdisc" ForeColor="Red" SetFocusOnError="True">*Discription is Required</asp:RequiredFieldValidator><br />
                    </div>

                    <div>
                        <asp:Label ID="Label13" runat="server" Text="Shelf Life(Days) :" Font-Size="Medium" Font-Bold="true"></asp:Label>
                        <asp:TextBox ID="txtduration" runat="server" CssClass="form-control" Placeholder="Enter a Shelf Life(Days)" Style="border-style: outset;"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator11" ValidationGroup="sreg" runat="server" ErrorMessage="Shelf Life(Days) is Required" ControlToValidate="txtduration" ForeColor="Red" SetFocusOnError="True">*Shelf Life(Days) is Required</asp:RequiredFieldValidator>
                    </div>

                    <div>
                        <asp:Label ID="Label14" runat="server" Text="Photo :" Font-Size="Medium" Font-Bold="true"></asp:Label>
                        <table style="width: 95%">
                            <tr>
                                <td colspan="2">
                                    <asp:Image ID="Image1" runat="server" Height="200px" Width="200px" Visible="false" BorderStyle="Ridge" BorderWidth="1px" BorderColor="Black" /></td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <br />
                                </td>
                            </tr>
                            <tr style="display: flex; gap: 10px;">
                                <td>
                                    <asp:FileUpload ID="FileUpload1" runat="server" CssClass="form-control" Width="250px" Style="border-style: outset;" /></td>
                                <td>
                                    <asp:Button ID="btnimgupload" runat="server" Text="Upload" UseSubmitBehavior="false" CssClass="btn btn-primary" Style="border-style: outset;" OnClick="btnimgupload_Click" /></td>
                            </tr>
                        </table>
                    </div>
                </div>

                <div class="modal-footer">
                    <center>
                        <asp:Button ID="addbtn" runat="server" Text="Add" CssClass="btn btn-success btn-lg" ValidationGroup="sreg" OnClick="btnadd_Click" />
                    </center>
                </div>
            </div>
        </div>
    </div>

    <!-- Update ModalPopUp -->
    <div class="modal fade" id="UpCardModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="UpCardModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg" role="dialog">
            <div class="modal-content" style="border-radius: 12px; border: none; box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.2);">
                <div class="modal-header" style="background-color: #228B22; color: white; border-top-left-radius: 12px; border-top-right-radius: 12px;">
                    <h3 id="H4" runat="server" class="title"><strong>Update Product Details</strong></h3>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
					<div>
                        <asp:Label ID="Label8" runat="server" Text="Product Id :" Font-Size="Medium" Font-Bold="true"></asp:Label>
                        <asp:TextBox ID="uptxtpid" runat="server" CssClass="form-control" Style="border-style: outset;" ReadOnly="true"></asp:TextBox>
                        <br />
                    </div>
					
                    <div>
                        <asp:Label ID="Label15" runat="server" Text="Product Name :" Font-Size="Medium" Font-Bold="true"></asp:Label>
                        <asp:TextBox ID="uptxtpname" runat="server" CssClass="form-control" Style="border-style: outset;"></asp:TextBox>
                        <br />
                    </div>

                    <div>
                        <asp:Label ID="Label16" runat="server" Text="Quantity :" Font-Size="Medium" Font-Bold="true"></asp:Label>
                        <asp:TextBox ID="uptxtquantity" runat="server" CssClass="form-control" Style="border-style: outset;"></asp:TextBox>                   
                        <br />
                    </div>

                    <div>
                        <asp:Label ID="Label17" runat="server" Text="Price :" Font-Size="Medium" Font-Bold="true"></asp:Label>
                        <asp:TextBox ID="uptxtprice" runat="server" CssClass="form-control" Style="border-style: outset;"></asp:TextBox>
                        <br />
                    </div>

                    <div>
                        <asp:Label ID="Label18" runat="server" Text="Discription :" Font-Size="Medium" Font-Bold="true"></asp:Label>
                        <asp:TextBox ID="uptxtdisc" runat="server" CssClass="form-control" Style="border-style: outset;"></asp:TextBox>
                        <br />
                    </div>

                    <div>
                        <asp:Label ID="Label19" runat="server" Text="Shelf Life(Days) :" Font-Size="Medium" Font-Bold="true"></asp:Label>
                        <asp:TextBox ID="uptxtduration" runat="server" CssClass="form-control" Placeholder="Enter a Shelf Life(Days)" Style="border-style: outset;"></asp:TextBox>
                        <br />
                    </div>

                    <div>
                        <asp:Label ID="Label20" runat="server" Text="Photo :" Font-Size="Medium" Font-Bold="true"></asp:Label>
                        <table style="width: 95%">
                            <tr>
                                <td colspan="2">
                                    <asp:Image ID="upImage1" runat="server" Height="200px" Width="200px" BorderStyle="Ridge" BorderWidth="1px" BorderColor="Black" /></td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <br />
                                </td>
                            </tr>
                            <tr style="display: flex; gap: 10px;">
                                <td>
                                    <asp:FileUpload ID="FileUpload2" runat="server" CssClass="form-control" Width="250px" Style="border-style: outset;" /></td>
                                <td>
                                    <asp:Button ID="upbtnimgupload" runat="server" Text="Upload" UseSubmitBehavior="false" CssClass="btn btn-primary" Style="border-style: outset;" OnClick="btnupimgupload_Click" /></td>
                            </tr>
                        </table>
                        <br />
                    </div>
                </div>

                <div class="modal-footer">
                    <center>
                        <asp:Button ID="Button1" runat="server" Text="Update" CssClass="btn btn-primary btn-lg" OnClick="btnupdate_Click"/>
                    </center>
                </div>
            </div>
        </div>
    </div>


    <!-- Delete Confirmation Modal -->
    <div class="modal fade" id="DeleteModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="DeleteModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg" role="dialog">
            <!-- Small Modal -->
            <div class="modal-content" style="border-radius: 12px; border: none; box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.2);">
                
                <div class="modal-body text-center">
                    <h4>Are you sure you want to delete this product?</h4>
                    <asp:HiddenField ID="hdfDeletePid" runat="server" />
                    <!-- Store Pid -->
                </div>
                <div class="modal-footer d-flex justify-content-center">
                    <asp:Button ID="btnDeleteConfirm" runat="server" Text="Delete" CssClass="btn btn-danger" OnClick="btnDeleteConfirm_Click" />
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                </div>
            </div>
        </div>
    </div>

    
    <!-- View ModalPopUp -->
    <div class="modal fade" id="ViewCardModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="ViewCardModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg" role="dialog">
            <div class="modal-content" style="border-radius: 12px; border: none; box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.2);">
                <div class="modal-header" style="background-color: #228B22; color: white; border-top-left-radius: 12px; border-top-right-radius: 12px;">
                    <h3 id="H3" runat="server" class="title"><strong>Product Details</strong></h3>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div style="display: flex; gap: 10px;">
                        <asp:Label ID="Label1" runat="server" Text="Product Id :" Font-Size="Medium" Font-Bold="true" Width="30%"></asp:Label>
                        <asp:TextBox ID="lbpid" runat="server" CssClass="form-control" Style="border-style: outset;" ReadOnly="true"></asp:TextBox>
                    </div>
                    <br />
                    <div style="display: flex; gap: 10px;">
                        <asp:Label ID="Label2" runat="server" Text="Product Name :" Font-Size="Medium" Font-Bold="true" Width="30%"></asp:Label>
                        <asp:TextBox ID="lbpname" runat="server" CssClass="form-control" Style="border-style: outset;" ReadOnly="true"></asp:TextBox>
                    </div>
                    <br />
                    <div style="display: flex; gap: 10px;">
                        <asp:Label ID="Label3" runat="server" Text="Quantity :" Font-Size="Medium" Font-Bold="true" Width="30%"></asp:Label>
                        <asp:TextBox ID="lbquantity" runat="server" CssClass="form-control" Style="border-style: outset;" ReadOnly="true"></asp:TextBox>
                    </div>
                    <br />
                    <div style="display: flex; gap: 10px;">
                        <asp:Label ID="Label4" runat="server" Text="Price :" Font-Size="Medium" Font-Bold="true" Width="30%"></asp:Label>
                        <asp:TextBox ID="lbprice" runat="server" CssClass="form-control" Style="border-style: outset;" ReadOnly="true"></asp:TextBox>
                    </div>
                    <br />
                    <div style="display: flex; gap: 10px;">
                        <asp:Label ID="Label5" runat="server" Text="Discription :" Font-Size="Medium" Font-Bold="true" Width="30%"></asp:Label>
                        <asp:TextBox ID="lbdisc" runat="server" CssClass="form-control" Style="border-style: outset;" ReadOnly="true"></asp:TextBox>
                    </div>
                    <br />
                    <div style="display: flex; gap: 10px;">
                        <asp:Label ID="Label6" runat="server" Text="Shelf Life(Days) :" Font-Size="Medium" Font-Bold="true" Width="30%"></asp:Label>
                        <asp:TextBox ID="lbduration" runat="server" CssClass="form-control" Style="border-style: outset;" ReadOnly="true"></asp:TextBox>
                    </div>
                    <br />
                    <div>
                        <asp:Label ID="Label7" runat="server" Text="Photo :" Font-Size="Medium" Font-Bold="true" Width="23%"></asp:Label>
                        <asp:Image ID="Image2" runat="server" Height="200px" Width="200px" BorderStyle="Ridge" BorderWidth="1px" BorderColor="Black" />
                    </div>
                </div>

            </div>
        </div>
    </div>



</asp:Content>

