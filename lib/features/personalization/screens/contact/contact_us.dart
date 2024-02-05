import 'package:flutter/material.dart';

class ContactScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact Information'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          ContactCard(
            title: 'MediShield Head Office',
            phone: '+44-783241995',
            email: 'info@medishieldhealthcare.uk',
            address:
                '71-75 Shelton Street, Covent Garden, London, United Kingdom, WC2H 9JQ',
          ),
          SizedBox(height: 16.0),
          ContactCard(
            title: 'MediShield India Office',
            phone: '+91-522-4236262',
            email: 'medishielddental@gmail.com',
            address: '9 B.N Road, Lalbagh, Lucknow, India',
          ),
          SizedBox(height: 16.0),
          ContactCard(
            title: 'MediShield Factory',
            address:
                'A-65/2 Government Industrial Estate, Talkatora, Lucknow, India – 226011',
          ),
        ],
      ),
    );
  }
}

class ContactCard extends StatelessWidget {
  final String title;
  final String? phone;
  final String? email;
  final String address;

  ContactCard({
    required this.title,
    this.phone,
    this.email,
    required this.address,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            if (phone != null) ...[
              Text('Phone: $phone'),
              SizedBox(height: 8.0),
            ],
            if (email != null) ...[
              Text('Email: $email'),
              SizedBox(height: 8.0),
            ],
            Text('Address: $address'),
          ],
        ),
      ),
    );
  }
}
