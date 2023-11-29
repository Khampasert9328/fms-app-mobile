// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fms_mobile_app/constant/app_api.dart';
import 'package:fms_mobile_app/pages/ot/HR/models/hr_checking_success.dart';
import 'package:fms_mobile_app/services/provider_service.dart';
import 'package:fms_mobile_app/widgets/loading/loading_approved.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class HRApprovedService {
  Future<void> hrapproved(context, List<String?> eovertimeid, String? isapproved, String? remark) async {
    final provider = Provider.of<ProviderService>(context, listen: false);
    LoadingApproved().showDialogLodingApproved(context, 'ກຳລັງອະນຸມັດ..');
    final user = await FirebaseAuth.instance.currentUser?.getIdToken();
    final token = user;

    String url = AppAPI.hrapproved;
    final res = await http.post(
      Uri.parse(url),
      body: jsonEncode({
        "e_overtime_id": eovertimeid, // ໄອດີ ໂອທີ່ ສາມາດເລື່ອກໄດ້ຫຼາຍອັນ
        "is_approved": isapproved, // is_approved > 1 = ' ອະນຸມັດ'  &&   is_approved < 1 = ປະຕິເສດ
        "remark": remark
      }),
      headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token',
      },
    );

    if (res.statusCode == 200) {
      Navigator.pop(context);
      LoadingApproved().LodingApprovedSuccess(context, "ອະນຸມັດສຳເລັດແລ້ວ");
      provider.getHRApprovedPro();
    } else {}
  }

  Future<HrCheckingSuccessModels?> getHRCheckingSuccess() async {
    final user = await FirebaseAuth.instance.currentUser?.getIdToken();
    final token = user;
    String url = AppAPI.gethrcheckingsuccess;
    final res = await http.get(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    if (res.statusCode == 200) {
      return hrCheckingSuccessModelsFromJson(res.body);
    }
    return null;
  }
}
