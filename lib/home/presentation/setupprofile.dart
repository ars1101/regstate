import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:session1_new/auth/presentation/Holder.dart';
import 'package:session1_new/auth/presentation/login.dart';
import 'package:session1_new/auth/widgets/customtextfield.dart';
import 'package:session1_new/home/presentation/chooseplatform.dart';
import 'package:session1_new/home/presentation/main.dart';
import 'package:session1_new/home/repository/supabase.dart';
import 'package:session1_new/main.dart';
import 'dart:typed_data';
import 'package:dia/dia.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:image_picker/image_picker.dart';

class SetupProfile extends StatefulWidget {
  const SetupProfile({super.key});

  @override
  State<SetupProfile> createState() => _SetupProfileState();
}

Map<String, dynamic> data = {'fullname': ''};
List<Map<String, dynamic>> platforms = [];
List plchan = [];

class _SetupProfileState extends State<SetupProfile> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPlatforms().then((value) => setState(() {
          allplatforms = value;
          setState(() {});
        }));
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {

      await supabase.auth.updateUser(UserAttributes(data: {
        "avatar":
            "https://tkrermffmfyblqfqzhlt.supabase.co/storage/v1/object/public/avatars/profpic.png"
      }));
      data = await supabase.auth.currentUser!.userMetadata!;
      print(data);
      setState(() {

      });
    });
  }

  bool isplat = false;
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController passc = TextEditingController();
  final ImagePicker picker = ImagePicker();

  String namee = '';
  String phonee = '';
  bool obs = true;
  bool check = false;
  String date = "Выберете дату рождения";
  XFile? avatar;
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
                        height: 73,
                      ),
                      Row(
                        children: [
                          Column(
                            children: [
                              Row(
                                children: [
                                  IconButton(
                                      onPressed: () async {
                                        avatar = await picker.pickImage(
                                            source: ImageSource.gallery);
                                        Uint8List bytes =
                                            await avatar!.readAsBytes();
                                        uploadAvatar(bytes,);
                                        data = supabase
                                            .auth.currentUser!.userMetadata!;
                                        setState(() {});
                                      },
                                      icon: Image.asset("assets/pic.png")),
                                  SizedBox(
                                    width: 40,
                                  ),
                                  SizedBox(width: 151, height: 151,
                                    child: ClipRRect(
                                    borderRadius: BorderRadius.circular(32),
                                    child: Center(child: Image.network(data['avatar'])
                                        ,
                                    ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 40,
                                  ),
                                  Image.asset('assets/theme.png'),
                                ],
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                              )
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 48,
                        height: 72,
                        child: CustomTextField(
                            label: "ФИО",
                            hint: "Введите ваше ФИО",
                            obs: false,
                            ctr: name,
                            onChanged: (t) {
                              setState(() {
                                namee = t;
                              });
                            }),
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 48,
                        height: 72,
                        child: CustomTextField(
                          label: "Телефон",
                          hint: "+7 (000) 000 00 00",
                          obs: false,
                          ctr: phone,
                          onChanged: (t) {
                            setState(() {
                              phonee = t;
                            });
                          },
                        ),
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      Text(
                        "Дата рождения",
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      GestureDetector(
                        onTap: () async {
                          await _selectDate();
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width - 48,
                          height: 44,
                          decoration: BoxDecoration(
                              color: Color(0xFFFFFAF0),
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(
                                  color: Color(0xFF5C636A), width: 1)),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    date,
                                    style: TextStyle(fontSize: 14),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 24,
                      )
                    ],
                  ),
                ],
              ),
            ),
            SliverToBoxAdapter(
              child: Row(
                children: [
                  SizedBox(
                    width: 24,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Источники новостей",
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width - 48,
                        height: 44 + (platforms.length * 91),
                        decoration: BoxDecoration(
                            color: Color(0xFFFFFAF0),
                            borderRadius: BorderRadius.circular(4),
                            border:
                                Border.all(color: Color(0xFF5C636A), width: 1)),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Выберите платформы",
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ],
                                ),
                                Spacer(),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      child: IconButton(
                                          onPressed: () async {
                                            Navigator.of(context)
                                                .push(MaterialPageRoute(
                                                    builder: (context) =>
                                                        ChoosePlat()))
                                                .then((value) => setState(() {
                                                      plchan.clear();
                                                      for (var i in platforms) {
                                                        plchan.add(
                                                            TextEditingController());
                                                      }
                                                    }));
                                          },
                                          icon: Icon(Icons.add)),
                                      height: 40,
                                      width: 40,
                                    ),
                                  ],
                                )
                              ],
                            ),
                            SizedBox(
                              child: ListView.builder(
                                itemBuilder: (_, index) {
                                  var plat = platforms[index];
                                  return Container(
                                    width:
                                        MediaQuery.of(context).size.width - 48,
                                    height: 91,
                                    decoration: BoxDecoration(
                                        color: Color(0xFFFFFAF0),
                                        border: Border.all(
                                            color: Color(0xFF5C636A),
                                            width: 1)),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            IconButton(
                                                onPressed: () {
                                                  platforms.remove(plat);
                                                  setState(() {});
                                                },
                                                icon: Image.asset(
                                                    'assets/cross.png')),
                                            SizedBox(
                                              width: 22,
                                            ),
                                            Image.network(
                                              plat['icon'],
                                              scale: 15,
                                            ),
                                            SizedBox(
                                              width: 8,
                                            ),
                                            Text(
                                              plat['title'],
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            Spacer(),
                                            IconButton(
                                                onPressed: () {},
                                                icon: Image.asset(
                                                    'assets/info.png')),
                                          ],
                                        ),
                                        SizedBox(
                                          child: TextField(
                                            controller: plchan[index],
                                          ),
                                          height: 25,
                                          width: 325,
                                        )
                                      ],
                                    ),
                                  );
                                },
                                itemCount: platforms.length,
                              ),
                              height: 91 * platforms.length.toDouble(),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      SizedBox(
                        height: 46,
                        width: MediaQuery.of(context).size.width - 48,
                        child: FilledButton(
                          onPressed: () {
                            for (int i = 0; i < platforms.length; i++) {
                              platforms[i]['chanels'] = plchan[i].text;
                            }
                            print(namee + phonee);
                            saveUserData(namee, phonee, date);
                            savePlatforms(platforms);
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => Home()));
                          },
                          child: Text('Продолжить'),
                        ),
                      ),
                      SizedBox(
                        height: 24,
                      )
                    ],
                  ),
                  SizedBox(
                    width: 24,
                  )
                ],
              ),
            )
          ],
        ));
  }

  Future<void> _selectDate() async {
    DateTime? _picked = await showDatePicker(
      context: context,
      firstDate: DateTime(1900),
      lastDate: DateTime(2025),
    );
    if (_picked != null) {
      setState(() {
        date = _picked.toString().split(' ')[0];
      });
    }
  }
}
