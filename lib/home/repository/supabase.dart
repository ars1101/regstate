

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
  print({
    "fullname": fullname,
    "phone": phone,
    "birthday": birthday,
  });
}


