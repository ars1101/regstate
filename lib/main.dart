import 'package:flutter/material.dart';
import 'package:session1_new/auth/presentation/login.dart';
import 'package:session1_new/core/themes.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  Supabase.initialize(url: "https://tkrermffmfyblqfqzhlt.supabase.co",

      anonKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InRrcmVybWZmbWZ5YmxxZnF6aGx0Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTI0MDc2ODUsImV4cCI6MjAyNzk4MzY4NX0.b73ENiCT8jMT8NaebYgNjA4ilbcM9VBYkVz3-63UsPc");
  runApp(const MyApp());
}

final supabase = Supabase.instance.client;
User? user;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: Themes,
      home: const LogIn(),
    );
  }
}


