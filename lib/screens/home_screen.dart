import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../services/gemini_translation_service.dart'; // ✅ Correct import

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  final TextEditingController _controller = TextEditingController();
  final GeminiTranslationService _translationService = GeminiTranslationService();

  String _translatedText = "";
  bool _isLoading = false;
  bool _isFavorite = false; // Favorite button toggle
  int _selectedIndex = 2; // Default selected tab is 'Translate'

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

  // Function to translate text
  void _translateText() async {
    if (_controller.text.isEmpty) return;

    setState(() => _isLoading = true);

    String translation = await _translationService.translateText(_controller.text);

    setState(() {
      _translatedText = translation;
      _isLoading = false;
    });
  }

  // Function to copy translation
  void _copyText() {
    Clipboard.setData(ClipboardData(text: _translatedText));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Copied to clipboard!")),
    );
  }

  // Function to mark translation as favorite
  void _toggleFavorite() {
    setState(() {
      _isFavorite = !_isFavorite;
    });
  }

  // Function to clear text fields
  void _clearText() {
    setState(() {
      _controller.clear();
      _translatedText = "";
    });
  }

  // Handle bottom navigation bar taps
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Handle navigation based on index
    switch (index) {
      case 0:
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Chat feature coming soon!")),
        );
        break;
      case 1:
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Camera feature coming soon!")),
        );
        break;
      case 2:
      // Stay on the translate screen
        break;
      case 3:
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Translation history coming soon!")),
        );
        break;
      case 4:
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Favorites feature coming soon!")),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade900,
        title: const Text(
          'AI Language Translator',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // 🔹 Language Swap Section
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [BoxShadow(color: Colors.grey.shade300, blurRadius: 4)],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _languageSelector(_sourceFlag, _sourceLanguage),
                    IconButton(
                      icon: const Icon(Icons.swap_horiz, size: 28, color: Colors.blue),
                      onPressed: _swapLanguages,
                    ),
                    _languageSelector(_targetFlag, _targetLanguage),
                  ],
                ),
              ),
              const SizedBox(height: 10),

              // Input Text Box
              _translationBox(
                title: _sourceLanguage,
                text: _controller.text,
                isInput: true,
                onTranslate: _translateText,
                controller: _controller,
                onClear: _clearText,
              ),
              const SizedBox(height: 10),

              // Output Translation Box with Copy & Favorite
              _translationBox(
                title: _targetLanguage,
                text: _translatedText.isEmpty ? "Translation will appear here" : _translatedText,
                isInput: false,
                onCopy: _copyText,
                onFavorite: _toggleFavorite,
                isFavorite: _isFavorite,
              ),
            ],
          ),
        ),
      ),

      // 🔹 Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue.shade900,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: "Chat"),
          BottomNavigationBarItem(icon: Icon(Icons.camera_alt), label: "Camera"),
          BottomNavigationBarItem(icon: Icon(Icons.translate), label: "Translate"),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: "History"),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Favorite"),
        ],
      ),
    );
  }

  // **Language Selector Widget**
  Widget _languageSelector(String flag, String language) {
    return Row(
      children: [
        Text(flag, style: const TextStyle(fontSize: 20)),
        const SizedBox(width: 8),
        Text(language, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      ],
    );
  }

  // **Translation Box Widget**
  Widget _translationBox({
    required String title,
    required String text,
    required bool isInput,
    TextEditingController? controller,
    VoidCallback? onTranslate,
    VoidCallback? onCopy,
    VoidCallback? onFavorite,
    VoidCallback? onClear,
    bool isFavorite = false,
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
              Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const Spacer(),
              const Icon(Icons.volume_up, color: Colors.blue),
              if (isInput && onClear != null)
                GestureDetector(
                  onTap: onClear,
                  child: const Padding(
                    padding: EdgeInsets.only(left: 8),
                    child: Icon(Icons.close, color: Colors.red),
                  ),
                ),
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
                child: _isLoading
                    ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                    : const Text("Translate", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            )
          else
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (onCopy != null) IconButton(icon: const Icon(Icons.copy, color: Colors.grey), onPressed: onCopy),
                if (onFavorite != null) IconButton(icon: Icon(isFavorite ? Icons.star : Icons.star_border, color: isFavorite ? Colors.yellow : Colors.grey), onPressed: onFavorite),
              ],
            ),
        ],
      ),
    );
  }
}
