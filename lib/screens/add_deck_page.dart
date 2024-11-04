// lib/screens/add_deck_page.dart
import 'package:flutter/material.dart';
import '../models/deck.dart';
import '../models/flashcard.dart';

class AddDeckPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TextEditingController titleController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add New Deck",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: 'Deck Title'),
              ),
              SizedBox(height: 24.0),
              TextButton(
                onPressed: () {
                  // Create a new Deck with an empty list of flashcards
                  final newDeck = Deck(
                    title: titleController.text,
                    flashcards: [],
                  );
                  // Pass the new deck back to the previous screen
                  Navigator.pop(context, newDeck);
                },
                child: Text(
                  "Add Deck",
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
