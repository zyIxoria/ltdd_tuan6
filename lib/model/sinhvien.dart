class SinhVien {
  final int? id; //final: một khi đã gán giá trị thì không thể thay đổi
  //?: có thể null
  final String name;
  String email;
  SinhVien({this.id, required this.name, required this.email});
  //Cặp ngoặc nhọn {} cho biết nó đang sử dụng Named Parameters (tham số có tên).
  // Khi gọi hàm, bạn phải chỉ rõ tên tham số
  // (ví dụ: SinhVien(name: 'An', email: 'an@gmail.com')).
  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'email': email};
  }//Hàm đóng gói
  factory SinhVien.fromMap(Map<String, dynamic> map) {
    return SinhVien(id: map['id'], name: map['name'], email: map['email']);
  }//Hàm mở gói

}

