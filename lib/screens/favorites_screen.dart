import 'package:flutter/material.dart';
import '../models/campus_item.dart';
import 'detail_screen.dart';

class FavoritesScreen extends StatefulWidget {
  final List<CampusItem> items;
  final VoidCallback onStateChanged;

  const FavoritesScreen({
    super.key,
    required this.items,
    required this.onStateChanged,
  });

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  List<CampusItem> get _favorites =>
      widget.items.where((item) => item.isFavorite).toList();

  Color _colorForCategory(Category category) {
    switch (category) {
      case Category.COURSE:
        return const Color(0xFF6C63FF);
      case Category.TASK:
        return const Color(0xFFF5A623);
      case Category.EVENT:
        return const Color(0xFF2ED573);
    }
  }

  IconData _iconForCategory(Category category) {
    switch (category) {
      case Category.COURSE:
        return Icons.menu_book_rounded;
      case Category.TASK:
        return Icons.assignment_rounded;
      case Category.EVENT:
        return Icons.event_rounded;
    }
  }

  String _labelForCategory(Category category) {
    switch (category) {
      case Category.COURSE:
        return 'Ders';
      case Category.TASK:
        return 'Ödev';
      case Category.EVENT:
        return 'Etkinlik';
    }
  }

  @override
  Widget build(BuildContext context) {
    final favorites = _favorites;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: AppBar(
        title: const Text('Favorilerim'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: const Color(0xFFFF6B81),
        foregroundColor: Colors.white,
      ),
      body: favorites.isEmpty
          ? Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.favorite_border_rounded,
                    size: 72,
                    color: Colors.grey.shade300,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Henüz favori yok',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey.shade400,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '⭐ simgesine basarak öğeleri ekleyin',
                    style: TextStyle(fontSize: 14, color: Colors.grey.shade400),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                final item = favorites[index];
                final color = _colorForCategory(item.category);

                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Material(
                    borderRadius: BorderRadius.circular(16),
                    elevation: 2,
                    shadowColor: Colors.black12,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(16),
                      onTap: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => DetailScreen(
                              item: item,
                              accentColor: color,
                              onStateChanged: widget.onStateChanged,
                            ),
                          ),
                        );
                        setState(() {});
                      },
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          children: [
                            // Category icon
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: color.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Icon(
                                _iconForCategory(item.category),
                                color: color,
                                size: 24,
                              ),
                            ),
                            const SizedBox(width: 14),

                            // Content
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.title,
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.grey.shade800,
                                      decoration: item.isDone
                                          ? TextDecoration.lineThrough
                                          : null,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 2,
                                        ),
                                        decoration: BoxDecoration(
                                          color: color.withValues(alpha: 0.1),
                                          borderRadius: BorderRadius.circular(
                                            6,
                                          ),
                                        ),
                                        child: Text(
                                          _labelForCategory(item.category),
                                          style: TextStyle(
                                            fontSize: 11,
                                            fontWeight: FontWeight.w600,
                                            color: color,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Icon(
                                        Icons.calendar_today_rounded,
                                        size: 12,
                                        color: Colors.grey.shade400,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        item.date,
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey.shade400,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            // Remove favorite
                            IconButton(
                              icon: Icon(
                                Icons.star_rounded,
                                color: Colors.amber.shade600,
                              ),
                              onPressed: () {
                                setState(() {
                                  item.isFavorite = false;
                                });
                                widget.onStateChanged();
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
