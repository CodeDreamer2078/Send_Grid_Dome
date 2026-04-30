<%@ Page Title="Compose Email" Language="C#" MasterPageFile="~/Site.Master"
    AutoEventWireup="true" Async="true"
    CodeBehind="Default.aspx.cs" Inherits="SendGridEmailDemo.DefaultPage" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container" style="max-width: 720px;">

        <%-- Page Header --%>
        <div class="page-header">
            <h1><i class="bi bi-pencil-square me-2 text-primary-custom"></i>Compose Email</h1>
            <p class="page-subtitle">Fill in the details below to send an email via Twilio SendGrid</p>
        </div>

        <div class="card content-card">

            <%-- Card Header --%>
            <div class="card-header-custom">
                <h4><i class="bi bi-envelope-plus me-2"></i>New Message</h4>
                <p class="header-subtitle">All fields are required</p>
            </div>

            <div class="card-body">

                <%-- Success Message --%>
                <asp:Label ID="lblSuccess" runat="server"
                    CssClass="alert alert-success d-block"
                    Visible="false" />

                <%-- Error Message --%>
                <asp:Label ID="lblError" runat="server"
                    CssClass="alert alert-danger d-block"
                    Visible="false" />

                <%-- ── Sender Section ──────────────────── --%>
                <div class="mb-3">
                    <small class="text-muted fw-500 text-uppercase" style="letter-spacing: 1px;">
                        <i class="bi bi-person-circle me-1"></i>Sender Details
                    </small>
                    <hr class="section-divider mt-1" />
                </div>

                <div class="row">
                    <%-- From Email --%>
                    <div class="col-md-6 field-group">
                        <label class="form-label">From Email</label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="bi bi-envelope"></i></span>
                            <asp:TextBox ID="txtFromEmail" runat="server"
                                CssClass="form-control"
                                placeholder="sender@yourdomain.com" />
                        </div>
                        <asp:RequiredFieldValidator ID="rfvFromEmail" runat="server"
                            ControlToValidate="txtFromEmail"
                            ErrorMessage="From Email is required."
                            CssClass="validation-error"
                            Display="Dynamic"
                            ValidationGroup="EmailForm" />
                        <asp:RegularExpressionValidator ID="revFromEmail" runat="server"
                            ControlToValidate="txtFromEmail"
                            ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"
                            ErrorMessage="Please enter a valid email address."
                            CssClass="validation-error"
                            Display="Dynamic"
                            ValidationGroup="EmailForm" />
                    </div>

                    <%-- From Name --%>
                    <div class="col-md-6 field-group">
                        <label class="form-label">From Name</label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="bi bi-person"></i></span>
                            <asp:TextBox ID="txtFromName" runat="server"
                                CssClass="form-control"
                                placeholder="Your Name or Company" />
                        </div>
                        <asp:RequiredFieldValidator ID="rfvFromName" runat="server"
                            ControlToValidate="txtFromName"
                            ErrorMessage="From Name is required."
                            CssClass="validation-error"
                            Display="Dynamic"
                            ValidationGroup="EmailForm" />
                    </div>
                </div>

                <%-- ── Recipient Section ───────────────── --%>
                <div class="mb-3 mt-2">
                    <small class="text-muted fw-500 text-uppercase" style="letter-spacing: 1px;">
                        <i class="bi bi-people me-1"></i>Recipient
                    </small>
                    <hr class="section-divider mt-1" />
                </div>

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
                        ErrorMessage="To Email is required."
                        CssClass="validation-error"
                        Display="Dynamic"
                        ValidationGroup="EmailForm" />
                    <asp:RegularExpressionValidator ID="revToEmail" runat="server"
                        ControlToValidate="txtToEmail"
                        ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"
                        ErrorMessage="Please enter a valid email address."
                        CssClass="validation-error"
                        Display="Dynamic"
                        ValidationGroup="EmailForm" />
                </div>

                <%-- ── Message Section ─────────────────── --%>
                <div class="mb-3 mt-2">
                    <small class="text-muted fw-500 text-uppercase" style="letter-spacing: 1px;">
                        <i class="bi bi-chat-text me-1"></i>Message Content
                    </small>
                    <hr class="section-divider mt-1" />
                </div>

                <%-- Subject --%>
                <div class="field-group">
                    <label class="form-label">Subject</label>
                    <div class="input-group">
                        <span class="input-group-text"><i class="bi bi-fonts"></i></span>
                        <asp:TextBox ID="txtSubject" runat="server"
                            CssClass="form-control"
                            placeholder="Email subject line" />
                    </div>
                    <asp:RequiredFieldValidator ID="rfvSubject" runat="server"
                        ControlToValidate="txtSubject"
                        ErrorMessage="Subject is required."
                        CssClass="validation-error"
                        Display="Dynamic"
                        ValidationGroup="EmailForm" />
                </div>

                <%-- Message Body --%>
                <div class="field-group">
                    <label class="form-label">Message Body</label>
                    <asp:TextBox ID="txtBody" runat="server"
                        CssClass="form-control"
                        TextMode="MultiLine"
                        Rows="6"
                        placeholder="Type your email message here..." />
                    <asp:RequiredFieldValidator ID="rfvBody" runat="server"
                        ControlToValidate="txtBody"
                        ErrorMessage="Message body cannot be empty."
                        CssClass="validation-error"
                        Display="Dynamic"
                        ValidationGroup="EmailForm" />
                </div>

                <%-- Send Button --%>
                <div class="d-grid mt-4">
                    <asp:Button ID="btnSend" runat="server"
                        Text="  Send Email"
                        CssClass="btn btn-lg btn-send"
                        OnClick="BtnSend_Click"
                        ValidationGroup="EmailForm" />
                </div>

            </div>
        </div>

    </div>
</asp:Content>
