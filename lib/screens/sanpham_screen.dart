import 'package:flutter/material.dart';
import '../model/sanpham.dart';
import '../widgets/sanpham_item.dart';

class SanPhamScreen extends StatefulWidget {
  const SanPhamScreen({super.key});

  @override
  State<SanPhamScreen> createState() => _SanPhamScreenState();
}

class _SanPhamScreenState extends State<SanPhamScreen> {
  final TextEditingController _maController = TextEditingController();
  final TextEditingController _tenController = TextEditingController();
  final TextEditingController _donGiaController = TextEditingController();
  final TextEditingController _giamGiaController = TextEditingController();

  final List<SanPham> _danhSachSanPham = [];

  void _themSanPham() {
    String ma = _maController.text.trim();
    String ten = _tenController.text.trim();
    String donGiaText = _donGiaController.text.trim();
    String giamGiaText = _giamGiaController.text.trim();

    if (ma.isEmpty || ten.isEmpty || donGiaText.isEmpty || giamGiaText.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Vui lòng nhập đầy đủ thông tin sản phẩm!"),
        ),
      );
      return;
    }

    double? donGia = double.tryParse(donGiaText);
    double? giamGia = double.tryParse(giamGiaText);

    if (donGia == null || giamGia == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Đơn giá và giảm giá phải là số!"),
        ),
      );
      return;
    }

    SanPham sp = SanPham(
      maSP: ma,
      tenSP: ten,
      donGia: donGia,
      giamGia: giamGia,
    );

    setState(() {
      _danhSachSanPham.add(sp);
    });

    _maController.clear();
    _tenController.clear();
    _donGiaController.clear();
    _giamGiaController.clear();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Đã thêm sản phẩm thành công!"),
      ),
    );
  }

  void _xoaSanPham(int index) {
    setState(() {
      _danhSachSanPham.removeAt(index);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Đã xóa sản phẩm!"),
      ),
    );
  }

  @override
  void dispose() {
    _maController.dispose();
    _tenController.dispose();
    _donGiaController.dispose();
    _giamGiaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Quản lý sản phẩm"),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            // Form nhập
            TextField(
              controller: _maController,
              decoration: const InputDecoration(
                labelText: "Mã sản phẩm",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),

            TextField(
              controller: _tenController,
              decoration: const InputDecoration(
                labelText: "Tên sản phẩm",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),

            TextField(
              controller: _donGiaController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Đơn giá",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),

            TextField(
              controller: _giamGiaController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Giảm giá",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _themSanPham,
                child: const Text("Thêm sản phẩm"),
              ),
            ),

            const SizedBox(height: 12),

            // Danh sách sản phẩm
            Expanded(
              child: _danhSachSanPham.isEmpty
                  ? const Center(
                child: Text(
                  "Chưa có sản phẩm nào!",
                  style: TextStyle(fontSize: 18),
                ),
              )
                  : ListView.builder(
                itemCount: _danhSachSanPham.length,
                itemBuilder: (context, index) {
                  return SanPhamItem(
                    sanPham: _danhSachSanPham[index],
                    onDelete: () => _xoaSanPham(index),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}