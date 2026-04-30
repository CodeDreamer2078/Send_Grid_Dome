using System;
using System.Web.UI;

namespace SendGridEmailDemo
{
    public partial class SiteMaster : MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        /// <summary>
        /// Returns "active" if the current page matches the given file name,
        /// enabling automatic menu highlighting in the navbar.
        /// </summary>
        public string GetActiveClass(string pageName)
        {
            string currentPage = System.IO.Path.GetFileName(Request.Path);

            if (string.Equals(currentPage, pageName, StringComparison.OrdinalIgnoreCase))
            {
                return "active";
            }

            return string.Empty;
        }
    }
}
