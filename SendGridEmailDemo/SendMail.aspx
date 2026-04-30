<%@ Page Title="Send Mail" Language="C#" MasterPageFile="~/Site.Master"
    AutoEventWireup="true" Async="true"
    CodeBehind="SendMail.aspx.cs" Inherits="SendGridEmailDemo.SendMailPage" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container">

        <%-- Page Header --%>
        <div class="page-header">
            <h1><i class="bi bi-send-plus me-2 text-primary-custom"></i>Send Mail</h1>
            <p class="page-subtitle">Send a beautifully designed HTML email with optional attachment</p>
        </div>

        <div class="row g-4">

            <%-- ══════════ LEFT COLUMN — Send Form ══════════ --%>
            <div class="col-lg-5">
                <div class="card content-card h-100">
                    <div class="card-header-custom">
                        <h4><i class="bi bi-envelope-arrow-up me-2"></i>Send Details</h4>
                        <p class="header-subtitle">Configure recipient and attachment</p>
                    </div>
                    <div class="card-body d-flex flex-column">

                        <%-- Success / Error Messages --%>
                        <asp:Label ID="lblSuccess" runat="server"
                            CssClass="alert alert-success d-block"
                            Visible="false" />

                        <asp:Label ID="lblError" runat="server"
                            CssClass="alert alert-danger d-block"
                            Visible="false" />

                        <%-- Sender Info (read-only from config) --%>
                        <div class="sender-info mb-3">
                            <div class="d-flex align-items-center gap-2 mb-2">
                                <span class="sender-avatar">
                                    <i class="bi bi-person-fill"></i>
                                </span>
                                <div>
                                    <div class="sender-name">
                                        <asp:Literal ID="litFromName" runat="server" />
                                    </div>
                                    <div class="sender-email">
                                        <asp:Literal ID="litFromEmail" runat="server" />
                                    </div>
                                </div>
                            </div>
                        </div>

                        <hr class="section-divider mt-0" />

                        <%-- To Email --%>
                        <div class="field-group">
                            <label class="form-label">To Email</label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="bi bi-send"></i></span>
                                <asp:TextBox ID="txtToEmail" runat="server"
                                    CssClass="form-control"
                                    placeholder="recipient@example.com" />
                            </div>
                            <asp:RequiredFieldValidator ID="rfvToEmail" runat="server"
                                ControlToValidate="txtToEmail"
                                ErrorMessage="Recipient email is required."
                                CssClass="validation-error"
                                Display="Dynamic"
                                ValidationGroup="SendMailForm" />
                            <asp:RegularExpressionValidator ID="revToEmail" runat="server"
                                ControlToValidate="txtToEmail"
                                ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"
                                ErrorMessage="Please enter a valid email address."
                                CssClass="validation-error"
                                Display="Dynamic"
                                ValidationGroup="SendMailForm" />
                        </div>

                        <%-- Subject (pre-filled) --%>
                        <div class="field-group">
                            <label class="form-label">Subject</label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="bi bi-fonts"></i></span>
                                <asp:TextBox ID="txtSubject" runat="server"
                                    CssClass="form-control" />
                            </div>
                            <asp:RequiredFieldValidator ID="rfvSubject" runat="server"
                                ControlToValidate="txtSubject"
                                ErrorMessage="Subject is required."
                                CssClass="validation-error"
                                Display="Dynamic"
                                ValidationGroup="SendMailForm" />
                        </div>

                        <%-- File Attachment --%>
                        <div class="field-group">
                            <label class="form-label">Attachment</label>
                            <asp:FileUpload ID="fuAttachment" runat="server"
                                CssClass="form-control file-upload-input" />
                            <small class="text-muted d-block mt-1">
                                <i class="bi bi-info-circle me-1"></i>Optional &mdash; Max 10 MB
                            </small>
                        </div>

                        <%-- Send Button --%>
                        <div class="d-grid mt-auto pt-3">
                            <asp:Button ID="btnSendMail" runat="server"
                                Text="  Send Email"
                                CssClass="btn btn-lg btn-send"
                                OnClick="BtnSendMail_Click"
                                ValidationGroup="SendMailForm" />
                        </div>

                    </div>
                </div>
            </div>

            <%-- ══════════ RIGHT COLUMN — Email Preview ══════════ --%>
            <div class="col-lg-7">
                <div class="card content-card">
                    <div class="card-header-custom">
                        <h4><i class="bi bi-eye me-2"></i>Email Preview</h4>
                        <p class="header-subtitle">This is how the recipient will see your email</p>
                    </div>
                    <div class="card-body p-0">

                        <%-- Browser-like frame --%>
                        <div class="email-preview-browser">
                            <div class="email-preview-toolbar">
                                <span class="toolbar-dot red"></span>
                                <span class="toolbar-dot yellow"></span>
                                <span class="toolbar-dot green"></span>
                                <span class="toolbar-url-bar">
                                    <i class="bi bi-lock-fill me-1"></i>mail.example.com
                                </span>
                            </div>
                            <div class="email-preview-content">
                                <asp:HiddenField ID="hdnTemplateHtml" runat="server" />
                                <iframe id="emailPreviewFrame" class="email-preview-iframe"
                                        title="Email Template Preview"></iframe>
                            </div>
                        </div>

                    </div>
                </div>
            </div>

        </div>
    </div>
</asp:Content>

<asp:Content ID="ScriptsContent" ContentPlaceHolderID="ScriptsContent" runat="server">
    <script>
        (function () {
            var hidden = document.getElementById('<%= hdnTemplateHtml.ClientID %>');
            var frame = document.getElementById('emailPreviewFrame');
            if (hidden && frame && hidden.value) {
                frame.srcdoc = hidden.value;
            }

            frame.addEventListener('load', function () {
                try {
                    var body = frame.contentDocument.body;
                    if (body) {
                        frame.style.height = body.scrollHeight + 40 + 'px';
                    }
                } catch (e) { }
            });
        })();
    </script>
</asp:Content>
