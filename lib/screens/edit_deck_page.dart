// lib/screens/edit_deck_page.dart
import 'package:flutter/material.dart';
import '../models/deck.dart'; // Import the Deck model

class EditDeckPage extends StatelessWidget {
  final Deck deck;

  EditDeckPage({required this.deck});

  @override
  Widget build(BuildContext context) {
    final TextEditingController titleController =
        TextEditingController(text: deck.title);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Edit Deck",
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      // Return the updated title back to the DeckPage
                      Navigator.pop(context,
                          {'title': titleController.text, 'deleted': false});
                    },
                    child: Text(
                      "Save Changes",
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      // Return a flag indicating the deck was deleted
                      Navigator.pop(context, {'deleted': true});
                    },
                    child: Text(
                      "Delete Deck",
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
