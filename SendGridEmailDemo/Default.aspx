<%@ Page Language="C#" AutoEventWireup="true" Async="true"
    CodeBehind="Default.aspx.cs" Inherits="SendGridEmailDemo.DefaultPage" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>SendGrid Email Demo</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
          rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YcnS/1t0dCmkaQP3UgIph/7FbO3Bs3SwggfN"
          crossorigin="anonymous" />
    <style>
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 2rem 0;
        }

        .email-card {
            max-width: 680px;
            width: 100%;
            border: none;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.25);
        }

        .card-header {
            background: #1a1a2e;
            padding: 1.5rem 2rem;
            border-bottom: 3px solid #667eea;
        }

        .card-header h4 {
            margin: 0;
            font-weight: 600;
            letter-spacing: 0.5px;
        }

        .card-header small {
            opacity: 0.7;
        }

        .card-body {
            padding: 2rem;
        }

        .form-label {
            font-weight: 600;
            color: #333;
            margin-bottom: 0.3rem;
        }

        .form-control:focus {
            border-color: #667eea;
            box-shadow: 0 0 0 0.2rem rgba(102, 126, 234, 0.25);
        }

        .btn-send {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border: none;
            padding: 0.7rem 2.5rem;
            font-weight: 600;
            letter-spacing: 0.5px;
            transition: transform 0.2s, box-shadow 0.2s;
        }

        .btn-send:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(102, 126, 234, 0.4);
        }

        .validation-error {
            color: #dc3545;
            font-size: 0.85rem;
            display: block;
            margin-top: 0.25rem;
        }

        .alert {
            border-radius: 8px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <div class="card email-card">

                <div class="card-header text-white">
                    <h4>SendGrid Email Demo</h4>
                    <small>Send emails using Twilio SendGrid API</small>
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

                    <div class="row">

                        <%-- From Email --%>
                        <div class="col-md-6 mb-3">
                            <label class="form-label" for="txtFromEmail">From Email</label>
                            <asp:TextBox ID="txtFromEmail" runat="server"
                                CssClass="form-control"
                                placeholder="sender@yourdomain.com" />

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
                        <div class="col-md-6 mb-3">
                            <label class="form-label" for="txtFromName">From Name</label>
                            <asp:TextBox ID="txtFromName" runat="server"
                                CssClass="form-control"
                                placeholder="Your Name or Company" />

                            <asp:RequiredFieldValidator ID="rfvFromName" runat="server"
                                ControlToValidate="txtFromName"
                                ErrorMessage="From Name is required."
                                CssClass="validation-error"
                                Display="Dynamic"
                                ValidationGroup="EmailForm" />
                        </div>
                    </div>

                    <%-- To Email --%>
                    <div class="mb-3">
                        <label class="form-label" for="txtToEmail">To Email</label>
                        <asp:TextBox ID="txtToEmail" runat="server"
                            CssClass="form-control"
                            placeholder="recipient@example.com" />

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

                    <%-- Subject --%>
                    <div class="mb-3">
                        <label class="form-label" for="txtSubject">Subject</label>
                        <asp:TextBox ID="txtSubject" runat="server"
                            CssClass="form-control"
                            placeholder="Email subject line" />

                        <asp:RequiredFieldValidator ID="rfvSubject" runat="server"
                            ControlToValidate="txtSubject"
                            ErrorMessage="Subject is required."
                            CssClass="validation-error"
                            Display="Dynamic"
                            ValidationGroup="EmailForm" />
                    </div>

                    <%-- Message Body --%>
                    <div class="mb-4">
                        <label class="form-label" for="txtBody">Message Body</label>
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
                    <div class="d-grid">
                        <asp:Button ID="btnSend" runat="server"
                            Text="Send Email"
                            CssClass="btn btn-primary btn-lg btn-send"
                            OnClick="BtnSend_Click"
                            ValidationGroup="EmailForm" />
                    </div>

                </div>

            </div>
        </div>
    </form>
</body>
</html>
