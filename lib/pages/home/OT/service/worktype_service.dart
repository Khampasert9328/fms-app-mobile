import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fms_mobile_app/constant/app_api.dart';
import 'package:fms_mobile_app/pages/home/OT/models/check_ot_model.dart';
import 'package:fms_mobile_app/pages/home/OT/models/ot_screen_models.dart';
import 'package:fms_mobile_app/pages/home/OT/models/projectall_models.dart';
import 'package:fms_mobile_app/pages/home/OT/models/workcode_models.dart';
import 'package:fms_mobile_app/pages/home/home_app.dart';
import 'package:fms_mobile_app/pages/home/home_page.dart';
import 'package:fms_mobile_app/pages/home/provider/timer_provider.dart';
import 'package:fms_mobile_app/pages/ot/HR/provider/set_item_checkbox.dart';
import 'package:fms_mobile_app/services/provider_service.dart';
import 'package:fms_mobile_app/widgets/loading/loading_success.dart';
import 'package:fms_mobile_app/widgets/loading/loading_widget.dart';
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
      context, String? worktype, String? projectid, String? workcode, String? checklatlng, String? detail) async {
    final provider = Provider.of<ProviderService>(context, listen: false);
    showDialog(context: context, builder: (context) => LoadingWidget());
    final time = Provider.of<TimerProvider>(context, listen: false);
    final user = await FirebaseAuth.instance.currentUser?.getIdToken();
    final token = user;
    String url = AppAPI.addOT;
    Object body = jsonEncode({
      "work_type": worktype,
      "project_id": projectid,
      "workcode": workcode,
      "checkin_lat_lng": checklatlng,
      "detail": detail ?? ""
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
      await time.startTimerOT(context);

      Navigator.of(context);
      showDialog(
        context: context,
        builder: (context) => LoadingDialog(
          title: "ລໍຖ້າກວດສອບ",
          onTap: () {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomeApp()));
          },
        ),
      );
    }
  }

  Future<void> stopOT(context, String? checklatlng) async {
    final time = Provider.of<TimerProvider>(context, listen: false);
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
      print(res.statusCode);
      time.stopTimerOT(context);

      Navigator.pop(context);
    }
  }

  Future<CheckOtModel?> checkOtTime() async {
    final user = await FirebaseAuth.instance.currentUser?.getIdToken();
    final token = user;
    final res = await http.get(Uri.parse(AppAPI.checkOt),
        headers: {'Content-Type': 'application/json; charset=UTF-8', 'Authorization': 'Bearer $token'});

    if (res.statusCode == 200) {
      return checkOtModelFromJson(res.body);
    }
    return null;
  }
}
