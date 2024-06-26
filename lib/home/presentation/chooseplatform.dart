import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:session1_new/auth/presentation/Holder.dart';
import 'package:session1_new/auth/presentation/login.dart';
import 'package:session1_new/auth/widgets/customtextfield.dart';
import 'package:session1_new/home/presentation/setupprofile.dart';
import 'package:session1_new/home/repository/supabase.dart';
import 'package:session1_new/main.dart';

import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

List allplatforms = [];

class ChoosePlat extends StatefulWidget {
  const ChoosePlat({super.key});

  @override
  State<ChoosePlat> createState() => _ChoosePlatState();
}

class _ChoosePlatState extends State<ChoosePlat> {
  @override
  void initState() {


  }

  bool isplat = false;
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController passc = TextEditingController();
  bool obs = true;
  bool check = false;
  String date = "Выберете дату рождения";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFFFFAF0),
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Row(
                children: [
                  SizedBox(
                    width: 24,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 67,
                      ),
                      Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              icon: Image.asset('assets/close.png')),
                          SizedBox(
                            width: 16,
                          ),
                          Text(
                            "Выберите платформу",
                            style: TextStyle(
                                color: Color(
                                  0xFF3A3A3A,
                                ),
                                fontSize: 22,
                                fontWeight: FontWeight.w500),
                          ),

                        ],
                      ),
                      SizedBox(
                        height: 22,
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 24,
                  )
                ],
              ),
            ),
            SliverList.builder(
              itemBuilder: (_, index) {
                bool isadded = false;
                var plat = allplatforms[index];
                return Column(
                  children: [
                    Row(
                      children: [SizedBox(width: 22,),
                        Image.network(
                          plat['icon'],
                          scale: 15,
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text(plat['title'], style: TextStyle(fontWeight: FontWeight.w500),),
                        Spacer(),
                        IconButton(
                            onPressed: (!platforms.contains(allplatforms[index]))
                                ? () {
                                    setState(() {
                                      isadded = true;
                                      platforms.add(plat);
                                      setState(() {
                                        print(platforms);
                                        print(platforms == allplatforms);
                                        print(allplatforms);
                                      });
                                    });
                                  }
                                : () {
                                    setState(() {
                                      isadded = false;
                                      platforms.remove(plat);
                                      setState(() {
                                      });
                                    });
                                  },
                            icon: Image.asset((platforms.contains(allplatforms[index]))
                                ? 'assets/ok.png'
                                : 'assets/plus.png')), IconButton(
                            onPressed: () {platforms.clear();},
                            icon: Image.asset((platforms.contains(allplatforms[index]))
                                ? 'assets/ok.png'
                                : 'assets/plus.png'))
                      
                      ],
                    )
                  ],
                );
              },
              itemCount: allplatforms.length,
            )
          ],
        ));
  }
}
