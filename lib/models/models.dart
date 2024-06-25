class Product {
  int? id;
  final String name;
  final double price;
  final String description;
  final String category;
  final String imagePath;
  final String qrCodePath;
  final bool enable;

  Product({
    this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.category,
    required this.imagePath,
    required this.qrCodePath,
    required this.enable,
  });

  Map<String, Object?> toMap() {
    return {
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
      imagePath: map['product_image_path'] as String,
      qrCodePath: map['product_qr_image_path'] as String,
      id: map['product_id'] as int,
      enable: map['product_enable'] == 1 ? true : false,
    );
  }

  @override
  String toString() {
    return 'Product{id: $id, name: $name, price: $price, description: $description, category: $category, imagePath: $imagePath, qrCodePath: $qrCodePath, enable: $enable}';
  }
}

class Sale {
  int? id;
  final double totalAmount;
  final String date;

  Sale({
    required this.totalAmount,
    required this.date,
    this.id,
  });

  Map<String, Object?> toMap() {
    return {
      'totalAmount': totalAmount,
      'date': date,
    };
  }

  static Sale fromMap(Map<String, Object?> map) {
    return Sale(
      id: map['id'] as int,
      totalAmount: map['totalAmount'] as double,
      date: map['date'] as String,
    );
  }
}

class SaleDetail {
  int? id;
  final int productId;
  final int saleId;
  final int quantity;

  SaleDetail({
    required this.productId,
    required this.saleId,
    required this.quantity,
    this.id,
  });

  Map<String, Object?> toMap() {
    return {
      'productId': productId,
      'saleId': saleId,
      'quantity': quantity,
    };
  }

  static SaleDetail fromMap(Map<String, Object?> map) {
    return SaleDetail(
      id: map['id'] as int,
      productId: map['productId'] as int,
      saleId: map['saleId'] as int,
      quantity: map['quantity'] as int,
    );
  }
}

class SummaryData {
  int sales;
  double totalAmount;
  double averageSale;

  SummaryData({
    required this.sales,
    required this.totalAmount,
    required this.averageSale,
  });
}