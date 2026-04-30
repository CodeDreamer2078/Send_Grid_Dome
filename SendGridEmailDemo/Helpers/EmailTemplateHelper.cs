using System;

namespace SendGridEmailDemo.Helpers
{
    /// <summary>
    /// Generates professional HTML email templates.
    /// Templates use table-based layouts and inline CSS for maximum email-client compatibility.
    /// </summary>
    public static class EmailTemplateHelper
    {
        private const string DefaultSubject = "Welcome to Our Platform!";

        public static string GetDefaultSubject()
        {
            return DefaultSubject;
        }

        /// <summary>
        /// Returns a complete, production-ready HTML email template.
        /// Uses the app's indigo/purple brand palette with inline CSS.
        /// </summary>
        public static string GetHtmlTemplate(string fromName)
        {
            if (string.IsNullOrWhiteSpace(fromName))
            {
                fromName = "Our Team";
            }

            string year = DateTime.Now.Year.ToString();

            return $@"<!DOCTYPE html>
<html lang=""en"">
<head>
<meta charset=""utf-8"">
<meta name=""viewport"" content=""width=device-width, initial-scale=1.0"">
<title>Welcome</title>
</head>
<body style=""margin:0;padding:0;background-color:#F1F5F9;font-family:'Segoe UI',Arial,Helvetica,sans-serif;-webkit-font-smoothing:antialiased;"">

<table role=""presentation"" width=""100%"" cellpadding=""0"" cellspacing=""0"" border=""0"" style=""background-color:#F1F5F9;"">
<tr><td align=""center"" style=""padding:40px 16px;"">

    <table role=""presentation"" width=""600"" cellpadding=""0"" cellspacing=""0"" border=""0""
           style=""background:#FFFFFF;border-radius:16px;overflow:hidden;box-shadow:0 4px 24px rgba(0,0,0,0.06);max-width:600px;width:100%;"">

        <!-- ===== HEADER ===== -->
        <tr>
            <td style=""background:linear-gradient(135deg,#4F46E5 0%,#7C3AED 100%);padding:48px 40px 40px;text-align:center;"">
                <table role=""presentation"" cellpadding=""0"" cellspacing=""0"" border=""0"" style=""margin:0 auto 20px;"">
                <tr><td style=""width:64px;height:64px;background:rgba(255,255,255,0.18);border-radius:50%;text-align:center;vertical-align:middle;font-size:28px;line-height:64px;"">
                    &#9993;
                </td></tr>
                </table>
                <h1 style=""color:#FFFFFF;margin:0 0 8px;font-size:28px;font-weight:700;letter-spacing:-0.5px;"">
                    Welcome Aboard!
                </h1>
                <p style=""color:rgba(255,255,255,0.75);margin:0;font-size:16px;font-weight:400;"">
                    We're thrilled to have you join us
                </p>
            </td>
        </tr>

        <!-- ===== BODY ===== -->
        <tr>
            <td style=""padding:40px;"">
                <p style=""color:#1E293B;font-size:17px;line-height:1.6;margin:0 0 8px;font-weight:600;"">
                    Hi there,
                </p>
                <p style=""color:#475569;font-size:15px;line-height:1.7;margin:0 0 28px;"">
                    Thank you for signing up! Your account has been successfully created
                    and you're all set to explore everything our platform has to offer.
                    Here's a quick overview of what you can do:
                </p>

                <!-- Feature blocks -->
                <table role=""presentation"" width=""100%"" cellpadding=""0"" cellspacing=""0"" border=""0"" style=""margin:0 0 30px;"">
                <tr>
                    <td width=""33%"" valign=""top"" style=""padding:0 6px 0 0;"">
                        <table role=""presentation"" width=""100%"" cellpadding=""0"" cellspacing=""0"" border=""0"">
                        <tr><td style=""background:#EEF2FF;border-radius:12px;padding:20px 12px;text-align:center;"">
                            <div style=""font-size:26px;margin-bottom:10px;"">&#128640;</div>
                            <p style=""color:#4F46E5;font-size:13px;font-weight:700;margin:0 0 4px;"">Quick Setup</p>
                            <p style=""color:#64748B;font-size:11px;margin:0;line-height:1.4;"">Get started in minutes</p>
                        </td></tr>
                        </table>
                    </td>
                    <td width=""33%"" valign=""top"" style=""padding:0 3px;"">
                        <table role=""presentation"" width=""100%"" cellpadding=""0"" cellspacing=""0"" border=""0"">
                        <tr><td style=""background:#ECFDF5;border-radius:12px;padding:20px 12px;text-align:center;"">
                            <div style=""font-size:26px;margin-bottom:10px;"">&#128274;</div>
                            <p style=""color:#059669;font-size:13px;font-weight:700;margin:0 0 4px;"">Secure</p>
                            <p style=""color:#64748B;font-size:11px;margin:0;line-height:1.4;"">Enterprise-grade security</p>
                        </td></tr>
                        </table>
                    </td>
                    <td width=""33%"" valign=""top"" style=""padding:0 0 0 6px;"">
                        <table role=""presentation"" width=""100%"" cellpadding=""0"" cellspacing=""0"" border=""0"">
                        <tr><td style=""background:#FFF7ED;border-radius:12px;padding:20px 12px;text-align:center;"">
                            <div style=""font-size:26px;margin-bottom:10px;"">&#128172;</div>
                            <p style=""color:#C2410C;font-size:13px;font-weight:700;margin:0 0 4px;"">24/7 Support</p>
                            <p style=""color:#64748B;font-size:11px;margin:0;line-height:1.4;"">We're always here to help</p>
                        </td></tr>
                        </table>
                    </td>
                </tr>
                </table>

                <p style=""color:#475569;font-size:15px;line-height:1.7;margin:0 0 32px;"">
                    Click the button below to access your dashboard and start exploring.
                    If you have any questions, our support team is always happy to help.
                </p>

                <!-- CTA Button -->
                <table role=""presentation"" width=""100%"" cellpadding=""0"" cellspacing=""0"" border=""0"">
                <tr><td align=""center"" style=""padding:0 0 10px;"">
                    <a href=""https://example.com/dashboard"" target=""_blank""
                       style=""display:inline-block;background:linear-gradient(135deg,#4F46E5 0%,#7C3AED 100%);color:#FFFFFF;padding:14px 40px;text-decoration:none;border-radius:8px;font-weight:600;font-size:16px;letter-spacing:0.3px;"">
                        Get Started &#8594;
                    </a>
                </td></tr>
                </table>
            </td>
        </tr>

        <!-- ===== DIVIDER ===== -->
        <tr>
            <td style=""padding:0 40px;"">
                <table role=""presentation"" width=""100%"" cellpadding=""0"" cellspacing=""0"" border=""0"">
                <tr><td style=""border-top:1px solid #E2E8F0;font-size:0;line-height:0;"">&#160;</td></tr>
                </table>
            </td>
        </tr>

        <!-- ===== FOOTER ===== -->
        <tr>
            <td style=""padding:28px 40px;text-align:center;"">
                <p style=""color:#64748B;font-size:13px;margin:0 0 6px;font-weight:600;"">
                    {fromName}
                </p>
                <p style=""color:#94A3B8;font-size:12px;margin:0 0 14px;line-height:1.5;"">
                    You received this email because you signed up for an account.
                </p>
                <p style=""color:#CBD5E1;font-size:11px;margin:0;"">
                    &#169; {year} {fromName}. All rights reserved.
                </p>
            </td>
        </tr>

    </table>

</td></tr>
</table>

</body>
</html>";
        }

        /// <summary>
        /// Returns a plain-text fallback version of the welcome email.
        /// </summary>
        public static string GetPlainTextFallback(string fromName)
        {
            if (string.IsNullOrWhiteSpace(fromName))
            {
                fromName = "Our Team";
            }

            return $@"Welcome Aboard!

Hi there,

Thank you for signing up! Your account has been successfully created and you're all set to explore everything our platform has to offer.

What you can do:
- Quick Setup: Get started in minutes
- Secure: Enterprise-grade security built in
- 24/7 Support: We're always here to help

Click the link below to access your dashboard:
https://example.com/dashboard

Best regards,
{fromName}

© {DateTime.Now.Year} {fromName}. All rights reserved.";
        }
    }
}
