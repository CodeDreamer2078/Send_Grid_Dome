using System;
using System.Configuration;
using System.Web.UI;
using SendGridEmailDemo.Models;
using SendGridEmailDemo.Services;

namespace SendGridEmailDemo
{
    public partial class DefaultPage : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                PopulateDefaultSenderFields();
            }
        }

        /// <summary>
        /// Handles the Send button click. Uses async/await to call the SendGrid API
        /// without blocking the request thread. Requires Async="true" on the page directive.
        /// </summary>
        protected async void BtnSend_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid)
            {
                return;
            }

            ResetMessages();

            try
            {
                var request = new EmailRequest
                {
                    FromEmail = txtFromEmail.Text.Trim(),
                    FromName = txtFromName.Text.Trim(),
                    ToEmail = txtToEmail.Text.Trim(),
                    Subject = txtSubject.Text.Trim(),
                    PlainTextContent = txtBody.Text.Trim(),
                    HtmlContent = null
                };

                var emailService = new EmailService();
                EmailResult result = await emailService.SendEmailAsync(request);

                if (result.IsSuccess)
                {
                    ShowSuccess(result.Message);
                    ClearRecipientFields();
                }
                else
                {
                    ShowError(result.Message);
                }
            }
            catch (InvalidOperationException ex)
            {
                ShowError($"Configuration error: {ex.Message}");
            }
            catch (Exception ex)
            {
                ShowError($"An unexpected error occurred: {ex.Message}");
            }
        }

        /// <summary>
        /// Pre-fills the From Email and From Name fields with values from Web.config
        /// so the user doesn't have to type them every time.
        /// </summary>
        private void PopulateDefaultSenderFields()
        {
            string defaultFromEmail = ConfigurationManager.AppSettings["DefaultFromEmail"];
            string defaultFromName = ConfigurationManager.AppSettings["DefaultFromName"];

            if (!string.IsNullOrEmpty(defaultFromEmail))
            {
                txtFromEmail.Text = defaultFromEmail;
            }

            if (!string.IsNullOrEmpty(defaultFromName))
            {
                txtFromName.Text = defaultFromName;
            }
        }

        private void ClearRecipientFields()
        {
            txtToEmail.Text = string.Empty;
            txtSubject.Text = string.Empty;
            txtBody.Text = string.Empty;
        }

        private void ShowSuccess(string message)
        {
            lblSuccess.Text = message;
            lblSuccess.Visible = true;
            lblError.Visible = false;
        }

        private void ShowError(string message)
        {
            lblError.Text = message;
            lblError.Visible = true;
            lblSuccess.Visible = false;
        }

        private void ResetMessages()
        {
            lblSuccess.Visible = false;
            lblError.Visible = false;
        }
    }
}
