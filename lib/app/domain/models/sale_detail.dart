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
