import 'package:flutter/material.dart';

class NoteDetailPage extends StatelessWidget {
  const NoteDetailPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const NoteDetailPage());
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
