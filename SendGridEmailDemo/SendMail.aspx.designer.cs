namespace SendGridEmailDemo
{
    public partial class SendMailPage
    {
        protected global::System.Web.UI.WebControls.Label lblSuccess;

        protected global::System.Web.UI.WebControls.Label lblError;

        protected global::System.Web.UI.WebControls.Literal litFromName;

        protected global::System.Web.UI.WebControls.Literal litFromEmail;

        protected global::System.Web.UI.WebControls.TextBox txtToEmail;

        protected global::System.Web.UI.WebControls.RequiredFieldValidator rfvToEmail;

        protected global::System.Web.UI.WebControls.RegularExpressionValidator revToEmail;

        protected global::System.Web.UI.WebControls.TextBox txtSubject;

        protected global::System.Web.UI.WebControls.RequiredFieldValidator rfvSubject;

        protected global::System.Web.UI.WebControls.FileUpload fuAttachment;

        protected global::System.Web.UI.WebControls.Button btnSendMail;

        protected global::System.Web.UI.WebControls.HiddenField hdnTemplateHtml;
    }
}
