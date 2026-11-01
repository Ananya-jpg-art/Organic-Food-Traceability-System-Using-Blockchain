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
    public partial class Login : System.Web.UI.Page
    {

        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["conOrganicFood"].ConnectionString);

        protected void Page_Load(object sender, EventArgs e)
        {
            ScriptManager.ScriptResourceMapping.AddDefinition(
                "jquery",
                new ScriptResourceDefinition
                {
                    Path = "~/Scripts/jquery-3.7.1.min.js", // Path to your jQuery file
                    DebugPath = "~/Scripts/jquery-3.7.1.js", // Path to your jQuery debug file
                    CdnPath = "https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js",
                    CdnDebugPath = "https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.js"
                }
            );
        }

        protected void User_login(object sender, EventArgs e)
        {
            if (!Page.IsValid)
            {
                return; // Stop execution if validation fails
            }

            con.Open();
            string email = txtid.Text;
            string password = txtpass.Text;

            string query = "SELECT ID, userType, Email FROM Register WHERE Email = @Email AND Password = @Password";
            SqlCommand cmd = new SqlCommand(query, con);
            cmd.Parameters.AddWithValue("@Email", email);
            cmd.Parameters.AddWithValue("@Password", password);

            SqlDataReader reader = cmd.ExecuteReader();

            if (reader.Read()) 
            {
                string uId = reader["ID"].ToString(); 
                string uType = reader["userType"].ToString(); 

                Session["Login"] = "Yes";
                Session["Email"] = email;
                Session["userId"] = uId;
                Session["Password"] = password;
                Session["userType"] = uType; 

                reader.Close();
                con.Close();

                Response.Redirect("Profile.aspx");
            }
            else
            {
                reader.Close();
                con.Close();
                Page.ClientScript.RegisterStartupScript(GetType(), "msg", "alert('Invalid Login Data!!!')", true);
            }
        }

    }
}