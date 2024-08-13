// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';

import '../../../../data/utils/constants/constants.dart';
import '../../../../data/utils/constants/themes.dart';
import '../../../../domain/models/product.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  ScreenshotController screenshotController = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    Product product = ModalRoute.of(context)?.settings.arguments as Product;
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: kPrimary,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: kNoColor,
        title: const Text(
          'Detalle de Producto',
          style: TextStyle(
            color: kOnPrimary,
          ),
        ),
      ),
      body: Stack(
        children: [
          ...kCircleDecorations,
          SafeArea(
            child: Stack(
              children: [
                Container(
                  constraints: const BoxConstraints(
                    maxHeight: 300,
                  ),
                  width: double.infinity,
                  child: Image.file(
                    File(
                      product.imagePath ?? '',
                    ),
                    fit: BoxFit.fill,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(
                        Icons.error,
                        color: kError,
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 200),
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    padding: const EdgeInsets.all(kDefaultPadding),
                    decoration: const BoxDecoration(
                      color: kSurface,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(kDefaultButtonRadius),
                        topRight: Radius.circular(kDefaultButtonRadius),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.name,
                              style: const TextStyle(
                                color: kTextColor,
                                fontSize: kExtraLargeText,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              height: kDefaultPadding,
                            ),
                            Text(
                              '\$${product.price}',
                              style: const TextStyle(
                                color: kPrimary,
                                fontSize: kLargeText,
                              ),
                            ),
                            const SizedBox(
                              height: kDefaultPadding,
                            ),
                            FittedBox(
                              child: Text(
                                product.description,
                                style: const TextStyle(
                                  color: kLightTextColor,
                                  fontSize: kMediumText,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.all(kMinimunPaddingSize),
                          height: 100,
                          width: 100,
                          decoration: const BoxDecoration(
                            color: kContainer,
                          ),
                          child: Image.file(
                            File(
                              product.qrCodePath ?? '',
                            ),
                            errorBuilder: (context, error, stackTrace) {
                              return const Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.error,
                                      color: kError,
                                    ),
                                    FittedBox(
                                      child: Text(
                                        'No hay un codigo QR disponible',
                                        maxLines: 3,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
