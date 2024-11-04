// import 'dart:io';
// import 'package:path/path.dart';
// import 'package:sqflite/sqflite.dart';
// import 'package:path_provider/path_provider.dart';
// import '../models/deck.dart';
// import '../models/flashcard.dart';
// 
// class DBHelper {
//   static final DBHelper _instance = DBHelper._internal();
//   static Database? _database;
// 
//   DBHelper._internal();
// 
//   factory DBHelper() => _instance;
// 
//   Future<Database> get database async {
//     if (_database != null) return _database!;
//     _database = await _initDatabase();
//     return _database!;
//   }
// 
//   Future<Database> _initDatabase() async {
//     Directory documentsDirectory = await getApplicationDocumentsDirectory();
//     String path = join(documentsDirectory.path, 'flashcards.db');
// 
//     return await openDatabase(
//       path,
//       version: 1,
//       onCreate: _createDB,
//     );
//   }
// 
//   Future _createDB(Database db, int version) async {
//     await db.execute('''
//       CREATE TABLE decks (
//         id INTEGER PRIMARY KEY AUTOINCREMENT,
//         title TEXT NOT NULL
//       )
//     ''');
//     await db.execute('''
//       CREATE TABLE flashcards (
//         id INTEGER PRIMARY KEY AUTOINCREMENT,
//         question TEXT NOT NULL,
//         answer TEXT NOT NULL,
//         deckId INTEGER,
//         FOREIGN KEY (deckId) REFERENCES decks (id) ON DELETE CASCADE
//       )
//     ''');
//   }
// 
//   // Add a new deck
//   Future<int> insertDeck(Deck deck) async {
//     final db = await database;
//     return await db.insert('decks', {'title': deck.title});
//   }
// 
// // Get all decks
//   Future<List<Deck>> getDecks() async {
//     final db = await database;
//     var result = await db.query('decks');
//     List<Deck> decks = [];
//     for (var deckMap in result) {
//       var flashcards = await getFlashcards(deckMap['id']);
//       decks.add(Deck(
//         title: deckMap['title'],
//         flashcards: flashcards,
//       ));
//     }
//     return decks;
//   }
// 
// // Insert a flashcard into a specific deck
//   Future<int> insertFlashcard(Flashcard flashcard, int deckId) async {
//     final db = await database;
//     return await db.insert('flashcards', {
//       'question': flashcard.question,
//       'answer': flashcard.answer,
//       'deckId': deckId,
//     });
//   }
// 
// // Get all flashcards for a specific deck
//   Future<List<Flashcard>> getFlashcards(int deckId) async {
//     final db = await database;
//     var result = await db.query(
//       'flashcards',
//       where: 'deckId = ?',
//       whereArgs: [deckId],
//     );
//     return result.map((flashcard) => Flashcard.fromJson(flashcard)).toList();
//   }
// }
