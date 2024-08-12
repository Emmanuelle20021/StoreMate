import 'mappable.dart';

class SaleDetail extends Mappable {
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

  @override
  Map<String, Object?> toMap() {
    return {
      'product_id': productId,
      'sale_id': saleId,
      'detail_quantity': quantity,
    };
  }

  static SaleDetail fromMap(Map<String, Object?> map) {
    return SaleDetail(
      id: map['detail_id'] as int,
      productId: map['product_id'] as int,
      saleId: map['sale_id'] as int,
      quantity: map['detail_quantity'] as int,
    );
  }

  copyWith({
    int? productId,
    int? saleId,
    int? quantity,
  }) {
    return SaleDetail(
      id: id,
      productId: productId ?? this.productId,
      saleId: saleId ?? this.saleId,
      quantity: quantity ?? this.quantity,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is SaleDetail &&
        other.runtimeType == runtimeType &&
        other.hashCode == hashCode;
  }

  @override
  int get hashCode {
    return productId.hashCode ^ saleId.hashCode ^ quantity.hashCode;
  }
}
