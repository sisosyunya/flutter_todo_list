class Todo {
  final String title;
  final bool isDone;
  final String category;

  Todo({
    required this.title,
    this.isDone = false,
    required this.category,
  });
}