// lib/screens/deck_page.dart
import 'package:flutter/material.dart';
import '../models/deck.dart';
import 'flashcard_page.dart';
import 'edit_deck_page.dart';
import 'add_deck_page.dart';
import 'dart:convert';
import 'package:flutter/services.dart';

class DeckPage extends StatefulWidget {
  final List<Deck> decks;

  DeckPage({required this.decks});

  @override
  _DeckPageState createState() => _DeckPageState();
}

class _DeckPageState extends State<DeckPage> {
  List<Deck> decks = [];

  @override
  void initState() {
    super.initState();
    decks = widget.decks;
  }

  Future<void> _addNewDeck() async {
    final newDeck = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddDeckPage(),
      ),
    );

    if (newDeck != null && newDeck is Deck) {
      setState(() {
        decks.add(newDeck);
      });
    }
  }

  Future<void> _editDeck(int index) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditDeckPage(deck: decks[index]),
      ),
    );

    if (result != null) {
      if (result['deleted'] == true) {
        setState(() {
          decks.removeAt(index);
        });
      } else if (result['title'] != null) {
        setState(() {
          decks[index] =
              Deck(title: result['title'], flashcards: decks[index].flashcards);
        });
      }
    }
  }

  Future<void> _viewFlashcards(int index) async {
    final updatedDeck = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FlashcardPage(deck: decks[index]),
      ),
    );

    if (updatedDeck != null) {
      setState(() {
        decks[index] = updatedDeck;
      });
    }
  }

  Future<void> _reloadDecks() async {
    final String response = await rootBundle
        .loadString('assets/flashcards.json'); // Load your JSON file
    final data = json.decode(response) as List; // Decode the JSON data
    setState(() {
      decks = data
          .map((deckJson) => Deck.fromJson(deckJson))
          .toList(); // Map to Deck objects
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Decks",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0), // Add right padding
            child: Container(
              margin: EdgeInsets.only(right: 8.0), // Add margin
              child: IconButton(
                icon:
                    Icon(Icons.download, color: Colors.white), // Download icon
                onPressed: _reloadDecks, // Call the reload function
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1.0,
          ),
          itemCount: decks.length,
          itemBuilder: (context, index) {
            final deck = decks[index];
            return GestureDetector(
              onTap: () {
                _viewFlashcards(index);
              },
              child: Card(
                margin: EdgeInsets.all(8.0),
                color: Color(0xFFF5E2AB),
                child: Stack(
                  children: [
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            deck.title,
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: 8,
                      right: 8,
                      child: IconButton(
                        icon: Icon(Icons.edit, color: Colors.blue),
                        onPressed: () {
                          _editDeck(index);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewDeck,
        backgroundColor: Colors.blue,
        child: Icon(Icons.add, color: Colors.white),
        tooltip: 'Add Deck',
      ),
    );
  }
}
