// lib/screens/add_flashcard_page.dart
import 'package:flutter/material.dart';
import '../models/deck.dart';
import '../models/flashcard.dart';

class AddFlashcardPage extends StatefulWidget {
  final Deck deck;

  AddFlashcardPage({required this.deck});

  @override
  _AddFlashcardPageState createState() => _AddFlashcardPageState();
}

class _AddFlashcardPageState extends State<AddFlashcardPage> {
  final _questionController = TextEditingController();
  final _answerController = TextEditingController();

  void _addFlashcard() {
    final newFlashcard = Flashcard(
      question: _questionController.text,
      answer: _answerController.text,
    );

    Navigator.pop(context, newFlashcard); // Pass new flashcard back
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Flashcard',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _questionController,
                decoration: InputDecoration(labelText: 'Question'),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _answerController,
                decoration: InputDecoration(labelText: 'Answer'),
              ),
              SizedBox(height: 24.0),
              TextButton(
                onPressed: _addFlashcard,
                child: Text(
                  'Save Flashcard',
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
