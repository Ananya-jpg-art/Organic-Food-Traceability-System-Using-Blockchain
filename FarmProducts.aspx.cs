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

namespace Organic_food
{
    public partial class FarmProducts : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["conOrganicFood"].ConnectionString);

        protected void Page_Load(object sender, EventArgs e)
        {
            //Session["Login"] = "Farmer";
            //Session["Login"] = "Manufacture";
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
            string id = Session["userId"].ToString();
            string query = "Select * from FarmProducts where userId = '" + id + "'";

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

        protected void lbtnaddnew_Click(object sender, EventArgs e)
        {
            txtpname.Text = "";
            txtquantity.Text = "";
            txtprice.Text = "";
            txtdisc.Text = "";
            txtduration.Text = "";
            Image1.ImageUrl = "";
            Image1.Visible = false;
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Popup", "$(document).ready(function() { $('#addUpCardModal').modal('show'); });", true);
        }

        protected void btnimgupload_Click(object sender, EventArgs e)
        {
            try
            {
                string file = Path.GetFileName(FileUpload1.PostedFile.FileName);
                //Save images into Images folder
                FileUpload1.SaveAs(Server.MapPath("~\\Images\\" + file));
                string path = Server.MapPath("~\\Images\\" + file);
                FileUpload1.SaveAs(path + file);

                Image1.ImageUrl = "Images\\" + file;
                Image1.Visible = true;
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Popup", "$(document).ready(function() { $('#addUpCardModal').modal('show'); });", true);
            }
            catch (Exception ex)
            {
                Page.ClientScript.RegisterStartupScript(GetType(), "msgbox", "alert('Please Select Photo !!!');", true);
            }
        }

        protected void btnadd_Click(object sender, EventArgs e)
        {
            string id = Session["userId"].ToString();
            string userType = Session["userType"].ToString();
            con.Open();
            string q = "Insert into FarmProducts(ProductName,Quantity,Price,Description,Duration,Photo,userId) values('" + txtpname.Text + "','" + txtquantity.Text + "','" + txtprice.Text + "','" + txtdisc.Text + "','" + txtduration.Text + "','" + Image1.ImageUrl + "','" + id + "')";
            SqlCommand cmd = new SqlCommand(q, con);
            cmd.Parameters.AddWithValue("@id", id);
            //cmd.Parameters.AddWithValue("@userType", userType);
            cmd.ExecuteNonQuery();
            con.Close();

            Page.ClientScript.RegisterStartupScript(GetType(), "msg", "alert('Product details added successfully!!!')", true);
            BindDataList();
        }

        protected void lbtedit_Click(object sender, EventArgs e)
        {
            LinkButton btn = (LinkButton)sender;  
            string pid = btn.CommandArgument;

            string q = "Select * from FarmProducts  where Pid='" + pid + "'";
            SqlDataAdapter daa = new SqlDataAdapter(q, con);
            DataTable dtt = new DataTable();
            daa.Fill(dtt);
            if (dtt.Rows.Count > 0)
            {
                uptxtpid.Text = dtt.Rows[0][0].ToString();
                uptxtpname.Text = dtt.Rows[0][1].ToString();
                uptxtquantity.Text = dtt.Rows[0][7].ToString();
                uptxtprice.Text = dtt.Rows[0][2].ToString();
                uptxtdisc.Text = dtt.Rows[0][3].ToString();
                uptxtduration.Text = dtt.Rows[0][4].ToString();
                upImage1.ImageUrl = dtt.Rows[0][5].ToString();
            }
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Popup", "$(document).ready(function() { $('#UpCardModal').modal('show'); });", true);
        }

        protected void btnupimgupload_Click(object sender, EventArgs e)
        {
            try
            {
                string file = Path.GetFileName(FileUpload2.PostedFile.FileName);
                //Save images into Images folder
                FileUpload2.SaveAs(Server.MapPath("~\\Images\\" + file));
                string path = Server.MapPath("~\\Images\\" + file);
                FileUpload2.SaveAs(path + file);

                upImage1.ImageUrl = "Images\\" + file;
                upImage1.Visible = true;
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Popup", "$(document).ready(function() { $('#UpCardModal').modal('show'); });", true);
            }
            catch (Exception ex)
            {
                Page.ClientScript.RegisterStartupScript(GetType(), "msgbox", "alert('Please Select Photo !!!');", true);
            }
        }

        protected void btnupdate_Click(object sender, EventArgs e)
        {
            con.Open();
            string q = "Update FarmProducts set ProductName='" + uptxtpname.Text + "', Photo='" + upImage1.ImageUrl + "',Description='" + uptxtdisc.Text + "',Quantity='" + uptxtquantity.Text + "',Price='" + uptxtprice.Text + "', Duration='" + uptxtduration.Text + "' where Pid='" + uptxtpid.Text + "'";
            SqlCommand cmd = new SqlCommand(q, con);
            cmd.ExecuteNonQuery();
            con.Close();

            Page.ClientScript.RegisterStartupScript(GetType(), "msg", "alert('Product details updated successfully!!!')", true);
            BindDataList();
        }

        protected void lbtview_Click(object sender, EventArgs e)
        {
            LinkButton btn = (LinkButton)sender;
            string pid = btn.CommandArgument;

            string q = "Select * from FarmProducts  where Pid='" + pid + "'";
            SqlDataAdapter daa = new SqlDataAdapter(q, con);
            DataTable dtt = new DataTable();
            daa.Fill(dtt);
            if (dtt.Rows.Count > 0)
            {
                lbpid.Text = dtt.Rows[0][0].ToString();
                lbpname.Text = dtt.Rows[0][1].ToString();
                lbquantity.Text = dtt.Rows[0][7].ToString();
                lbprice.Text = dtt.Rows[0][2].ToString();
                lbdisc.Text = dtt.Rows[0][3].ToString();
                lbduration.Text = dtt.Rows[0][4].ToString();
                Image2.ImageUrl = dtt.Rows[0][5].ToString();
            }
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Popup", "$(document).ready(function() { $('#ViewCardModal').modal('show'); });", true);
        }

        protected void lbtdelete_Click(object sender, EventArgs e)
        {
            LinkButton btn = (LinkButton)sender;
            string pid = btn.CommandArgument;
            Session["Pid"] = pid;
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Popup", "$(document).ready(function() { $('#DeleteModal').modal('show'); });", true);
        }

        protected void btnDeleteConfirm_Click(object sender, EventArgs e)
        {
            string pid = Convert.ToString(Session["Pid"]);

            con.Open();
            string q = "DELETE FROM FarmProducts where Pid='" + pid + "'";
            SqlCommand cmd = new SqlCommand(q, con);
            cmd.ExecuteNonQuery();
            con.Close();

            Page.ClientScript.RegisterStartupScript(GetType(), "msg", "alert('Product details deleted successfully!!!')", true);
            BindDataList();
        }

        protected void lbtnsearch_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrWhiteSpace(txtsearch.Text))
            {
                BindDataList(); 
            }
            else
            {
                string query = "SELECT * FROM FarmProducts WHERE ProductName LIKE @ProductName";

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

        protected void lbtnAddProduce(object sender, EventArgs e)
        {
            ptxtbatchno.Text = "";
            ptxtcrop.Text = "";
            psoilDropDown.SelectedValue = "";
            pfarmingpractDropDown.SelectedValue = "";
            ptxtsdate.Text = "";
            ptxthdate.Text = "";


            LinkButton btn = (LinkButton)sender;
            string pid = btn.CommandArgument;
            Session["Pid"] = pid;
            string q = "Select * from FarmProducts  where Pid='" + pid + "'";
            SqlDataAdapter daa = new SqlDataAdapter(q, con);
            DataTable dtt = new DataTable();
            daa.Fill(dtt);
            if (dtt.Rows.Count > 0)
            {
                ptxtpid.Text = dtt.Rows[0][0].ToString();
                ptxtpname.Text = dtt.Rows[0][1].ToString();
            }
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Popup", "$(document).ready(function() { $('#ProduceCardModal').modal('show'); });", true);
        
        }

        protected void btnaddproduce_Click(object sender, EventArgs e)
        {
            string pid = Convert.ToString(Session["Pid"]);

            // Validate inputs
            if (string.IsNullOrWhiteSpace(ptxtbatchno.Text) ||
                string.IsNullOrWhiteSpace(ptxtcrop.Text) ||
                psoilDropDown.SelectedIndex == 0 ||
                pfarmingpractDropDown.SelectedIndex == 0 ||
                string.IsNullOrWhiteSpace(ptxtsdate.Text) ||
                string.IsNullOrWhiteSpace(ptxthdate.Text))
            {
                ShowErrorMessage("Please fill in all required fields.");
                return; // Stop execution if validation fails
            }

            // Proceed with database insertion if validation passes
            con.Open();
            string q = "INSERT INTO FarmProduceDetails (Pid, BatchNo, CropDetails, SoilDetails, FarmingPractice, SowingDate, HarvestDate) " +
                       "VALUES (@Pid, @BatchNo, @CropDetails, @SoilDetails, @FarmingPractice, @SowingDate, @HarvestDate)";
            using (SqlCommand cmd = new SqlCommand(q, con))
            {
                cmd.Parameters.AddWithValue("@Pid", pid);
                cmd.Parameters.AddWithValue("@BatchNo", ptxtbatchno.Text);
                cmd.Parameters.AddWithValue("@CropDetails", ptxtcrop.Text);
                cmd.Parameters.AddWithValue("@SoilDetails", psoilDropDown.SelectedValue);
                cmd.Parameters.AddWithValue("@FarmingPractice", pfarmingpractDropDown.SelectedValue);
                cmd.Parameters.AddWithValue("@SowingDate", ptxtsdate.Text);
                cmd.Parameters.AddWithValue("@HarvestDate", ptxthdate.Text);
                cmd.ExecuteNonQuery();
            }

            // Success message
            ScriptManager.RegisterStartupScript(this, this.GetType(), "msg", "alert('Product Produce Details Added Successfully!!!');", true);

            // Refresh DataList
            BindDataList();
        }

        private void ShowErrorMessage(string message)
        {
            bool hasError = false;

            if (string.IsNullOrWhiteSpace(ptxtbatchno.Text))
            {
                lblErrorMessage1.Text = "Batch Number is required.";
                lblErrorMessage1.Visible = true;
                hasError = true;
            }
            else
            {
                lblErrorMessage1.Visible = false;
            }

            if (string.IsNullOrWhiteSpace(ptxtcrop.Text))
            {
                lblErrorMessage2.Text = "Crop Details are required.";
                lblErrorMessage2.Visible = true;
                hasError = true;
            }
            else
            {
                lblErrorMessage2.Visible = false;
            }

            if (psoilDropDown.SelectedIndex == 0)
            {
                lblErrorMessage3.Text = "Please select a Soil Type.";
                lblErrorMessage3.Visible = true;
                hasError = true;
            }
            else
            {
                lblErrorMessage3.Visible = false;
            }

            if (pfarmingpractDropDown.SelectedIndex == 0)
            {
                lblErrorMessage4.Text = "Please select a Farming Practice.";
                lblErrorMessage4.Visible = true;
                hasError = true;
            }
            else
            {
                lblErrorMessage4.Visible = false;
            }

            if (string.IsNullOrWhiteSpace(ptxtsdate.Text))
            {
                lblErrorMessage5.Text = "Sowing Date is required.";
                lblErrorMessage5.Visible = true;
                hasError = true;
            }
            else
            {
                lblErrorMessage5.Visible = false;
            }

            if (string.IsNullOrWhiteSpace(ptxthdate.Text))
            {
                lblErrorMessage6.Text = "Harvest Date is required.";
                lblErrorMessage6.Visible = true;
                hasError = true;
            }
            else
            {
                lblErrorMessage6.Visible = false;
            }

            // Keep modal open if there are errors
            if (hasError)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Popup", "$(document).ready(function() { $('#ProduceCardModal').modal('show'); });", true);
            }
        }


        protected void lbtnViewProduce(object sender, EventArgs e)
        {
            LinkButton btn = (LinkButton)sender;
            string pid = btn.CommandArgument;
            Session["Pid"] = pid;
            Response.Redirect("FarmProduceDetails.aspx");
        }

        
    }
}