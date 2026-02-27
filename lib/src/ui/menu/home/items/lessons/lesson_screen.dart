import 'package:en_tube/src/constraints/app_color.dart';
import 'package:en_tube/src/widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class LessonScreen extends StatefulWidget {
  const LessonScreen({super.key});

  @override
  State<LessonScreen> createState() => _LessonScreenState();
}

class _LessonScreenState extends State<LessonScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: AppBarWidget(title: tr('courses.quick_english_a2')),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Course Hero Image
            Container(
              height: 140,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Colors.purple, Colors.blue],
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(
                child: Icon(
                  Icons.play_circle_outline,
                  size: 60,
                  color: AppColor.white,
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Course Title
            Text(
              tr('courses.quick_english_a2'),
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: AppColor.white,
              ),
            ),

            const SizedBox(height: 8),

            // Course Description
            Text(
              tr('courses.achieve_high_levels'),
              style: TextStyle(
                fontSize: 14,
                color: AppColor.white.withValues(alpha: 0.7),
              ),
            ),

            const SizedBox(height: 16),

            // Course Info Cards
            Row(
              children: [
                Expanded(
                  child: _InfoCard(
                    icon: Icons.video_library,
                    title: '24 Videos',
                    subtitle: 'Total lessons',
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _InfoCard(
                    icon: Icons.timer,
                    title: '12 Hours',
                    subtitle: 'Duration',
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            Row(
              children: [
                Expanded(
                  child: _InfoCard(
                    icon: Icons.star,
                    title: 'A2 Level',
                    subtitle: 'Difficulty',
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _InfoCard(
                    icon: Icons.people,
                    title: '1,234',
                    subtitle: 'Students',
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Start Course Button (yuqorida)
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text('Starting course...')));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.play_arrow, color: AppColor.white),
                    SizedBox(width: 8),
                    Text(
                      tr('common.start'),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColor.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // What You'll Learn Section
            Text(
              'What You\'ll Learn',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColor.white,
              ),
            ),

            const SizedBox(height: 12),

            _LearningPoint(text: 'Master basic English grammar'),
            _LearningPoint(text: 'Improve your speaking skills'),
            _LearningPoint(text: 'Build your vocabulary'),
            _LearningPoint(text: 'Practice with real conversations'),

            const SizedBox(height: 20),

            // Course Content Section
            Text(
              'Course Content',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColor.white,
              ),
            ),

            const SizedBox(height: 12),

            _LessonItem(
              number: 1,
              title: 'Introduction to English',
              duration: '15 min',
              isCompleted: true,
            ),
            _LessonItem(
              number: 2,
              title: 'Basic Greetings',
              duration: '20 min',
              isCompleted: true,
            ),
            _LessonItem(
              number: 3,
              title: 'Present Simple Tense',
              duration: '30 min',
              isCompleted: false,
            ),
            _LessonItem(
              number: 4,
              title: 'Daily Routines',
              duration: '25 min',
              isCompleted: false,
            ),
            _LessonItem(
              number: 5,
              title: 'Questions and Answers',
              duration: '28 min',
              isCompleted: false,
            ),

            const SizedBox(height: 20),

            // Bottom Actions
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Added to favorites')),
                      );
                    },
                    icon: Icon(
                      Icons.favorite_border,
                      color: AppColor.white,
                      size: 20,
                    ),
                    label: Text(
                      'Save',
                      style: TextStyle(color: AppColor.white, fontSize: 14),
                    ),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(
                        color: Colors.white.withValues(alpha: 0.3),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Sharing course...')),
                      );
                    },
                    icon: Icon(Icons.share, color: AppColor.white, size: 20),
                    label: Text(
                      'Share',
                      style: TextStyle(color: AppColor.white, fontSize: 14),
                    ),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(
                        color: Colors.white.withValues(alpha: 0.3),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

// Info Card Widget
class _InfoCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _InfoCard({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Icon(icon, color: AppColor.white, size: 24),
          const SizedBox(height: 6),
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: AppColor.white,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 11,
              color: AppColor.white.withValues(alpha: 0.6),
            ),
          ),
        ],
      ),
    );
  }
}

// Learning Point Widget
class _LearningPoint extends StatelessWidget {
  final String text;

  const _LearningPoint({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(Icons.check_circle, color: Colors.green, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 14, color: AppColor.white),
            ),
          ),
        ],
      ),
    );
  }
}

// Lesson Item Widget
class _LessonItem extends StatelessWidget {
  final int number;
  final String title;
  final String duration;
  final bool isCompleted;

  const _LessonItem({
    required this.number,
    required this.title,
    required this.duration,
    required this.isCompleted,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: isCompleted
                  ? Colors.green
                  : Colors.white.withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: isCompleted
                  ? const Icon(Icons.check, color: AppColor.white, size: 18)
                  : Text(
                      '$number',
                      style: const TextStyle(
                        color: AppColor.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColor.white,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  duration,
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColor.white.withValues(alpha: 0.6),
                  ),
                ),
              ],
            ),
          ),
          Icon(
            isCompleted ? Icons.replay : Icons.play_arrow,
            color: AppColor.white,
            size: 24,
          ),
        ],
      ),
    );
  }
}
