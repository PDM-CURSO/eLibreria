import 'dart:io';
import 'dart:typed_data';

import 'package:http/http.dart';
import 'package:native_pdf_view/native_pdf_view.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as Pw;
import 'package:flutter/material.dart';

class DetailsBookExport extends StatefulWidget {
  final Map<String, dynamic> bookDetails;
  final String? title;
  final String? img;

  DetailsBookExport({
    required this.bookDetails,
    required this.title,
    required this.img,
  });

  @override
  State<DetailsBookExport> createState() => _DetailsBookExportState();
}

class _DetailsBookExportState extends State<DetailsBookExport> {
  Future<Uint8List> _downloadFile(String url) async {
    var response = await get(Uri.parse(url));
    var bytes = response.bodyBytes;
    return bytes;
  }

  Future<String> _generatePdfPage() async {
    final pdfDoc = Pw.Document(
      title: "Ficha de venta para libro: ${widget.title}",
      author: "Org Name",
    );
    final _coverImage = Pw.MemoryImage(await _downloadFile(widget.img!));

    Pw.Page _customPdfContent = Pw.Page(
      build: (Pw.Context context) {
        return Pw.Container(
          child: Pw.ListView(
            children: <Pw.Widget>[
              Pw.Container(
                margin: Pw.EdgeInsets.all(24),
                height: 280,
                width: 200,
                child: Pw.Image(
                  _coverImage,
                ),
              ),
              Pw.Text(
                "${widget.title}\n\n${widget.bookDetails["description"] ?? "No description available"}",
              ),
            ],
          ),
        );
      },
    );

    pdfDoc.addPage(_customPdfContent);
    // Genera archivo pdf y lo guarda
    String path = (await getExternalStorageDirectory())!.path;
    File file = File("$path/fichaVenta${widget.title}.pdf");
    await file.writeAsBytes(await pdfDoc.save());
    return file.path;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Document preview")),
      body: FutureBuilder(
        future: _generatePdfPage(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text("Error al crear el Documento"));
          } else if (snapshot.hasData) {
            final pdfController = PdfController(
              document: PdfDocument.openFile("${snapshot.data}"),
            );
            return PdfView(controller: pdfController);
          } else {
            return const Text("Renderizando archivo");
          }
        },
      ),
    );
  }
}
