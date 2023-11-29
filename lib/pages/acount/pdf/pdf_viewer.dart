import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fms_mobile_app/services/provider_service.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PDFViewer extends StatefulWidget {
  const PDFViewer({super.key});

  @override
  State<PDFViewer> createState() => _PDFViewerState();
}

class _PDFViewerState extends State<PDFViewer> {
  @override
  Widget build(BuildContext context) {
    final providerService = Provider.of<ProviderService>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        title: Text(
          providerService.langs == 'la' ? "ກົດລະບຽບຂອງບໍລິສັດ" : "Setting",
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.white),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: <Color>[
                Color(0xff039881),
                Color(0xff024C41),
              ],
            ),
          ),
        ),
      ),
      body: SfPdfViewer.network(
        
          'https://fms-admin.archiineergroup.la/files/%E0%BA%81%E0%BA%BB%E0%BA%94%E0%BA%A5%E0%BA%B0%E0%BA%9A%E0%BA%BD%E0%BA%9A%E0%BA%9A%E0%BB%8D%E0%BA%A5%E0%BA%B4%E0%BA%AA%E0%BA%B1%E0%BA%94.pdf', pageSpacing: 4,),
    );
  }
}
