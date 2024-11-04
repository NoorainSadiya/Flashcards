// lib/screens/flashcard_page.dart
import 'package:flutter/material.dart';
import '../models/flashcard.dart';
import '../models/deck.dart';
import 'edit_flashcard_page.dart';
import 'quiz_page.dart';
import 'add_flashcard_page.dart';

class FlashcardPage extends StatefulWidget {
  final Deck deck;

  FlashcardPage({required this.deck});

  @override
  _FlashcardPageState createState() => _FlashcardPageState();
}

class _FlashcardPageState extends State<FlashcardPage> {
  bool isAlphabetical = false;

  void toggleSorting() {
    setState(() {
      isAlphabetical = !isAlphabetical;
    });
  }

  Future<void> _addFlashcard() async {
    final newFlashcard = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddFlashcardPage(deck: widget.deck),
      ),
    );

    if (newFlashcard != null && newFlashcard is Flashcard) {
      setState(() {
        widget.deck.flashcards.add(newFlashcard);
      });
    }
  }

  Future<void> _editFlashcard(int index) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            EditFlashcardPage(flashcard: widget.deck.flashcards[index]),
      ),
    );

    if (result is Flashcard) {
      // Update the flashcard
      setState(() {
        widget.deck.flashcards[index] = result;
      });
    } else if (result == null) {
      // Delete the flashcard
      setState(() {
        widget.deck.flashcards.removeAt(index);
      });
    }
  }

  void _startQuiz() {
    if (widget.deck.flashcards.isEmpty) {
      // Show a dialog if there are no flashcards
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("No Flashcards"),
            content: Text(
                "Please add flashcards to this deck before starting the quiz."),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: Text("OK"),
              ),
            ],
          );
        },
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => QuizPage(deck: widget.deck),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Flashcard> sortedFlashcards;

    if (isAlphabetical) {
      sortedFlashcards = List.from(widget.deck.flashcards);
      sortedFlashcards.sort((a, b) => a.question.compareTo(b.question));
    } else {
      sortedFlashcards = widget.deck.flashcards;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${widget.deck.title} Deck',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: Icon(
              isAlphabetical ? Icons.timer : Icons.sort_by_alpha,
              color: Colors.white,
            ),
            tooltip: 'Toggle Alphabetical Order',
            onPressed: toggleSorting,
          ),
          IconButton(
            icon: Icon(Icons.quiz, color: Colors.white),
            tooltip: 'Take Quiz',
            onPressed: _startQuiz,
          ),
        ],
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 1.0,
        ),
        itemCount: sortedFlashcards.length,
        itemBuilder: (context, index) {
          final flashcard = sortedFlashcards[index];
          return GestureDetector(
            onTap: () {
              _editFlashcard(index); // Navigate to EditFlashcardPage
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                color: Color(0xFFBBDEFA),
                child: Center(
                  child: Text(
                    flashcard.question,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addFlashcard,
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        tooltip: 'Add Flashcard',
      ),
    );
  }
}
