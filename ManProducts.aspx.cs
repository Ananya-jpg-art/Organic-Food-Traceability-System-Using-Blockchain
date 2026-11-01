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
    public partial class ManProducts : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["conOrganicFood"].ConnectionString);

        protected void Page_Load(object sender, EventArgs e)
        {
            //Session["Login"] = "Manufacturer";
            //Session["Login"] = "Distributor";
            //Session["Login"] = "Retailer";
            //Session["Login"] = "Customer";
            if (!IsPostBack)
            {
                if (Session["userType"] == null)
                {
                    Response.Redirect("Login.aspx");
                }
                BindDataList();
            }
        }

        private void BindDataList()
        {
            string id = Session["userId"].ToString();

            string query = "Select * from ManProducts where userId = '" + id + "'";

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
            string q = "Insert into ManProducts(mProductName,Quantity,mPrice,mDescription,mDuration,mPhoto,userId) values('" + txtpname.Text + "','" + txtquantity.Text + "','" + txtprice.Text + "','" + txtdisc.Text + "','" + txtduration.Text + "','" + Image1.ImageUrl + "','" + id + "')";
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
            string manpid = btn.CommandArgument;

            string q = "Select * from ManProducts  where mPid='" + manpid + "'";
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
            string q = "Update ManProducts set mProductName='" + uptxtpname.Text + "', mPhoto='" + upImage1.ImageUrl + "',mDescription='" + uptxtdisc.Text + "',Quantity='" + uptxtquantity.Text + "',mPrice='" + uptxtprice.Text + "', mDuration='" + uptxtduration.Text + "' where mPid='" + uptxtpid.Text + "'";
            SqlCommand cmd = new SqlCommand(q, con);
            cmd.ExecuteNonQuery();
            con.Close();

            Page.ClientScript.RegisterStartupScript(GetType(), "msg", "alert('Product details updated successfully!!!')", true);
            BindDataList();
        }

        protected void lbtview_Click(object sender, EventArgs e)
        {
            LinkButton btn = (LinkButton)sender;
            string manpid = btn.CommandArgument;

            string q = "Select * from ManProducts where mPid='" + manpid + "'";
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
            string manpid = btn.CommandArgument;
            Session["mPid"] = manpid;
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Popup", "$(document).ready(function() { $('#DeleteModal').modal('show'); });", true);
        }

        protected void btnDeleteConfirm_Click(object sender, EventArgs e)
        {
            string manpid = Convert.ToString(Session["mPid"]);

            con.Open();
            string q = "DELETE FROM ManProducts where mPid='" + manpid + "'";
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

    }
}