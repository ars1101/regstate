import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:session1_new/auth/presentation/Holder.dart';
import 'package:session1_new/auth/presentation/login.dart';
import 'package:session1_new/auth/widgets/customtextfield.dart';
import 'package:session1_new/home/presentation/chooseplatform.dart';
import 'package:session1_new/home/repository/supabase.dart';
import 'package:session1_new/main.dart';

import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool obs = true;
  bool check = false;
  int ind = 0;
  Map<String,dynamic> data = {};
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      data = supabase.auth.currentUser!.userMetadata!;
    });
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Row(
      children: [SizedBox(width: 24,),
        Column(children: [SizedBox(height: 73,),
        Row(
          children: [
            Image.asset("assets/profpic.png"),
          ],
        ),
        ],), SizedBox(width: 24,)
      ],
    ),);
  }
}
