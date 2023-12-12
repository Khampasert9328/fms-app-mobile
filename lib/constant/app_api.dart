class AppAPI {
  static String apiPath = "https://fms-api.archiineergroup.la/api";
  static String checkAttend = '$apiPath/attendance/check-attend';
  static String getleavetype = '$apiPath/leaves/leavetype';
  static String getleave = '$apiPath/leaves?year=2023&l_status_id=1';
  static String getOverTimeProject = '$apiPath/overtimes/project/approve?year=2023';
  static String getOverTimeCount = '$apiPath/overtimes/total-project-approve';
  static String getOverTimeExecult = '$apiPath/overtimes/executive/approve?year=2023';
  static String getOverTimeExecultCount = '$apiPath/overtimes/total-executive-approve';

  //Leave
  static String addrequestLeave = '$apiPath/leaves/request-new';


  //HR
  static String getHrApproved = '$apiPath/overtimes/hr/all/approve?year=2023&o_status_id=3';
  static String hrapproved = '$apiPath/overtimes/approve-hr';
  static String gethrcheckingsuccess = '$apiPath/overtimes/hr/all/approve?year=2023&o_status_id=-1,4';

  //PM
  static String getpmawait = '$apiPath/overtimes/project/approve?year=2023&o_status_id=1';
  static String getpmsuccess = '$apiPath/overtimes/project/approve?year=2023&o_status_id=-1,2';
  static String pmapproved = '$apiPath/overtimes/approve-project';

  //DR
  static String getdrawait = '$apiPath/overtimes/executive/approve?year=2023&o_status_id=2';
  static String getdrsuccess = '$apiPath/overtimes/executive/approve?year=2023&o_status_id=-1,3';
  static String drApproved = '$apiPath/overtimes/approve-executive';

  //DR Approve
  static String getallformapprovetimesheet = '$apiPath/timesheets/team/timesheet';

  //TimeSheets
  static String getTimesheetAllMonthYears = '$apiPath/timesheets/all/lists-year/113?year=&status=-1,0&month=';
  static String approvedTimeSheets = '$apiPath/timesheets/approvals/executive-director';
  static String getdrapprovedsuccess = '$apiPath/timesheets/all/lists-year/113?year=&status=1,2&month=';

  //dasboard
  static String timesheetspandingdays = '$apiPath/timesheets/pending-days-all';

  //totalcount
  static String totalcount = '$apiPath/overtimes/total-executive-approve';

//worktype
  static String worktype = '$apiPath/work-types/me';
  static String project = '$apiPath/projects/me';
  static String workcode = '$apiPath/workcodes/me?work_type_id=';
  // OT
  static String addOT = '$apiPath/overtimes/request-start';
  static String stopOT = '$apiPath/overtimes/request-stop';
  static String checkOt = '$apiPath/overtimes/get-time-start';
  static String getOTAwait = '$apiPath/overtimes?year=2023&o_status_id=1,2,3';
  static String getOTSuccess = '$apiPath/overtimes?year=2023&o_status_id=-1,4';



//HRApproved
  static String getHRLeaveRequest = '$apiPath/leaves/hr-leave-request?year=2023&l_status_id=1,2,3';
  static String getHRLeaveRequestsuceess = '$apiPath/leaves/hr-leave-request?year=2023&l_status_id=-1,4';
  static String hrapproveleaverequ = '$apiPath/leaves/approve-hr';

  //TM
  static String leavefriends = '$apiPath/leaves/list/me?year=2023&l_status_id=1,2,3';
  static String leavefriendsSuccess = '$apiPath/leaves/list/me?year=2023&l_status_id=-1,4';
  static String tmapproved = '$apiPath/leaves/approval-status';
  
  //Years
  static String getyearsall = '$apiPath/organisations/get-year';


  //count
   static String getCountHr = '$apiPath/overtimes/total-hr-approve';
   static String getCountProject = '$apiPath/overtimes/total-project-approve';








}
