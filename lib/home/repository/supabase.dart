

import 'package:session1_new/main.dart';

Future<List<Map<String,dynamic>>> getPlatforms() async {
  var a = await supabase.from('platforms').select();
  return a;
}