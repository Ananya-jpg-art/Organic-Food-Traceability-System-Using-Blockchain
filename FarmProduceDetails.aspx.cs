using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Organic_food
{
    public partial class FarmProduceDetails : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["conOrganicFood"].ConnectionString);
        protected void Page_Load(object sender, EventArgs e)
        {
            //Session["Login"] = "Farmer";
            if (!IsPostBack)
            {
                BindGridView();
                if (Session["userType"] == null)
                {
                    Response.Redirect("Login.aspx");
                }
            }
        }

        protected void lbtnsearch_Click(object sender, EventArgs e)
        {
            BindGridView(txtSearch.Text.Trim());
        }

        private void BindGridView(string searchQuery = "")
        {
            string pid = Session["Pid"].ToString();

            string query = @"SELECT FPD.ProId, FP.ProductName, FPD.BatchNo, FPD.CropDetails, 
                        FPD.SoilDetails, FPD.FarmingPractice, FPD.SowingDate, FPD.HarvestDate 
                     FROM [FarmProduceDetails] FPD
                     JOIN [FarmProducts] FP ON FPD.Pid = FP.Pid WHERE FPD.Pid = '" + pid + "'";

            
            if (!string.IsNullOrEmpty(searchQuery))
            {
                query += " WHERE FPD.ProId LIKE @SearchQuery";
            }

            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                if (!string.IsNullOrEmpty(searchQuery))
                {
                    cmd.Parameters.AddWithValue("@SearchQuery", "%" + searchQuery + "%");
                }

                using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();
                    sda.Fill(dt);
                    gvFarmProduce.DataSource = dt;
                    gvFarmProduce.DataBind();

                    if (dt.Rows.Count == 0)
                    {
                        lbNoData.Visible = true;
                    }
                }
            }
        }


        [System.Web.Services.WebMethod]
        public static string UpdateFarmProduce(int ProId, string CropDetails, string SoilDetails, string FarmingPractice, string SowingDate, string HarvestDate)
        {
            string query = "UPDATE FarmProduceDetails SET CropDetails=@CropDetails, SoilDetails=@SoilDetails, FarmingPractice=@FarmingPractice, SowingDate=@SowingDate, HarvestDate=@HarvestDate WHERE ProId=@ProId";

            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["conOrganicFood"].ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@ProId", ProId);
                    cmd.Parameters.AddWithValue("@CropDetails", CropDetails);
                    cmd.Parameters.AddWithValue("@SoilDetails", SoilDetails);
                    cmd.Parameters.AddWithValue("@FarmingPractice", FarmingPractice);
                    cmd.Parameters.AddWithValue("@SowingDate", SowingDate);
                    cmd.Parameters.AddWithValue("@HarvestDate", HarvestDate);

                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();

                }
            }
            return "Product details updated successfully!";
        }

        protected void gvFarmProduce_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int proId = Convert.ToInt32(gvFarmProduce.DataKeys[e.RowIndex].Value);
            DeleteRecord(proId);
            BindGridView();
        }

        private void DeleteRecord(int proId)
        {
            string query = "DELETE FROM FarmProduceDetails WHERE ProId = @ProId";
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.AddWithValue("@ProId", proId);

                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();
            }
        }
    }
}