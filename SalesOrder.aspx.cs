﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Prac4_Exercise2
{
    public partial class SalesOrder : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            lblTitleGridView.Text = "Sales Order by " + ddlStaff.SelectedItem.Text
                + "in the year of " + rblYear.SelectedItem.Text+ ". Grand Total Sales: "
                ;
        }
    }
}