import 'package:flutter/material.dart';

class LessonWidget extends StatefulWidget {
  const LessonWidget({super.key});

  @override
  State<LessonWidget> createState() => _LessonWidgetState();
}

class _LessonWidgetState extends State<LessonWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5, 
            offset: const Offset(0, 3),
          ),
        ],

      ),
      margin: const EdgeInsets.only(bottom: 16.0),
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          const Icon(Icons.book, size: 40.0, color: Colors.blue),
          const SizedBox(width: 16.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Lesson Title',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  'Brief description of the lesson goes here.',
                  style: TextStyle(fontSize: 14.0, color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}