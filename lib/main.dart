// ignore_for_file: unused_local_variable

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fms_mobile_app/firebase_options.dart';
import 'package:fms_mobile_app/pages/calendar/provider/calenda_provicer.dart';
import 'package:fms_mobile_app/pages/calendar/provider/time_sheet_provider.dart';
import 'package:fms_mobile_app/pages/calendar/provider/workandprojectviewmodels.dart';
import 'package:fms_mobile_app/pages/home/provider/timer_provider.dart';
import 'package:fms_mobile_app/pages/ot/HR/provider/set_item_checkbox.dart';

import 'package:fms_mobile_app/services/auth_service.dart';

import 'package:fms_mobile_app/services/provider_service.dart';
import 'package:fms_mobile_app/services/provider_service_splase.dart';
import 'package:fms_mobile_app/splash.dart';
import 'package:fms_mobile_app/theme/color.dart';
import 'package:fms_mobile_app/utils/easyloading.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'package:provider/provider.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';


Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  print("Handling a background message: ${message.messageId}");
}

void main() async {
 
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
 configLoading();
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

// NotificationSettings settings = await messaging.requestPermission(
//   alert: true,
//   announcement: false,
//   badge: true,
//   carPlay: false,
//   criticalAlert: false,
//   provisional: false,
//   sound: true,
// );

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    print('Message data: ${message.data}');

    if (message.notification != null) {
      print('Message also contained a notification: ${message.notification}');
    }
  });

  runApp(const MyApp());
}



void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = false
    ..customAnimation = CustomAnimation();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('lo');
    return ScreenUtilInit(
       designSize: const Size(360, 589),
      builder: (context, child) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => ProviderService()),
            ChangeNotifierProvider(create: (_) => AuthService()),
            ChangeNotifierProvider(create: (_) =>CalendarProvider()),
            ChangeNotifierProvider(create: (_) =>TimeSheetProvider()),
            ChangeNotifierProvider(create: (_)=>WorkAndProjectProvider()),
            ChangeNotifierProvider(create: (_)=>SetItmem()),
            ChangeNotifierProvider(create: (_)=>TimerProvider()),
            ChangeNotifierProvider(create: (_)=>ProviderSplase())
          ],
          child: MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              brightness: Brightness.light,
              useMaterial3: true,
              colorSchemeSeed: primary,
           

              fontFamily: 'NotoSansLao',
            ),

            debugShowCheckedModeBanner: false,
            initialRoute: '/',
            routes: {
              '/': (_) => const Splash(),
            },
            builder: EasyLoading.init(),
          
          ),
        );
      },
    );
  }
}


