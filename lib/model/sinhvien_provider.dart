import 'package:flutter/material.dart';

// Model SinhVien (Bạn có thể để chung file hoặc tách riêng)
class SinhVien {
  String id;
  String ten;
  String email;

  SinhVien({required this.id, required this.ten, required this.email});
}

class SinhVienProvider with ChangeNotifier {
  // Danh sách khởi tạo ban đầu (Mock data)
  List<SinhVien> _danhSach = [
    SinhVien(id: '1', ten: 'Nguyen Van A', email: 'a@example.com'),
    SinhVien(id: '2', ten: 'Nguyen Van B', email: 'b@example.com'),
    SinhVien(id: '3', ten: 'An Binh Tran', email: 'abt@abc.com'),
  ];

  String _searchQuery = '';

  // Getter để lấy danh sách đã lọc theo tìm kiếm
  List<SinhVien> get danhSach {
    if (_searchQuery.isEmpty) {
      return [..._danhSach];
    }
    return _danhSach
        .where((sv) =>
    sv.ten.toLowerCase().contains(_searchQuery.toLowerCase()) ||
        sv.email.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();
  }

  // Hàm cập nhật từ khóa tìm kiếm
  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners(); // Thông báo để giao diện ListView cập nhật lại
  }

  // Thêm sinh viên mới
  void addSinhVien(String ten, String email) {
    final newSV = SinhVien(
      id: DateTime.now().toString(), // Tạo ID duy nhất bằng timestamp
      ten: ten,
      email: email,
    );
    _danhSach.add(newSV);
    notifyListeners(); // Cập nhật UI
  }

  // Cập nhật thông tin sinh viên
  void updateSinhVien(String id, String tenMoi, String emailMoi) {
    final index = _danhSach.indexWhere((sv) => sv.id == id);
    if (index >= 0) {
      _danhSach[index].ten = tenMoi;
      _danhSach[index].email = emailMoi;
      notifyListeners();
    }
  }

  // Xóa sinh viên
  void deleteSinhVien(String id) {
    _danhSach.removeWhere((sv) => sv.id == id);
    notifyListeners();
  }
}