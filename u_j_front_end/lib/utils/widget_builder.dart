import 'package:flutter/material.dart';

class WidgetBuilderUtil {
  WidgetBuilderUtil._(); // private constructor

  /* ================= ICON RESOLVER ================= */

  static IconData resolveIcon(String? iconName) {
    switch (iconName) {
      case "phone":
        return Icons.phone;
      case "lock":
        return Icons.lock;
      case "email":
        return Icons.email;
      case "user":
        return Icons.person;
      default:
        return Icons.text_fields;
    }
  }

  /* ================= IMAGE FIT RESOLVER ================= */

  static BoxFit resolveBoxFit(String? fitType) {
    switch (fitType?.toLowerCase()) {
      case "cover":
        return BoxFit.cover;
      case "contain":
        return BoxFit.contain;
      case "fill":
        return BoxFit.fill;
      case "fitwidth":
        return BoxFit.fitWidth;
      case "fitheight":
        return BoxFit.fitHeight;
      case "none":
        return BoxFit.none;
      case "scaledown":
        return BoxFit.scaleDown;
      default:
        return BoxFit.cover;
    }
  }

  /* ================= IMAGE SECTION BUILDER ================= */

  static Widget? buildImageSection({
    required Map<String, dynamic> imageSection,
  }) {
    if (imageSection["visible"] != true) {
      return null;
    }

    final String? imageUrl = imageSection["image_url"];
    final String imageType = imageSection["image_type"] ?? "asset";
    final BoxFit fit = resolveBoxFit(imageSection["fit"]);
    final double? width = imageSection["width"]?.toDouble();
    final double? height = imageSection["height"]?.toDouble();

    if (imageUrl == null || imageUrl.isEmpty) {
      return null;
    }

    Widget imageWidget;

    if (imageType == "network") {
      imageWidget = Image.network(
        imageUrl,
        fit: fit,
        width: width,
        height: height,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            width: width,
            height: height,
            color: Colors.grey[300],
            child: const Center(
              child: Icon(
                Icons.image_not_supported,
                size: 64,
                color: Colors.grey,
              ),
            ),
          );
        },
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Container(
            width: width,
            height: height,
            child: Center(
              child: CircularProgressIndicator(
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes!
                    : null,
              ),
            ),
          );
        },
      );
    } else {
      // asset image
      imageWidget = Image.asset(
        imageUrl,
        fit: fit,
        width: width,
        height: height,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            width: width,
            height: height,
            color: Colors.grey[300],
            child: const Center(
              child: Icon(
                Icons.image_not_supported,
                size: 64,
                color: Colors.grey,
              ),
            ),
          );
        },
      );
    }

    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(22),
        bottomLeft: Radius.circular(22),
      ),
      child: imageWidget,
    );
  }

  /* ================= FIELD BUILDER ================= */

  static Widget buildField({
    required Map<String, dynamic> field,
    required bool obscurePassword,
    required ValueChanged<bool> onTogglePassword,
    required ValueChanged<String> onChanged,
  }) {
    final bool isPassword = field["field_type"] == "password";
    final bool isPhone = field["key"] == "phone";

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          field["label"] ?? "",
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        TextField(
          keyboardType: isPhone ? TextInputType.phone : TextInputType.text,
          obscureText: isPassword ? obscurePassword : false,
          onChanged: onChanged,
          enabled: field["enabled"] ?? true,
          decoration: InputDecoration(
            hintText: field["placeHolder"] ?? "",
            prefixIcon: Icon(
              resolveIcon(field["icon"]),
            ),
            suffixIcon: isPassword
                ? IconButton(
                    icon: Icon(
                      obscurePassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                    onPressed: () => onTogglePassword(!obscurePassword),
                  )
                : null,
            filled: true,
            fillColor: const Color(0xFFF7F8FA),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        const SizedBox(height: 22),
      ],
    );
  }

  /* ================= BUTTON BUILDER ================= */

  static Widget buildPrimaryButton({
    required String label,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF143A6E),
          elevation: 6,
          shadowColor: Colors.black.withOpacity(0.3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}