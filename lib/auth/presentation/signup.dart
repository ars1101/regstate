import 'package:flutter/material.dart';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:session1_new/auth/presentation/Holder.dart';
import 'package:session1_new/auth/presentation/login.dart';
import 'package:session1_new/auth/widgets/customtextfield.dart';
import 'package:session1_new/home/presentation/setupprofile.dart';
import 'package:session1_new/main.dart';

import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  void initState() {}
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController passc = TextEditingController();
  bool obs = true;
  bool check = false;

  bool isValid() {
    if (EmailValidator.validate(email.text) &
        (email.text.length > 0) &
        (pass.text.length >= 6) &
        (pass.text == passc.text)
    ) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFAF0),
      body: Row(
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
                'Создать аккаунт',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                'Завершите регистрацию чтобы начать',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              SizedBox(
                height: 33,
              ),
              SizedBox(
                  height: 72,
                  width: MediaQuery.of(context).size.width - 48,
                  child: CustomTextField(
                      onChanged: (te) {
                        setState(() {});
                      },
                      label: 'Почта',
                      hint: '***********@mail.com',
                      obs: false,
                      ctr: email)),
              SizedBox(
                height: 24,
              ),
              SizedBox(
                  height: 72,
                  width: MediaQuery.of(context).size.width - 48,
                  child: CustomTextField(
                      onChanged: (te) {
                        setState(() {});
                      },
                      label: 'Пароль',
                      hint: '**********',
                      obs: obs,
                      ctr: pass,
                      onTapSuffix: () {
                        setState(() {
                          if (obs == true) {
                            obs = false;
                          } else {
                            obs = true;
                          }
                        });
                      })),
              SizedBox(height: 24,),
              SizedBox(
                  height: 72,
                  width: MediaQuery.of(context).size.width - 48,
                  child: CustomTextField(
                      onChanged: (te) {
                        setState(() {});
                      },
                      label: 'Повторите пароль',
                      hint: '**********',
                      obs: obs,
                      ctr: passc,
                      onTapSuffix: () {
                        setState(() {
                          if (obs == true) {
                            obs = false;
                          } else {
                            obs = true;
                          }
                        });
                      })),
              SizedBox(
                height: 37,
              ),
              Spacer(),
              SizedBox(
                height: 46,
                width: MediaQuery.of(context).size.width - 48,
                child: FilledButton(
                  onPressed: (!isValid())
                      ? null
                      : () async {
                          try {
                            var res = await supabase.auth.signUp(
                                password: pass.text, email: email.text);
                            if (res != null) {
                              user = res.user;
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => SetupProfile()));
                            }
                          } on AuthException catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(e.message)));
                          }
                        },
                  child: Text('Зарегистрироваться'),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width - 48,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'У меня уже есть аккаунт! ',
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
                        'Войти',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: Color(0xFF7576D6),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 18,
              ),
              SizedBox(
                height: 28,
              )
            ],
            crossAxisAlignment: CrossAxisAlignment.start,
          ),
          SizedBox(
            width: 24,
          )
        ],
      ),
    );
  }
}
