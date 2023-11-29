import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fms_mobile_app/constant/app_api.dart';
import 'package:fms_mobile_app/pages/ot/TM/models/leave_friends_models.dart';
import 'package:fms_mobile_app/services/provider_service.dart';
import 'package:fms_mobile_app/widgets/loading/loading_approved.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class TMServicer {
  Future<LeaveFriendsModels?> getleavefirends() async {
    final user = await FirebaseAuth.instance.currentUser?.getIdToken();
    final token = user;
    String url = AppAPI.leavefriends;
    final res = await http.get(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    if (res.statusCode == 200) {
      return leaveFriendsModelsFromJson(res.body);
    }
    return null;
  }

  Future<LeaveFriendsModels?> getleavefirendsSuccess() async {
    final user = await FirebaseAuth.instance.currentUser?.getIdToken();
    final token = user;
    String url = AppAPI.leavefriendsSuccess;
    final res = await http.get(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    if (res.statusCode == 200) {
      return leaveFriendsModelsFromJson(res.body);
    }
    return null;
  }

  Future<void> tmapproved(context, List<String?> eleaveid, int? isapproved, String? remark) async {
    final provider = Provider.of<ProviderService>(context, listen: false);
    LoadingApproved().showDialogLodingApproved(context, 'ກຳລັງອະນຸມັດ..');
    final user = await FirebaseAuth.instance.currentUser?.getIdToken();
    final token = user;
    String url = AppAPI.tmapproved;
    Object body = jsonEncode({
      "is_approved": isapproved, // is_approved > 1 = ' ອະນຸມັດ'  &&   is_approved < 1 = ປະຕິເສດ
      "e_leave_id": eleaveid, // ໄອດີ ການລາພັກ ສາມາດເລື່ອກໄດ້ຫຼາຍອັນ
      "remark": remark // remark ແມ່ນເຫດຜົນ ຈຳເປັນຕ້ອງໃສ່ ຖ້າໃສ່ is_approved < 1
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
      provider.getLeaveFirendsPro();
    }
  }
}
