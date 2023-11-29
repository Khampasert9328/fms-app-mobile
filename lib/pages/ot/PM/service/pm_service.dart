import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fms_mobile_app/constant/app_api.dart';
import 'package:fms_mobile_app/pages/ot/PM/models/pm_await_models.dart';
import 'package:fms_mobile_app/pages/ot/PM/models/pm_success_models.dart';
import 'package:fms_mobile_app/services/provider_service.dart';
import 'package:fms_mobile_app/widgets/loading/loading_approved.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class PMService {
  Future<PmModels?> getPmService() async {
    final user = await FirebaseAuth.instance.currentUser?.getIdToken();
    final token = user;

    String url = AppAPI.getpmawait;
    final res = await http.get(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    if (res.statusCode == 200) {
      return pmModelsFromJson(res.body);
    }
    return null;
  }

  Future<PmSuccessModels?> getPmSuccess() async {
    final user = await FirebaseAuth.instance.currentUser?.getIdToken();
    final token = user;

    String url = AppAPI.getpmsuccess;
    final res = await http.get(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    if (res.statusCode == 200) {
      return pmSuccessModelsFromJson(res.body);
    }
    return null;
  }

  Future<void> pmapprove(context, List<String?> eovertimeid, String? isapproved, String? remark) async {
    final provider = Provider.of<ProviderService>(context, listen: false);
    LoadingApproved().showDialogLodingApproved(context, 'ກຳລັງອະນຸມັດ..');
    final user = await FirebaseAuth.instance.currentUser?.getIdToken();
    final token = user;
    String url = AppAPI.pmapproved;
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
      provider.getPMPro();
    }
  }
}
