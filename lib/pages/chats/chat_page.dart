import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fms_mobile_app/services/provider_service.dart';
import 'package:provider/provider.dart';


class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {

  @override
  Widget build(BuildContext context) {
       final providerService = Provider.of<ProviderService>(context);
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.light,
        title: new Center(
            child: new Text(providerService.langs == 'la' ? "ສົນທະນາ" : "Chat",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white))),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[Color(0xff039881), Color(0xff024C41)]),
          ),
        ),
      ),
      body: Center(
        // ignore: prefer_const_constructors
        child: SizedBox(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    "assets/images/logo.svg",
                    width: 130,
                    color: Colors.green.shade200,
                  ),
                ],
              ),
              Center(
                child: Text(
                  "Coming Soon",
                  style: TextStyle(
                      color: Colors.grey.shade400,
                      fontSize: 20,
                      fontWeight: FontWeight.w800),
                ),
              ),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
