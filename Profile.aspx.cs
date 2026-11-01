using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace Organic_food
{
    public partial class Profile : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["conOrganicFood"].ConnectionString);

        protected void Page_Load(object sender, EventArgs e)
        {           
            if (!IsPostBack)
            {
                //if (Session["userType"] == null)
                //{
                //    Response.Redirect("Login.aspx");
                //}

                if (Session["userId"] != null && Session["userType"] != null)
                {
                    LoadUserProfile(Session["userId"].ToString());
                    SetUserType(Session["userType"].ToString());
                }
                else
                {
                    Response.Redirect("Login.aspx"); // Redirect to login if session is missing
                }
            }
        }

        private void LoadUserProfile(string userId)
        {
            try
            {
                con.Open();
                string query = "SELECT * FROM Register WHERE ID = @ID";
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@ID", userId);
                    SqlDataReader dr = cmd.ExecuteReader();

                    if (dr.Read())
                    {
                        TextBox1.Text = dr["ID"].ToString();
                        TextBox2.Text = dr["company_Name"].ToString();
                        TextBox3.Text = dr["Address"].ToString();
                        TextBox4.Text = dr["Email"].ToString();
                        TextBox5.Text = dr["Contact"].ToString();
                    }
                }
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error loading profile: " + ex.Message + "');</script>");
            }
            finally
            {
                con.Close();
            }

            SetReadOnlyMode(true);
        }

        protected void ButtonEdit_Click(object sender, EventArgs e)
        {
            
            if (ButtonEdit.Text == "Edit")
            {
                SetReadOnlyMode(false);
                ButtonEdit.Text = "Update";
            }
            else
            {
                UpdateUserProfile();
            }
        }

        private void UpdateUserProfile()
        {
            if (!Page.IsValid)
            {
                return; // Stop execution if validation fails
            }

            try
            {
                con.Open();
                string query = "UPDATE Register SET company_Name = @CompanyName, Address = @Address, Email = @Email, Contact = @Contact WHERE ID = @ID";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@CompanyName", TextBox2.Text);
                    cmd.Parameters.AddWithValue("@Address", TextBox3.Text);
                    cmd.Parameters.AddWithValue("@Email", TextBox4.Text);
                    cmd.Parameters.AddWithValue("@Contact", TextBox5.Text);
                    cmd.Parameters.AddWithValue("@ID", TextBox1.Text); // Use ID for updating

                    int rowsAffected = cmd.ExecuteNonQuery();
                    if (rowsAffected > 0)
                    {
                        Response.Write("<script>alert('Profile updated successfully!');</script>");
                    }
                    else
                    {
                        Response.Write("<script>alert('Error updating profile.');</script>");
                    }
                }
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error: " + ex.Message + "');</script>");
            }
            finally
            {
                con.Close();
            }

            SetReadOnlyMode(true);
            ButtonEdit.Text = "Edit";
        }


        private void SetUserType(string userType)
        {
            switch (userType.ToLower()) // Ensure case-insensitive comparison
            {
                case "farmer":
                    ProfileImage.ImageUrl = "Images/farmer.png";
                    ProfileTitle.Text = "Farmer";
                    break;
                case "distributor":
                    ProfileImage.ImageUrl = "Images/distributor.png";
                    ProfileTitle.Text = "Distributor";
                    break;
                case "manufacturer":
                    ProfileImage.ImageUrl = "Images/manufacturer.png";
                    ProfileTitle.Text = "Manufacturer"; 
                    break;
                case "retailer":
                    ProfileImage.ImageUrl = "Images/retailer.png";
                    ProfileTitle.Text = "Retailer";
                    break;
                case "customer":
                    ProfileImage.ImageUrl = "Images/customer.png";
                    ProfileTitle.Text = "Customer";
                    break;
                default:
                    ProfileImage.ImageUrl = "Images/default.png"; // Default image
                    ProfileTitle.Text = "User";
                    break;
            }
        }

        private void SetReadOnlyMode(bool isReadOnly)
        {
            TextBox2.ReadOnly = isReadOnly;
            TextBox3.ReadOnly = isReadOnly;
            TextBox4.ReadOnly = isReadOnly;
            TextBox5.ReadOnly = isReadOnly;
        }

    }
}