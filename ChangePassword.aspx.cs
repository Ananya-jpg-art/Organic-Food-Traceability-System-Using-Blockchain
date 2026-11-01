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
    public partial class Change_Password : System.Web.UI.Page
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
            }
        }

        
        protected void ButtonChangePassword_Click(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(TextBoxNewPassword.Text) && TextBoxNewPassword.Text == TextBoxConfirmPassword.Text)
            {
                string newPassword = TextBoxNewPassword.Text;

                string connectionString = ConfigurationManager.ConnectionStrings["conOrganicFood"].ConnectionString;
                using (SqlConnection con = new SqlConnection(connectionString))
                {
                    string query = string.Empty;
                    SqlCommand cmd = new SqlCommand();
                    cmd.Connection = con;

                    if (Session["userId"] != null)
                    {
                        string uId = Session["userId"].ToString();
                        query = "UPDATE Register SET Password = @NewPassword, ConfPass = @NewPassword WHERE ID = @Id";
                        cmd.Parameters.AddWithValue("@Id", uId);
                    }

                    //string uId = Session["userId"].ToString();
                    //query = "UPDATE Register SET Password = @NewPassword, ConfPass = @NewPassword WHERE ID = @Id";
                    //cmd.Parameters.AddWithValue("@Id", uId);

                    if (!string.IsNullOrEmpty(query))
                    {
                        cmd.CommandText = query;
                        cmd.Parameters.AddWithValue("@NewPassword", newPassword);

                        con.Open();
                        int rowsAffected = cmd.ExecuteNonQuery();
                        con.Close();

                        if (rowsAffected > 0)
                        {
                            Page.ClientScript.RegisterStartupScript(GetType(), "msg", "alert('Password changed successfully.')", true);
                        }
                        else
                        {
                            Page.ClientScript.RegisterStartupScript(GetType(), "msg", "alert('Password change failed. Please try again.')", true);
                        }
                    }
                }
            }
            else
            {
                Page.ClientScript.RegisterStartupScript(GetType(), "msg", "alert('Passwords do not match. Please try again.')", true);
            }
        }

    }
}