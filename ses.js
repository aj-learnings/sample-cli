const nodemailer = require("nodemailer");
const { defaultProvider } = require("@aws-sdk/credential-provider-node");
const { SESClient } = require("@aws-sdk/client-ses");

async function main() {
  const creds = defaultProvider(); // automatically uses EC2 IAM role
  const ses = new SESClient({ region: "us-east-1", credentials: creds });

  let transporter = nodemailer.createTransport({
    SES: { ses, aws: { SendRawEmailCommand: require("@aws-sdk/client-ses").SendRawEmailCommand } }
  });

  let info = await transporter.sendMail({
    from: "verified-sender@example.com",
    to: "verified-recipient@example.com",
    subject: "Test via Nodemailer + IAM role",
    text: "This email is sent using Nodemailer with EC2 IAM role credentials (no access keys hardcoded)."
  });

  console.log("✅ Email sent:", info.messageId);
}

main().catch(console.error);
