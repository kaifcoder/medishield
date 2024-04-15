import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Us'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(8),
        child: Html(
          data: """
      <!DOCTYPE html>
      <html lang="en">
      <head>
          <meta charset="UTF-8">
          <meta name="viewport" content="width=device-width, initial-scale=1.0">
          <title>About Us</title>
      </head>
      <body>
          <h1>About MediShield HealthCare</h1>
          <p>MediShield HealthCare, founded in the year 2001, specializes in supplying new age Disposable products to Hospitals, clinics, laboratories, Dental Clinics, Dental Laboratories, Medical and Dental Institutions, & Government agencies, business groups, all over the world.</p>
          
          <h2>Our Mission</h2>
          <p>At MediShield, we promise a safer life. Dr. Hasan Faraz initiated the MediShield initiative at the age of 24 with just a capital of 75k, driven by the negligence in safety and hygiene by doctors. Despite facing challenges as a Bachelor of Dental Surgery, the encouragement from his mother, a blood cancer patient, fueled his determination. Today, MediShield has a turnover of 10Cr+.</p>
      
          <h2>Wide Range of Products</h2>
          <p>MediShield incorporates the philosophy of "Quest for Excellence," ensuring customers receive high-quality products backed by excellent service. We believe in cost-effectiveness through effective operations, timely deliveries, and prompt correspondence, prioritizing 100% customer satisfaction. Our products meet world-class requirements, offering a wide range of dental and surgical products, including but not limited to:</p>
          <ul>
          <li>Latex Examination Gloves</li>
          <li>Latex Surgical Gloves</li>
          <li>Nitrile Gloves</li>
          <li>Plastic Gloves</li>
          <li>Face mask</li>
          <li>Blood Lancet</li>
          <li>Alcohol Swabs</li>
          <li>Head Cap [Surgeons Cap / Buffont Cap]</li>
          <li>Shoe Cover</li>
          <li>Disposable Aprons</li>
          <li>H.I.V Kit</li>
          <li>O.T Kit</li>
          </ul>
      
          <h2>Certified Products</h2>
          <p>MediShield Healthcare is committed to delivering unparalleled innovation and quality in disposable Healthcare Products. We provide a wide variety of healthcare range types, sizes, colors, and characteristics to best suit our customers' needs.</p>
      
          <h2>Contact Us</h2>
          <p>If you have any inquiries or would like to learn more about MediShield HealthCare, please don't hesitate to contact us:</p>
          <address>
          MediShield Healthcare Pvt. Ltd. <br>
          Address: 9 B.N Road, Lalbagh, Lucknow, India <br>
          Phone: +91-522-4236262 <br>
          Email: eximlko@gmail.com
          </address>
      </body>
      </html>
      
      """,
        ),
      ),
    );
  }
}
