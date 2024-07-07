class Word {
  final String word;
  final String definition;
  bool isFavorite;

  Word({required this.word, required this.definition, this.isFavorite = false});

  factory Word.fromJson(Map<String, dynamic> json) {
    return Word(
      word: json['word'],
      definition: json['definition'],
    );
  }
}
