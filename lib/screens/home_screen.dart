import 'package:flutter/material.dart';
import '../models/campus_item.dart';
import 'list_screen.dart';
import 'favorites_screen.dart';

class HomeScreen extends StatelessWidget {
  final List<CampusItem> items;
  final VoidCallback onStateChanged;

  const HomeScreen({
    super.key,
    required this.items,
    required this.onStateChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final courseCount = items
        .where((i) => i.category == Category.COURSE)
        .length;
    final taskCount = items.where((i) => i.category == Category.TASK).length;
    final eventCount = items.where((i) => i.category == Category.EVENT).length;
    final favCount = items.where((i) => i.isFavorite).length;
    final doneCount = items.where((i) => i.isDone).length;
    final importantCount = items
        .where((i) => i.priority == Priority.IMPORTANT && !i.isDone)
        .length;

    // Upcoming items (next 3 by date, not done)
    final upcoming = items.where((i) => !i.isDone).toList()
      ..sort((a, b) => a.date.compareTo(b.date));
    final upcomingPreview = upcoming.take(3).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF0F2F8),
      body: CustomScrollView(
        slivers: [
          // ── Gradient Header ──
          SliverToBoxAdapter(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF6C63FF), Color(0xFF4834DF)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(32),
                  bottomRight: Radius.circular(32),
                ),
              ),
              child: SafeArea(
                bottom: false,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(24, 16, 24, 28),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Top bar
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.2),
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                child: const Icon(
                                  Icons.school_rounded,
                                  color: Colors.white,
                                  size: 24,
                                ),
                              ),
                              const SizedBox(width: 12),
                              const Text(
                                'CampusGuide',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ],
                          ),
                          // Favorites button
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => FavoritesScreen(
                                    items: items,
                                    onStateChanged: onStateChanged,
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.2),
                                borderRadius: BorderRadius.circular(14),
                              ),
                              child: Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  const Icon(
                                    Icons.favorite_rounded,
                                    color: Colors.white,
                                    size: 22,
                                  ),
                                  if (favCount > 0)
                                    Positioned(
                                      top: -6,
                                      right: -6,
                                      child: Container(
                                        padding: const EdgeInsets.all(4),
                                        decoration: const BoxDecoration(
                                          color: Color(0xFFFF6B81),
                                          shape: BoxShape.circle,
                                        ),
                                        child: Text(
                                          '$favCount',
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 28),

                      // Greeting
                      const Text(
                        'Merhaba 👋',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Üniversite hayatınızı düzenleyin',
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.8),
                          fontSize: 15,
                        ),
                      ),

                      const SizedBox(height: 24),

                      // ── Inline Stats ──
                      Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 16,
                          horizontal: 20,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _HeaderStat(
                              icon: Icons.check_circle_rounded,
                              value: '$doneCount',
                              label: 'Tamamlanan',
                            ),
                            Container(
                              width: 1,
                              height: 36,
                              color: Colors.white.withValues(alpha: 0.25),
                            ),
                            _HeaderStat(
                              icon: Icons.favorite_rounded,
                              value: '$favCount',
                              label: 'Favori',
                            ),
                            Container(
                              width: 1,
                              height: 36,
                              color: Colors.white.withValues(alpha: 0.25),
                            ),
                            _HeaderStat(
                              icon: Icons.warning_rounded,
                              value: '$importantCount',
                              label: 'Önemli',
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // ── Body Content ──
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 28, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ── Section Title ──
                  Text(
                    'Kategoriler',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: Colors.grey.shade800,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // ── Category Cards ──
                  _CategoryCard(
                    icon: Icons.menu_book_rounded,
                    label: 'Dersler',
                    subtitle: '$courseCount ders mevcut',
                    gradient: const [Color(0xFF6C63FF), Color(0xFF8B83FF)],
                    onTap: () =>
                        _navigateToList(context, Category.COURSE, 'Dersler'),
                  ),
                  const SizedBox(height: 14),
                  _CategoryCard(
                    icon: Icons.assignment_rounded,
                    label: 'Ödevler',
                    subtitle: '$taskCount ödev bekliyor',
                    gradient: const [Color(0xFFF5A623), Color(0xFFFFBF5E)],
                    onTap: () =>
                        _navigateToList(context, Category.TASK, 'Ödevler'),
                  ),
                  const SizedBox(height: 14),
                  _CategoryCard(
                    icon: Icons.event_rounded,
                    label: 'Etkinlikler',
                    subtitle: '$eventCount etkinlik planlandı',
                    gradient: const [Color(0xFF2ED573), Color(0xFF5EE89E)],
                    onTap: () =>
                        _navigateToList(context, Category.EVENT, 'Etkinlikler'),
                  ),

                  const SizedBox(height: 32),

                  // ── Upcoming Section ──
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Yaklaşan Görevler',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          color: Colors.grey.shade800,
                        ),
                      ),
                      Text(
                        '${upcoming.length} kalan',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey.shade400,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  ...upcomingPreview.map(
                    (item) => Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: _UpcomingTile(item: item),
                    ),
                  ),
                  if (upcomingPreview.isEmpty)
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 32),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        children: [
                          Icon(
                            Icons.celebration_rounded,
                            size: 48,
                            color: Colors.grey.shade300,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Tüm görevler tamamlandı!',
                            style: TextStyle(
                              color: Colors.grey.shade400,
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToList(BuildContext context, Category category, String title) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ListScreen(
          title: title,
          category: category,
          items: items,
          onStateChanged: onStateChanged,
        ),
      ),
    );
  }
}

