import 'package:flutter/material.dart';
import '../services/chat_gpt_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  final TextEditingController _controller = TextEditingController();
  String _translatedText = "";
  bool _isLoading = false;

  // Default Language Setup
  String _sourceLanguage = "සිංහල";
  String _targetLanguage = "English";
  String _sourceFlag = "🇱🇰";
  String _targetFlag = "🇺🇸";

  // Function to swap languages
  void _swapLanguages() {
    setState(() {
      String tempLanguage = _sourceLanguage;
      _sourceLanguage = _targetLanguage;
      _targetLanguage = tempLanguage;

      String tempFlag = _sourceFlag;
      _sourceFlag = _targetFlag;
      _targetFlag = tempFlag;
    });
  }

  // Function to handle translation using ChatGPT API
  void _translateText() async {
    if (_controller.text.isEmpty) return;

    setState(() => _isLoading = true);

    String translatedText = await GoogleTranslateService.translateText(_controller.text, "en");

    setState(() {
      _translatedText = translatedText;
      _isLoading = false;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade900,
        title: const Text(
          'Language Translator',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.menu, color: Colors.white),
            onPressed: () {}, // TODO: Implement menu drawer
          )
        ],
      ),
      body: SingleChildScrollView(  // 🛠️ Fix Overflow Issue
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Language Selection Row
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(color: Colors.grey.shade300, blurRadius: 4),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _languageSelector("🇱🇰", "සිංහල"),
                    IconButton(
                      icon: const Icon(Icons.swap_horiz, size: 28, color: Colors.blue),
                      onPressed: _swapLanguages,
                    ),
                    _languageSelector("🇺🇸", "English"),
                  ],
                ),
              ),
              const SizedBox(height: 10),

              // Input Text Box
              _translationBox(
                title: "සිංහල",
                text: _controller.text,
                isInput: true,
                onTranslate: _translateText,
                controller: _controller,
              ),
              const SizedBox(height: 10),

              // Output Translation Box
              _translationBox(
                title: "English",
                text: _translatedText.isEmpty
                    ? "Translation will appear here"
                    : _translatedText,
                isInput: false,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.blue.shade900,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: "Chat"),
          BottomNavigationBarItem(icon: Icon(Icons.camera_alt), label: "Camera"),
          BottomNavigationBarItem(icon: Icon(Icons.translate), label: "Translate"),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: "History"),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Favourite"),
        ],
      ),
    );
  }


  // Language Selector Widget
  Widget _languageSelector(String flag, String language) {
    return Row(
      children: [
        Text(flag, style: const TextStyle(fontSize: 20)),
        const SizedBox(width: 8),
        Text(
          language,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  // Translation Box Widget
  Widget _translationBox({
    required String title,
    required String text,
    required bool isInput,
    TextEditingController? controller,
    VoidCallback? onTranslate,
  }) {
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
              Text(
                title,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
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
              : Text(
            text,
            style: const TextStyle(fontSize: 16),
          ),
          if (isInput)
            Align(
              alignment: Alignment.bottomRight,
              child: ElevatedButton(
                onPressed: onTranslate,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white, // White text color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                ),
                child: _isLoading
                    ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                )
                    : const Text(
                  "Translate",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // Ensures text color is white
                  ),
                ),
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
