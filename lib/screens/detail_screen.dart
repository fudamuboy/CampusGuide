import 'package:flutter/material.dart';
import '../models/campus_item.dart';

class DetailScreen extends StatefulWidget {
  final CampusItem item;
  final Color accentColor;
  final VoidCallback onStateChanged;

  const DetailScreen({
    super.key,
    required this.item,
    required this.accentColor,
    required this.onStateChanged,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  void _toggleFavorite() {
    setState(() {
      widget.item.isFavorite = !widget.item.isFavorite;
    });
    widget.onStateChanged();
  }

  void _toggleDone() {
    setState(() {
      widget.item.isDone = !widget.item.isDone;
    });
    widget.onStateChanged();
  }

  String get _categoryLabel {
    switch (widget.item.category) {
      case Category.COURSE:
        return 'Ders';
      case Category.TASK:
        return 'Ödev';
      case Category.EVENT:
        return 'Etkinlik';
    }
  }

  IconData get _categoryIcon {
    switch (widget.item.category) {
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
    final item = widget.item;
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      body: CustomScrollView(
        slivers: [
          // ── Hero Header ──
          SliverAppBar(
            expandedHeight: 180,
            pinned: true,
            backgroundColor: widget.accentColor,
            foregroundColor: Colors.white,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                item.title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      widget.accentColor,
                      widget.accentColor.withValues(alpha: 0.7),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Center(
                  child: Icon(
                    _categoryIcon,
                    size: 64,
                    color: Colors.white.withValues(alpha: 0.2),
                  ),
                ),
              ),
            ),
          ),

          // ── Body ──
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ── Status badges ──
                  Wrap(
                    spacing: 10,
                    runSpacing: 8,
                    children: [
                      _Badge(
                        icon: _categoryIcon,
                        label: _categoryLabel,
                        color: widget.accentColor,
                      ),
                      _Badge(
                        icon: item.priority == Priority.IMPORTANT
                            ? Icons.priority_high_rounded
                            : Icons.remove_rounded,
                        label: item.priority == Priority.IMPORTANT
                            ? 'Önemli'
                            : 'Normal',
                        color: item.priority == Priority.IMPORTANT
                            ? Colors.redAccent
                            : Colors.grey,
                      ),
                      if (item.isDone)
                        const _Badge(
                          icon: Icons.check_circle,
                          label: 'Tamamlandı',
                          color: Colors.green,
                        ),
                      if (item.isFavorite)
                        _Badge(
                          icon: Icons.star_rounded,
                          label: 'Favori',
                          color: Colors.amber.shade700,
                        ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // ── Date ──
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.calendar_today_rounded,
                          color: widget.accentColor,
                          size: 20,
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Tarih',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade400,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              item.date,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey.shade800,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // ── Description ──
                  Text(
                    'Açıklama',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: Colors.grey.shade700,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: Text(
                      item.description,
                      style: TextStyle(
                        fontSize: 15,
                        height: 1.6,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ),

                  const SizedBox(height: 32),

                  // ── Action Buttons ──
                  Row(
                    children: [
                      Expanded(
                        child: _ActionButton(
                          icon: item.isFavorite
                              ? Icons.star_rounded
                              : Icons.star_border_rounded,
                          label: item.isFavorite
                              ? 'Favorilerden Çıkar'
                              : 'Favorilere Ekle',
                          color: Colors.amber.shade700,
                          filled: item.isFavorite,
                          onTap: _toggleFavorite,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _ActionButton(
                          icon: item.isDone
                              ? Icons.undo_rounded
                              : Icons.check_circle_outline_rounded,
                          label: item.isDone ? 'Tamamlanmadı' : 'Tamamlandı',
                          color: Colors.green,
                          filled: item.isDone,
                          onTap: _toggleDone,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Badge Widget ───────────────────────────────────────────────────────────

class _Badge extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const _Badge({required this.icon, required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Action Button Widget ───────────────────────────────────────────────────

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final bool filled;
  final VoidCallback onTap;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.filled,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(14),
      color: filled ? color : Colors.white,
      elevation: filled ? 2 : 0,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: filled ? color : color.withValues(alpha: 0.3),
            ),
          ),
          child: Column(
            children: [
              Icon(icon, color: filled ? Colors.white : color, size: 24),
              const SizedBox(height: 6),
              Text(
                label,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: filled ? Colors.white : color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
