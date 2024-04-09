import 'package:flutter/material.dart';



import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:session1_new/auth/widgets/customtextfield.dart';

import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:url_launcher/url_launcher.dart';


class Holder extends StatefulWidget {
  const Holder({super.key});

  @override
  State<Holder> createState() => _HolderState();
}


class _HolderState extends State<Holder> {
  @override
  void initState() {}
  Uri pdf = Uri.parse(
      'https://lwtgrvmdvlhofehpmgtb.supabase.co/storage/v1/object/public/policy/rud%20(1).pdf?t=2024-02-13T19%3A55%3A19.306Z');
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  bool obs = true;
  bool check = false;

  bool isValid() {
    if (EmailValidator.validate(email.text) &
    (email.text.length > 0) &
    (pass.text.length >= 6)) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(),
    );
  }
}


