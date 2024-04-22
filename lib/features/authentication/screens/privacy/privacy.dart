import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class Privacy extends StatelessWidget {
  const Privacy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy Policy'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Html(data: """
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Privacy Notice</title>
</head>
<body>
    <h1>Privacy Notice</h1>
    <p>Welcome to Medishield, provided by MEDI SHIELD HEALTH CARE. At Medishield, we understand the importance of your privacy and are committed to safeguarding your personal information. This Privacy Notice outlines how we collect, use, and protect your information through our mobile application.</p>
    
    <h2>Information Collection</h2>
    <p>We collect personal information to enhance your experience with Medishield and to improve our services. This information may include:</p>
    <ol>
        <li>Information You Provide: We may collect information you voluntarily provide while using Medishield, such as your name, contact details, and medical history.</li>
        <li>Automatic Information: We automatically collect certain information about your usage of the Medishield application, including device information, IP address, and usage patterns. This helps us optimize our services and improve user experience.</li>
        <li>Information from Third Parties: We may receive information about you from third-party sources, such as healthcare providers or medical records, to ensure the accuracy and relevance of the information we hold.</li>
    </ol>

    <h2>Use of Information</h2>
    <p>We use the collected information for various purposes, including:</p>
    <ul>
        <li>Providing and personalizing our services to meet your healthcare needs.</li>
        <li>Analyzing usage data to improve the performance and usability of the Medishield application.</li>
        <li>Communicating with you about updates, promotions, and important notices related to our services.</li>
        <li>Conducting research and analysis to enhance our understanding of healthcare trends and user preferences.</li>
    </ul>

    <h2>Information Sharing</h2>
    <p>We are committed to protecting your privacy and do not sell your personal information to third parties. However, we may share your information under certain circumstances, including:</p>
    <ul>
        <li>With service providers: We may share your information with trusted third-party service providers who assist us in delivering our services, such as hosting providers, analytics platforms, and customer support services.</li>
        <li>For legal compliance: We may disclose your information if required by law or to protect our legal rights, property, or safety, or that of others.</li>
    </ul>

    <h2>Data Retention</h2>
    <p>We retain your personal information only for as long as necessary to fulfill the purposes outlined in this Privacy Notice, unless a longer retention period is required or permitted by law.</p>

    <h2>Your Rights</h2>
    <p>You have the right to access, correct, or delete your personal information held by Medishield. You can also object to the processing of your data or request data portability. To exercise these rights, please contact us using the information provided below.</p>

    <h2>Contact Us</h2>
    <p>If you have any questions, concerns, or requests regarding our Privacy Notice or the handling of your personal information, please contact us at:</p>
    <address>
        MEDI SHIELD HEALTH CARE <br>
        Address: 9 B.N Road, Lalbagh, Lucknow, India <br>
        Phone: +91-522-4236262 <br>
        Email: eximlko@gmail.com
    </address>

    <p>We may update this Privacy Notice from time to time to reflect changes in our practices or applicable laws. We encourage you to review this notice periodically for any updates.</p>
</body>
</html>

"""),
          ],
        ),
      ),
    );
  }
}
