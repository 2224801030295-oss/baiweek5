import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/note.dart';
import '../providers/note_provider.dart';

class NoteEditorScreen extends StatefulWidget {
  final Note? note;

  const NoteEditorScreen({super.key, this.note});

  @override
  State<NoteEditorScreen> createState() => _NoteEditorScreenState();
}

class _NoteEditorScreenState extends State<NoteEditorScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // Nếu là sửa note thì fill sẵn dữ liệu
    if (widget.note != null) {
      titleController.text = widget.note!.title;
      contentController.text = widget.note!.content;
    }
  }

  void saveNote() {
    final provider = Provider.of<NoteProvider>(context, listen: false);

    String title = titleController.text.trim();
    String content = contentController.text.trim();

    if (title.isEmpty && content.isEmpty) {
      Navigator.pop(context);
      return;
    }

    // Nếu note cũ -> update
    if (widget.note != null) {
      final updatedNote = Note(
        id: widget.note!.id,
        title: title,
        content: content,
        timestamp: DateTime.now().toIso8601String(),
      );
      provider.updateNote(updatedNote);
    } else {
      // Note mới -> add
      final newNote = Note(
        title: title,
        content: content,
        timestamp: DateTime.now().toIso8601String(),
      );
      provider.addNote(newNote);
    }

    Navigator.pop(context); // Trở về HomePage sau khi lưu
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.note == null ? 'New Note' : 'Edit Note'),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: saveNote, // NÚT LƯU QUAN TRỌNG
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                hintText: 'Title',
                border: InputBorder.none,
              ),
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: TextField(
                controller: contentController,
                decoration: const InputDecoration(
                  hintText: 'Write something...',
                  border: InputBorder.none,
                ),
                maxLines: null,
                expands: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
