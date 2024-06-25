import 'package:store_mate/components/sales_component.dart';
import 'package:store_mate/models/models.dart';

const fakeSales = [
  SalesCard(
    totalAmount: 30.0,
    date: '2024-04-15',
  ),
  SalesCard(
    totalAmount: 15.0,
    date: '2024-04-16',
  ),
  SalesCard(
    totalAmount: 15.0,
    date: '2024-04-16',
  ),
  SalesCard(
    totalAmount: 15.0,
    date: '2024-04-16',
  ),
  SalesCard(
    totalAmount: 15.0,
    date: '2024-04-16',
  ),
  SalesCard(
    totalAmount: 15.0,
    date: '2024-04-16',
  ),
  // Agrega más SalesCard según sea necesario
];

final List<Product> products = [
  Product(
    name: 'Camisa Polo',
    price: 20.0,
    description: 'Camisa de vestir',
    category: 'Ropa',
    imagePath: 'assets/images/shirt.jpg',
    qrCodePath: 'assets/images/qr_code.png',
    enable: true,
  ),
  Product(
    name: 'Pantalón',
    price: 30.0,
    description: 'Pantalón de vestir',
    category: 'Ropa',
    imagePath: 'assets/images/pants.jpg',
    qrCodePath: 'assets/images/qr_code.png',
    enable: true,
  )
];
