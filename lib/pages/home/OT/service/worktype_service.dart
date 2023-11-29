import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fms_mobile_app/constant/app_api.dart';
import 'package:fms_mobile_app/pages/home/OT/models/ot_screen_models.dart';
import 'package:fms_mobile_app/pages/home/OT/models/projectall_models.dart';
import 'package:fms_mobile_app/pages/home/OT/models/workcode_models.dart';
import 'package:fms_mobile_app/pages/ot/HR/provider/set_item_checkbox.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class WorkTypeService {
  Future<WorkTypeModels?> getWorkType() async {
    final user = await FirebaseAuth.instance.currentUser?.getIdToken();
    final token = user;

    String url = AppAPI.worktype;
    final res = await http.get(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    if (res.statusCode == 200) {
      return workTypeModelsFromJson(res.body);
    }
    return null;
  }

  Future<ProjectAllModels?> getWorkProjecall() async {
    final user = await FirebaseAuth.instance.currentUser?.getIdToken();
    final token = user;

    String url = AppAPI.project;
    final res = await http.get(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    if (res.statusCode == 200) {
      return projectAllModelsFromJson(res.body);
    }
    return null;
  }

  Future<WorkCodeModels?> getWorkCode(context) async {
    final user = await FirebaseAuth.instance.currentUser?.getIdToken();
    final token = user;
    final workt = Provider.of<SetItmem>(context, listen: false);
    final worktype = workt.workType;

    String url = "${AppAPI.apiPath}/workcodes/me?work_type_id=$worktype";
    final res = await http.get(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    if (res.statusCode == 200) {
      return workCodeModelsFromJson(res.body);
    }
    return null;
  }

  Future<void> startOT(
      context, String? worktype, String? projectype, String? workcode, String? checklatlng, String? detail) async {
    final user = await FirebaseAuth.instance.currentUser?.getIdToken();
    final token = user;
    String url = AppAPI.addOT;
    Object body = jsonEncode({
      "work_type": worktype, //work_type == 1 ມີ project_id and workcode || work_type == 2  ມີແຕ່  workcode
      "project_id": projectype,
      "workcode": workcode,
      "checkin_lat_lng": checklatlng,
      "detail": detail
    });
    final res = await http.post(
      Uri.parse(url),
      body: body,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );
     print('unsuccess===${res.body}');
    print('unsuccess===${res.statusCode}');
    if (res.statusCode == 200) {
      print('success===${res.statusCode}');
      Navigator.pop(context);
    }
  }

  Future<void> stopOT(context, String? checklatlng) async {
    final user = await FirebaseAuth.instance.currentUser?.getIdToken();
    final token = user;
    String url = AppAPI.stopOT;
    Object body = jsonEncode({
      "checkin_lat_lng": checklatlng,
    });
    final res = await http.post(
      Uri.parse(url),
      body: body,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );
    if (res.statusCode == 200) {
      Navigator.pop(context);
    }
  }
}
