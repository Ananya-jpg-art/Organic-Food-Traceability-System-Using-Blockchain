<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="FarmProduceDetails.aspx.cs" Inherits="Organic_food.FarmProduceDetails" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.12.1/css/all.css" crossorigin="anonymous" />

    <style>
        .header-container {
            text-align: center;
            margin-bottom: 10px;
        }

        .title {
            text-decoration: underline;
            color: darkcyan;
            font-family: cursive;
            font-size: 27px;
            font-weight: bold;
            margin-bottom: 5px;
        }

        .search-container {
            display: flex;
            justify-content: flex-end;
            width: 32%;
            margin-left: auto;
            gap: 20px;
        }

            .search-container input {
                width: 80%;
            }

        .styled-gridview {
            width: 100%;
            border-collapse: collapse;
            background-color: #d4edda; /* Light green background */
            border: 1px solid #155724; /* Dark green border */
        }

            .styled-gridview th {
                background-color: #155724; /* Dark green header */
                color: white;
                padding: 10px;
                text-align: left;
            }

            .styled-gridview td {
                padding: 10px;
                border: 1px solid #155724;
            }

            .styled-gridview tr:nth-child(even) {
                background-color: #c3e6cb; /* Lighter green for even rows */
            }

            .styled-gridview tr:hover {
                background-color: #b1dfbb; /* Slightly darker green on hover */
            }
    </style>
    <script>
        function showDetails(proId, productName, batchNo, crop, soil, farmingPractice, sowingDate, harvestDate) {
            document.getElementById("modalProId").innerText = proId;
            document.getElementById("modalProductName").innerText = productName;
            document.getElementById("modalBatchNo").innerText = batchNo;
            document.getElementById("modalCropDetail").innerText = crop;
            document.getElementById("modalSoilDetail").innerText = soil;
            document.getElementById("modalFarmingPractice").innerText = farmingPractice;
            document.getElementById("modalSowingDate").innerText = sowingDate;
            document.getElementById("modalHarvestDate").innerText = harvestDate;

            // Show the modal
            var modal = new bootstrap.Modal(document.getElementById("manageViewModal"));
            modal.show();
        }

        function editDetails(proId, productName, batchNo, crop, soil, farmingPractice, sowingDate, harvestDate) {
            console.log("Editing:", proId, productName, batchNo, crop, soil, farmingPractice, sowingDate, harvestDate); // Debugging

            document.getElementById("editProId").value = proId;
            document.getElementById("editProductName").value = productName;
            document.getElementById("editBatchNo").value = batchNo;
            document.getElementById("editCropDetail").value = crop;

            var soilDropdown = document.getElementById("editSoilDetailDropdown");

            // Check if the soil type exists in the dropdown
            var found = false;
            for (var i = 0; i < soilDropdown.options.length; i++) {
                if (soilDropdown.options[i].value === soil) {
                    soilDropdown.selectedIndex = i;
                    found = true;
                    break;
                }
            }

            // If the soil type is not in the predefined list, add it as the first option
            if (!found && soil.trim() !== "") {
                var newOption = document.createElement("option");
                newOption.value = soil;
                newOption.text = soil;
                newOption.selected = true;
                soilDropdown.insertBefore(newOption, soilDropdown.firstChild);
            }

            //farmingPracticeDropdown
            var farmPractDropdown = document.getElementById("editFarmingPracticeDropdown");

            // Check if the farm type exists in the dropdown
            var found = false;
            for (var i = 0; i < farmPractDropdown.options.length; i++) {
                if (farmPractDropdown.options[i].value === farmingPractice) {
                    farmPractDropdown.selectedIndex = i;
                    found = true;
                    break;
                }
            }

            // If the farm type is not in the predefined list, add it as the first option
            if (!found && farm.trim() !== "") {
                var newOption = document.createElement("option");
                newOption.value = farmingPractice;
                newOption.text = farmingPractice;
                newOption.selected = true;
                farmPractDropdown.insertBefore(newOption, farmPractDropdown.firstChild);
            }


            //document.getElementById("editFarmingPractice").value = farmingPractice;
            document.getElementById("editSowingDate").value = sowingDate;
            document.getElementById("editHarvestDate").value = harvestDate;

            var modal = new bootstrap.Modal(document.getElementById("editModal"));
            modal.show();
        }

        function updateDetails() {
            var proId = document.getElementById("editProId").value; // Still used for updating, but read-only
            var crop = document.getElementById("editCropDetail").value;
            var soil = document.getElementById("editSoilDetailDropdown").value;
            var farmingPractice = document.getElementById("editFarmingPracticeDropdown").value;
            var sowingDate = document.getElementById("editSowingDate").value;
            var harvestDate = document.getElementById("editHarvestDate").value;

            // Send updated data to the server using AJAX
            $.ajax({
                type: "POST",
                url: "FarmProduceDetails.aspx/UpdateFarmProduce",
                data: JSON.stringify({ ProId: proId, CropDetails: crop, SoilDetails: soil, FarmingPractice: farmingPractice, SowingDate: sowingDate, HarvestDate: harvestDate }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function () {
                    alert("✅ Update Successful! The farm produce details have been updated.");
                    location.reload(); // Refresh the page to reflect changes
                },
                error: function () {
                    alert("❌ Update Failed! Please try again.");
                }
            });
        }
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <br />
    <div class="header-container">
        <h1 align="center" style="text-decoration: underline; color: darkcyan; font-family: cursive">Farmer Produce Details</h1>

    </div>

    <div class="search-container">
        <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" Placeholder="Search by ProduceId"></asp:TextBox>
        <asp:LinkButton ID="lbtnsearch" runat="server" Height="35px" BackColor="#228B22" CssClass="btn btn-success" Width="50px" OnClick="lbtnsearch_Click">
                <span class="fas fa-search" style="color:white; margin-top:4px;"></span>
        </asp:LinkButton>
    </div>
    <br />
    <center>
         <asp:Label id="lbNoData" runat="server" Visible="false" Font-Bold="true" ForeColor="Red" Font-Size="30px" Text="No Data Available"></asp:Label>
    </center>

    <asp:ScriptManager runat="server" />
    <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
        <ContentTemplate>
            <asp:GridView ID="gvFarmProduce" runat="server" AutoGenerateColumns="False"
                CssClass="styled-gridview" DataKeyNames="ProId" OnRowDeleting="gvFarmProduce_RowDeleting">
                <Columns>
                    <asp:BoundField DataField="ProId" HeaderText="Produce Id" />
                    <asp:BoundField DataField="ProductName" HeaderText="Product Name" />
                    <asp:BoundField DataField="BatchNo" HeaderText="Batch No" />
                    <asp:BoundField DataField="CropDetails" HeaderText="Crop Details" />
                    <asp:BoundField DataField="SoilDetails" HeaderText="Soil Details" />
                    <asp:BoundField DataField="FarmingPractice" HeaderText="Farming Practice" />
                    <asp:BoundField DataField="SowingDate" HeaderText="Sowing Date" DataFormatString="{0:yyyy-MM-dd}" />
                    <asp:BoundField DataField="HarvestDate" HeaderText="Harvest Date" DataFormatString="{0:yyyy-MM-dd}" />
                    <asp:TemplateField HeaderText="Delete">
                        <ItemTemplate>
                            <asp:LinkButton ID="btnDelete" runat="server" CommandName="Delete" CommandArgument='<%# Eval("ProId") %>' CssClass="btn btn-danger" CausesValidation="false" OnClientClick="return confirm('Are you sure you want to delete this data?');">
                  🗑️
                </asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="View">
                        <ItemTemplate>
                            <asp:LinkButton ID="lbtnView" runat="server" CssClass="btn btn-info"
                                OnClientClick='<%# "showDetails(\"" + Eval("ProId") + "\", \"" + Eval("ProductName") + "\", \"" + Eval("BatchNo") + "\", \"" + Eval("CropDetails") + "\", \"" + Eval("SoilDetails") + "\", \"" + Eval("FarmingPractice") + "\", \"" + Eval("SowingDate") + "\", \"" + Eval("HarvestDate") + "\"); return false;" %>'>
                    <i class="fas fa-eye" style="color:white; font-size:medium; font-weight:bold"></i>
                            </asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Edit">
                        <ItemTemplate>
                            <asp:LinkButton ID="lbtnEdit" runat="server" CssClass="btn btn-warning"
                                OnClientClick='<%# "editDetails(\"" + Eval("ProId") + "\", \"" + Eval("ProductName") + "\", \"" + Eval("BatchNo") + "\", \"" + Eval("CropDetails") + "\", \"" + Eval("SoilDetails") + "\", \"" + Eval("FarmingPractice") + "\", \"" + Eval("SowingDate") + "\", \"" + Eval("HarvestDate") + "\"); return false;" %>'>
            <i class="fas fa-edit"></i> 
                            </asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>

                </Columns>
            </asp:GridView>

            <!-- View Modal -->
            <div id="manageViewModal" class="modal fade" tabindex="-1" role="dialog" data-bs-backdrop="static" data-bs-keyboard="false">
                <div class="modal-dialog modal-lg" role="document">
                    <div class="modal-content" style="border-radius: 12px; border: none; box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.2);">
                        <div class="modal-header" style="background-color: #228B22; color: white; border-top-left-radius: 12px; border-top-right-radius: 12px;">
                            <h4 class="modal-title"><i class="fas fa-seedling"></i> Farm Produce Details</h4>
                            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                        </div>
                        <div class="modal-body" style="background-color: #f4f4f4; padding: 20px;">
                            <div class="container">
                                <div class="row">
                                    <div class="col-md-6">
                                        <p><strong>🌿 Produce ID:</strong> <span id="modalProId" class="text-success"></span></p>
                                    </div>
                                    <div class="col-md-6">
                                        <p><strong>📦 Batch No:</strong> <span id="modalBatchNo" class="text-success"></span></p>
                                    </div>
                                </div>
                                <hr style="border-top: 2px solid #228B22;">
                                <p><strong>🍎 Product Name:</strong> <span id="modalProductName" class="text-success"></span></p>
                                <p><strong>🚜 Farming Practice:</strong> <span id="modalFarmingPractice" class="text-success"></span></p>
                                <div class="row">
                                    <div class="col-md-6">
                                        <p><strong>🌱 Crop Detail:</strong> <span id="modalCropDetail" class="text-success"></span></p>
                                        <p><strong>🌍 Sowing Date:</strong> <span id="modalSowingDate" class="text-success"></span></p>
                                    </div>
                                    <div class="col-md-6">
                                        <p><strong>🌾 Soil Detail:</strong> <span id="modalSoilDetail" class="text-success"></span></p>
                                        <p><strong>🍂 Harvest Date:</strong> <span id="modalHarvestDate" class="text-success"></span></p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>


            <!-- Edit Modal -->
            <div id="editModal" class="modal fade" tabindex="-1" role="dialog" data-bs-backdrop="static" data-bs-keyboard="false">
                <div class="modal-dialog modal-lg" role="document">
                    <div class="modal-content" style="border-radius: 12px; border: none; box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.2);">
                        <div class="modal-header" style="background-color: #228B22; color: white; border-top-left-radius: 12px; border-top-right-radius: 12px;">
                            <h4 class="modal-title">Farm Produce</h4>
                            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                        </div>
                        <div class="modal-body" style="background-color: #f4f4f4; padding: 20px;">
                            <!-- Read-Only Fields -->
                            <div class="mb-3">
                                <label><strong>Product ID:</strong></label>
                                <input type="text" id="editProId" class="form-control" readonly />
                            </div>
                            <div class="mb-3">
                                <label><strong>Product Name:</strong></label>
                                <input type="text" id="editProductName" class="form-control" readonly />
                            </div>
                            <div class="mb-3">
                                <label><strong>Batch No:</strong></label>
                                <input type="text" id="editBatchNo" class="form-control" readonly />
                            </div>

                            <!-- Editable Fields -->
                            <div class="mb-3">
                                <label><strong>Crop Detail:</strong></label>
                                <input type="text" id="editCropDetail" class="form-control" />
                            </div>
                            <div class="mb-3">
                                <label><strong>Soil Detail:</strong></label>
                                <select id="editSoilDetailDropdown" class="form-control">
                                    <option value="">--Select Soil Type--</option>
                                    <option value="Loamy soil">Loamy soil</option>
                                    <option value="Sandy loam">Sandy loam</option>
                                    <option value="Clayey soil">Clayey soil</option>
                                    <option value="Well-drained sandy loam">Well-drained sandy loam</option>
                                    <option value="Well-drained alluvial soil">Well-drained alluvial soil</option>
                                </select>
                            </div>
                            <div class="mb-3">
                                <label><strong>Farming Practice:</strong></label>
                                <select id="editFarmingPracticeDropdown" class="form-control">
                                    <option value="">--Select Farming Practice--</option>
                                    <option value="Crop Rotation">Crop Rotation</option>
                                    <option value="Green Manuring">Green Manuring</option>
                                    <option value="Composting & Vermicomposting">Composting & Vermicomposting</option>
                                    <option value="Mulching">Mulching</option>
                                    <option value="Biological Pest Control">Biological Pest Control</option>
                                    <option value="Companion Planting">Companion Planting</option>
                                </select>                             
                            </div>
                            <div class="mb-3">
                                <label><strong>Sowing Date:</strong></label>
                                <input type="date" id="editSowingDate" class="form-control" />
                            </div>
                            <div class="mb-3">
                                <label><strong>Harvest Date:</strong></label>
                                <input type="date" id="editHarvestDate" class="form-control" />
                            </div>
                        </div>
                        <div class="modal-footer" style="background-color: #e8f5e9;">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                                ❌ Cancel
                            </button>
                            <button type="button" class="btn btn-success" onclick="updateDetails()">
                                ✅ Update
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
     <br /><br />
    <%-- <div class="modal-footer" style="background-color: #e8f5e9; border-bottom-left-radius: 12px; border-bottom-right-radius: 12px;">
                            <button type="button" class="btn btn-outline-success" data-bs-dismiss="modal">
                                <i class="fas fa-times"></i>Close
                            </button>
    </div>--%>
</asp:Content>
