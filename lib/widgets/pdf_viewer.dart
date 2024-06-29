import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:http/http.dart'
    as http; // Add this line to import the http package
import 'package:cloud_storo/modals/file_model.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class PdfViewer extends StatefulWidget {
  final FileModel file;

  PdfViewer({super.key, required this.file});

  @override
  State<PdfViewer> createState() => _PdfViewerState();
}

class _PdfViewerState extends State<PdfViewer> {
  late File pdfFile;
  bool initialized = false;
  loadpdffFile(FileModel file) async {
    final response = await http.get(
      Uri.parse(file.url),
    );
    final bytes = response.bodyBytes;
    return storeFile(file, bytes);
  }

  storeFile(FileModel file, List<int> bytes) async {
    final dir = await getApplicationDocumentsDirectory();
    final filename = File("${dir.path}/${file.name}");
    await filename.writeAsBytes(bytes, flush: true);
    return filename;
  }

  initializePDF() async {
    pdfFile = await loadpdffFile(widget.file);
    initialized = true;
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initializePDF();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: initialized
          ? PDFView(
              filePath: pdfFile.path,
              fitEachPage: false,
            )
          : Container(),
    );
  }
}
