import 'dart:io';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:file_picker/file_picker.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';

import '../components/layout/application_shell.dart';
import '../components/personal_info/form_header.dart';
import '../components/personal_info/field_builders/continue_button.dart';
import '../screens/review_screen.dart';
import 'package:u_j_front_end/models/review_model.dart';

/* ===================== DOCUMENT TYPES ===================== */

enum DocumentType {
  hospitalization,
  additional,
  doctor,
}

/* ===================== SCREEN ===================== */

class UploadDocumentsScreen extends StatefulWidget {
  const UploadDocumentsScreen({super.key});

  @override
  State<UploadDocumentsScreen> createState() =>
      _UploadDocumentsScreenState();
}

class _UploadDocumentsScreenState extends State<UploadDocumentsScreen> {
  static const int maxFileSizeBytes = 5 * 1024 * 1024; // 5 MB

  final Map<DocumentType, bool> uploadStatus = {
    DocumentType.hospitalization: false,
    DocumentType.additional: false,
    DocumentType.doctor: false,
  };

  final Map<DocumentType, Uint8List?> fileBytes = {};
  final Map<DocumentType, String?> fileNames = {};
  final Map<DocumentType, String?> fileSizes = {};

  bool get allUploaded =>
      uploadStatus.values.every((value) => value);

  // 🔹 LOAD JSON FROM ASSETS
  Future<Map<String, dynamic>> _loadUploadDocsConfig() async {
    final jsonString =
    await rootBundle.loadString('assets/data/upload_document.json');
    return json.decode(jsonString);
  }

  String formatFileSize(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) {
      return '${(bytes / 1024).toStringAsFixed(2)} KB';
    }
    return '${(bytes / (1024 * 1024)).toStringAsFixed(2)} MB';
  }

  Future<void> pickFile(DocumentType type) async {
    FilePickerResult? result =
    await FilePicker.platform.pickFiles(withData: true);

    if (result == null || result.files.isEmpty) return;

    final PlatformFile file = result.files.single;
    final Uint8List? bytes = file.bytes;
    if (bytes == null) return;

    if (bytes.length > maxFileSizeBytes) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('File size must be less than 5 MB'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      uploadStatus[type] = true;
      fileBytes[type] = bytes;
      fileNames[type] = file.name;
      fileSizes[type] = formatFileSize(bytes.length);
    });

    _showSuccessBanner(file.name, fileSizes[type]!);
  }

  Future<void> openPreview(DocumentType type) async {
    final bytes = fileBytes[type];
    final name = fileNames[type];

    if (bytes == null || name == null) return;

    final lower = name.toLowerCase();

    if (lower.endsWith('.jpg') ||
        lower.endsWith('.jpeg') ||
        lower.endsWith('.png')) {
      _showImagePreview(bytes);
    } else {
      final dir = await getTemporaryDirectory();
      final file = File('${dir.path}/$name');
      await file.writeAsBytes(bytes, flush: true);
      await OpenFilex.open(file.path);
    }
  }

  void _showImagePreview(Uint8List bytes) {
    showDialog(
      context: context,
      builder: (_) => Dialog(
        insetPadding: const EdgeInsets.all(20),
        child: InteractiveViewer(
          panEnabled: true,
          minScale: 0.5,
          maxScale: 4,
          child: Image.memory(bytes),
        ),
      ),
    );
  }

  void _showSuccessBanner(String name, String size) {
    final messenger = ScaffoldMessenger.of(context);

    messenger
      ..clearMaterialBanners()
      ..showMaterialBanner(
        MaterialBanner(
          backgroundColor: Colors.green.shade50,
          leading:
          const Icon(Icons.check_circle, color: Colors.green),
          content: Text(
            'File "$name" ($size) uploaded successfully',
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          actions: [
            TextButton(
              onPressed: messenger.hideCurrentMaterialBanner,
              child: const Text('DISMISS'),
            ),
          ],
        ),
      );

    Future.delayed(const Duration(seconds: 5), () {
      if (mounted) messenger.hideCurrentMaterialBanner();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: _loadUploadDocsConfig(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final config = snapshot.data!;
        final documents = config["documents"] as List;

        return ApplicationShell(
          currentStep: 3,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(32),
            child: Center(
              child: Container(
                width: 900,
                padding: const EdgeInsets.all(28),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Column(
                  children: [
                    FormHeader(
                      title: config["title"],
                      subtitle: config["subtitle"],
                    ),

                    const SizedBox(height: 32),

                    Wrap(
                      spacing: 30,
                      runSpacing: 30,
                      children: documents.map<Widget>((doc) {
                        final DocumentType type =
                        DocumentType.values.firstWhere(
                              (e) => e.name == doc["key"],
                        );

                        return _UploadCard(
                          title: doc["title"],
                          subtitle: doc["subtitle"],
                          uploaded: uploadStatus[type]!,
                          onUpload: () => pickFile(type),
                          onPreview: () => openPreview(type),
                        );
                      }).toList(),
                    ),

                    const SizedBox(height: 50),

                    Align(
                      alignment: Alignment.centerRight,
                      child: ContinueButton(
                        onPressed: allUploaded
                            ? () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ReviewPage(
                                reviewData:
                                ReviewModel.getSampleData(),
                              ),
                            ),
                          );
                        }
                            : null,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

/* ===================== UPLOAD CARD ===================== */

class _UploadCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool uploaded;
  final VoidCallback onUpload;
  final VoidCallback onPreview;

  const _UploadCard({
    required this.title,
    required this.subtitle,
    required this.uploaded,
    required this.onUpload,
    required this.onPreview,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: uploaded ? onPreview : onUpload,
        child: Container(
          width: 260,
          height: 190,
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: uploaded ? Colors.green : Colors.black54,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                uploaded ? Icons.visibility : Icons.add,
                size: 30,
                color: uploaded ? Colors.green : Colors.black,
              ),
              const SizedBox(height: 14),
              Text(
                title,
                textAlign: TextAlign.center,
                style:
                const TextStyle(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 6),
              Text(
                subtitle,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
