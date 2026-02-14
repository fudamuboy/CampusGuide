import 'package:flutter/material.dart';
import '../models/campus_item.dart';
import 'detail_screen.dart';

class ListScreen extends StatefulWidget {
  final String title;
  final Category category;
  final List<CampusItem> items;
  final VoidCallback onStateChanged;

  const ListScreen({
    super.key,
    required this.title,
    required this.category,
    required this.items,
    required this.onStateChanged,
  });

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  String _searchQuery = '';
  String _filter = 'Tümü';

  List<CampusItem> get _filteredItems {
    return widget.items.where((item) {
      if (item.category != widget.category) return false;
      if (_searchQuery.isNotEmpty &&
          !item.title.toLowerCase().contains(_searchQuery.toLowerCase())) {
        return false;
      }
      if (_filter == 'Önemli' && item.priority != Priority.IMPORTANT) {
        return false;
      }
      return true;
    }).toList();
  }

  Color get _accentColor {
    switch (widget.category) {
      case Category.COURSE:
        return const Color(0xFF6C63FF);
      case Category.TASK:
        return const Color(0xFFF5A623);
      case Category.EVENT:
        return const Color(0xFF2ED573);
    }
  }

  IconData get _categoryIcon {
    switch (widget.category) {
      case Category.COURSE:
        return Icons.menu_book_rounded;
      case Category.TASK:
        return Icons.assignment_rounded;
      case Category.EVENT:
        return Icons.event_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _filteredItems;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
        elevation: 0,
        backgroundColor: _accentColor,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          // ── Search & Filter Bar ──
          Container(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            color: Colors.white,
            child: Column(
              children: [
                // Search
                TextField(
                  onChanged: (value) => setState(() => _searchQuery = value),
                  decoration: InputDecoration(
                    hintText: 'Ara...',
                    hintStyle: TextStyle(color: Colors.grey.shade400),
                    prefixIcon: Icon(Icons.search, color: Colors.grey.shade400),
                    filled: true,
                    fillColor: const Color(0xFFF5F6FA),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 0,
                      horizontal: 16,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                // Filter dropdown
                Row(
                  children: [
                    Icon(
                      Icons.filter_list_rounded,
                      color: Colors.grey.shade500,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Filtrele :',
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF5F6FA),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: _filter,
                          style: TextStyle(
                            color: Colors.grey.shade800,
                            fontSize: 14,
                          ),
                          items: ['Tümü', 'Önemli']
                              .map(
                                (f) =>
                                    DropdownMenuItem(value: f, child: Text(f)),
                              )
                              .toList(),
                          onChanged: (value) {
                            if (value != null) {
                              setState(() => _filter = value);
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // ── Results count ──
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 4),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '${filtered.length} sonuç',
                style: TextStyle(
                  color: Colors.grey.shade500,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),

          // ── Item List ──
          Expanded(
            child: filtered.isEmpty
                ? Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.inbox_rounded,
                          size: 64,
                          color: Colors.grey.shade300,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Sonuç bulunamadı',
                          style: TextStyle(
                            color: Colors.grey.shade400,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                    itemCount: filtered.length,
                    itemBuilder: (context, index) {
                      final item = filtered[index];
                      return _ItemCard(
                        item: item,
                        accentColor: _accentColor,
                        categoryIcon: _categoryIcon,
                        onFavoriteToggle: () {
                          setState(() {
                            item.isFavorite = !item.isFavorite;
                          });
                          widget.onStateChanged();
                        },
                        onTap: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => DetailScreen(
                                item: item,
                                accentColor: _accentColor,
                                onStateChanged: widget.onStateChanged,
                              ),
                            ),
                          );
                          setState(() {});
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

// ─── Item Card Widget ───────────────────────────────────────────────────────

class _ItemCard extends StatelessWidget {
  final CampusItem item;
  final Color accentColor;
  final IconData categoryIcon;
  final VoidCallback onFavoriteToggle;
  final VoidCallback onTap;

  const _ItemCard({
    required this.item,
    required this.accentColor,
    required this.categoryIcon,
    required this.onFavoriteToggle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Material(
        borderRadius: BorderRadius.circular(16),
        elevation: 2,
        shadowColor: Colors.black12,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: item.isDone
                  ? Border.all(color: Colors.green.shade200, width: 1.5)
                  : null,
            ),
            child: Row(
              children: [
                // Left accent bar
                Container(
                  width: 4,
                  height: 56,
                  decoration: BoxDecoration(
                    color: item.isDone
                        ? Colors.green.shade400
                        : item.priority == Priority.IMPORTANT
                        ? Colors.redAccent
                        : accentColor,
                    borderRadius: BorderRadius.circular(4),
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
                          color: item.isDone
                              ? Colors.grey.shade400
                              : Colors.grey.shade800,
                          decoration: item.isDone
                              ? TextDecoration.lineThrough
                              : null,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          Icon(
                            Icons.calendar_today_rounded,
                            size: 13,
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
                          const SizedBox(width: 12),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: item.priority == Priority.IMPORTANT
                                  ? Colors.red.shade50
                                  : Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              item.priority == Priority.IMPORTANT
                                  ? 'Önemli'
                                  : 'Normal',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: item.priority == Priority.IMPORTANT
                                    ? Colors.redAccent
                                    : Colors.grey.shade500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Favorite button
                IconButton(
                  icon: Icon(
                    item.isFavorite
                        ? Icons.star_rounded
                        : Icons.star_border_rounded,
                    color: item.isFavorite
                        ? Colors.amber.shade600
                        : Colors.grey.shade300,
                  ),
                  onPressed: onFavoriteToggle,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
