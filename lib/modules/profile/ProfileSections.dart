import 'package:flutter/material.dart';

class ProfileSections extends StatelessWidget {
  String title;
  String details;
  IconData icon;
  final VoidCallback? onEdit;
  final VoidCallback? onIconTap;
  final IconData? iconToShow;

  ProfileSections({required this.title,  required this.details, required this.icon,this.onEdit,this.iconToShow,this.onIconTap});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.00,vertical: 5.00),
        child: Row(
          children: [
            Icon(icon, color: Color(0xff224820), size: 20,),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("$title", style: TextStyle(color: Color(0xff224820), fontSize: 18),),
                  Text("$details", style: TextStyle(color: Colors.grey, fontSize: 18),),
                  
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}