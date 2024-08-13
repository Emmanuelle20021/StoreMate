import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:permission_handler/permission_handler.dart';
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

class ShopMate extends StatefulWidget {
  const ShopMate({super.key});

  @override
  State<ShopMate> createState() => _ShopMateState();
}

class _ShopMateState extends State<ShopMate> {
  @override
  void initState() {
    super.initState();
    _requestPermissions();
  }

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

Future<void> _requestPermissions() async {
  // Lista de permisos que necesitas
  List<Permission> permissions = [
    Permission.camera,
    Permission.location,
    Permission.storage,
  ];

  // Verifica el estado de cada permiso
  for (var permission in permissions) {
    if (await permission.isDenied) {
      // Si el permiso es negado, lo solicita
      await permission.request();
    } else if (await permission.isPermanentlyDenied) {
      // Si el permiso fue permanentemente negado, dirige al usuario a la configuración
      openAppSettings();
    }
  }
}
