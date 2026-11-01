using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace Organic_food
{
    public partial class TrackOrder : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["conOrganicFood"].ConnectionString);

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["userType"] == null)
                {
                    Response.Redirect("Login.aspx");
                }

                BindData();

                //string userType = Session["userType"].ToString();
                //lblUserType.Text = userType;

                LoadTrackingDates();
            }
        }

        protected void BindData()
        {
            string oid = Session["Oid"].ToString();
            string userType = Session["userType"].ToString();
            string id = Session["userId"].ToString();

            txtoid.Text = oid;
            hfFromId.Value = id;
            hfFromType.Value = userType;

            string query1 = "select Pid, ProductName, Quantity, Price, ToId, ToType, Date, Time, OidLink from Orders where Oid = '" + oid + "'";
            SqlDataAdapter daa1 = new SqlDataAdapter(query1, con);
            DataTable dtt1 = new DataTable();
            daa1.Fill(dtt1);
            if (dtt1.Rows.Count > 0)
            {
                lbpid.Text = dtt1.Rows[0][0].ToString();
                lbpname.Text = dtt1.Rows[0][1].ToString();
                lbquantity.Text = dtt1.Rows[0][2].ToString();
                lbprice.Text = dtt1.Rows[0][3].ToString();
                hfToId.Value = dtt1.Rows[0][4].ToString();
                hfToType.Value = dtt1.Rows[0][5].ToString();
                hfDate.Value = dtt1.Rows[0][6].ToString();
                hfTime.Value = dtt1.Rows[0][7].ToString();
                hfOidlink.Value = dtt1.Rows[0][8].ToString();
            }

            string rc_ToId = hfToId.Value;
            Session["RC_ToId"] = rc_ToId;

            string rc_ToType = hfToType.Value;
            Session["RC_ToType"] = rc_ToType;

            string rc_Date = hfDate.Value;
            Session["RC_Date"] = rc_Date;

            string rc_Time = hfTime.Value;
            Session["RC_Time"] = rc_Time;

            string rc_Oidlink = hfOidlink.Value;
            Session["RC_Oidlink"] = rc_Oidlink;

            //show other product data from ManProductTable
            string query2 = "select mDuration, mDescription, mPhoto from ManProducts where mPid = '" + lbpid.Text + "'";
            SqlDataAdapter daa2 = new SqlDataAdapter(query2, con);
            DataTable dtt2 = new DataTable();
            daa2.Fill(dtt2);
            if (dtt2.Rows.Count > 0)
            {
                lbduration.Text = dtt2.Rows[0][0].ToString();
                lbdisc.Text = dtt2.Rows[0][1].ToString();
                oImage2.ImageUrl = dtt2.Rows[0][2].ToString();
            }

            string query3 = "select OidLink from Orders where Oid = '" + hfOidlink.Value + "'";
            SqlDataAdapter daa3 = new SqlDataAdapter(query3, con);
            DataTable dtt3 = new DataTable();
            daa3.Fill(dtt3);
            if (dtt3.Rows.Count > 0)
            {
                lbproid.Text = dtt3.Rows[0][0].ToString();
            }

            string query4 = "select BatchNo, CropDetails, SoilDetails, FarmingPractice, SowingDate, HarvestDate from FarmProduceDetails where ProId = '" + lbproid.Text + "'";
            SqlDataAdapter daa4 = new SqlDataAdapter(query4, con);
            DataTable dtt4 = new DataTable();
            daa4.Fill(dtt4);
            if (dtt4.Rows.Count > 0)
            {
                lbbatchno.Text = dtt4.Rows[0][0].ToString();
                lbcrop.Text = dtt4.Rows[0][1].ToString();
                lbsoil.Text = dtt4.Rows[0][2].ToString();
                lbfarmpract.Text = dtt4.Rows[0][3].ToString();
                lbsdate.Text = dtt4.Rows[0][4].ToString();
                lbhdate.Text = dtt4.Rows[0][5].ToString();
            }
        }

        protected void oidsearch_Click(object sender, EventArgs e)
        {
            string oid = txtoid.Text;
            string userType = Session["userType"].ToString();
            string id = Session["userId"].ToString();

            hfFromId.Value = id;
            hfFromType.Value = userType;

            string query1 = "select Pid, ProductName, Quantity, Price, ToId, ToType, Date, Time, OidLink from Orders where Oid = '" + oid + "'";
            SqlDataAdapter daa1 = new SqlDataAdapter(query1, con);
            DataTable dtt1 = new DataTable();
            daa1.Fill(dtt1);
            if (dtt1.Rows.Count > 0)
            {
                lbpid.Text = dtt1.Rows[0][0].ToString();
                lbpname.Text = dtt1.Rows[0][1].ToString();
                lbquantity.Text = dtt1.Rows[0][2].ToString();
                lbprice.Text = dtt1.Rows[0][3].ToString();
                hfToId.Value = dtt1.Rows[0][4].ToString();
                hfToType.Value = dtt1.Rows[0][5].ToString();
                hfDate.Value = dtt1.Rows[0][6].ToString();
                hfTime.Value = dtt1.Rows[0][7].ToString();
                hfOidlink.Value = dtt1.Rows[0][8].ToString();
            }

            string rc_ToId = hfToId.Value;
            Session["RC_ToId"] = rc_ToId;

            string rc_ToType = hfToType.Value;
            Session["RC_ToType"] = rc_ToType;

            string rc_Date = hfDate.Value;
            Session["RC_Date"] = rc_Date;

            string rc_Time = hfTime.Value;
            Session["RC_Time"] = rc_Time;

            string rc_Oidlink = hfOidlink.Value;
            Session["RC_Oidlink"] = rc_Oidlink;

            //show other product data from ManProductTable
            string query2 = "select mDuration, mDescription, mPhoto from ManProducts where mPid = '" + lbpid.Text + "'";
            SqlDataAdapter daa2 = new SqlDataAdapter(query2, con);
            DataTable dtt2 = new DataTable();
            daa2.Fill(dtt2);
            if (dtt2.Rows.Count > 0)
            {
                lbduration.Text = dtt2.Rows[0][0].ToString();
                lbdisc.Text = dtt2.Rows[0][1].ToString();
                oImage2.ImageUrl = dtt2.Rows[0][2].ToString();
            }

            string query3 = "select OidLink from Orders where Oid = '" + hfOidlink.Value + "'";
            SqlDataAdapter daa3 = new SqlDataAdapter(query3, con);
            DataTable dtt3 = new DataTable();
            daa3.Fill(dtt3);
            if (dtt3.Rows.Count > 0)
            {
                lbproid.Text = dtt3.Rows[0][0].ToString();
            }

            string query4 = "select BatchNo, CropDetails, SoilDetails, FarmingPractice, SowingDate, HarvestDate from FarmProduceDetails where ProId = '" + lbproid.Text + "'";
            SqlDataAdapter daa4 = new SqlDataAdapter(query4, con);
            DataTable dtt4 = new DataTable();
            daa4.Fill(dtt4);
            if (dtt4.Rows.Count > 0)
            {
                lbbatchno.Text = dtt4.Rows[0][0].ToString();
                lbcrop.Text = dtt4.Rows[0][1].ToString();
                lbsoil.Text = dtt4.Rows[0][2].ToString();
                lbfarmpract.Text = dtt4.Rows[0][3].ToString();
                lbsdate.Text = dtt4.Rows[0][4].ToString();
                lbhdate.Text = dtt4.Rows[0][5].ToString();
            }

            LoadTrackingDates();
        }

        private void LoadTrackingDates()
        {
            string oid = Session["Oid"].ToString();
            string userType = Session["userType"].ToString();
            string id = Session["userId"].ToString();

            string rctoid = Session["RC_ToId"].ToString();
            string rctotype = Session["RC_ToType"].ToString();
            string rcdate = Session["RC_Date"].ToString();
            string rctime = Session["RC_Time"].ToString();
            string rcoidlink = Session["RC_Oidlink"].ToString();

            //Retailer OR Customer - Date,Time,CompanyName 
            string q1 = "select company_Name from Register where ID = '" + id + "'";
            SqlDataAdapter daa1 = new SqlDataAdapter(q1, con);
            DataTable dtt1 = new DataTable();
            daa1.Fill(dtt1);
            if (dtt1.Rows.Count > 0)
            {
                lblRCType.Text = dtt1.Rows[0][0].ToString();
            }

            lblRCTypeDate.Text = rcdate;
            lblRCTypeTime.Text = rctime;

            //Distributor - Date,Time,CompanyName 
            string qd1 = "select ToType, Date, Time, ToId from Orders where OidLink = '" + rcoidlink + "' and FromId = '" + rctoid + "'";
            SqlDataAdapter daad1 = new SqlDataAdapter(qd1, con);
            DataTable dttd1 = new DataTable();
            daad1.Fill(dttd1);
            if (dttd1.Rows.Count > 0)
            {
                hfDistType.Value = dttd1.Rows[0][0].ToString();
                lblDistDate.Text = dttd1.Rows[0][1].ToString();
                lblDistTime.Text = dttd1.Rows[0][2].ToString();
                hfDistToId.Value = dttd1.Rows[0][3].ToString();
            }

            string qd2 = "select company_Name from Register where ID = '" + rctoid + "'";
            SqlDataAdapter daad2 = new SqlDataAdapter(qd2, con);
            DataTable dttd2 = new DataTable();
            daad2.Fill(dttd2);
            if (dttd2.Rows.Count > 0)
            {
                lblDistCompany.Text = dttd2.Rows[0][0].ToString();
            }

            //Manufacturer - Date,Time,CompanyName 
            string qm1 = "select ToType, Date, Time, ToId, OidLink from Orders where Oid = '" + rcoidlink + "' and FromId = '" + hfDistToId.Value + "'";
            SqlDataAdapter daam1 = new SqlDataAdapter(qm1, con);
            DataTable dttm1 = new DataTable();
            daam1.Fill(dttm1);
            if (dttm1.Rows.Count > 0)
            {
                hfManType.Value = dttm1.Rows[0][0].ToString();
                lblManDate.Text = dttm1.Rows[0][1].ToString();
                lblManTime.Text = dttm1.Rows[0][2].ToString();
                hfManToId.Value = dttm1.Rows[0][3].ToString();
                hfManOidlink.Value = dttm1.Rows[0][4].ToString();
            }

            string qm2 = "select company_Name from Register where ID = '" + hfDistToId.Value + "'";
            SqlDataAdapter daam2 = new SqlDataAdapter(qm2, con);
            DataTable dttm2 = new DataTable();
            daam2.Fill(dttm2);
            if (dttm2.Rows.Count > 0)
            {
                lblManCompany.Text = dttm2.Rows[0][0].ToString();
            }

            //Farmer - Harvest-Date,CompanyName 
            string qf1 = "select HarvestDate from FarmProduceDetails where ProId = '" + hfManOidlink.Value + "'";
            SqlDataAdapter daaf1 = new SqlDataAdapter(qf1, con);
            DataTable dttf1 = new DataTable();
            daaf1.Fill(dttf1);
            if (dttf1.Rows.Count > 0)
            {
                lblFarmDate.Text = dttf1.Rows[0][0].ToString();
            }

            string qf2 = "select company_Name from Register where ID = '" + hfManToId.Value + "'";
            SqlDataAdapter daaf2 = new SqlDataAdapter(qf2, con);
            DataTable dttf2 = new DataTable();
            daaf2.Fill(dttf2);
            if (dttf2.Rows.Count > 0)
            {
                lblFarmCompany.Text = dttf2.Rows[0][0].ToString();
            }

        }

    }
}