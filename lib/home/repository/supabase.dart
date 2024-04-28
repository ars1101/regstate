

import 'dart:typed_data';

import 'package:session1_new/main.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<List<Map<String,dynamic>>> getPlatforms() async {
  var a = await supabase.from('platforms').select();
  return a;
}

Future<UserResponse> savePlatforms(List<Map<String,dynamic>> platforms) async {
  return await supabase.auth.updateUser(
      UserAttributes(
          data: {
            "platforms": platforms
          }
      )
  );
}

Future<void> saveUserData(
    String fullname,
    String phone,
    String birthday
    ) async {
  await supabase.auth.updateUser(
      UserAttributes(
          data: {
            "fullname": fullname,
            "phone": phone,
            "birthday": birthday,
          }
      )
  );
}

Future<void> uploadAvatar(Uint8List bytes) async {
  var name = "${supabase.auth.currentUser!.id}.png";
  await supabase.storage
      .from("avatars")
      .uploadBinary(
      name,
      bytes
  );
  await supabase.auth.updateUser(
      UserAttributes(
          data: {
            "avatar": "https://tkrermffmfyblqfqzhlt.supabase.co/storage/v1/object/public/avatars/" + name
          }
      )
  );
  print(name);
}

Future<List<Map<String,dynamic>>> getNews() async {
  var res = await supabase.from("news").select();
  return res;
}