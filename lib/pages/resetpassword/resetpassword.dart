import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fms_mobile_app/services/provider_service.dart';
import 'package:fms_mobile_app/theme/color.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ResetPass extends StatefulWidget {
  final String? url;

  const ResetPass({Key? key, this.url}) : super(key: key);

  @override
  _ResetPassState createState() => _ResetPassState();
}

class _ResetPassState extends State<ResetPass> {
  //String url = "https://fms-admin.archiineergroup.la/forgot-password?is_mobile=1/";

  final controller = WebViewController()
  ..setJavaScriptMode(JavaScriptMode.disabled)
  ..loadRequest(Uri.parse('https://fms-admin.archiineergroup.la/forgot-password?is_mobile=1/'));


  @override
  void initState() {
    super.initState();

    // controller = WebViewController()
    //     ..loadRequest(
    //       Uri.parse('https://fms-admin.archiineergroup.la/forgot-password?is_mobile=1'),
    //     );
  }

// void _changeUrl() {
//     setState(() {
//       this.url = "https://github.com/flutter/flutter";
//     });
//   }

  @override
  Widget build(BuildContext context) {
    //print("url:" + url);
    final providerService = Provider.of<ProviderService>(context);
    return Scaffold(
        appBar: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle.light,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: white,
            ),
            onPressed: () {
              Navigator.pop(
                context,
                // MYHomePage is another page for showcase
                // replace it with your page name
              );
            },
          ),
          title: new Text(providerService.langs == 'la' ? "ປ່ຽນລະຫັດຜ່ານ" : ' Change Password',
              style: const TextStyle(color: Colors.white)),
          centerTitle: true,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: <Color>[Color(0xff039881), Color(0xff024C41)]),
            ),
          ),
        ),
        body: WebViewWidget(
          controller: controller,
        )
        // Web(
        //   initialUrl: url,
        //   javascriptMode: JavascriptMode.unrestricted,
        // ),
        );
  }
}
