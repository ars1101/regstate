import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:session1_new/auth/presentation/Holder.dart';
import 'package:session1_new/auth/presentation/login.dart';
import 'package:session1_new/auth/widgets/customtextfield.dart';
import 'package:session1_new/core/themes.dart';
import 'package:session1_new/home/presentation/chooseplatform.dart';
import 'package:session1_new/home/presentation/setupprofile2.dart';
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
  Map<String, dynamic> data = {'fullname': ''};

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      data = supabase.auth.currentUser!.userMetadata!;
      print(data);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          SizedBox(
            width: 24,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 73,
              ),
              Row(
                children: [
                  Image.asset("assets/profpic.png"),
                  SizedBox(
                    width: 24,
                  ),
                  SizedBox(
                    height: 121,
                    width: 168,
                    child: Text(
                      data['fullname'],
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                      ),
                      softWrap: true,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 28,
              ),
              Container(
                width: MediaQuery.of(context).size.width - 48,
                height: 1,
                color: sub_text,
              ),
              SizedBox(
                height: 25,
              ),
              Text(
                "История",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              SizedBox(
                height: 18,
              ),
              Text(
                'Прочитанные статьи',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              SizedBox(
                height: 18,
              ),
              Text(
                'Чёрный список',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              SizedBox(
                height: 24,
              ),
              Text(
                "Настройки",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              SizedBox(
                height: 18,
              ),
              GestureDetector( onTap: (){Navigator.of(context)
                  .push(MaterialPageRoute(
                  builder: (context) =>
                      SetupProfile2()));},
                child: Text(
                  'Редактирование профиля',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              SizedBox(
                height: 18,
              ),
              Text(
                'Политика конфиденциальности',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              SizedBox(
                height: 18,
              ),
              Text(
                'Оффлайн чтение',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              SizedBox(
                height: 18,
              ),
              Text(
                'О нас',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              SizedBox(
                height: 24,
              ),
              SizedBox(
                height: 46,
                width: MediaQuery.of(context).size.width - 48,
                child: OutlinedButton(
                    child: Text(
                      "Выход",
                      style: TextStyle(color: error, ),
                    ),
                    onPressed: () {
                      supabase.auth.signOut();
                      Navigator.of(context)
                          .push(MaterialPageRoute(
                          builder: (context) =>
                              LogIn()));
                    },  style: OutlinedButton.styleFrom(foregroundColor: error, shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(4)), )), ),
              )
            ],
          ),
          SizedBox(
            width: 24,
          )
        ],
      ),
    );
  }
}
