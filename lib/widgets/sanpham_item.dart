import 'package:flutter/material.dart';
import '../model/sanpham.dart';

class SanPhamItem extends StatelessWidget {
  final SanPham sanPham;
  final VoidCallback onDelete;

  const SanPhamItem({
    super.key,
    required this.sanPham,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Tên SP + nút xóa
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    sanPham.tenSP,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: onDelete,
                  icon: const Icon(Icons.delete, color: Colors.red),
                ),
              ],
            ),

            const SizedBox(height: 8),

            Text("Mã sản phẩm: ${sanPham.maSP}"),
            Text("Tên sản phẩm: ${sanPham.tenSP}"),
            Text("Đơn giá: ${sanPham.donGia.toStringAsFixed(0)} VNĐ"),
            Text("Giảm giá: ${sanPham.giamGia.toStringAsFixed(0)} VNĐ"),
            Text(
              "Thuế nhập khẩu: ${sanPham.tinhThueNhapKhau().toStringAsFixed(0)} VNĐ",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
          ],
        ),
      ),
    );
  }
}