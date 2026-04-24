# SendGridEmailDemo

A production-structured **ASP.NET Web Forms (.NET Framework 4.7.2)** demo project that demonstrates how to send emails using the **Twilio SendGrid Email API** in C#.

---

## Project Structure

```
SendGridEmailDemo.sln
SendGridEmailDemo/
├── Default.aspx                  # Email form UI (Bootstrap-styled)
├── Default.aspx.cs               # Code-behind with async email handling
├── Default.aspx.designer.cs      # Auto-generated control declarations
├── Global.asax                   # Application lifecycle entry point
├── Global.asax.cs                # Application-level error handling
├── Web.config                    # Configuration (API key, sender defaults)
├── packages.config               # NuGet package references
├── Properties/
│   └── AssemblyInfo.cs           # Assembly metadata
├── Models/
│   ├── EmailRequest.cs           # Email composition data model
│   └── EmailResult.cs            # Email operation result model
└── Services/
    └── EmailService.cs           # Reusable SendGrid integration service
```

---

## Prerequisites

- **Visual Studio 2019 or later** (Community, Professional, or Enterprise)
- **.NET Framework 4.7.2** or later installed
- **SendGrid account** (free tier available at [sendgrid.com](https://sendgrid.com))
- **Internet connection** (for SendGrid API calls)

---

## SendGrid Account Setup Guide

### Step 1 — Create a SendGrid Account

1. Go to [https://signup.sendgrid.com/](https://signup.sendgrid.com/)
2. Sign up with your email address
3. Complete the account verification process
4. Log into the SendGrid dashboard

### Step 2 — Generate an API Key

1. In the SendGrid dashboard, navigate to **Settings → API Keys**
2. Click **Create API Key**
3. Give it a name (e.g., `SendGridEmailDemo`)
4. Choose **Restricted Access** and enable only **Mail Send → Full Access**
5. Click **Create & View**
6. **Copy the API key immediately** — it won't be shown again
7. Store it securely (you'll paste it into `Web.config`)

### Step 3 — Verify Sender Identity

SendGrid requires sender verification before you can send emails.

**Option A — Single Sender Verification (easiest for testing)**

1. Go to **Settings → Sender Authentication**
2. Click **Verify a Single Sender**
3. Fill in your sender details (name, email, company, address)
4. Click **Create**
5. Check your email inbox and click the verification link
6. Use this verified email as the `DefaultFromEmail` in `Web.config`

**Option B — Domain Authentication (recommended for production)**

1. Go to **Settings → Sender Authentication → Domain Authentication**
2. Follow the wizard to add DNS records (CNAME) to your domain
3. Once verified, any email address at your domain can be used as a sender

### Step 4 — Test Your Setup

After verifying your sender, you're ready to configure the project and send a test email.

---

## Visual Studio Setup Guide

### Option A — Open the Existing Solution (Recommended)

1. Open **Visual Studio**
2. Click **File → Open → Project/Solution**
3. Navigate to this folder and select `SendGridEmailDemo.sln`
4. Wait for Visual Studio to load the project

### Option B — Create a New Project from Scratch

1. Open Visual Studio → **Create a new project**
2. Search for **ASP.NET Web Application (.NET Framework)**
3. Select it and click **Next**
4. Name the project `SendGridEmailDemo`
5. Set the Framework to **.NET Framework 4.7.2** (or later)
6. Click **Create**
7. Choose the **Empty** template with **Web Forms** checked
8. Copy the source files from this repository into the project

---

## NuGet Package Installation

### Using Package Manager Console

Open **Tools → NuGet Package Manager → Package Manager Console** and run:

```powershell
Install-Package SendGrid
```

This automatically installs SendGrid and all its dependencies (Newtonsoft.Json, etc.).

### Using NuGet Package Manager UI

1. Right-click the project in **Solution Explorer**
2. Click **Manage NuGet Packages...**
3. Go to the **Browse** tab
4. Search for **SendGrid**
5. Select the **SendGrid** package by Twilio
6. Click **Install**

### Restoring Existing Packages

If you cloned this repository and the `packages` folder is missing:

1. Right-click the solution in **Solution Explorer**
2. Click **Restore NuGet Packages**

Or run in Package Manager Console:

```powershell
Update-Package -Reinstall
```

---

## Configuration

Open `SendGridEmailDemo/Web.config` and update the `<appSettings>` section:

```xml
<appSettings>
  <add key="SendGridApiKey" value="SG.xxxxxxxxxxxxxxxxxxxx" />
  <add key="DefaultFromEmail" value="your-verified-email@yourdomain.com" />
  <add key="DefaultFromName" value="Your App Name" />
</appSettings>
```

| Key                | Description                                             |
| ------------------ | ------------------------------------------------------- |
| `SendGridApiKey`   | Your SendGrid API key (starts with `SG.`)               |
| `DefaultFromEmail` | The verified sender email address                       |
| `DefaultFromName`  | Display name that appears in the "From" field of emails |

---

## Running the Project

1. Press **F5** (or **Ctrl+F5** for without debugging) in Visual Studio
2. The browser will open `Default.aspx` with the email form
3. Fill in the fields and click **Send Email**
4. Check the recipient's inbox (including spam/junk folder for first sends)

---

## HTML Email Example (Bonus)

The `EmailService` includes a method for sending styled HTML emails to multiple recipients.

### Usage in Code-Behind

```csharp
var emailService = new EmailService();

string htmlBody = @"
<html>
<body style='font-family: Arial, sans-serif; padding: 20px;'>
    <div style='max-width: 600px; margin: 0 auto; background: #ffffff;
                border: 1px solid #e0e0e0; border-radius: 8px; padding: 30px;'>
        <h2 style='color: #333;'>Welcome to Our Service!</h2>
        <p style='color: #555; line-height: 1.6;'>
            Thank you for signing up. We're excited to have you on board.
        </p>
        <a href='https://example.com/verify'
           style='display: inline-block; background: #667eea; color: #fff;
                  padding: 12px 24px; text-decoration: none; border-radius: 6px;
                  margin-top: 15px;'>
            Verify Your Account
        </a>
        <hr style='border: none; border-top: 1px solid #eee; margin: 25px 0;' />
        <p style='color: #999; font-size: 12px;'>
            If you didn't create an account, you can safely ignore this email.
        </p>
    </div>
</body>
</html>";

var recipients = new List<string>
{
    "user1@example.com",
    "user2@example.com"
};

EmailResult result = await emailService.SendHtmlEmailToMultipleRecipientsAsync(
    fromEmail: "noreply@yourdomain.com",
    fromName: "Your App",
    toEmails: recipients,
    subject: "Welcome to Our Service!",
    htmlContent: htmlBody,
    plainTextFallback: "Thank you for signing up. Visit https://example.com/verify to verify."
);
```

---

## Common Errors and Fixes

### 401 Unauthorized

**Cause:** Invalid or missing API key.

**Fix:**
- Verify the API key in `Web.config` starts with `SG.`
- Confirm the key has **Mail Send** permissions in the SendGrid dashboard
- Regenerate the key if it may have been revoked

### 403 Forbidden — Sender Identity Not Verified

**Cause:** The "From" email address is not verified in SendGrid.

**Fix:**
- Go to SendGrid **Settings → Sender Authentication**
- Verify the sender email address used in the "From Email" field
- Ensure the verified email matches exactly (case-sensitive domain)

### 403 Forbidden — Account Under Review

**Cause:** New SendGrid accounts may be placed under review.

**Fix:**
- Check your email for messages from SendGrid about account review
- Contact SendGrid support to expedite the review
- Complete any additional verification steps they require

### 400 Bad Request

**Cause:** Malformed request data.

**Fix:**
- Ensure all email addresses are in valid format
- Check that the subject and body are not empty
- Verify there are no special characters causing issues

### Network / Timeout Errors

**Cause:** Firewall or proxy blocking outbound HTTPS requests.

**Fix:**
- Ensure your server can reach `api.sendgrid.com` on port 443
- Configure proxy settings in `Web.config` if behind a corporate proxy
- Check firewall rules for outbound HTTPS traffic

### System.InvalidOperationException: SendGrid API key is not configured

**Cause:** The `SendGridApiKey` value in `Web.config` is missing or still set to the placeholder.

**Fix:**
- Open `Web.config` and replace `YOUR_SENDGRID_API_KEY` with your actual API key

---

## Production Best Practices

### Security

- **Never hardcode API keys** in source code. Use `Web.config` with config transforms,
  environment variables, or Azure Key Vault.
- Add `Web.config` to `.gitignore` (or use `Web.config` transforms with a
  `Web.Release.config` that reads from environment variables).
- Use **Restricted Access** API keys with only the permissions your app needs.

### Configuration Management

```xml
<!-- Web.Release.config transform example -->
<appSettings>
  <add key="SendGridApiKey"
       value="${SENDGRID_API_KEY}"
       xdt:Transform="SetAttributes" xdt:Locator="Match(key)" />
</appSettings>
```

### Logging

- Use a structured logging framework (Serilog, NLog, or log4net).
- Log email send attempts, successes, and failures with correlation IDs.
- Never log full API keys — mask them (e.g., `SG.****...xxxx`).

### Retry Strategy

```csharp
// Simple retry pattern for transient failures
int maxRetries = 3;
for (int attempt = 1; attempt <= maxRetries; attempt++)
{
    EmailResult result = await emailService.SendEmailAsync(request);
    if (result.IsSuccess || result.StatusCode == 400)
    {
        break; // Don't retry client errors
    }

    if (attempt < maxRetries)
    {
        await Task.Delay(TimeSpan.FromSeconds(Math.Pow(2, attempt)));
    }
}
```

Consider using the [Polly](https://github.com/App-vNext/Polly) library for production-grade retry/circuit-breaker patterns.

### Rate Limiting

- SendGrid free tier allows 100 emails/day.
- Implement queuing for bulk sends (database queue or message queue like RabbitMQ).
- Respect SendGrid rate limits (check response headers for `X-RateLimit-*`).

### Email Deliverability

- Always include both HTML and plain-text versions of emails.
- Set up SPF, DKIM, and DMARC DNS records for your sending domain.
- Use Domain Authentication in SendGrid for better deliverability.
- Monitor your sender reputation in the SendGrid dashboard.

### HTML Email Best Practices

- Use inline CSS styles (many email clients strip `<style>` blocks).
- Keep email width under 600px for mobile compatibility.
- Always include a plain-text fallback.
- Test with tools like [Litmus](https://litmus.com) or [Email on Acid](https://emailonacid.com).

---

## Architecture Notes

| Layer          | File                        | Responsibility                           |
| -------------- | --------------------------- | ---------------------------------------- |
| **UI**         | `Default.aspx`              | Form layout, validation controls, styles |
| **Code-Behind**| `Default.aspx.cs`           | Event handling, input binding, UX flow   |
| **Service**    | `Services/EmailService.cs`  | SendGrid API communication, error mgmt  |
| **Models**     | `Models/EmailRequest.cs`    | Email data transfer object               |
| **Models**     | `Models/EmailResult.cs`     | Operation result encapsulation           |
| **Config**     | `Web.config`                | API keys, sender defaults                |

The service layer is intentionally decoupled from the UI so it can be reused across multiple pages, scheduled jobs, or API controllers without modification.
