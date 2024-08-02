import 'package:flutter/material.dart';




class privacy extends StatelessWidget {
  const privacy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade800,
        title: Text('Privacy Policy'),
        centerTitle: true,
        automaticallyImplyLeading: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.green.shade50,
              Colors.white,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 15.0,
              ),
              Center(

                child: Text(
                  "Privacy Policy for a Mobile Application\n"

                    "This Privacy Policy explains how we collect, use, and disclose information from users of our mobile application (SPROUT). By using the App, you agree to the terms of this Privacy Policy.\n"

                "Information Collected\n"

                  "We collect certain information from you when you use our App. This information may include:\n"

                "Personal information such as your name, email address, and phone number, which you may provide to us when you register an account or contact us for support.\n"

                "Device information such as your device type, operating system, and unique device identifier (UDID) to maintain and improve our App's performance and functionality.\n"

      "Usage information such as your App activity, including the pages you visit and the features you use, to understand how you use the App and improve our services.\n"

                "Location information if you give us permission to access your device's location services. We may use this information to provide you with location-based services and to improve our App's functionality.\n"

      "Use of Information\n"

                "We use the information we collect to provide and improve the App's functionality and services. Specifically, we may use your information to:\n"

      "Provide you with the services you request, such as registering an account or processing payments.\n"

      "Communicate with you about the App, such as sending you notifications and updates.\n"

      "Personalize your experience with the App and improve our services based on your usage patterns.\n"

                "Analyze usage trends and user behavior to improve our App's performance and functionality.\n"

      "Comply with legal and regulatory requirements.\n"

      "Sharing of Information\n"

                "We do not sell, rent or share your personal information with third parties except as necessary to provide you with the services you request or as required by law. However, we may share anonymized and aggregated usage data with third parties for analytical and research purposes.\n"

      "Data Security\n"

      "We take reasonable measures to protect the personal information we collect from you against unauthorized access, disclosure, alteration, or destruction. However, no method of transmission over the internet or electronic storage is completely secure, and we cannot guarantee the security of your information.\n"

      "Changes to this Policy\n"

      "We may update this Privacy Policy from time to time. If we make any material changes, we will notify you by email or through the App's notification system. Your continued use of the App after any changes to this Privacy Policy will constitute your acceptance of such changes.\n"

                "Contact Us\n"

                "If you have any questions or concerns about this Privacy Policy, please contact us \n",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
