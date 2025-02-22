import 'package:flutter/material.dart';

class TranslationBox extends StatelessWidget {
  final String title;
  final String text;
  final bool isInput;
  final TextEditingController? controller;
  final VoidCallback? onTranslate;

  const TranslationBox({
    super.key,
    required this.title,
    required this.text,
    required this.isInput,
    this.controller,
    this.onTranslate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [BoxShadow(color: Colors.grey.shade300, blurRadius: 4)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const Spacer(),
              const Icon(Icons.volume_up, color: Colors.blue),
              if (isInput) const SizedBox(width: 8),
              if (isInput) const Icon(Icons.close, color: Colors.red),
            ],
          ),
          const SizedBox(height: 10),
          isInput
              ? TextField(
            controller: controller,
            decoration: const InputDecoration(
              hintText: "Enter text...",
              border: InputBorder.none,
            ),
            maxLines: 3,
          )
              : Text(text, style: const TextStyle(fontSize: 16)),
          if (isInput)
            Align(
              alignment: Alignment.bottomRight,
              child: ElevatedButton(
                onPressed: onTranslate,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                ),
                child: const Text("Translate", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            )
          else
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: const [
                Icon(Icons.copy, color: Colors.grey),
                SizedBox(width: 8),
                Icon(Icons.share, color: Colors.grey),
                SizedBox(width: 8),
                Icon(Icons.star_border, color: Colors.grey),
              ],
            ),
        ],
      ),
    );
  }
}
