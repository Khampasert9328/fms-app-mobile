import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fms_mobile_app/constant/app_api.dart';
import 'package:fms_mobile_app/model/get_years_models.dart';
import 'package:http/http.dart' as http;

class YearService {
  Future<GetYearsModels?> getYearsAll() async {
    final user = await FirebaseAuth.instance.currentUser?.getIdToken();
    final token = user;
    String url = AppAPI.getyearsall;
    final res = await http.get(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    if (res.statusCode == 200) {
      return getYearsModelsFromJson(res.body);
    }
    return null;
  }
}
