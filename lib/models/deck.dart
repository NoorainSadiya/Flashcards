import 'flashcard.dart'; // Only import this once

class Deck {
  String title;
  final List<Flashcard> flashcards;

  Deck({required this.title, required this.flashcards});

  // Getter to get the number of flashcards
  int get numberOfCards => flashcards.length;

  factory Deck.fromJson(Map<String, dynamic> json) {
    var list = json['flashcards'] as List;
    List<Flashcard> flashcardsList =
        list.map((i) => Flashcard.fromJson(i)).toList();

    return Deck(
      title: json['title'],
      flashcards: flashcardsList,
    );
  }
}
