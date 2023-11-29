import 'package:fms_mobile_app/constant/app_api.dart';
import 'package:fms_mobile_app/pages/ot/models/HR/HR_models.dart';

import 'package:http/http.dart' as http;

class HRService {
  Future<HrApprovedModels?> getHRApproved(String? token) async {
    String url = AppAPI.getHrApproved;
    final res = await http.get(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    if (res.statusCode == 200) {
      return hrApprovedModelsFromJson(res.body);
    }

    return null;
  }
}
