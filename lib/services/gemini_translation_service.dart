import 'dart:convert';
import 'package:http/http.dart' as http;

class GeminiTranslationService {
  static const String _apiKey = "AIzaSyDytxnq3LGzzinjfOm26KBPkQFo8SdBAz0";  // 🔒 Replace with your actual API key
  static const String _baseUrl =
      "https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent";

  Future<String> translateText(String text) async {
    final response = await http.post(
      Uri.parse("$_baseUrl?key=$_apiKey"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "contents": [
          {
            "parts": [
              {"text": "Translate the following Sinhala text to English: $text"}
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
