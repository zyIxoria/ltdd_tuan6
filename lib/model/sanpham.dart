class SanPham {
  String maSP;
  String tenSP;
  double donGia;
  double giamGia;

  SanPham({
    required this.maSP,
    required this.tenSP,
    required this.donGia,
    required this.giamGia,
  });

  // Phương thức tính thuế nhập khẩu = 10% đơn giá
  double tinhThueNhapKhau() {
    return donGia * 0.1;
  }
}