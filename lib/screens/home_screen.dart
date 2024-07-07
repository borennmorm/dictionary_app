import 'package:dictionary_app/screens/about_screen.dart';
import 'package:dictionary_app/screens/save_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/dictionary_controller.dart';
import '../widgets/word_card.dart';
import 'definition_screen.dart';

class HomeScreen extends StatelessWidget {
  final DictionaryController controller = Get.put(DictionaryController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'វចនានុក្រមខ្មែរ',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green,
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Get.to(() => SaveScreen());
            },
            icon: const Icon(CupertinoIcons.bookmark,
                size: 28, color: Colors.white),
          ),
        ],
      ),
      backgroundColor: Colors.grey[200],
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.green,
              ),
              child: Text(
                'វចនានុក្រមខ្មែរ',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(
                Icons.home,
                color: Colors.green,
              ),
              title: const Text('ទំព័រដើម'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.info, color: Colors.green),
              title: const Text('អំពីយើង'),
              onTap: () {
                Get.to(() => const AboutScreen());
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Container(
            color: Colors.green,
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'ស្វែងរក',
                labelStyle: const TextStyle(color: Colors.black),
                fillColor: Colors.white,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.green),
                ),
              ),
              onChanged: (query) => controller.fetchWords(query),
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 12, right: 12),
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }
                final wordsToShow = controller.words.take(100).toList();
                return ListView.builder(
                  itemCount: wordsToShow.length,
                  itemBuilder: (context, index) {
                    final word = wordsToShow[index];
                    return WordCard(
                      word: word,
                      onTap: () => Get.to(() => DefinitionScreen(word: word)),
                      onFavoriteChanged: (isFavorite) {
                        if (isFavorite) {
                          controller.addToSaved(word);
                        } else {
                          controller.removeFromSaved(word);
                        }
                      },
                    );
                  },
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
