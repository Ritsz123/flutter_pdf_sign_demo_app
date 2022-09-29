import 'dart:convert';
import 'dart:io';

import 'package:advance_pdf_viewer_fork/advance_pdf_viewer_fork.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PdfScreen(),
    );
  }
}

class PdfScreen extends StatefulWidget {
  const PdfScreen({Key? key}) : super(key: key);

  @override
  State<PdfScreen> createState() => _PdfScreenState();
}

class _PdfScreenState extends State<PdfScreen> {
  PDFDocument? document;
  bool signed = false;
  late Directory dir;
  bool loaded = false;

  @override
  void initState() {
    init();
    super.initState();
  }

  init() async {
    dir = await getApplicationDocumentsDirectory();
    await saveLocally();
    await updateDoc();
  }

  updateDoc() async {
    final doc = await getPdfFile();
    setState(() {
      document = doc;
    });
  }

  signPDF() async {
    final u8int = await File("${dir.path}/myDocument.pdf").readAsBytes();
    final pdfDoc = PdfDocument.fromBase64String(base64Encode(u8int));

    final page = pdfDoc.pages[pdfDoc.pages.count - 1];
    page.graphics.drawImage(
        PdfBitmap(File("${dir.path}/sign.jpg").readAsBytesSync()),
        Rect.fromLTRB(90, page.getClientSize().height - 80, 190,
            page.getClientSize().height - 40));
    // PdfStandardFont(PdfFontFamily.timesRoman, 20)
    final file = File("${dir.path}/myDocument.pdf");
    await file.writeAsBytes(await pdfDoc.save());
    pdfDoc.dispose();
    print('pdf signed success');
    setState(() {
      signed = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          signed
              ? Expanded(
                  child: StreamBuilder<PDFDocument>(
                    builder: (context, snap) {
                      if (snap.hasData) {
                        return PDFViewer(
                          document: snap.data!,
                        );
                      }
                      return Center(child: CircularProgressIndicator());
                    },
                    stream:
                        PDFDocument.fromFile(File("${dir.path}/myDocument.pdf"))
                            .asStream(),
                  ),
                )
              : document != null
                  ? Expanded(child: _pdfViewer(document!))
                  : Expanded(child: Center(child: CircularProgressIndicator())),
          ElevatedButton(onPressed: signPDF, child: Text('sign pdf')),
        ],
      ),
    );
  }

  _pdfViewer(PDFDocument document) {
    return PDFViewer(
      document: document,
      showIndicator: true,
      showNavigation: true,
      enableSwipeNavigation: true,
    );
  }

  Future<PDFDocument> getPdfFile() async {
    return PDFDocument.fromFile(File("${dir.path}/myDocument.pdf"));
  }

  Future<void> saveLocally() async {
    final dir = await getApplicationDocumentsDirectory();
    await Dio().download(
        "https://filebin.net/cwdbd946gusekoww/GT-Contract_v1.pdf",
        "${dir.path}/myDocument.pdf");
    print('download success');
  }
}

// class PdfScreen extends StatefulWidget {
//   const PdfScreen({Key? key}) : super(key: key);
//
//   @override
//   State<PdfScreen> createState() => _PdfScreenState();
// }
//
// class _PdfScreenState extends State<PdfScreen> {
//   PDFDocument? document;
//   bool created = false;
//   late Directory appDocDir;
//
//   @override
//   void initState() {
//     load();
//     super.initState();
//   }
//
//   Future<void> load() async {
//     appDocDir = await getApplicationDocumentsDirectory();
//     document = created
//         ? await PDFDocument.fromFile(File('${appDocDir.path}/output.pdf'))
//         : await PDFDocument.fromURL(
//             "https://clri-ltc.ca/files/2018/09/TEMP-PDF-Document.pdf");
//     setState(() {});
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: Column(
//         children: [
//           SizedBox(
//             width: double.infinity,
//             height: 300,
//             child: document != null
//                 ? PDFViewer(
//                     document: document!,
//                   )
//                 : CircularProgressIndicator(),
//           ),
//           ElevatedButton(
//               onPressed: () async {
//                 final u8list = await File.fromUri(Uri.parse(
//                         "https://clri-ltc.ca/files/2018/09/TEMP-PDF-Document.pdf"))
//                     .readAsBytes();
//                 final pdfDoc =
//                     PdfDocument.fromBase64String(base64Encode(u8list));
//                 pdfDoc.pages.add().graphics.drawString(
//                       'Ritesh Khadse',
//                       PdfStandardFont(
//                         PdfFontFamily.timesRoman,
//                         20,
//                       ),
//                     );
//                 print(appDocDir.path);
//                 final file =
//                     await File('${appDocDir.path}/output.pdf').create();
//                 file.writeAsBytes(pdfDoc.saveSync());
//                 pdfDoc.dispose();
//
//                 document = await PDFDocument.fromFile(
//                     File('${appDocDir.path}/output.pdf'));
//                 setState(() {});
//               },
//               child: Text('Sign pdf')),
//         ],
//       ),
//     );
//   }
// }
