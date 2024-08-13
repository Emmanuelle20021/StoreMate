import 'mappable.dart';

class Product extends Mappable {
  int? id;
  final String name;
  final double price;
  final String description;
  final String category;
  final String? imagePath;
  final String? qrCodePath;
  final bool enable;

  Product({
    this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.category,
    this.imagePath,
    this.qrCodePath,
    required this.enable,
  });

  @override
  Map<String, Object?> toMap() {
    return {
      'product_id': id,
      'product_name': name,
      'product_price': price,
      'product_description': description,
      'product_category': category,
      'product_image_path': imagePath,
      'product_qr_image_path': qrCodePath,
      'product_enable': enable ? 1 : 0,
    };
  }

  static Product fromMap(Map<String, Object?> map) {
    return Product(
      name: map['product_name'] as String,
      price: map['product_price'] as double,
      description: map['product_description'] as String,
      category: map['product_category'] != null
          ? map['product_category'] as String
          : 'Otro',
      imagePath: map['product_image_path'] != null
          ? map['product_image_path'] as String
          : null,
      qrCodePath: map['product_qr_image_path'] != null
          ? map['product_qr_image_path'] as String
          : null,
      id: map['product_id'] as int,
      enable: map['product_enable'] == 1 ? true : false,
    );
  }

  @override
  String toString() {
    return 'Product{id: $id, name: $name, price: $price, description: $description, category: $category, imagePath: $imagePath, qrCodePath: $qrCodePath, enable: $enable}';
  }

  copyWith({
    String? name,
    double? price,
    String? description,
    String? category,
    String? imagePath,
    String? qrCodePath,
    bool? enable,
  }) {
    return Product(
      id: id,
      name: name ?? this.name,
      price: price ?? this.price,
      description: description ?? this.description,
      category: category ?? this.category,
      imagePath: imagePath ?? this.imagePath,
      qrCodePath: qrCodePath ?? this.qrCodePath,
      enable: enable ?? this.enable,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Product &&
        other.runtimeType == runtimeType &&
        other.hashCode == hashCode;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        price.hashCode ^
        description.hashCode ^
        category.hashCode ^
        imagePath.hashCode ^
        qrCodePath.hashCode ^
        enable.hashCode;
  }
}
