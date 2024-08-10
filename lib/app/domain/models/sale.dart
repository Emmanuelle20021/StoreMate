import 'mappable.dart';

class Sale extends Mappable {
  int? id;
  final double totalAmount;
  final String date;

  Sale({
    required this.totalAmount,
    required this.date,
    this.id,
  });

  @override
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
