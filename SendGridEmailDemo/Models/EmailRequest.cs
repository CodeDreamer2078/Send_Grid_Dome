using System.Collections.Generic;

namespace SendGridEmailDemo.Models
{
    /// <summary>
    /// Represents the data required to compose and send an email through SendGrid.
    /// </summary>
    public class EmailRequest
    {
        public string FromEmail { get; set; }

        public string FromName { get; set; }

        public string ToEmail { get; set; }

        public string Subject { get; set; }

        public string PlainTextContent { get; set; }

        public string HtmlContent { get; set; }

        /// <summary>
        /// Optional list of additional recipients for multi-recipient emails.
        /// </summary>
        public List<string> AdditionalRecipients { get; set; }

        public EmailRequest()
        {
            AdditionalRecipients = new List<string>();
        }
    }
}
