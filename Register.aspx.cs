using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.Sql;
using System.Data.SqlClient;
using System.Configuration;
using System.IO;
using System;

namespace Organic_food
{
    public partial class Register : System.Web.UI.Page
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

        protected void btn_Regclick(object sender, EventArgs e)
        {
            if (!Page.IsValid)
            {
                return; // Stop execution if validation fails
            }

            con.Open();

            // Check if the company name already exists
            string checkCompanyQuery = "SELECT COUNT(*) FROM Register WHERE company_Name = @company_Name";
            using (SqlCommand checkCmd = new SqlCommand(checkCompanyQuery, con))
            {
                checkCmd.Parameters.AddWithValue("@company_Name", txt_compName.Text);
                int companyExists = (int)checkCmd.ExecuteScalar();

                if (companyExists > 0)
                {
                    Page.ClientScript.RegisterStartupScript(GetType(), "msg", "alert('This company name is already registered!')", true);
                    con.Close();
                    return;
                }
            }

            // Check if the email already exists
            string checkEmailQuery = "SELECT COUNT(*) FROM Register WHERE Email = @Email";
            using (SqlCommand checkCmd = new SqlCommand(checkEmailQuery, con))
            {
                checkCmd.Parameters.AddWithValue("@Email", txt_email.Text);
                int emailExists = (int)checkCmd.ExecuteScalar();

                if (emailExists > 0)
                {
                    Page.ClientScript.RegisterStartupScript(GetType(), "msg", "alert('This email is already registered!')", true);
                    con.Close();
                    return;
                }
            }

            // Check if the password already exists
            string checkPasswordQuery = "SELECT COUNT(*) FROM Register WHERE Password = @Password";
            using (SqlCommand checkCmd = new SqlCommand(checkPasswordQuery, con))
            {
                checkCmd.Parameters.AddWithValue("@Password", txt_pass.Text);
                int passwordExists = (int)checkCmd.ExecuteScalar();

                if (passwordExists > 0)
                {
                    Page.ClientScript.RegisterStartupScript(GetType(), "msg", "alert('This password is already in use! Please choose a different one.')", true);
                    con.Close();
                    return;
                }
            }

            string query = "INSERT INTO Register (Password, userType, company_Name, Address, Email, Contact, ConfPass) " +
                           "VALUES (@Password, @userType, @company_Name, @Address, @Email, @Contact, @ConfPass)";
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.AddWithValue("@Password", txt_pass.Text);
                cmd.Parameters.AddWithValue("@userType", utypeDropDown.SelectedValue);
                cmd.Parameters.AddWithValue("@company_Name", txt_compName.Text);
                cmd.Parameters.AddWithValue("@Address", txt_address.Text);
                cmd.Parameters.AddWithValue("@Email", txt_email.Text);
                cmd.Parameters.AddWithValue("@Contact", txt_contact.Text);
                cmd.Parameters.AddWithValue("@ConfPass", txt_cpass.Text);

                cmd.ExecuteNonQuery();
            }

            con.Close();

            Page.ClientScript.RegisterStartupScript(GetType(), "msg", "alert('You are successfully registered!!')", true);

            ClearFields();
        }

        private void ClearFields()
        {
            txt_pass.Text = string.Empty;
            utypeDropDown.SelectedIndex = 0;
            txt_compName.Text = string.Empty;
            txt_address.Text = string.Empty;
            txt_email.Text = string.Empty;
            txt_contact.Text = string.Empty;
            txt_cpass.Text = string.Empty;

        }
    }
}