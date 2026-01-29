// lib/models/document_model.dart
class DocumentModel {
  final String name;
  final String fileName;
  final bool isUploaded;

  DocumentModel({
    required this.name,
    required this.fileName,
    this.isUploaded = true,
  });

  factory DocumentModel.fromJson(Map<String, dynamic> json) {
    return DocumentModel(
      name: json['name'] as String,
      fileName: json['fileName'] as String,
      isUploaded: json['isUploaded'] as bool? ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'fileName': fileName,
      'isUploaded': isUploaded,
    };
  }
}

