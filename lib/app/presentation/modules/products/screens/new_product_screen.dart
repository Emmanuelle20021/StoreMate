// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';
import 'package:store_mate/app/data/utils/constants/constants.dart';
import 'package:store_mate/app/data/utils/constants/themes.dart';
import 'package:store_mate/app/data/utils/injector.dart';
import 'package:store_mate/app/domain/repositories/product_repository.dart';
import 'package:store_mate/app/presentation/bloc/products_cubit.dart';

import '../../../../domain/models/product.dart';
import '../../../global/widgets/custom_text_form_field.dart';

class NewProductScreen extends StatefulWidget {
  const NewProductScreen({super.key});

  @override
  State<NewProductScreen> createState() => _NewProductScreenState();
}

class _NewProductScreenState extends State<NewProductScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final ScreenshotController screenshotController = ScreenshotController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late FocusNode _priceFocusNode;
  late FocusNode _descriptionFocusNode;

  String? imagePath;
  bool enable = true;
  @override
  void initState() {
    _priceFocusNode = FocusNode();
    _descriptionFocusNode = FocusNode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimary,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: kNoColor,
        title: const Text(
          'Nuevo Producto',
          style: TextStyle(
            color: kOnPrimary,
            fontSize: kLargeText,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          ...kCircleDecorations,
          SafeArea(
            child: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(
                color: kBackground,
              ),
              padding: const EdgeInsets.all(kDefaultPadding),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: kDefaultPadding,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 2,
                              child: CustomTextFormField(
                                controller: _nameController,
                                validator: _validator,
                                label: 'Nombre',
                                hintText: 'Camisa Polo...',
                                nextFocusNode: _priceFocusNode,
                              ),
                            ),
                            const SizedBox(width: kDefaultPadding),
                            Expanded(
                              child: CustomTextFormField(
                                controller: _priceController,
                                validator: _validator,
                                focusNode: _priceFocusNode,
                                label: 'Precio',
                                hintText: '100.00',
                                inputType: TextInputType.number,
                                suffix: '\$',
                                nextFocusNode: _descriptionFocusNode,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: kDefaultGap),
                      CustomTextFormField(
                        controller: _descriptionController,
                        focusNode: _descriptionFocusNode,
                        validator: _validator,
                        label: 'Descripción',
                        hintText: 'Ropa color negra , de algodón...',
                        maxLines: 4,
                      ),
                      const SizedBox(height: kDefaultGap),
                      Container(
                        height: kCircleDecorationLargeSize,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: kLightTextColor.withOpacity(
                            kDefaultOverlayOpacity,
                          ),
                          borderRadius: BorderRadius.circular(
                            kDefaultButtonRadius,
                          ),
                        ),
                        child: imagePath != null
                            ? Image.file(
                                File(imagePath!),
                                fit: BoxFit.fill,
                              )
                            : const Icon(
                                Icons.image,
                                size: kCircleDecorationSmallSize,
                              ),
                      ),
                      const SizedBox(height: kDefaultGap),
                      Row(
                        children: [
                          Expanded(
                            child: TextButton.icon(
                              onPressed: () => getImage(ImageSource.camera),
                              icon: const Icon(
                                Icons.camera_alt,
                                color: kPrimary,
                              ),
                              label: const Text(
                                'Cámara',
                                style: TextStyle(
                                  color: kPrimary,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: TextButton.icon(
                              onPressed: () => getImage(ImageSource.gallery),
                              icon: const Icon(
                                Icons.photo,
                                color: kPrimary,
                              ),
                              label: const Text(
                                'Galería',
                                style: TextStyle(
                                  color: kPrimary,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: kDefaultGap),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () async {
                                if (enable) {
                                  bool response =
                                      await _saveNewProduct(context);
                                  if (mounted) {
                                    createDialog(context, response).then(
                                      (_) => {
                                        if (!enable)
                                          {
                                            Navigator.pop(context),
                                          }
                                      },
                                    );
                                  }
                                }
                              },
                              child: const Text('Guardar'),
                            ),
                          ),
                          const SizedBox(width: kDefaultPadding),
                          Expanded(
                            child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                  kError,
                                ),
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text(
                                'Cancelar',
                                style: TextStyle(color: kOnPrimary),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future getImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      final imageTemporary = File(image.path);
      setState(() {
        imagePath = imageTemporary.path;
      });
    } on PlatformException catch (e) {
      debugPrint('Failed to pick image: $e');
    }
  }

  String? _validator(String? text) {
    if (text == null || text.isEmpty) {
      return 'No deje el campo vacío';
    }
    return null;
  }

  Future<void> createDialog(BuildContext context, bool response) {
    if (response) {
      return showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text(
            'Producto guardado',
            style: TextStyle(
              color: kTextColor,
              fontSize: kExtraLargeText,
            ),
          ),
          icon: const Icon(
            Icons.check,
            size: kCircleDecorationSmallSize,
          ),
          iconColor: kPrimary,
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Aceptar'),
            ),
          ],
        ),
      );
    } else {
      enable = true;
      return showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text(
            'Ups algo salio mal',
            style: TextStyle(
              color: kError,
              fontSize: kExtraLargeText,
            ),
          ),
          content: const Text(
            'Verifique que los datos se hayan ingresado correctamente',
          ),
          icon: const Icon(
            Icons.error,
            size: kCircleDecorationSmallSize,
          ),
          iconColor: kError,
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Aceptar'),
            ),
          ],
        ),
      );
    }
  }

  FutureOr<bool> _saveNewProduct(BuildContext context) async {
    enable = false;
    try {
      if (_formKey.currentState!.validate()) {
        final newProduct = Product(
          name: _nameController.text,
          price: double.parse(_priceController.text),
          description: _descriptionController.text,
          category: 'Otro',
          imagePath: imagePath,
          qrCodePath: '',
          enable: true,
        );
        ProductRepository productRepository =
            Injector.of(context).productRepository;
        bool isSaved = await productRepository.insert(
          row: newProduct,
        );
        Product? lastProduct = await productRepository.getProduct(
          where: 'product_name = ?',
          whereArgs: [newProduct.name],
        );

        if (isSaved && lastProduct != null) {
          final filename = lastProduct.name.replaceAll(' ', '_');
          final image = await screenshotController.captureFromWidget(
            QrImageView(
              data: lastProduct.id.toString(),
              version: QrVersions.auto,
              size: 100.0,
            ),
          );

          // Solicitar permisos
          await Permission.storage.request();
          // Obtener el directorio de documentos de la aplicación

          final qrDirectory = Directory('/storage/emulated/0/Pictures/QR');

          // Verificar si el directorio QR existe
          if (!await qrDirectory.exists()) {
            // Crear el directorio si no existe
            await qrDirectory.create(recursive: true);
          }

          // Crear el archivo en el directorio QR
          final filePath = '${qrDirectory.path}/$filename.png';
          debugPrint(filePath);
          final file = File(filePath);

          // Escribir los bytes en el archivo
          await file.writeAsBytes(image);
          // Notifica al sistema de medios para que reescanee la carpeta
          const MethodChannel channel = MethodChannel('com.example.app/media');
          await channel.invokeMethod('scanFile', {'path': filePath});

          lastProduct = lastProduct.copyWith(
            qrCodePath: filePath,
          );
          final bool isSavedQR = await productRepository.update(
            row: lastProduct!,
            where: 'product_id = ?',
            whereArgs: [lastProduct.id!],
          );
          if (isSavedQR && lastProduct.id != null) {
            Product? lastProductWithQR = await productRepository.getProduct(
              where: 'product_id = ?',
              whereArgs: [lastProduct.id!],
            );
            if (lastProductWithQR == null) return false;
            ProductsCubit productsCubit = context.read<ProductsCubit>();
            List<Product> products = productsCubit.state.toList();
            products.add(lastProductWithQR);
            productsCubit.changeProducts(products);
          }
        }
        return isSaved;
      } else {
        return false;
      }
    } catch (e) {
      debugPrint('Error: $e');
      enable = true;
      return false;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _descriptionController.dispose();
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    super.dispose();
  }
}
