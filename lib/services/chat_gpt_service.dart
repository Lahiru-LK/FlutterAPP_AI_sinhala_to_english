import 'dart:convert';
import 'package:http/http.dart' as http;
import '../utils/api_key.dart';

class GoogleTranslateService {
  static const String _baseUrl = "https://translation.googleapis.com/language/translate/v2";

  static Future<String> translateText(String text, String targetLanguage) async {
    final response = await http.post(
      Uri.parse("$_baseUrl?key=$googleTranslateApiKey"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "q": text,
        "target": targetLanguage,
        "format": "text"
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data["data"]["translations"][0]["translatedText"];
    } else {
      return "Translation failed: ${response.body}";
    }
  }
}
