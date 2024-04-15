import 'package:flutter/material.dart';
import 'package:medishield/common/widgets/appbar/appbar.dart';

class Tnc extends StatelessWidget {
  const Tnc({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(
        title: Text(
          '',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        showBackArrow: true,
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Terms And Conditions',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              'Acceptance of these terms of use',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 5.0),
            Text(
              'Use of the App is subject to the following Terms of Use. By navigating within the Site, or clicking on any object on the Site, you are agreeing to these Terms of Use. We reserve the right to update the Terms of Use at any time as the need arises without any notice to you. You can review the Terms of Use at any time by clicking on the “Terms and conditions” link at the bottom of this Login Screen.',
              style: TextStyle(fontSize: 14.0),
            ),
            SizedBox(height: 20.0),
            Text(
              'Terms of Service, Notices, and Revisions',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 5.0),
            Text(
              'If you choose to visit Medishield Healthcare, your visit and any dispute over privacy are subject to this Notice and our Conditions of Use, including limitations on damages, arbitration of disputes. If you have any concerns about privacy at Medishield Healthcare, please send us a thorough description to eximlko@gmail.com and we will try to resolve it. Our business changes constantly. This Notice and the Conditions of Use will change also, and the use of information that we gather now is subject to the Privacy Policy in effect at the time of use. You should check our website frequently to see recent changes.',
              style: TextStyle(fontSize: 14.0),
            ),
            SizedBox(height: 20.0),
            // Add more Text widgets for the remaining terms and conditions
            Text(
              'Phone calls',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 5.0),
            Text(
              'When you are in contact with Medishield Healthcare by phone, the call may be monitored or recorded for quality assurances purposes. Your continued participation in any telephone conversation serves as express consent to be monitored or recorded.\n\n For the inbound leads via any source, Medishield Healthcare can contact them through emails, newsletters, promotional messages, etc.',
              style: TextStyle(fontSize: 14.0),
            ),
            SizedBox(height: 20.0),
            Text(
              'Copyright and trademarks',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 5.0),
            Text(
              'The content included on the Medishield App  – including all text, images, videos, and other media, as well as the design and styling of all content – are exclusively owned by Medishield Healthcare or by third parties who have given their permission for use by Medishield Healthcare Copyright by Medishield Healthcare or such third parties of all such content is explicit by its appearance on the Medishield App.',
              style: TextStyle(fontSize: 14.0),
            ),
            SizedBox(height: 20.0),
            Text(
              'Restricted use',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 5.0),
            Text(
              'Visitors to this website may not copy, distribute, screen shot, reproduce, sell or publish any of the copyrighted material downloaded or copied from this website. For the avoidance of doubt, no permission is given for the transfer of any of this material to an open internet site. For permission, please contact eximlko@gmail.com. Medishield Healthcare monitors the web closely for violations of our use policy. Design Trademarks or stylized versions of Trademarks are not permitted for use except by written permission from Medishield Healthcare.',
              style: TextStyle(fontSize: 14.0),
            ),
            SizedBox(height: 20.0),
            Text(
              'Reporting violations',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 5.0),
            Text(
              'If you become aware of any violations of Copyrights, Trademarks, or other Intellectual Property in connection with the Site, whether owned by the Site Owners or Third Parties, please contact us at\n\n\nAddress: 9 B.N Road, Lalbagh, Lucknow, India\nIndia: +91-522-4236262',
              style: TextStyle(fontSize: 14.0),
            ),
            SizedBox(height: 20.0),
            // You can use the same structure as above
          ],
        ),
      ),
    );
  }
}
