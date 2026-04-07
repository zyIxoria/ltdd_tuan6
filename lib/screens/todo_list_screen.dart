import 'package:flutter/material.dart';
import '../model/todo.dart';
import '../widgets/todo_item.dart';
import 'add_todo_screen.dart';

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key});

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  final List<Todo> _todoList = [
    Todo(
      title: 'Tap huan',
      content: 'Tham gia buổi tập huấn đầu tuần',
      isCompleted: true,
    ),
    Todo(
      title: 'De Cuong hoc phan',
      content: 'Hoàn thành đề cương học phần môn Flutter',
      isCompleted: false,
    ),
    Todo(
      title: 'NCKH',
      content: 'Chuẩn bị nội dung nghiên cứu khoa học',
      isCompleted: false,
    ),
    Todo(
      title: 'Hop chuyen mon',
      content: 'Tham gia họp chuyên môn với nhóm',
      isCompleted: false,
    ),
  ];

  Future<void> _goToAddTodoScreen() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AddTodoScreen(),
      ),
    );

    if (result != null && result is Todo) {
      setState(() {
        _todoList.add(result);
      });
    }
  }

  void _toggleTodoStatus(int index, bool? value) {
    setState(() {
      _todoList[index].isCompleted = value ?? false;
    });
  }

  void _deleteTodo(int index) {
    setState(() {
      _todoList.removeAt(index);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Đã xóa công việc'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F1FA),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF7F1FA),
        elevation: 0,
        title: const Text(
          'Todo',
          style: TextStyle(color: Colors.black87),
        ),
      ),
      body: _todoList.isEmpty
          ? const Center(
        child: Text(
          'Chưa có công việc nào!',
          style: TextStyle(fontSize: 18),
        ),
      )
          : ListView.builder(
        itemCount: _todoList.length,
        itemBuilder: (context, index) {
          return TodoItem(
            todo: _todoList[index],
            onChanged: (value) => _toggleTodoStatus(index, value),
            onDelete: () => _deleteTodo(index),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _goToAddTodoScreen,
        backgroundColor: const Color(0xFFE5D7F5),
        child: const Icon(Icons.add, color: Colors.black87),
      ),
    );
  }
}