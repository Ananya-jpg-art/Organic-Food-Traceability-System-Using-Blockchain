using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.Sql;
using System.Data.SqlClient;
using System.Configuration;
using System.IO;
using System.Security.Cryptography;
using System.Text;

namespace Organic_food
{
    public partial class ViewManProducts : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["conOrganicFood"].ConnectionString);
        private string _prevHash;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["userType"] == null && Session["userId"] == null)
                {
                    Response.Redirect("Login.aspx");
                }

                //Add_UpCard.Visible = false;
                //ViewCard.Visible = false;

                BindDataList();
            }
        }

        private void BindDataList()
        {
            string query = "Select * from ManProducts";

            SqlCommand cmd = new SqlCommand(query, con);

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);

            DataList1.DataSource = dt;
            DataList1.DataBind();

            if (dt.Rows.Count == 0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "msg", "alert('No Data Available!!');", true);
                DataList1.Visible = true;
            }
        }

        protected void lbtnsearch_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrWhiteSpace(txtsearch.Text))
            {
                BindDataList();
            }
            else
            {
                string query = "SELECT * FROM ManProducts WHERE mProductName LIKE @ProductName";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@ProductName", "%" + txtsearch.Text.Trim() + "%");
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    if (dt.Rows.Count > 0)
                    {
                        DataList1.DataSource = dt;
                        DataList1.DataBind();
                        DataList1.Visible = true;
                    }
                    else
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "msg", "alert('No Data Available!!');", true);
                    }
                }
            }
        }

        protected void orderbtn_Click(object sender, EventArgs e)
        {
            ocompDropdown.Items.Clear(); 
            otxtquantity.Text = "";
            otxtprice.Text = "";

            LinkButton btn = (LinkButton)sender;
            string pid = btn.CommandArgument;
            Session["mPid"] = pid;

            string q = "Select * from ManProducts  where mPid='" + pid + "'";
            SqlDataAdapter daa = new SqlDataAdapter(q, con);
            DataTable dtt = new DataTable();
            daa.Fill(dtt);
            if (dtt.Rows.Count > 0)
            {
                otxtpid.Text = dtt.Rows[0][0].ToString();
                otxtpname.Text = dtt.Rows[0][1].ToString();
                otxtdisc.Text = dtt.Rows[0][3].ToString();
                otxtduration.Text = dtt.Rows[0][4].ToString();
                oImage2.ImageUrl = dtt.Rows[0][5].ToString();
            }
            string pname = otxtpname.Text;
            Session["mProductName"] = pname;

            ScriptManager.RegisterStartupScript(this, this.GetType(), "Popup", "$(document).ready(function() { $('#OrderCardModal').modal('show'); });", true);
            BindCompanyNames();
        }

        private void BindCompanyNames()
        {
            string mpname = Session["mProductName"].ToString();
            string userType = Session["userType"].ToString();

            if(userType== "Distributor")
            {
                //string query = "SELECT ID, company_Name FROM Register where userType = 'Manufacturer'"; 

                string query = @"SELECT DISTINCT r.ID, r.company_Name 
                     FROM Register r
                     INNER JOIN ManProducts p ON r.ID = p.userId
                     WHERE r.userType = 'Manufacturer' 
                     AND p.mProductName = '" + mpname + "'";

                SqlCommand cmd = new SqlCommand(query, con);
                con.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                ocompDropdown.DataSource = reader;
                ocompDropdown.DataTextField = "company_Name";
                ocompDropdown.DataValueField = "ID";
                ocompDropdown.DataBind();
            }
            else if(userType == "Retailer" || userType == "Customer")
            {
                string query = "SELECT ID, company_Name FROM Register where userType = 'Distributor'";
                SqlCommand cmd = new SqlCommand(query, con);
                con.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                ocompDropdown.DataSource = reader;
                ocompDropdown.DataTextField = "company_Name";
                ocompDropdown.DataValueField = "ID";
                ocompDropdown.DataBind();
            }
        }

        protected void ordbtn_Click(object sender, EventArgs e)
        {
            string pid = otxtpid.Text;
            string productname = otxtpname.Text;
            string proquantity = otxtquantity.Text;
            string totalprice = otxtprice.Text;
            string id = Session["userId"].ToString();
            string userType = Session["userType"].ToString();
            string date = DateTime.Now.ToShortDateString();
            string time = DateTime.Now.ToShortTimeString();
            string selectedCompanyID = ocompDropdown.SelectedValue;
            string selectedCompanyUserType = GetUserTypeById(selectedCompanyID);

            con.Open();

            string query = "SELECT TOP 1 CurrHash FROM Orders WHERE FromId = @fromId ORDER BY Oid DESC";

            SqlCommand cmmd = new SqlCommand(query, con);
            cmmd.Parameters.AddWithValue("@fromId", id);
            _prevHash = cmmd.ExecuteScalar() as string ?? "Genesis";

            OrderBlock bl = new OrderBlock
            {
                Prid = pid,
                PrName = productname,
                PrQuantity = proquantity,
                PrPrice = totalprice,
                PrFromId = id,
                PrFromType = userType,
                PrToId = selectedCompanyID,
                PrToType = selectedCompanyUserType,
                Date = date,
                Time = time,
                Previousblock = _prevHash
            };

            Block block = new Block();
            block.GenerateHash(bl.Prid, bl.PrName, bl.PrQuantity, bl.PrPrice, bl.PrFromId, bl.PrFromType, bl.PrToId, bl.PrToType, bl.Date, bl.Time, bl.Previousblock);
            bl.block = block.GetFinalBlock();

            string q = "Insert into Orders(Pid,ProductName,Quantity,Price,FromId,FromType,ToId,ToType,Date,Time,Status,PrevHash,CurrHash) values(@Pid,@ProductName,@Quantity,@Price,@FromId,@FromType,@ToId,@ToType,@Date,@Time,@Status,@PreviousHash,@CurrentHash)";
            SqlCommand cmd = new SqlCommand(q, con);
            cmd.Parameters.AddWithValue("@Pid", pid);
            cmd.Parameters.AddWithValue("@ProductName", productname);
            cmd.Parameters.AddWithValue("@Quantity", proquantity);
            cmd.Parameters.AddWithValue("@Price", totalprice);
            cmd.Parameters.AddWithValue("@FromId", id);
            cmd.Parameters.AddWithValue("@FromType", userType);
            cmd.Parameters.AddWithValue("@ToId", selectedCompanyID);
            cmd.Parameters.AddWithValue("@ToType", selectedCompanyUserType);
            cmd.Parameters.AddWithValue("@Date", date);
            cmd.Parameters.AddWithValue("@Time", time);
            cmd.Parameters.AddWithValue("@Status", "Pending");
            cmd.Parameters.AddWithValue("@PreviousHash", _prevHash);
            cmd.Parameters.AddWithValue("@CurrentHash", bl.block);
            cmd.ExecuteNonQuery();
            con.Close();

            ScriptManager.RegisterStartupScript(this, this.GetType(), "msg", "alert('Product Order Successfully!!');", true);
        }

        private string GetUserTypeById(string companyId)
        {
            string userType = "";
            string query = "SELECT userType FROM Register WHERE ID = @CompanyId";

            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.AddWithValue("@CompanyId", companyId);
                con.Open();
                object result = cmd.ExecuteScalar();
                con.Close();

                if (result != null)
                {
                    userType = result.ToString();
                }
            }
            return userType;
        }

        protected void otxtquantity_TextChanged(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(otxtquantity.Text))
            {
                int quant;
                if (int.TryParse(otxtquantity.Text, out quant) && quant > 0)
                {
                    string productId = otxtpid.Text;
                    int unitPrice = GetPriceFromDatabase(productId);

                    int totalPrice = unitPrice * quant;
                    otxtprice.Text = totalPrice.ToString();
                }
                else
                {
                    otxtquantity.Text = "1";
                    otxtprice.Text = GetPriceFromDatabase(otxtpid.Text).ToString(); // Reset to base price
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Invalid Quantity!');", true);
                }
            }

            ScriptManager.RegisterStartupScript(this, this.GetType(), "Popup", "$(document).ready(function() { $('#OrderCardModal').modal('show'); });", true);
        }

        private int GetPriceFromDatabase(string productId)
        {
            int price = 0;
            string query = "SELECT mPrice FROM ManProducts WHERE mPid = @ProductID";

            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.AddWithValue("@ProductID", productId);
                con.Open();
                object result = cmd.ExecuteScalar();
                if (result != null)
                {
                    price = Convert.ToInt32(result);
                }
            }
            return price;
        }

        public class Block
        {
            private byte[] _finalHashBlock;

            public void GenerateHash(string prid, string prname, string prquantity, string prprice, string prfromId, string prfromType, string prtoId, string prtoType, string date, string time, string previousBlock)
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

            public string GetFinalBlock()
            {
                return _finalHashBlock != null ? BitConverter.ToString(_finalHashBlock).Replace("-", "") : "Not Defined";
            }
        }

    }
}