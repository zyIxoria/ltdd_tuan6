import 'package:flutter/material.dart';
import 'package:ltdd_tuan6/database/db_helper.dart';
import 'package:ltdd_tuan6/model/sinhvien.dart';
import 'package:ltdd_tuan6/view/add_edit_sinhvien.dart';

class SinhVienListScreen extends StatefulWidget {
  const SinhVienListScreen({super.key});

  @override
  State<SinhVienListScreen> createState() => _SinhVienListScreenState();
}

class _SinhVienListScreenState extends State<SinhVienListScreen> {
  late Future<List<SinhVien>> svs;
  final DatabaseHelper db = DatabaseHelper();

  @override
  void initState() {
    super.initState();
    _loadSinhVien();
  }

  void _loadSinhVien() {
    setState(() {
      svs = db.getSinhViens();
    });
  }

  Future<void> _deleteSinhVien(int id) async {
    await db.deleteSinhVien(id);
    _loadSinhVien();

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Đã xóa sinh viên')),
      );
    }
  }

  void _showDeleteConfirm(int id, String name) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Xác nhận xóa"),
        content: Text("Bạn có chắc muốn xóa sinh viên \"$name\" không?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Hủy"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _deleteSinhVien(id);
            },
            child: const Text("Xóa"),
          ),
        ],
      ),
    );
  }

  Future<void> _goToAddScreen() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AddEditSinhVienScreen(),
      ),
    );

    if (result == true) {
      _loadSinhVien();
    }
  }

  Future<void> _goToEditScreen(SinhVien sv) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddEditSinhVienScreen(sinhVien: sv),
      ),
    );

    if (result == true) {
      _loadSinhVien();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Danh sách sinh viên"),
      ),
      body: FutureBuilder<List<SinhVien>>(
        future: svs,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Text("Lỗi: ${snapshot.error}"),
            );
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text("Chưa có sinh viên nào"),
            );
          }

          final list = snapshot.data!;

          return ListView.builder(
            itemCount: list.length,
            itemBuilder: (context, index) {
              final sv = list[index];

              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: ListTile(
                  leading: CircleAvatar(
                    child: Text('${index+1}',style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),),
                  ),
                  title: Text(sv.name),
                  subtitle: Text(sv.email),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.orange),
                        onPressed: () => _goToEditScreen(sv),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _showDeleteConfirm(sv.id!, sv.name),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _goToAddScreen,
        child: const Icon(Icons.add),
      ),
    );
  }
}