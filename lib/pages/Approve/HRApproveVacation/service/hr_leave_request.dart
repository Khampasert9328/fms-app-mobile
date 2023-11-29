import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fms_mobile_app/constant/app_api.dart';
import 'package:fms_mobile_app/pages/Approve/HRApproveVacation/models/hrleaverequest_models.dart';
import 'package:fms_mobile_app/services/provider_service.dart';
import 'package:fms_mobile_app/widgets/loading/loading_approved.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class HRLeaveRequestService {
  Future<HrLeaveRequestModels?> getHRLeaveRequest() async {
    final user = await FirebaseAuth.instance.currentUser?.getIdToken();
    final token = user;
    String url = AppAPI.getHRLeaveRequest;
    final res = await http.get(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    if (res.statusCode == 200) {
      return hrLeaveRequestModelsFromJson(res.body);
    }
    return null;
  }

  Future<HrLeaveRequestModels?> getHRLeaveRequestSuccess() async {
    final user = await FirebaseAuth.instance.currentUser?.getIdToken();
    final token = user;
    String url = AppAPI.getHRLeaveRequestsuceess;
    final res = await http.get(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    if (res.statusCode == 200) {
      return hrLeaveRequestModelsFromJson(res.body);
    }
    return null;
  }

  Future<void> hrapprovedleave(context, List<String?> eleaveid, int? isapprove, String? remark) async {
    final provider = Provider.of<ProviderService>(context, listen: false);
    LoadingApproved().showDialogLodingApproved(context, 'ກຳລັງອະນຸມັດ..');
    final user = await FirebaseAuth.instance.currentUser?.getIdToken();
    final token = user;
    String url = AppAPI.hrapproveleaverequ;
    Object body = jsonEncode({
      "e_leave_id": eleaveid, // ໄອດີ ການລາພັກ ສາມາດເລື່ອກໄດ້ຫຼາຍອັນ
      "is_approved": isapprove, // is_approved > 1 = ' ອະນຸມັດ'  &&   is_approved < 1 = ປະຕິເສດ
      "remark": remark // is_approved > 1 = ບໍໃສ່ໍໄດ້  &&  is_approved < 1 ໃສ່ remark
    });
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
      provider.getHrLeaveReq();
    }
  }
}
