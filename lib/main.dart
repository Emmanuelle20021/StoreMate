import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:store_mate/app/data/implementation/local_database_repository_implementation.dart';
import 'package:store_mate/app/data/implementation/product_repository_implementation.dart';
import 'package:store_mate/app/data/implementation/sale_detail_repository_implementation.dart';
import 'package:store_mate/app/data/implementation/sale_repository_implementation.dart';
import 'package:store_mate/app/data/utils/constants/themes.dart';
import 'package:store_mate/app/data/utils/injector.dart';
import 'package:store_mate/app/presentation/bloc/bloc_provider.dart';
import 'package:store_mate/app/presentation/routes/app_routes.dart';
import 'package:store_mate/app/presentation/routes/routes.dart';
import 'app/data/utils/constants/constants.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  final db = LocalDatatabaseImplementation();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(
    Injector(
      productRepository: ProductImplementation(databaseImplementation: db),
      saleDetailRepository: SaleDetailImplementation(
        databaseImplementation: db,
      ),
      saleRepository: SaleImplementation(databaseImplementation: db),
      child: const ShopMate(),
    ),
  );
}

class ShopMate extends StatelessWidget {
  const ShopMate({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocsProvider(
      child: MaterialApp(
        title: kAppTitle,
        routes: appRoutes,
        initialRoute: Routes.home,
        themeMode: ThemeMode.system,
        theme: lightTheme,
      ),
    );
  }
}
