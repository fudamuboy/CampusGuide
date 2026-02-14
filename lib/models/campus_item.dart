enum Category { COURSE, TASK, EVENT }

enum Priority { IMPORTANT, NORMAL }

class CampusItem {
  final String id;
  final Category category;
  final String title;
  final String description;
  final String date;
  final Priority priority;
  bool isFavorite;
  bool isDone;

  CampusItem({
    required this.id,
    required this.category,
    required this.title,
    required this.description,
    required this.date,
    required this.priority,
    this.isFavorite = false,
    this.isDone = false,
  });

  factory CampusItem.fromJson(Map<String, dynamic> json) {
    return CampusItem(
      id: json['id'] as String,
      category: Category.values.firstWhere((e) => e.name == json['category']),
      title: json['title'] as String,
      description: json['description'] as String,
      date: json['date'] as String,
      priority: Priority.values.firstWhere((e) => e.name == json['priority']),
      isFavorite: json['isFavorite'] as bool? ?? false,
      isDone: json['isDone'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'category': category.name,
      'title': title,
      'description': description,
      'date': date,
      'priority': priority.name,
      'isFavorite': isFavorite,
      'isDone': isDone,
    };
  }
}
