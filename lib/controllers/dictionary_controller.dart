import 'package:get/get.dart';
import '../models/word_model.dart';
import '../services/database_service.dart';

class DictionaryController extends GetxController {
  var words = <Word>[].obs;
  var isLoading = true.obs;
  var savedWords = <Word>[].obs;

  @override
  void onInit() {
    fetchWords('');
    super.onInit();
  }

  void fetchWords(String query) async {
    isLoading(true);
    try {
      final results = await DatabaseService().fetchWords(query);
      words.assignAll(results);
    } finally {
      isLoading(false);
    }
  }

  void addToSaved(Word word) {
    if (!savedWords.contains(word)) {
      savedWords.add(word);
    }
  }

  void removeFromSaved(Word word) {
    savedWords.remove(word);
  }

  void toggleSaveWord(Word word) {
    if (savedWords.contains(word)) {
      savedWords.remove(word);
    } else {
      savedWords.add(word);
    }
  }
}
