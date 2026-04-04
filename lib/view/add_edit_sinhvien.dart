import 'package:flutter/material.dart';
import 'package:ltdd_tuan6/database/db_helper.dart';
import 'package:ltdd_tuan6/model/sinhvien.dart';

class AddEditSinhVienScreen extends StatefulWidget {
  final SinhVien? sinhVien;

  const AddEditSinhVienScreen({super.key, this.sinhVien});

  @override
  State<AddEditSinhVienScreen> createState() => _AddEditSinhVienScreenState();
}

class _AddEditSinhVienScreenState extends State<AddEditSinhVienScreen> {
  final _formKey = GlobalKey<FormState>();
  final DatabaseHelper db = DatabaseHelper();

  late TextEditingController _nameController;
  late TextEditingController _emailController;

  bool get isEdit => widget.sinhVien != null;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(
      text: widget.sinhVien?.name ?? '',
    );
    _emailController = TextEditingController(
      text: widget.sinhVien?.email ?? '',
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _saveSinhVien() async {
    if (!_formKey.currentState!.validate()) return;

    final name = _nameController.text.trim();
    final email = _emailController.text.trim();

    try {
      if (isEdit) {
        final updated = SinhVien(
          id: widget.sinhVien!.id,
          name: name,
          email: email,
        );
        await db.updateSinhVien(updated);

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Cập nhật sinh viên thành công")),
          );
        }
      } else {
        final newSv = SinhVien(
          name: name,
          email: email,
        );
        await db.insertSinhVien(newSv);

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Thêm sinh viên thành công")),
          );
        }
      }

      if (mounted) {
        Navigator.pop(context, true);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Lỗi: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? "Sửa sinh viên" : "Thêm sinh viên"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: "Tên sinh viên",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Vui lòng nhập tên";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Vui lòng nhập email";
                  }
                  if (!value.contains('@')) {
                    return "Email không hợp lệ";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _saveSinhVien,
                  child: Text(isEdit ? "Cập nhật" : "Thêm mới"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}