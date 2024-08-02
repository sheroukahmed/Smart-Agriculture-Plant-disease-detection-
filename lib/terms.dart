import 'package:flutter/material.dart';




class terms extends StatelessWidget {
  const terms({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade800,
        title: Text('Terms of Service'),
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
                    "Welcome to our mobile application (Sprout). These Terms of Service govern your use of the App and any services or content provided through the App. By using the App, you agree to these Terms. If you do not agree to these Terms, you may not use the App.\n"

        "1. License to Use the App\n"
            "We grant you a limited, non-exclusive, non-transferable, revocable license to use the App for your personal, non-commercial use only. You may not use the App for any other purpose without our prior written consent.\n"

        "2. User Content\n"
            "You may be able to post, upload, or submit content to the App, including comments, reviews, and other information (User Content). By submitting User Content, you represent and warrant that you have the right to submit such content and that it does not violate any third-party rights or applicable laws. We reserve the right to remove any User Content that we believe violates these Terms or is inappropriate in any way.\n"

      "3. User Conduct\n"
      "You agree to use the App only for lawful purposes and in accordance with these Terms. You may not:\n"

      "- Use the App in any way that violates any applicable federal, state, local, or international law or regulation.\n"

      "- Use the App to transmit, or procure the sending of, any advertising or promotional material, including any junk mail, chain letter, spam, or any other similar solicitation.\n"

      "- Impersonate or attempt to impersonate us, our employees, another user, or any other person or entity.\n"

      "4. Intellectual Property Rights\n"
          "The App and its entire contents, features, and functionality (including but not limited to all information, software, text, displays, images, video, and audio, and the design, selection, and arrangement thereof) are owned by us or our licensors and are protected by United States and international copyright, trademark, patent, trade secret, and other intellectual property or proprietary rights laws.\n"

    "5. Disclaimer of Warranties\n"
    "The App is provided as is and without warranty of any kind, whether express or implied, including but not limited to the implied warranties of merchantability, fitness for a particular purpose, and non-infringement. We do not warrant that the App will meet your requirements, that the operation of the App will be uninterrupted or error-free, or that defects in the App will be corrected.\n"

    "6. Limitation of Liability\n"
    "In no event shall we be liable for any direct, indirect, incidental, special, consequential, or exemplary damages (including but not limited to procurement of substitute goods or services; loss of use, data, or profits; or business interruption) arising out of or in connection with your use or inability to use the App, even if we have been advised of the possibility of such damages.\n"

    "7. Indemnification\n"
    "You agree to indemnify, defend, and hold harmless us, our affiliates, and our respective officers, directors, employees, agents, and licensors from and against any and all claims, liabilities, damages, losses, costs, expenses, or fees (including reasonable attorneys' fees) arising from your use of the App or your violation of these Terms.\n"

    "8. Governing Law\n"
    "These Terms shall be governed by and construed in accordance with the laws of the state of [insert state] without giving effect to any principles of conflicts of law.\n"

    "9. Modification of Terms\n"
    "We reserve the right to modify these Terms at any time. Any such modifications will become effective immediately upon posting on the App. Your continued use of the App after any modifications to these Terms constitutes your acceptance of such modifications.\n"

    "10. Termination\n"
    "We may terminate these Terms and your access to the App at any time, with or without cause, without notice to you.\n"

    "11. Entire Agreement\n"
    "These Terms constitute the entire agreement between you and us with respect to the App, and supersede all prior or contemporaneous communications and proposals, whether oral or written, between you and us.\n"

    "If you have any questions about these Terms, please contact us at [insert contact information].",
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