// ─── Header Stat ────────────────────────────────────────────────────────────

class _HeaderStat extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;

  const _HeaderStat({
    required this.icon,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: Colors.white, size: 20),
        const SizedBox(height: 6),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.7),
            fontSize: 11,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

// ─── Category Card Widget ───────────────────────────────────────────────────

class _CategoryCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String subtitle;
  final List<Color> gradient;
  final VoidCallback onTap;

  const _CategoryCard({
    required this.icon,
    required this.label,
    required this.subtitle,
    required this.gradient,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(20),
      elevation: 4,
      shadowColor: gradient.first.withValues(alpha: 0.3),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              colors: gradient,
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.22),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(icon, color: Colors.white, size: 28),
              ),
              const SizedBox(width: 18),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 19,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.8),
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Colors.white,
                  size: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Upcoming Tile Widget ───────────────────────────────────────────────────

class _UpcomingTile extends StatelessWidget {
  final CampusItem item;

  const _UpcomingTile({required this.item});

  Color get _categoryColor {
    switch (item.category) {
      case Category.COURSE:
        return const Color(0xFF6C63FF);
      case Category.TASK:
        return const Color(0xFFF5A623);
      case Category.EVENT:
        return const Color(0xFF2ED573);
    }
  }

  IconData get _categoryIcon {
    switch (item.category) {
      case Category.COURSE:
        return Icons.menu_book_rounded;
      case Category.TASK:
        return Icons.assignment_rounded;
      case Category.EVENT:
        return Icons.event_rounded;
    }
  }

  String get _categoryLabel {
    switch (item.category) {
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
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: _categoryColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(_categoryIcon, color: _categoryColor, size: 22),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey.shade800,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 7,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: _categoryColor.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        _categoryLabel,
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: _categoryColor,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Icon(
                      Icons.calendar_today_rounded,
                      size: 11,
                      color: Colors.grey.shade400,
                    ),
                    const SizedBox(width: 3),
                    Text(
                      item.date,
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey.shade400,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          if (item.priority == Priority.IMPORTANT)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.red.shade50,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text('🔥', style: TextStyle(fontSize: 14)),
            ),
        ],
      ),
    );
  }
}
