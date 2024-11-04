import 'package:flutter/material.dart';
import '../models/deck.dart'; // Import Deck model
import '../models/flashcard.dart'; // Import Flashcard model
import 'dart:math'; // Import dart:math for random

class QuizPage extends StatefulWidget {
  final Deck deck;

  QuizPage({required this.deck});

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  late List<Flashcard> shuffledFlashcards; // List to hold shuffled flashcards
  int currentIndex = 0; // Track current flashcard index
  int seenCount = 0; // Track number of seen flashcards
  int peekedCount = 0; // Track number of peeked answers
  bool isAnswerShown = false; // Track if the answer is shown

  @override
  void initState() {
    super.initState();
    shuffledFlashcards =
        List.from(widget.deck.flashcards); // Create a copy of the flashcards
    shuffledFlashcards.shuffle(Random()); // Shuffle the flashcards
  }

  void showAnswer() {
    setState(() {
      isAnswerShown = true;
      peekedCount++; // Increment peeked count when answer is shown
    });
  }

  void nextCard() {
    if (currentIndex < shuffledFlashcards.length - 1) {
      setState(() {
        currentIndex++;
        isAnswerShown = false; // Reset answer shown state
        seenCount++; // Increment seen count
      });
    }
  }

  void previousCard() {
    if (currentIndex > 0) {
      setState(() {
        currentIndex--;
        isAnswerShown = false; // Reset answer shown state
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentCard = shuffledFlashcards[
        currentIndex]; // Get the current card from the shuffled list

    // Calculate half of the screen height
    final double boxHeight = MediaQuery.of(context).size.height / 2;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Quiz: ${widget.deck.title}",
          style: TextStyle(color: Colors.white), // Set title color to white
        ),
        backgroundColor: Colors.blue, // Set AppBar background color
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 16.0), // Adjust top padding
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start, // Align to the top
          children: [
            // Flashcard
            Padding(
              padding: const EdgeInsets.all(16),
              child: Container(
                height:
                    boxHeight, // Set the height to half of the screen height
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: isAnswerShown
                      ? Color(0xFFC8E6C9)
                      : Color(0xFFBBDEFA), // Updated colors
                ),
                padding: EdgeInsets.all(32), // Increase padding for larger size
                child: Center(
                  child: Text(
                    isAnswerShown ? currentCard.answer : currentCard.question,
                    style: TextStyle(fontSize: 28), // Increased font size
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            // Control Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_left),
                  onPressed: previousCard,
                ),
                IconButton(
                  icon: Icon(Icons.visibility),
                  onPressed: showAnswer,
                ),
                IconButton(
                  icon: Icon(Icons.arrow_right),
                  onPressed: nextCard,
                ),
              ],
            ),
            // Seen Count
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                  "Seen: $seenCount of ${shuffledFlashcards.length}"), // Change 'cards' to 'flashcards'
            ),
            // Peeked Count
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text("Peeked: $peekedCount of $seenCount"),
            ),
          ],
        ),
      ),
    );
  }
}
