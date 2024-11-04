import 'package:flutter/material.dart';
import 'models/deck.dart'; // Ensure you import the Deck model correctly
import 'services/flashcard_service.dart'; // Import the service to load decks
import 'screens/deck_page.dart'; // Import DeckPage

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flashcards App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FutureBuilder<List<Deck>>(
        future: FlashcardService().loadDecks(), // Load the decks asynchronously
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            return DeckPage(
                decks: snapshot.data!); // Pass loaded decks to DeckPage
          } else {
            return Center(child: Text('No decks available.'));
          }
        },
      ),
    );
  }
}
