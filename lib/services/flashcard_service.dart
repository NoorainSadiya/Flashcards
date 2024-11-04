import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/deck.dart';

class FlashcardService {
  Future<List<Deck>> loadDecks() async {
    String jsonString = await rootBundle.loadString('assets/flashcards.json');
    final jsonResponse = json.decode(jsonString);
    List<Deck> decks =
        (jsonResponse as List).map((deck) => Deck.fromJson(deck)).toList();
    return decks;
  }
}
