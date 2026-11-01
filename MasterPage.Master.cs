using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Organic_food
{
    public partial class MasterPage : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (System.Web.HttpContext.Current.Session["Login"] != null)
            {
                string userType = Session["userType"]?.ToString();

                if (userType == "Farmer")
                {
                    farmerNav.Visible = true;
                    ManufactureNav.Visible = false;
                    DistributorNav.Visible = false;
                    RetailerCustomerNav.Visible = false;
                    navhome.Visible = false;
                }
                else if (userType == "Manufacturer")
                {
                    farmerNav.Visible = false;
                    ManufactureNav.Visible = true;
                    DistributorNav.Visible = false;
                    RetailerCustomerNav.Visible = false;
                    navhome.Visible = false;
                }
                else if (userType == "Distributor")
                {
                    farmerNav.Visible = false;
                    ManufactureNav.Visible = false;
                    DistributorNav.Visible = true;
                    RetailerCustomerNav.Visible = false;
                    navhome.Visible = false;
                }
                else if (userType == "Retailer" || userType == "Customer")
                {
                    farmerNav.Visible = false;
                    ManufactureNav.Visible = false;
                    DistributorNav.Visible = false;
                    RetailerCustomerNav.Visible = true;
                    navhome.Visible = false;
                }
                else
                {
                    farmerNav.Visible = false;
                    ManufactureNav.Visible = false;
                    DistributorNav.Visible = false;
                    RetailerCustomerNav.Visible = false;
                    navhome.Visible = true;
                }




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
            
        }

    }
}