import 'package:flutter/material.dart';



import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:session1_new/auth/presentation/Holder.dart';
import 'package:session1_new/auth/presentation/forgotpass.dart';
import 'package:session1_new/auth/presentation/signup.dart';
import 'package:session1_new/auth/widgets/customtextfield.dart';
import 'package:session1_new/home/presentation/main.dart';
import 'package:session1_new/main.dart';

import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:url_launcher/url_launcher.dart';


class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}


class _LogInState extends State<LogIn> {
  @override
  void initState() {}
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
                  'Добро пожаловать',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  'Заполните почту и пароль чтобы продолжить',
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
                        ctr: email)),
                SizedBox(
                  height: 24,
                ),
                SizedBox(
                    height: 72,
                    width: MediaQuery.of(context).size.width - 48,
                    child: CustomTextField( onChanged: (te){setState(() {});},
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
                SizedBox(
                  height: 37,
                ),
                Row(
                  children: [
                    SizedBox(
                      height: 14,
                      width: 14,
                      child: Checkbox(
                          value: check,
                          onChanged: (val) {
                            setState(() {
                              check = val!;
                            });
                          }),
                    ),
                    SizedBox(
                      width: 11,
                    ),Text(
                      'Запомнить меня',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: Color(0xFFA7A7A7)),
                    ), SizedBox(width: 70,),

                    GestureDetector( onTap: (){
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => ForgotPass()));

                    },
                      child: Text(
                        'Забыли пароль?',
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: Color(0xFF7576D6)),
                      ),
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.start,
                ),
                Spacer(),
                SizedBox(
                  height: 46,
                  width: MediaQuery.of(context).size.width - 48,
                  child: FilledButton(
                    onPressed: (!isValid()) ? null : () async {
                      try{
                        var res = await supabase.auth.signInWithPassword(password: pass.text, email: email.text );
                        if(res != null){user = res.user;
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => Home()));
                        }
                        } on AuthException catch(e){
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message)));
                      }
                    },
                    child: Text('Войти'),
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
                        'У меня нет аккаунта! ',
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: Color(0xFFA7A7A7)),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => SignUp()));
                        },
                        child: Text(
                          'Создать',
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
                SizedBox(height: 18,),

                SizedBox(height: 28,)
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


