namespace SendGridEmailDemo.Models
{
    /// <summary>
    /// Represents a file attachment to be included with an email sent via SendGrid.
    /// The file content must be Base64-encoded before assignment.
    /// </summary>
    public class EmailAttachment
    {
        public string FileName { get; set; }

        public string Base64Content { get; set; }

        public string ContentType { get; set; }
    }
}
