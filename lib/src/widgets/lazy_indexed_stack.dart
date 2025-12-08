import 'package:flutter/material.dart';

/// Lazy IndexedStack - faqat ko'rsatilgan screen yaratiladi
/// Screen birinchi marta ko'rsatilganda yaratiladi va keyin xotirada saqlanadi
class LazyIndexedStack extends StatefulWidget {
  final int index;
  final List<Widget Function()> children;

  const LazyIndexedStack({
    super.key,
    required this.index,
    required this.children,
  });
  

  @override
  State<LazyIndexedStack> createState() => _LazyIndexedStackState();
}

class _LazyIndexedStackState extends State<LazyIndexedStack> with AutomaticKeepAliveClientMixin {
  // Qaysi screen lar allaqachon yaratilgan
  late List<bool> _activated;

  // Yaratilgan screen lar
  late List<Widget?> _cachedChildren;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _activated = List<bool>.filled(widget.children.length, false);
    _cachedChildren = List<Widget?>.filled(widget.children.length, null);
  }

  @override
  void didUpdateWidget(LazyIndexedStack oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Widget yangilanganda ham cache ni saqlab qolamiz
    if (oldWidget.children.length != widget.children.length) {
      // Agar screen lar soni o'zgarsa, cache ni yangilaymiz
      final oldActivated = _activated;
      final oldCached = _cachedChildren;

      _activated = List<bool>.filled(widget.children.length, false);
      _cachedChildren = List<Widget?>.filled(widget.children.length, null);

      // Eski cache ni yangi cache ga ko'chiramiz
      for (int i = 0; i < oldActivated.length && i < _activated.length; i++) {
        _activated[i] = oldActivated[i];
        _cachedChildren[i] = oldCached[i];
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // AutomaticKeepAliveClientMixin uchun kerak

    // Hozirgi screen ni yaratish (agar hali yaratilmagan bo'lsa)
    if (!_activated[widget.index]) {
      _activated[widget.index] = true;
      _cachedChildren[widget.index] = widget.children[widget.index]();
    }

    return IndexedStack(
      index: widget.index,
      children: List.generate(
        widget.children.length,
        (index) {
          // Agar screen yaratilgan bo'lsa, uni ko'rsatamiz
          // Aks holda, bo'sh Container qaytaramiz
          if (_activated[index]) {
            return _cachedChildren[index]!;
          }
          return Container();
        },
      ),
    );
  }
}
