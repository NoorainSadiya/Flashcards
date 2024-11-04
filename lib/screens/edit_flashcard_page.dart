import 'package:flutter/material.dart';
import '../models/flashcard.dart';

class EditFlashcardPage extends StatefulWidget {
  final Flashcard flashcard;

  EditFlashcardPage({required this.flashcard});

  @override
  _EditFlashcardPageState createState() => _EditFlashcardPageState();
}

class _EditFlashcardPageState extends State<EditFlashcardPage> {
  late TextEditingController questionController;
  late TextEditingController answerController;

  @override
  void initState() {
    super.initState();
    questionController = TextEditingController(text: widget.flashcard.question);
    answerController = TextEditingController(text: widget.flashcard.answer);
  }

  void saveFlashcard() {
    Navigator.pop(
      context,
      Flashcard(
        question: questionController.text,
        answer: answerController.text,
      ),
    );
  }

  void deleteFlashcard() {
    Navigator.pop(context, null); // Returning null indicates deletion
  }

  @override
  void dispose() {
    questionController.dispose();
    answerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Edit Flashcard",
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
                controller: questionController,
                decoration: InputDecoration(labelText: "Question"),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: answerController,
                decoration: InputDecoration(labelText: "Answer"),
              ),
              SizedBox(height: 32.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                    onPressed: saveFlashcard,
                    child: Text(
                      "Save",
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                  TextButton(
                    onPressed: deleteFlashcard,
                    child: Text(
                      "Delete",
                      style: TextStyle(color: Colors.blue),
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
