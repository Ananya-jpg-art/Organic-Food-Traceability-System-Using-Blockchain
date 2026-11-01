<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="DistOrders.aspx.cs" Inherits="Organic_food.DistOrders" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
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
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <br />
    <div class="header-container">
        <h1 align="center" style="text-decoration: underline; color: darkcyan; font-family: cursive">Orders Details</h1>
    </div>

    <div class="search-container">
        <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" Placeholder="Search by Product Name"></asp:TextBox>
        <asp:LinkButton ID="lbtnsearch" runat="server" Height="35px" BackColor="#228B22" CssClass="btn btn-success" Width="50px" >
                <span class="fas fa-search" style="color:white; margin-top:4px;" OnClick="lbtnsearch_Click"></span>
        </asp:LinkButton>
    </div>
    <br />
    <center>
         <asp:Label id="lbNoData" runat="server" Visible="false" Font-Bold="true" ForeColor="Red" Font-Size="30px" Text="No Data Available"></asp:Label>
    </center>

    <asp:GridView ID="Distordergridview" runat="server" AutoGenerateColumns="False" CssClass="styled-gridview" DataKeyNames="Oid" OnRowDeleting="Distordergridview_RowDeleting">
        <Columns>
            <asp:BoundField DataField="Oid" HeaderText="OrderId">
                <HeaderStyle CssClass="text-center" />
                <ItemStyle HorizontalAlign="Center" />
            </asp:BoundField>
            <asp:BoundField DataField="ProductName" HeaderText="Product Name">
                <HeaderStyle CssClass="text-center" />
                <ItemStyle HorizontalAlign="Center" />
            </asp:BoundField>
            <asp:BoundField DataField="Quantity" HeaderText="Quantity">
                <HeaderStyle CssClass="text-center" />
                <ItemStyle HorizontalAlign="Center" />
            </asp:BoundField>
            <asp:BoundField DataField="Price" HeaderText="Total Price">
                <HeaderStyle CssClass="text-center" />
                <ItemStyle HorizontalAlign="Center" />
            </asp:BoundField>
            <asp:BoundField DataField="FromType" HeaderText="From">
                <HeaderStyle CssClass="text-center" />
                <ItemStyle HorizontalAlign="Center" />
            </asp:BoundField>
            <asp:BoundField DataField="ToType" HeaderText="To">
                <HeaderStyle CssClass="text-center" />
                <ItemStyle HorizontalAlign="Center" />
            </asp:BoundField>
            <asp:BoundField DataField="Date" HeaderText="Date" DataFormatString="{0:yyyy-MM-dd}">
                <HeaderStyle CssClass="text-center" Width="120px"/>
                <ItemStyle HorizontalAlign="Center" />
            </asp:BoundField>
            <asp:BoundField DataField="Time" HeaderText="Time">
                <HeaderStyle CssClass="text-center" />
                <ItemStyle HorizontalAlign="Center" />
            </asp:BoundField>
            <asp:BoundField DataField="Status" HeaderText="Status">
                <HeaderStyle CssClass="text-center" />
                <ItemStyle HorizontalAlign="Center" />
            </asp:BoundField>
            <asp:BoundField DataField="isManipulated" HeaderText="isManipulated">
                <HeaderStyle CssClass="text-center" />
                <ItemStyle HorizontalAlign="Center" />
            </asp:BoundField>
            <asp:TemplateField HeaderText="Actions" >
                <HeaderStyle CssClass="text-center" Width="190px" />
                <ItemStyle HorizontalAlign="Center" />
                <ItemTemplate>
                    <asp:Button ID="btnFinish" runat="server" Text="Finish" CssClass="btn btn-success"
                        CommandName="Finish" CommandArgument='<%# Eval("Oid") %>' OnCommand="btnAction_Command"
                        Enabled='<%# Eval("Status").ToString() == "Pending" %>' />

                    <asp:Button ID="btnDelivered" runat="server" Text="Delivered" CssClass="btn btn-primary"
                        CommandName="Delivered" CommandArgument='<%# Eval("Oid") %>' OnCommand="btnAction_Command"
                        Enabled='<%# Eval("Status").ToString() == "Pending" || Eval("Status").ToString() == "Finished" %>' />
                </ItemTemplate>
                <ItemStyle HorizontalAlign="Center" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="OidLink">
                <HeaderStyle CssClass="text-center" />
                <ItemStyle HorizontalAlign="Center" />
                <ItemTemplate>
                    <%-- Show Label if OidLink is not NULL --%>
                    <asp:Label ID="lblOidLink" runat="server"
                        Text='<%# Eval("OidLink") != DBNull.Value && Eval("OidLink") != null ? Eval("OidLink").ToString() : "" %>'
                        Visible='<%# Eval("OidLink") != DBNull.Value && Eval("OidLink") != null %>'>
                    </asp:Label>

                 <%--Show Dropdown if OidLink is NULL --%>
                    <asp:DropDownList ID="ddlOidLink" runat="server" AutoPostBack="true"
                        OnSelectedIndexChanged="ddlOidLink_SelectedIndexChanged">
                    </asp:DropDownList>

                  <%-- Store Order ID --%>
                    <asp:HiddenField ID="hfOid" runat="server" Value='<%# Eval("Oid") %>' />
                </ItemTemplate>
            </asp:TemplateField>

            <asp:TemplateField HeaderText="Delete">
                <HeaderStyle CssClass="text-center" />
                <ItemStyle HorizontalAlign="Center" />
                <ItemTemplate>
                    <asp:LinkButton ID="btnDelete" runat="server" CommandName="Delete" CommandArgument='<%# Eval("Oid") %>' CssClass="btn btn-danger" CausesValidation="false" OnClientClick="return confirm('Are you sure you want to delete this data?');">
                  Cancel Order
                </asp:LinkButton>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
</asp:Content>
