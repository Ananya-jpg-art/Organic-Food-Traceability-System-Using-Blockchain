using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Security.Cryptography;
using System.Text;
using System.IO;

namespace Organic_food
{
    public partial class DistOrders : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["conOrganicFood"].ConnectionString);
        protected void Page_Load(object sender, EventArgs e)
        {
            //Session["Login"] = "Farmer";
            //Session["Login"] = "Manufacturer";
            if (!IsPostBack)
            {
                BindGridView();
                AdjustGridViewColumns();
                if (Session["userType"] == null)
                {
                    Response.Redirect("Login.aspx");
                }
            }
        }
        private void AdjustGridViewColumns()
        {
            if (Session["userType"] != null)
            {
                string userType = Session["userType"].ToString();

                Distordergridview.Columns[12].Visible = userType == "Distributor"; // Delete column index

                Distordergridview.Columns[10].Visible = userType != "Distributor"; // Actions column index
                Distordergridview.Columns[11].Visible = userType != "Distributor"; // Actions column index
            }
        }
        protected void lbtnsearch_Click(object sender, EventArgs e)
        {
            BindGridView(txtSearch.Text.Trim());
        }

        private void BindGridView(string searchQuery = "")
        {
            string id = Session["userId"].ToString();
            string userType = Session["userType"].ToString();

            if (userType == "Distributor")
            {
                string query = @"SELECT * FROM Orders Where [FromType] ='Distributor' And [ToType] ='Manufacturer' And [FromId] = '" + id + "'";

                if (!string.IsNullOrEmpty(searchQuery))
                {
                    query += " WHERE ProductName LIKE @SearchQuery";
                }

                SqlCommand cmd = new SqlCommand(query, con);
                if (!string.IsNullOrEmpty(searchQuery))
                {
                    cmd.Parameters.AddWithValue("@SearchQuery", "%" + searchQuery + "%");
                }

                SqlDataAdapter sda = new SqlDataAdapter(cmd);

                DataTable dt = new DataTable();
                sda.Fill(dt);

                if (dt.Rows.Count == 0)
                {
                    lbNoData.Visible = true;
                }

                dt.Columns.Add("isManipulated");

                if (dt.Rows.Count > 0)
                {
                    List<OrderBlock> blocklist = getBlockList();
                    for (int z = 0; z < blocklist.Count; z++)
                    {
                        OrderBlock block1 = blocklist[z];
                        DataRow row = dt.Rows[z];

                        Block blocks = new Block();

                        blocks.gethash(block1.Prid, block1.PrName, block1.PrQuantity, block1.PrPrice, block1.PrFromId, block1.PrFromType, block1.PrToId, block1.PrToType, block1.Date, block1.Time, block1.Previousblock);
                        string block1hash = blocks.getFinalBlock();

                        if (block1hash == block1.block)
                        {
                            //blockans = "Match\n";
                            row["isManipulated"] = "No";

                        }
                        else
                        {
                            //blockans = "Not Match\n";
                            row["isManipulated"] = "Yes";

                        }

                    }

                    Distordergridview.DataSource = dt;
                    Distordergridview.DataBind();
                }
            }
            else
            {
                string query = @"SELECT * FROM Orders Where [FromType] ='Distributor' And [ToType] ='Manufacturer' And [ToId] = '" + id + "'";

                if (!string.IsNullOrEmpty(searchQuery))
                {
                    query += " WHERE ProductName LIKE @SearchQuery";
                }

                SqlCommand cmd = new SqlCommand(query, con);
                if (!string.IsNullOrEmpty(searchQuery))
                {
                    cmd.Parameters.AddWithValue("@SearchQuery", "%" + searchQuery + "%");
                }

                SqlDataAdapter sda = new SqlDataAdapter(cmd);

                DataTable dt = new DataTable();
                sda.Fill(dt);

                if (dt.Rows.Count == 0)
                {
                    lbNoData.Visible = true;
                }

                dt.Columns.Add("isManipulated");

                if (dt.Rows.Count > 0)
                {
                    List<OrderBlock> blocklist = getBlockList();
                    for (int z = 0; z < blocklist.Count; z++)
                    {
                        OrderBlock block1 = blocklist[z];
                        DataRow row = dt.Rows[z];

                        Block blocks = new Block();

                        blocks.gethash(block1.Prid, block1.PrName, block1.PrQuantity, block1.PrPrice, block1.PrFromId, block1.PrFromType, block1.PrToId, block1.PrToType, block1.Date, block1.Time, block1.Previousblock);
                        string block1hash = blocks.getFinalBlock();

                        if (block1hash == block1.block)
                        {
                            //blockans = "Match\n";
                            row["isManipulated"] = "No";

                        }
                        else
                        {
                            //blockans = "Not Match\n";
                            row["isManipulated"] = "Yes";

                        }

                    }

                    Distordergridview.DataSource = dt;
                    Distordergridview.DataBind();
                }
            }

            PopulateDropdowns();
        }

        private void PopulateDropdowns()
        {
            foreach (GridViewRow row in Distordergridview.Rows)
            {
                string id = Session["userId"].ToString();

                DropDownList ddlOidLink = (DropDownList)row.FindControl("ddlOidLink");
                HiddenField hfOid = (HiddenField)row.FindControl("hfOid");
                Label lblOidLink = (Label)row.FindControl("lblOidLink");

                if (ddlOidLink != null && hfOid != null && lblOidLink != null)
                {
                    int orderId = Convert.ToInt32(hfOid.Value);

                    // Check if OidLink is already set
                    string checkQuery = "SELECT OidLink FROM Orders WHERE Oid = @Oid";
                    object oidLinkValue = null;
                    using (SqlCommand cmd = new SqlCommand(checkQuery, con))
                    {
                        cmd.Parameters.AddWithValue("@Oid", orderId);
                        con.Open();
                        oidLinkValue = cmd.ExecuteScalar();
                        con.Close();
                    }

                    if (oidLinkValue == DBNull.Value || oidLinkValue == null) // Show dropdown only if OidLink is NULL
                    {
                        string pidQuery = @"SELECT Oid FROM Orders 
                        WHERE ProductName = (SELECT ProductName FROM Orders WHERE Oid = @Oid) 
                        AND OidLink IS NOT NULL And FromId = '"+id+"'"; // Ensures OidLink is NULL

                        using (SqlCommand cmd = new SqlCommand(pidQuery, con))
                        {
                            cmd.Parameters.AddWithValue("@Oid", orderId);

                            con.Open(); // Ensure connection is open
                            using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                            {
                                DataTable dt = new DataTable();
                                sda.Fill(dt);
                                ddlOidLink.DataSource = dt;
                                ddlOidLink.DataTextField = "Oid";
                                ddlOidLink.DataValueField = "Oid";
                                ddlOidLink.DataBind();
                            }
                            con.Close(); // Ensure connection is closed after operation
                        }

                        ddlOidLink.Items.Insert(0, new ListItem("-- Select --", "0"));
                        ddlOidLink.Visible = true;
                        lblOidLink.Visible = false;
                    }

                    else
                    {
                        ddlOidLink.Visible = false;
                        lblOidLink.Text = oidLinkValue.ToString();
                        lblOidLink.Visible = true;
                    }
                }
            }
        }

        protected void ddlOidLink_SelectedIndexChanged(object sender, EventArgs e)
        {
            string id = Session["userId"].ToString();

            DropDownList ddl = (DropDownList)sender;
            GridViewRow row = (GridViewRow)ddl.NamingContainer;

            HiddenField hfOid = (HiddenField)row.FindControl("hfOid");
            Label lblOidLink = (Label)row.FindControl("lblOidLink");
            int orderId = Convert.ToInt32(hfOid.Value);
            string selectedOidLink = ddl.SelectedValue;

            if (selectedOidLink != "0") // Ensure a valid selection
            {
                string updateQuery = "UPDATE Orders SET OidLink = @OidLink WHERE Oid = @Oid";
                using (SqlCommand cmd = new SqlCommand(updateQuery, con))
                {
                    cmd.Parameters.AddWithValue("@OidLink", selectedOidLink);
                    cmd.Parameters.AddWithValue("@Oid", orderId);

                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();
                }

                ddl.Visible = false;
                lblOidLink.Text = selectedOidLink;
                lblOidLink.Visible = true;
            }
        }

        protected void btnAction_Command(object sender, CommandEventArgs e)
        {
            int orderId = Convert.ToInt32(e.CommandArgument);

            if (e.CommandName == "Finish")
            {
                UpdateOrderStatus(orderId, "Finished");
            }
            else if (e.CommandName == "Delivered")
            {
                UpdateOrderStatus(orderId, "Delivered");
            }
            BindGridView();
        }

        private void UpdateOrderStatus(int orderId, string status)
        {
            string query = "UPDATE Orders SET Status = @Status WHERE Oid = @OrderId";
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.AddWithValue("@Status", status);
                cmd.Parameters.AddWithValue("@OrderId", orderId);

                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();
            }
        }

        private void DeleteRecord(int Oid)
        {
            string query = "DELETE FROM Orders WHERE Oid = @Oid";
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.AddWithValue("@Oid", Oid);

                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();
            }
        }

        protected void Distordergridview_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int Oid = Convert.ToInt32(Distordergridview.DataKeys[e.RowIndex].Value);
            DeleteRecord(Oid);
            BindGridView();
        }

        public List<OrderBlock> getBlockList()
        {
            string id = Session["userId"].ToString();
            string userType = Session["userType"].ToString();

            if (userType == "Distributor")
            {
                List<OrderBlock> blocklist = new List<OrderBlock>();
                DataTable dt = new DataTable("Blocklist");

                string trackquery = @"SELECT * FROM Orders Where [FromType] ='Distributor' And [ToType] ='Manufacturer' And [FromId] = '" + id + "'";
                SqlDataAdapter da = new SqlDataAdapter(trackquery, con);
                da.Fill(dt);

                int count = dt.Rows.Count;
                for (int i = 0; i < count; i++)
                {
                    OrderBlock blst = new OrderBlock();
                    blst.Prid = dt.Rows[i]["Pid"].ToString();
                    blst.PrName = dt.Rows[i]["ProductName"].ToString();
                    blst.PrQuantity = dt.Rows[i]["Quantity"].ToString();
                    blst.PrPrice = dt.Rows[i]["Price"].ToString();
                    blst.PrFromId = dt.Rows[i]["FromId"].ToString();
                    blst.PrFromType = dt.Rows[i]["FromType"].ToString();
                    blst.PrToId = dt.Rows[i]["ToId"].ToString();
                    blst.PrToType = dt.Rows[i]["ToType"].ToString();
                    blst.Date = dt.Rows[i]["Date"].ToString();
                    blst.Time = dt.Rows[i]["Time"].ToString();
                    blst.Previousblock = dt.Rows[i]["PrevHash"].ToString();
                    blst.block = dt.Rows[i]["CurrHash"].ToString();
                    blocklist.Add(blst);
                }

                return blocklist;
            }
            else
            {
                List<OrderBlock> blocklist = new List<OrderBlock>();
                DataTable dt = new DataTable("Blocklist");

                string trackquery = @"SELECT * FROM Orders Where [FromType] ='Distributor' And [ToType] ='Manufacturer'";
                SqlDataAdapter da = new SqlDataAdapter(trackquery, con);
                da.Fill(dt);

                int count = dt.Rows.Count;
                for (int i = 0; i < count; i++)
                {
                    OrderBlock blst = new OrderBlock();
                    blst.Prid = dt.Rows[i]["Pid"].ToString();
                    blst.PrName = dt.Rows[i]["ProductName"].ToString();
                    blst.PrQuantity = dt.Rows[i]["Quantity"].ToString();
                    blst.PrPrice = dt.Rows[i]["Price"].ToString();
                    blst.PrFromId = dt.Rows[i]["FromId"].ToString();
                    blst.PrFromType = dt.Rows[i]["FromType"].ToString();
                    blst.PrToId = dt.Rows[i]["ToId"].ToString();
                    blst.PrToType = dt.Rows[i]["ToType"].ToString();
                    blst.Date = dt.Rows[i]["Date"].ToString();
                    blst.Time = dt.Rows[i]["Time"].ToString();
                    blst.Previousblock = dt.Rows[i]["PrevHash"].ToString();
                    blst.block = dt.Rows[i]["CurrHash"].ToString();
                    blocklist.Add(blst);
                }

                return blocklist;
            }

        }

        public class Block
        {
            private byte[] _finalHashBlock;

            public void gethash(string prid, string prname, string prquantity, string prprice, string prfromId, string prfromType, string prtoId, string prtoType, string date, string time, string previousBlock)
            {
                byte[] prIdBytes = Encoding.UTF8.GetBytes(prid);
                byte[] prnameBytes = Encoding.UTF8.GetBytes(prname);
                byte[] prquantityBytes = Encoding.UTF8.GetBytes(prquantity);
                byte[] prpriceBytes = Encoding.UTF8.GetBytes(prprice);
                byte[] prfromIdBytes = Encoding.UTF8.GetBytes(prfromId);
                byte[] prfromTypeBytes = Encoding.UTF8.GetBytes(prfromType);
                byte[] prtoIdBytes = Encoding.UTF8.GetBytes(prtoId);
                byte[] prtoTypeBytes = Encoding.UTF8.GetBytes(prtoType);
                byte[] dateBytes = Encoding.UTF8.GetBytes(date);
                byte[] timeBytes = Encoding.UTF8.GetBytes(time);
                byte[] prevHashBytes = Encoding.UTF8.GetBytes(previousBlock);

                using (SHA512 sha = new SHA512Managed())
                using (MemoryStream st = new MemoryStream())
                using (BinaryWriter bw = new BinaryWriter(st))
                {
                    bw.Write(prIdBytes);
                    bw.Write(prnameBytes);
                    bw.Write(prquantityBytes);
                    bw.Write(prpriceBytes);
                    bw.Write(prfromIdBytes);
                    bw.Write(prfromTypeBytes);
                    bw.Write(prtoIdBytes);
                    bw.Write(prtoTypeBytes);
                    bw.Write(dateBytes);
                    bw.Write(timeBytes);
                    bw.Write(prevHashBytes);
                    _finalHashBlock = sha.ComputeHash(st.ToArray());
                }
            }

            public string getFinalBlock()
            {
                return _finalHashBlock != null ? BitConverter.ToString(_finalHashBlock).Replace("-", "") : "Not Defined";
            }
        }


    }
}