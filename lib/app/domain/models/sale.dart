import 'mappable.dart';

class Sale extends Mappable {
  int? id;
  final double totalAmount;
  final String date;
  final int? enable;

  Sale({
    required this.totalAmount,
    required this.date,
    this.enable,
    this.id,
  });

  @override
  Map<String, Object?> toMap() {
    return {
      'sale_id': id,
      'sale_total_amount': totalAmount,
      'sale_creation_date': date,
      'sale_enable': enable,
    };
  }

  static Sale fromMap(Map<String, Object?> map) {
    return Sale(
      id: map['sale_id'] as int,
      totalAmount: map['sale_total_amount'] as double,
      date: map['sale_creation_date'] as String,
      enable: map['sale_enable'] as int,
    );
  }

  @override
  String toString() {
    return 'id: $id,totalAmount: $totalAmount,date:$date,enable:$enable';
  }
}
