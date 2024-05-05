import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:session1_new/auth/presentation/Holder.dart';
import 'package:session1_new/auth/presentation/login.dart';
import 'package:session1_new/auth/widgets/customtextfield.dart';
import 'package:session1_new/home/presentation/article.dart';
import 'package:session1_new/home/presentation/chooseplatform.dart';
import 'package:session1_new/home/presentation/main.dart';
import 'package:session1_new/home/repository/supabase.dart';
import 'package:session1_new/main.dart';
import 'dart:typed_data';
import 'package:dia/dia.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:image_picker/image_picker.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

Map<String, dynamic> data = {'fullname': ''};
List<Map<String, dynamic>> platforms = [];
List plchan = [];
List<Map<String, dynamic>> news = [];
List<Map<String, dynamic>> snews = [];

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPlatforms().then((value) => setState(() {
          allplatforms = value;
          setState(() {});
        }));
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      snews = await getNews();
      data = supabase.auth.currentUser!.userMetadata!;
      List<String> p = [];
      for (var i in data['platforms']) {
        p.add(i['id']);
      }
      for (var i in snews) {
        if (p.contains(i['id_platform'])) {
          news.add(i);
          setState(() {});
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFFFFAF0),
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                children: [
                  SizedBox(
                    height: 63,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 24,
                      ),
                      Text(
                        "Лента новостей",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      Spacer(),
                      IconButton(
                          onPressed: () {},
                          icon: Image.asset('assets/shelf.png')),
                      SizedBox(
                        width: 24,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 18,
                  )
                ],
              ),
            ),
            SliverList.builder(
              itemBuilder: (_, index) {
                var a = news[index];
                Map<String, dynamic> plat = {};
                for (var i in allplatforms) {
                  if (i['id'] == a['id_platform']) {
                    plat = i;
                  }
                }
                print(a);
                return GestureDetector(onTap: (){Navigator.of(context)
                    .push(MaterialPageRoute(
                    builder: (context) =>
                        Article(b: a, plat: plat)));},
                  child: Row(
                    children: [
                      SizedBox(
                        width: 24,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                height: 30,
                                width: 30,
                                child: Image.network(plat['icon']),
                              ),
                              SizedBox(
                                width: 12,
                              ),
                              Column(crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    a['channel'] + ' | ' + plat['title'],
                                    style: Theme.of(context).textTheme.titleLarge,
                                  ),
                                  Text(a['published_at'])
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                child: Text(
                                  a['title'],
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                width: (a['type_media'] == "photo") ? 238 : 346,
                                height: 80,
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              (a['type_media'] == "photo")
                                  ? SizedBox(
                                      width: 100,
                                      height: 75,
                                      child: Image.network(a['media']),
                                    )
                                  : SizedBox()
                            ],
                          ),SizedBox(height: 12,),
                          SizedBox(
                            child: Text(
                              a['text'], softWrap: false, overflow: TextOverflow.ellipsis,
                              maxLines: 5,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            width: 346,
                            height: 112,
                          ), SizedBox(height: 12,),
                          Container(color: Colors.black, width: MediaQuery.of(context).size.width - 44, height: 1,), SizedBox(height: 12,)
                        ],
                      ),
                    ],
                  ),
                );
              },
              itemCount: news.length,
            )
          ],
        ));
  }
}
