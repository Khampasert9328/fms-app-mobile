import 'package:firebase_auth/firebase_auth.dart';
import 'package:fms_mobile_app/constant/app_api.dart';
import 'package:fms_mobile_app/pages/overtime/models/GetMyOverTime.dart';
import 'package:http/http.dart' as http;

class MyOTService {
  Future<GetMyOverTimeModels?> getMyOvertimAwait() async {
    final user = await FirebaseAuth.instance.currentUser?.getIdToken();
    final token = user;
    String url = AppAPI.getOTAwait;
    final res = await http.get(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    if (res.statusCode == 200) {
      return getMyOverTimeModelsFromJson(res.body);
    }

    return null;
  }

   Future<GetMyOverTimeModels?> getMyOvertimSuccess() async {
    final user = await FirebaseAuth.instance.currentUser?.getIdToken();
    final token = user;
    String url = AppAPI.getOTSuccess;
    final res = await http.get(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    if (res.statusCode == 200) {
      return getMyOverTimeModelsFromJson(res.body);
    }

    return null;
  }


}
