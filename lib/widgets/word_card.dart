import 'package:flutter/material.dart';
import '../models/word_model.dart';

class WordCard extends StatefulWidget {
  final Word word;
  final VoidCallback onTap;
  final ValueChanged<bool> onFavoriteChanged;

  const WordCard({
    Key? key,
    required this.word,
    required this.onTap,
    required this.onFavoriteChanged,
  }) : super(key: key);

  @override
  _WordCardState createState() => _WordCardState();
}

class _WordCardState extends State<WordCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        leading: const Icon(
          Icons.wb_sunny,
          color: Colors.green,
        ),
        title: Text(widget.word.word),
        trailing: IconButton(
          icon: Icon(
            widget.word.isFavorite
                ? Icons.bookmark
                : Icons.bookmark_border_outlined,
            color: Colors.green,
          ),
          onPressed: () {
            setState(() {
              widget.word.isFavorite = !widget.word.isFavorite;
              widget.onFavoriteChanged(widget.word.isFavorite);
            });
          },
        ),
        onTap: widget.onTap,
      ),
    );
  }
}
