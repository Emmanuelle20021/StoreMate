import 'package:flutter/material.dart';
import 'package:store_mate/components/summary_component.dart';
import 'package:store_mate/db/database.dart';
import 'package:store_mate/models/models.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<List<Map<String, Object?>>> mostSale =
      StoreMateDatabase.instance.selectAllProducts();
  Future<SummaryData> sales = StoreMateDatabase.instance.selectTodaySales();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const FittedBox(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: Text(
                  'Resumen de Ventas',
                  style: TextStyle(
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            FutureBuilder(
              future: sales,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      'Error: ${snapshot.error}',
                      style: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                } else if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                SummaryData sales = snapshot.data!;
                if (sales.averageSale.isNaN) {
                  sales.averageSale = 0.0;
                }
                return SalesSummaryWidget(
                  totalSales: sales.totalAmount,
                  numberOfTransactions: sales.sales,
                  averageSale: sales.averageSale,
                );
              },
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Text(
                'Productos más Vendidos',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: FutureBuilder<List<Map<String, Object?>>>(
                future: mostSale,
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(
                            snapshot.data![index]['product_name'] as String,
                          ),
                          subtitle: Text(
                            'Cantidad: ${snapshot.data![index]['product_quantity']}',
                          ),
                          leading: const Icon(Icons.shopping_cart),
                        );
                      },
                    );
                  } else if (snapshot.hasData && snapshot.data!.isEmpty) {
                    return const Center(
                      child: Text("No hay productos que mostrar"),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        'Error: ${snapshot.error}',
                        style: const TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton.icon(
                  onPressed: _launchURL,
                  icon: const Icon(Icons.coffee),
                  label: const Text(
                    'BuyMeACoffe',
                    semanticsLabel: 'BuyMeACoffe',
                  ),
                  style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.amber),
                    foregroundColor: MaterialStatePropertyAll(
                      Colors.black87,
                    ),
                    iconSize: MaterialStatePropertyAll(15),
                    textStyle: MaterialStatePropertyAll(
                      TextStyle(
                        fontSize: 11,
                      ),
                    ),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () async {
                    await StoreMateDatabase.instance.getDbPath();
                  },
                  icon: const Icon(Icons.trending_up),
                  label: const Text(
                    'Ver ventas',
                    semanticsLabel: 'Ver ventas',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _launchURL() async {
    final uri = Uri(
      scheme: 'https',
      host: 'www.buymeacoffee.com',
      path: '/EmmaMoraDev',
    );
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'No se puede abrir $uri';
    }
  }
}
