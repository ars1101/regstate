import 'package:flutter/material.dart';



import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:session1_new/auth/presentation/Holder.dart';
import 'package:session1_new/auth/presentation/login.dart';
import 'package:session1_new/auth/presentation/signup.dart';
import 'package:session1_new/auth/repository/supawidgets.dart';
import 'package:session1_new/auth/widgets/customtextfield.dart';
import 'package:session1_new/main.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:url_launcher/url_launcher.dart';


class ForgotPass extends StatefulWidget {
  const ForgotPass({super.key});

  @override
  State<ForgotPass> createState() => _ForgotPassState();
}
TextEditingController emaile = TextEditingController();

class _ForgotPassState extends State<ForgotPass> {
  @override
  void initState() { }

  Uri pdf = Uri.parse(
      'https://lwtgrvmdvlhofehpmgtb.supabase.co/storage/v1/object/public/policy/rud%20(1).pdf?t=2024-02-13T19%3A55%3A19.306Z');

  bool obs = true;
  bool check = false;

  bool isValid() {
    if (EmailValidator.validate(emaile.text)) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFAF0),
      body: SingleChildScrollView(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: 24,
            ),
            Column(
              children: [
                SizedBox(
                  height: 78,
                ),
                Text(
                  'Восстановление пароля',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  'Введите свою почту',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                SizedBox(
                  height: 33,
                ),

                SizedBox(
                    height: 72,
                    width: MediaQuery.of(context).size.width - 48,
                    child: CustomTextField( onChanged: (te){setState(() {});},
                        label: 'Почта',
                        hint: '***********@mail.com',
                        obs: false,
                        ctr: emaile)),
                SizedBox(
                  height: 56,
                ),
                SizedBox(
                  height: 46,
                  width: MediaQuery.of(context).size.width - 48,
                  child: FilledButton(
                    onPressed: (!isValid()) ? null : () async {try{
                      await sendOtp(emaile.text,);
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => Holder()));
                    } on AuthException catch(e){
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message)));
                    }
                    },
                    child: Text('Send OTP'),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(width: MediaQuery.of(context).size.width - 48,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Remember password? Back to ',
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: Color(0xFFA7A7A7)),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => LogIn()));
                        },
                        child: Text(
                          'Sign In',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: Color(0xFF0560FA)),
                        ),
                      )
                    ],
                  ),

                ),
                SizedBox(height: 28,)
              ],
              crossAxisAlignment: CrossAxisAlignment.start,
            ),
            SizedBox(
              width: 24,
            )
          ],
        ),
      ),
    );
  }
}
