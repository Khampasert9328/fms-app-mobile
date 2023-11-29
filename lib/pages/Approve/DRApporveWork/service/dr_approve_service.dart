import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fms_mobile_app/constant/app_api.dart';
import 'package:fms_mobile_app/pages/Approve/DRApporveWork/models/dr_approve_success.dart';
import 'package:fms_mobile_app/pages/Approve/DRApporveWork/models/getallforapprovetime_models.dart';
import 'package:fms_mobile_app/pages/Approve/DRApporveWork/models/gettimesheetallMonthandyear_models.dart';
import 'package:fms_mobile_app/pages/ot/HR/provider/set_item_checkbox.dart';
import 'package:fms_mobile_app/widgets/loading/loading_approved.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class DRApproveService {
  Future<GetAllForApproveTimeSheetModels?> getAllForApproveTimeSheet() async {
    final user = await FirebaseAuth.instance.currentUser?.getIdToken();
    final token = user;
    String url = AppAPI.getallformapprovetimesheet;
    final res = await http.get(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    if (res.statusCode == 200) {
      return getAllForApproveTimeSheetModelsFromJson(res.body);
    }
    return null;
  }

  Future<GetTimeSheetsAllMonthandYearModels?> getTimeMonthAndYears(context) async {
    final user = await FirebaseAuth.instance.currentUser?.getIdToken();
    final token = user;
    final infomontyear = Provider.of<SetItmem>(context, listen: false);

    String url =
        '${AppAPI.apiPath}/timesheets/all/lists-year/${infomontyear.employeeid}?year=${infomontyear.selectYear}&status=-1&month=${infomontyear.selectMonth}';
    final res = await http.get(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    if (res.statusCode == 200) {
      return getTimeSheetsAllMonthandYearModelsFromJson(res.body);
    }
    return null;
  }

  Future<void> drApproveTimeSheets(
      context, List<String?> date, String? employeid, int? isapprove, String? remark) async {
    LoadingApproved().showDialogLodingApproved(context, 'ກຳລັງອະນຸມັດ..');
    final user = await FirebaseAuth.instance.currentUser?.getIdToken();
    final token = user;
    String url = AppAPI.approvedTimeSheets;
    Object body = jsonEncode({
      "date": date,
      "employee_id": employeid,
      "is_approvals": isapprove,
      "remark": remark,
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
    }
  }

  Future<DrApprovedSuccessModels?> getDRApprovedSuccess(context) async {
    final datenow = DateTime.now();
    String formatyear = DateFormat('yyyy').format(datenow);
    String formatmonth = DateFormat('mm').format(datenow);
    final user = await FirebaseAuth.instance.currentUser?.getIdToken();
    final token = user;
    final infomontyear = Provider.of<SetItmem>(context, listen: false);
    String url =
        '${AppAPI.apiPath}/timesheets/all/lists-year/${infomontyear.employeeid}?year=${infomontyear.selectYearSucees ?? formatyear}&status=1,2&month=${infomontyear.selectMonthSucees ?? formatmonth}';
    final res = await http.get(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    if (res.statusCode == 200) {
      return drApprovedSuccessModelsFromJson(res.body);
    }

    return null;
  }
}
