using System;
using System.Collections.Generic;
using System.Configuration;
using System.Web.UI;
using SendGridEmailDemo.Helpers;
using SendGridEmailDemo.Models;
using SendGridEmailDemo.Services;

namespace SendGridEmailDemo
{
    public partial class SendMailPage : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadSenderInfo();
                LoadEmailTemplate();
            }
        }

        protected async void BtnSendMail_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid)
            {
                return;
            }

            ResetMessages();

            try
            {
                string fromEmail = ConfigurationManager.AppSettings["DefaultFromEmail"];
                string fromName = ConfigurationManager.AppSettings["DefaultFromName"];
                string templateHtml = EmailTemplateHelper.GetHtmlTemplate(fromName);
                string plainText = EmailTemplateHelper.GetPlainTextFallback(fromName);

                var request = new EmailRequest
                {
                    FromEmail = fromEmail,
                    FromName = fromName,
                    ToEmail = txtToEmail.Text.Trim(),
                    Subject = txtSubject.Text.Trim(),
                    HtmlContent = templateHtml,
                    PlainTextContent = plainText
                };

                var attachments = new List<EmailAttachment>();

                if (fuAttachment.HasFile)
                {
                    byte[] fileBytes = fuAttachment.FileBytes;
                    attachments.Add(new EmailAttachment
                    {
                        FileName = fuAttachment.FileName,
                        Base64Content = Convert.ToBase64String(fileBytes),
                        ContentType = fuAttachment.PostedFile.ContentType
                    });
                }

                var emailService = new EmailService();
                EmailResult result = await emailService.SendEmailWithAttachmentsAsync(request, attachments);

                if (result.IsSuccess)
                {
                    ShowSuccess(result.Message);
                    txtToEmail.Text = string.Empty;
                }
                else
                {
                    ShowError(result.Message);
                }

                ReloadTemplatePreview();
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

        private void LoadSenderInfo()
        {
            string fromEmail = ConfigurationManager.AppSettings["DefaultFromEmail"] ?? "not configured";
            string fromName = ConfigurationManager.AppSettings["DefaultFromName"] ?? "Not Configured";

            litFromName.Text = Server.HtmlEncode(fromName);
            litFromEmail.Text = Server.HtmlEncode(fromEmail);
        }

        private void LoadEmailTemplate()
        {
            txtSubject.Text = EmailTemplateHelper.GetDefaultSubject();

            string fromName = ConfigurationManager.AppSettings["DefaultFromName"] ?? "Demo App";
            hdnTemplateHtml.Value = EmailTemplateHelper.GetHtmlTemplate(fromName);
        }

        /// <summary>
        /// Re-populates the hidden field after postback so the iframe preview
        /// continues to display the template even after a send attempt.
        /// </summary>
        private void ReloadTemplatePreview()
        {
            string fromName = ConfigurationManager.AppSettings["DefaultFromName"] ?? "Demo App";
            hdnTemplateHtml.Value = EmailTemplateHelper.GetHtmlTemplate(fromName);
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
