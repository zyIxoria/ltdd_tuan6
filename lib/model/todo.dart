class Todo {
  String title;
  String content;
  bool isCompleted;

  Todo({
    required this.title,
    required this.content,
    this.isCompleted = false,
  });
}