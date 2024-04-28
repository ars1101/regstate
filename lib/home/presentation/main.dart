import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:session1_new/auth/presentation/Holder.dart';
import 'package:session1_new/auth/presentation/login.dart';
import 'package:session1_new/auth/widgets/customtextfield.dart';
import 'package:session1_new/core/themes.dart';
import 'package:session1_new/home/presentation/Profile.dart';
import 'package:session1_new/home/presentation/chooseplatform.dart';
import 'package:session1_new/home/presentation/home.dart';
import 'package:session1_new/home/repository/supabase.dart';
import 'package:session1_new/main.dart';

import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool obs = true;
  bool check = false;
  int ind = 0;




  @override
  Widget build(BuildContext context) {
    return Scaffold(bottomNavigationBar: BottomNavigationBar(currentIndex: ind,
        items: [BottomNavigationBarItem(
          icon: Image.asset(
              (ind == 0) ? "assets/home1.png" : "assets/home.png"),
          label: "Home",
        ),
          BottomNavigationBarItem(
              icon: Image.asset((ind == 1)?'assets/search1.png': 'assets/search.png' ), label: "Search"),
          BottomNavigationBarItem(
              icon: Image.asset((ind == 2)
                  ? "assets/favorite1.png"
                  : "assets/favorite.png"),
              label: "Favorite"),
          BottomNavigationBarItem(
              icon: Image.asset((ind == 3)
                  ? "assets/profile1.png"
                  : "assets/profile.png"),
              label: "Profile")],
        selectedItemColor: (accent),
        unselectedItemColor: Color(0xFFA7A7A7),
        unselectedLabelStyle: TextStyle(color: Color(0xFFA7A7A7)),
        selectedLabelStyle: TextStyle(color: accent),
        showUnselectedLabels: true,
        showSelectedLabels: true,
        onTap: (inda) {
          setState(() {
            ind = inda;
          });
        }

    ),
      body: [HomePage(), Holder(), Holder(), Profile()][ind],
    );
  }
}
