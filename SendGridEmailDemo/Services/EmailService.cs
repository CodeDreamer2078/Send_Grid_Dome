using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Net;
using System.Threading.Tasks;
using SendGrid;
using SendGrid.Helpers.Mail;
using SendGridEmailDemo.Models;

namespace SendGridEmailDemo.Services
{
    /// <summary>
    /// Reusable service that handles all SendGrid email operations.
    /// Reads the API key from Web.config and provides async methods for sending emails.
    /// </summary>
    public class EmailService
    {
        private readonly string _apiKey;

        public EmailService()
        {
            _apiKey = ConfigurationManager.AppSettings["SendGridApiKey"];

            if (string.IsNullOrWhiteSpace(_apiKey))
            {
                throw new InvalidOperationException(
                    "SendGrid API key is not configured. " +
                    "Add 'SendGridApiKey' to the <appSettings> section in Web.config.");
            }
        }

        /// <summary>
        /// Sends a single email to one recipient using SendGrid.
        /// Supports both plain-text and HTML content.
        /// </summary>
        public async Task<EmailResult> SendEmailAsync(EmailRequest request)
        {
            if (request == null)
            {
                throw new ArgumentNullException(nameof(request));
            }

            try
            {
                var client = new SendGridClient(_apiKey);

                var fromAddress = new EmailAddress(request.FromEmail, request.FromName);
                var toAddress = new EmailAddress(request.ToEmail);

                var message = MailHelper.CreateSingleEmail(
                    fromAddress,
                    toAddress,
                    request.Subject,
                    request.PlainTextContent,
                    request.HtmlContent);

                Response response = await client.SendEmailAsync(message);

                if (IsSuccessStatusCode(response.StatusCode))
                {
                    return EmailResult.Success(
                        "Email sent successfully!",
                        (int)response.StatusCode);
                }

                string responseBody = await response.Body.ReadAsStringAsync();
                return EmailResult.Failure(
                    $"SendGrid returned status {(int)response.StatusCode}: {responseBody}",
                    (int)response.StatusCode);
            }
            catch (Exception ex)
            {
                return EmailResult.Failure(
                    $"An error occurred while sending the email: {ex.Message}");
            }
        }

        /// <summary>
        /// Sends an HTML email to multiple recipients using SendGrid.
        /// Uses MailHelper.CreateSingleEmailToMultipleRecipients for batch sending.
        /// </summary>
        public async Task<EmailResult> SendHtmlEmailToMultipleRecipientsAsync(
            string fromEmail,
            string fromName,
            List<string> toEmails,
            string subject,
            string htmlContent,
            string plainTextFallback = null)
        {
            if (toEmails == null || !toEmails.Any())
            {
                return EmailResult.Failure("At least one recipient email address is required.");
            }

            try
            {
                var client = new SendGridClient(_apiKey);

                var fromAddress = new EmailAddress(fromEmail, fromName);
                var recipients = toEmails
                    .Select(email => new EmailAddress(email.Trim()))
                    .ToList();

                var message = MailHelper.CreateSingleEmailToMultipleRecipients(
                    fromAddress,
                    recipients,
                    subject,
                    plainTextFallback,
                    htmlContent);

                Response response = await client.SendEmailAsync(message);

                if (IsSuccessStatusCode(response.StatusCode))
                {
                    return EmailResult.Success(
                        $"Email sent successfully to {recipients.Count} recipient(s)!",
                        (int)response.StatusCode);
                }

                string responseBody = await response.Body.ReadAsStringAsync();
                return EmailResult.Failure(
                    $"SendGrid returned status {(int)response.StatusCode}: {responseBody}",
                    (int)response.StatusCode);
            }
            catch (Exception ex)
            {
                return EmailResult.Failure(
                    $"An error occurred while sending emails: {ex.Message}");
            }
        }

        /// <summary>
        /// Sends a single email with optional file attachments using SendGrid.
        /// Attachment content must be Base64-encoded before calling this method.
        /// </summary>
        public async Task<EmailResult> SendEmailWithAttachmentsAsync(
            EmailRequest request,
            List<EmailAttachment> attachments)
        {
            if (request == null)
            {
                throw new ArgumentNullException(nameof(request));
            }

            try
            {
                var client = new SendGridClient(_apiKey);

                var fromAddress = new EmailAddress(request.FromEmail, request.FromName);
                var toAddress = new EmailAddress(request.ToEmail);

                var message = MailHelper.CreateSingleEmail(
                    fromAddress,
                    toAddress,
                    request.Subject,
                    request.PlainTextContent,
                    request.HtmlContent);

                if (attachments != null)
                {
                    foreach (EmailAttachment attachment in attachments)
                    {
                        message.AddAttachment(
                            attachment.FileName,
                            attachment.Base64Content,
                            attachment.ContentType);
                    }
                }

                Response response = await client.SendEmailAsync(message);

                if (IsSuccessStatusCode(response.StatusCode))
                {
                    return EmailResult.Success(
                        "Email sent successfully with attachment(s)!",
                        (int)response.StatusCode);
                }

                string responseBody = await response.Body.ReadAsStringAsync();
                return EmailResult.Failure(
                    $"SendGrid returned status {(int)response.StatusCode}: {responseBody}",
                    (int)response.StatusCode);
            }
            catch (Exception ex)
            {
                return EmailResult.Failure(
                    $"An error occurred while sending the email: {ex.Message}");
            }
        }

        /// <summary>
        /// SendGrid returns 200, 201, or 202 (Accepted) on success.
        /// 202 is the most common success response for email sending.
        /// </summary>
        private static bool IsSuccessStatusCode(HttpStatusCode statusCode)
        {
            int code = (int)statusCode;
            return code >= 200 && code < 300;
        }
    }
}
