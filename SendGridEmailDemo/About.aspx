<%@ Page Title="Getting Started" Language="C#" MasterPageFile="~/Site.Master"
    AutoEventWireup="true"
    CodeBehind="About.aspx.cs" Inherits="SendGridEmailDemo.AboutPage" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container" style="max-width: 900px;">

        <%-- Page Header --%>
        <div class="page-header">
            <h1><i class="bi bi-book me-2 text-primary-custom"></i>Getting Started Guide</h1>
            <p class="page-subtitle">Everything you need to configure and start sending emails</p>
        </div>

        <%-- ── Feature Highlights ──────────────────────────── --%>
        <div class="row g-3 mb-4">
            <div class="col-md-3 col-6">
                <div class="feature-card">
                    <div class="feature-icon indigo">
                        <i class="bi bi-envelope-paper"></i>
                    </div>
                    <h5>Send Emails</h5>
                    <p>Compose and send emails through the SendGrid API</p>
                </div>
            </div>
            <div class="col-md-3 col-6">
                <div class="feature-card">
                    <div class="feature-icon emerald">
                        <i class="bi bi-shield-check"></i>
                    </div>
                    <h5>API Security</h5>
                    <p>Keys stored securely in Web.config, never in code</p>
                </div>
            </div>
            <div class="col-md-3 col-6">
                <div class="feature-card">
                    <div class="feature-icon amber">
                        <i class="bi bi-layers"></i>
                    </div>
                    <h5>Clean Architecture</h5>
                    <p>Service layer separated from UI for reusability</p>
                </div>
            </div>
            <div class="col-md-3 col-6">
                <div class="feature-card">
                    <div class="feature-icon sky">
                        <i class="bi bi-code-square"></i>
                    </div>
                    <h5>HTML Support</h5>
                    <p>Send rich HTML emails with multiple recipients</p>
                </div>
            </div>
        </div>

        <%-- ── Setup Steps ─────────────────────────────────── --%>
        <div class="card content-card mb-4">
            <div class="card-header-custom">
                <h4><i class="bi bi-rocket-takeoff me-2"></i>Quick Setup</h4>
                <p class="header-subtitle">Follow these steps to start sending emails</p>
            </div>
            <div class="card-body">
                <div class="row g-3">
                    <div class="col-md-6">
                        <div class="step-card">
                            <div class="step-number">1</div>
                            <div class="step-content">
                                <h6>Create SendGrid Account</h6>
                                <p>Sign up at
                                    <a href="https://signup.sendgrid.com/" target="_blank" rel="noopener">sendgrid.com</a>
                                    and complete verification.</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="step-card">
                            <div class="step-number">2</div>
                            <div class="step-content">
                                <h6>Generate API Key</h6>
                                <p>Go to Settings &rarr; API Keys &rarr; Create with
                                    <strong>Mail Send</strong> permission.</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="step-card">
                            <div class="step-number">3</div>
                            <div class="step-content">
                                <h6>Verify Sender Identity</h6>
                                <p>Go to Sender Authentication &rarr; Verify a Single Sender with your email.</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="step-card">
                            <div class="step-number">4</div>
                            <div class="step-content">
                                <h6>Update Web.config</h6>
                                <p>Paste your API key and verified sender email into the config file below.</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <%-- ── Configuration Reference ─────────────────────── --%>
        <div class="card content-card mb-4">
            <div class="card-header-custom">
                <h4><i class="bi bi-gear me-2"></i>Configuration Reference</h4>
                <p class="header-subtitle">Update these values in Web.config &rarr; appSettings</p>
            </div>
            <div class="card-body">
                <div class="config-block">
                    <span class="tag">&lt;appSettings&gt;</span><br />
                    &nbsp;&nbsp;<span class="tag">&lt;add</span>
                        <span class="attr">key=</span><span class="val">"SendGridApiKey"</span>
                        <span class="attr">value=</span><span class="val">"SG.your_api_key_here"</span>
                    <span class="tag">/&gt;</span><br />
                    &nbsp;&nbsp;<span class="tag">&lt;add</span>
                        <span class="attr">key=</span><span class="val">"DefaultFromEmail"</span>
                        <span class="attr">value=</span><span class="val">"verified@yourdomain.com"</span>
                    <span class="tag">/&gt;</span><br />
                    &nbsp;&nbsp;<span class="tag">&lt;add</span>
                        <span class="attr">key=</span><span class="val">"DefaultFromName"</span>
                        <span class="attr">value=</span><span class="val">"Your App Name"</span>
                    <span class="tag">/&gt;</span><br />
                    <span class="tag">&lt;/appSettings&gt;</span>
                </div>

                <div class="row mt-4 g-3">
                    <div class="col-md-4">
                        <div class="alert alert-info mb-0">
                            <div>
                                <strong>SendGridApiKey</strong><br />
                                <small>Starts with <code>SG.</code> &mdash; get it from your SendGrid dashboard</small>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="alert alert-info mb-0">
                            <div>
                                <strong>DefaultFromEmail</strong><br />
                                <small>Must be a verified sender address in your SendGrid account</small>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="alert alert-info mb-0">
                            <div>
                                <strong>DefaultFromName</strong><br />
                                <small>Display name shown in the recipient's inbox</small>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <%-- ── Common Errors ───────────────────────────────── --%>
        <div class="card content-card mb-4">
            <div class="card-header-custom">
                <h4><i class="bi bi-exclamation-triangle me-2"></i>Troubleshooting</h4>
                <p class="header-subtitle">Common errors and how to fix them</p>
            </div>
            <div class="card-body">
                <div class="accordion" id="errorAccordion">

                    <div class="accordion-item border-0 border-bottom">
                        <h2 class="accordion-header">
                            <button class="accordion-button collapsed fw-600" type="button"
                                    data-bs-toggle="collapse" data-bs-target="#err1">
                                <span class="badge bg-danger me-2">401</span> Unauthorized
                            </button>
                        </h2>
                        <div id="err1" class="accordion-collapse collapse" data-bs-parent="#errorAccordion">
                            <div class="accordion-body text-secondary">
                                Your API key is invalid or missing. Verify it starts with <code>SG.</code>,
                                has <strong>Mail Send</strong> permissions, and hasn't been revoked.
                            </div>
                        </div>
                    </div>

                    <div class="accordion-item border-0 border-bottom">
                        <h2 class="accordion-header">
                            <button class="accordion-button collapsed fw-600" type="button"
                                    data-bs-toggle="collapse" data-bs-target="#err2">
                                <span class="badge bg-danger me-2">403</span> Sender Identity Not Verified
                            </button>
                        </h2>
                        <div id="err2" class="accordion-collapse collapse" data-bs-parent="#errorAccordion">
                            <div class="accordion-body text-secondary">
                                The "From" email is not verified in SendGrid. Go to
                                <strong>Settings &rarr; Sender Authentication</strong> and verify
                                the exact email address you're sending from.
                            </div>
                        </div>
                    </div>

                    <div class="accordion-item border-0 border-bottom">
                        <h2 class="accordion-header">
                            <button class="accordion-button collapsed fw-600" type="button"
                                    data-bs-toggle="collapse" data-bs-target="#err3">
                                <span class="badge bg-warning text-dark me-2">400</span> Bad Request
                            </button>
                        </h2>
                        <div id="err3" class="accordion-collapse collapse" data-bs-parent="#errorAccordion">
                            <div class="accordion-body text-secondary">
                                Malformed request data. Ensure all email addresses are valid,
                                subject is not empty, and there are no invalid characters.
                            </div>
                        </div>
                    </div>

                    <div class="accordion-item border-0">
                        <h2 class="accordion-header">
                            <button class="accordion-button collapsed fw-600" type="button"
                                    data-bs-toggle="collapse" data-bs-target="#err4">
                                <span class="badge bg-secondary me-2">Config</span> API Key Not Configured
                            </button>
                        </h2>
                        <div id="err4" class="accordion-collapse collapse" data-bs-parent="#errorAccordion">
                            <div class="accordion-body text-secondary">
                                The <code>SendGridApiKey</code> in Web.config is still set to the placeholder.
                                Replace <code>YOUR_SENDGRID_API_KEY</code> with your actual key.
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>

        <%-- ── CTA --%>
        <div class="text-center mb-3">
            <a href="Default.aspx" class="btn btn-lg btn-send">
                <i class="bi bi-pencil-square me-2"></i>Start Composing
            </a>
        </div>

    </div>
</asp:Content>
