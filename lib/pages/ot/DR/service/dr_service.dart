import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fms_mobile_app/constant/app_api.dart';
import 'package:fms_mobile_app/pages/ot/DR/models/dr_await_models.dart';
import 'package:fms_mobile_app/pages/ot/DR/models/dr_success_models.dart';
import 'package:fms_mobile_app/services/provider_service.dart';
import 'package:fms_mobile_app/widgets/loading/loading_approved.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class DRService {
  Future<DrAwaitModels?> getDrAwait() async {
    final user = await FirebaseAuth.instance.currentUser?.getIdToken();
    final token = user;
    String url = AppAPI.getdrawait;
    final res = await http.get(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    if (res.statusCode == 200) {
      return drAwaitModelsFromJson(res.body);
    }
    return null;
  }

  Future<void> drApproved(context, List<String?> eovertimeid, String? isapproved, String? remark) async {
    final provider = Provider.of<ProviderService>(context, listen: false);
    LoadingApproved().showDialogLodingApproved(context, 'ກຳລັງອະນຸມັດ..');
    final user = await FirebaseAuth.instance.currentUser?.getIdToken();
    final token = user;
    String url = AppAPI.drApproved;
    Object body = jsonEncode(
      {
        "e_overtime_id": eovertimeid,
        "is_approved": isapproved,
        "remark": remark,
      },
    );
    final res = await http.post(
      Uri.parse(url),
      body: body,
      headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token',
      },
    );

    if (res.statusCode == 200) {
      Navigator.pop(context);
      LoadingApproved().LodingApprovedSuccess(context, "ອະນຸມັດສຳເລັດແລ້ວ");
      provider.getDRAwaitPro();
    }
  }

  Future<DrSuccessModels?> getDRSuccessSer() async {
    final user = await FirebaseAuth.instance.currentUser?.getIdToken();
    final token = user;
    String url = AppAPI.getdrsuccess;
    final res = await http.get(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    if (res.statusCode == 200) {
      return drSuccessModelsFromJson(res.body);
    }
    return null;
  }
}
