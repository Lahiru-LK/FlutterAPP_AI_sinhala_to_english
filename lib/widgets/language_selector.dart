import 'package:flutter/material.dart';

class LanguageSelector extends StatelessWidget {
  final String flag;
  final String language;
  final VoidCallback onTap;

  const LanguageSelector({
    super.key,
    required this.flag,
    required this.language,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Text(flag, style: const TextStyle(fontSize: 20)),
          const SizedBox(width: 8),
          Text(language, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
