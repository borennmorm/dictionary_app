import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/dictionary_controller.dart';
import 'definition_screen.dart';

class SaveScreen extends StatelessWidget {
  final DictionaryController controller = Get.put(DictionaryController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'រក្សាពាក្យទុក',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green,
      ),
      body: Obx(() {
        final savedWords = controller.savedWords;
        if (savedWords.isEmpty) {
          return const Center(
            child: Text('No saved words yet.'),
          );
        }
        return ListView.builder(
          itemCount: savedWords.length,
          itemBuilder: (context, index) {
            final savedWord = savedWords[index];
            return Card(
              margin: const EdgeInsets.all(10),
              child: ListTile(
                title: Text(savedWord.word),
                trailing: IconButton(
                  icon: const Icon(
                    Icons.bookmark,
                    color: Colors.green,
                  ),
                  onPressed: () {
                    controller.toggleSaveWord(savedWord);
                  },
                ),
                onTap: () => Get.to(() => DefinitionScreen(word: savedWord)),
              ),
            );
          },
        );
      }),
    );
  }
}
