<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="FarmProducts.aspx.cs" Inherits="Organic_food.FarmProducts" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <style>
        .merchant-card {
            border: 1px solid #ccc;
            padding: 7px;
            margin: 10px;
            width: 300px;
            height: 450px;
            text-align: center;
            float: left;
            color: black;
            background-color: whitesmoke;
            opacity: 0.9;
            border-radius:3%;
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

        function showProduceCardModal() {
            $('#ProduceCardModal').modal('show');
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
        <center>
            <div>
                <asp:DataList ID="DataList1" runat="server" RepeatColumns="4" CellPadding="5">
                    <ItemTemplate>
                        <div class="merchant-card">
                            <h4><b><%# Eval("ProductName") %></b></h4>
                            <hr />
                            <img src='<%# Eval("Photo") %>' alt='<%# Eval("Photo") %>' style="width: 90%; height: 50%; border: 1px solid black;" />
                            <center>
                                 <div class="d-flex justify-content-between mt-3" style="width:80%;">
                                    <asp:LinkButton ID="btnEdit" runat="server" CssClass="btn btn-warning"  data-bs-toggle="tooltip" data-bs-placement="right" title="Edit" OnClick="lbtedit_Click" CommandArgument='<%# Eval("Pid") %>'>
                                        <i class="fas fa-edit"></i> 
                                    </asp:LinkButton>
                                    
                                    <asp:LinkButton ID="btnView" runat="server" CssClass="btn btn-primary"  data-bs-toggle="tooltip" data-bs-placement="right" title="View" OnClick="lbtview_Click" CommandArgument='<%# Eval("Pid") %>'>
                                        <i class="fas fa-eye"></i> 
                                    </asp:LinkButton>
                                    
                                    <asp:LinkButton ID="btnDelete" runat="server" CssClass="btn btn-danger"  data-bs-toggle="tooltip" data-bs-placement="right" title="Delete" OnClick="lbtdelete_Click" CommandArgument='<%# Eval("Pid") %>'>
                                        <i class="fas fa-trash"></i> 
                                    </asp:LinkButton>
                                </div>
                            </center>
                            <asp:LinkButton ID="addProducebtn" runat="server" type="button" class="btn btn-info" CommandArgument='<%# Eval("Pid") %>' style="width: 90%; border: 1px ridge black; margin-top:3%; margin-bottom:3%; background-color:midnightblue; color:white; font-weight:bold;" onclick="lbtnAddProduce">Add Produce Details</asp:LinkButton>
                            <asp:LinkButton ID="viewProducebtn" runat="server" type="button" class="btn btn-info" CommandArgument='<%# Eval("Pid") %>' style="width: 90%; border: 1px ridge black; background-color:forestgreen; color:white; font-weight:bold;" onclick="lbtnViewProduce">View Produce Details</asp:LinkButton>
                        </div>
                    </ItemTemplate>
                </asp:DataList>
            </div>
            <br />
            <br />
        </center>
    </div>



    <!-- Add ModalPopUp -->
    <div class="modal fade" id="addUpCardModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="addUpCardModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content" style="border-radius: 12px; border: none; box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.2);">
                <div class="modal-header"  style="background-color: #228B22; color: white; border-top-left-radius: 12px; border-top-right-radius: 12px;">
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
                        <br />
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

                <div class="modal-footer" style="align-items:center;">
                    <asp:Button ID="addbtn" runat="server" Text="Add" CssClass="btn btn-success btn-lg" ValidationGroup="sreg" OnClick="btnadd_Click" />
                </div>
            </div>
        </div>
    </div>

    <!-- Update ModalPopUp -->
    <div class="modal fade" id="UpCardModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="UpCardModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg" role="document">
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
        <div class="modal-dialog modal-lg" role="document">
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
    <div class="modal fade" id="ViewCardModal"  data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="ViewCardModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg" role="document">
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


    <!-- ProduceData ModalPopUp -->
    <div class="modal fade" id="ProduceCardModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="ProduceCardModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg"  role="dialog">
            <div class="modal-content" style="border-radius: 12px; border: none; box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.2);">
                <div class="modal-header" style="background-color: #228B22; color: white; border-top-left-radius: 12px; border-top-right-radius: 12px;">
                    <h3 id="H5" runat="server" class="title"><strong>Manage Product Produce Details</strong></h3>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
					<div>
                        <asp:Label ID="Label21" runat="server" Text="Product Id :" Font-Size="Medium" Font-Bold="true"></asp:Label>
                        <asp:TextBox ID="ptxtpid" runat="server" CssClass="form-control" Style="border-style: outset;" ReadOnly="true"></asp:TextBox>
                        <br />
                    </div>
					
                    <div>
                        <asp:Label ID="Label22" runat="server" Text="Product Name :" Font-Size="Medium" Font-Bold="true"></asp:Label>
                        <asp:TextBox ID="ptxtpname" runat="server" CssClass="form-control" Style="border-style: outset;" ReadOnly="true"></asp:TextBox>
                        <br />
                    </div>
					
					<div>
                        <asp:Label ID="Label23" runat="server" Text="Batch Number :" Font-Size="Medium" Font-Bold="true"></asp:Label>
                        <asp:TextBox ID="ptxtbatchno" runat="server" CssClass="form-control" Placeholder="Enter a batch no. like(A123,A987,B852,...)" Style="border-style: outset;"></asp:TextBox>
					    <asp:Label ID="lblErrorMessage1" runat="server" ForeColor="Red" Visible="false"></asp:Label>
                        <br />
                    </div>
					
					<div>
                        <asp:Label ID="Label24" runat="server" Text="Crop Details :" Font-Size="Medium" Font-Bold="true"></asp:Label>
                        <asp:TextBox ID="ptxtcrop" runat="server" TextMode="Multiline" CssClass="form-control" Placeholder="Enter a crop details" Style="border-style: outset;"></asp:TextBox>
					    <asp:Label ID="lblErrorMessage2" runat="server" ForeColor="Red" Visible="false"></asp:Label>
                        <br />
                    </div>

                    <div>
                        <asp:Label ID="Label25" runat="server" Text="Soil Details :" Font-Size="Medium" Font-Bold="true"></asp:Label>
                        <div style="display: flex; align-items: center; gap: 10px;">
                            <asp:DropDownList ID="psoilDropDown" runat="server" CssClass="form-control" AppendDataBoundItems="true" Style="border-style: outset;" Width="100%">
                                <asp:ListItem Value="" Selected="True" Disabled="True">--Select Soil Type--</asp:ListItem>
                                <asp:ListItem>Loamy soil</asp:ListItem>
                                <asp:ListItem>Sandy loam</asp:ListItem>
                                <asp:ListItem>Clayey soil</asp:ListItem>
                                <asp:ListItem>Well-drained sandy loam</asp:ListItem>
                                <asp:ListItem>Well-drained alluvial soil</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <asp:Label ID="lblErrorMessage3" runat="server" ForeColor="Red" Visible="false"></asp:Label>
                        <br />
                    </div>
					
					<div>
                        <asp:Label ID="Label26" runat="server" Text="Farming Practice :" Font-Size="Medium" Font-Bold="true"></asp:Label>
                        <div style="display: flex; align-items: center; gap: 10px;">
                            <asp:DropDownList ID="pfarmingpractDropDown" runat="server" CssClass="form-control" AppendDataBoundItems="true" Style="border-style: outset;" Width="100%">
                                <asp:ListItem Value="" Selected="True" Disabled="True">--Select Farming Practice--</asp:ListItem>
                                <asp:ListItem>Crop Rotation</asp:ListItem>
                                <asp:ListItem>Green Manuring</asp:ListItem>
                                <asp:ListItem>Composting & Vermicomposting</asp:ListItem>
                                <asp:ListItem>Mulching</asp:ListItem>
                                <asp:ListItem>Biological Pest Control</asp:ListItem>
                                <asp:ListItem>Companion Planting</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <asp:Label ID="lblErrorMessage4" runat="server" ForeColor="Red" Visible="false"></asp:Label>
                        <br />
                    </div>

                    <div>
                        <asp:Label ID="Label27" runat="server" Text="Sowing Date :" Font-Size="Medium" Font-Bold="true"></asp:Label>
                        <asp:TextBox ID="ptxtsdate" runat="server" TextMode="Date" CssClass="form-control" Placeholder="Select a sowing date" Style="border-style: outset;"></asp:TextBox>
                        <asp:Label ID="lblErrorMessage5" runat="server" ForeColor="Red" Visible="false"></asp:Label>
                        <br />
                    </div>

                    <div>
                        <asp:Label ID="Label28" runat="server" Text="Harverst Date :" Font-Size="Medium" Font-Bold="true"></asp:Label>
                        <asp:TextBox ID="ptxthdate" runat="server" TextMode="Date" CssClass="form-control" Placeholder="Select a harverst date" Style="border-style: outset;"></asp:TextBox>
                        <asp:Label ID="lblErrorMessage6" runat="server" ForeColor="Red" Visible="false"></asp:Label>
                        <br />
                    </div>
                    

                </div>

                <div class="modal-footer" style="align-items:center;">
                    <asp:Button ID="btnaddproduce" runat="server" Text="Add Produce" CssClass="btn btn-success btn-lg" OnClick="btnaddproduce_Click"/>
                </div>
            </div>
        </div>
    </div>

    
</asp:Content>
