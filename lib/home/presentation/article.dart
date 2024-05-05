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

class Article extends StatefulWidget {
  final Map<String, dynamic> b;
  final Map<String, dynamic> plat;
  const Article({super.key, required this.b, required this.plat});

  @override
  State<Article> createState() => _ArticleState();
}

Map<String, dynamic> data = {'fullname': ''};
List<Map<String, dynamic>> platforms = [];
List plchan = [];
List<Map<String, dynamic>> news = [];
List<Map<String, dynamic>> snews = [];

class _ArticleState extends State<Article> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPlatforms().then((value) => setState(() {
      allplatforms = value;
      setState(() {});
    }));

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFFFFAF0),
        body: ListView(children: [SizedBox(height: 63,), Row(
          children: [ SizedBox(width: 22,), IconButton(onPressed: (){Navigator.of(context).pop();}, icon: Image.asset('assets/str.png')),
            SizedBox(
              height: 30,
              width: 30,
              child: Image.network(widget.plat['icon']),
            ),
            SizedBox(
              width: 12,
            ),
            Column(
              children: [
                Text(
                  widget.b['channel'] + ' | ' + widget.plat['title'],
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
                ),
              ],
            ),
          ],
        ), SizedBox(height: 16 ,), Row(
          children: [SizedBox(width: 22,),
            SizedBox( width: MediaQuery.of(context).size.width - 44,
              child: Text(
                widget.b['title'],
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),

          ],
        ),SizedBox(height: 18,), (widget.b['type_media'] == "photo")? Column(
          children: [
            SizedBox(height: 213, width:  MediaQuery.of(context).size.width - 44, child: Image.network(widget.b['media']) ,), SizedBox(height: 18,)
          ],
        ): SizedBox(),
          Row(
            children: [SizedBox(width: 22,),
              SizedBox( width: MediaQuery.of(context).size.width - 44,
                child: Text(
                  widget.b['text'],
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ), SizedBox(height: 22,)
        ],));
  }
}
