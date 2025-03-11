import 'dart:convert';
import 'package:http/http.dart' as http;

class GeminiTranslationService {
  static const String _apiKey = "AIzaSyDytxnq3LGzzinjfOm26KBPkQFo8SdBAz0";
  static const String _baseUrl = "https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent?key=$_apiKey";

  Future<String> translateText(String text, bool isEnglishToSinhala) async {
    final response = await http.post(
      Uri.parse(_baseUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "contents": [
          {
            "parts": [
              {
                "text": isEnglishToSinhala
                    ? "Translate the following English text to Sinhala with proper grammar and structure. Ensure clarity and correctness while keeping it formal and natural, without unnecessary explanations ,  similar to Google Translate: $text"
                    : "Translate the following Sinhala sentence to English with proper grammar and structure. Ensure clarity and correctness while keeping it formal and natural, similar to Google Translate: $text"
              }
            ]
          }
        ]
      }),
    );

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      try {
        return jsonResponse["candidates"][0]["content"]["parts"][0]["text"];
      } catch (e) {
        return "Translation failed. Unexpected response format.";
      }
    } else {
      return "Translation failed: ${response.body}";
    }
  }


}
