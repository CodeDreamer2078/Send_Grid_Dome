using System;
using System.Web;

namespace SendGridEmailDemo
{
    public class Global : HttpApplication
    {
        protected void Application_Start(object sender, EventArgs e)
        {
        }

        protected void Application_Error(object sender, EventArgs e)
        {
            Exception exception = Server.GetLastError();

            // In production, replace with a proper logging framework (Serilog, NLog, etc.)
            System.Diagnostics.Debug.WriteLine(
                $"[{DateTime.UtcNow:O}] Unhandled exception: {exception?.Message}");
        }
    }
}
