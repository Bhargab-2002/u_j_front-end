// lib/screen/review/widgets/document_list.dart
import 'package:flutter/material.dart';
import '../../../models/document_model.dart';
import '../../../theme/colors.dart';
import '../../../theme/spacing.dart';
class DocumentList extends StatelessWidget {
  final List<DocumentModel> documents;

  const DocumentList({super.key, required this.documents});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: documents
          .map((doc) => _buildDocumentItem(doc))
          .toList(),
    );
  }

  Widget _buildDocumentItem(DocumentModel document) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.lg),
      child: Row(
        children: [
          Expanded(
            child: Text(
              document.name,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.grey[300]!),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: AppColors.successGreen,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 14,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  document.fileName,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}