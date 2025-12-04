import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/note_provider.dart';
import '../widgets/note_card.dart';
import 'note_editor_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    Provider.of<NoteProvider>(context, listen: false).loadNotes();
  }

  // ⭐ Hàm mở trang Editor và reload khi quay lại
  Future<void> _openEditor(NoteProvider provider, [note]) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => NoteEditorScreen(note: note),
      ),
    );
    provider.loadNotes(); // ⭐⭐⭐ Load lại sau khi pop
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<NoteProvider>();
    final notes = provider.notes;

    return Scaffold(
      appBar: AppBar(title: const Text('Simple Note App')),

      body: notes.isEmpty
          ? const Center(child: Text('No notes yet'))
          : ListView.builder(
        itemCount: notes.length,
        itemBuilder: (context, index) {
          final note = notes[index];
          return NoteCard(
            note: note,
            onTap: () => _openEditor(provider, note),
            onDelete: () async {
              await provider.deleteNote(note.id!);
            },
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () => _openEditor(provider),
        child: const Icon(Icons.add),
      ),
    );
  }
}
