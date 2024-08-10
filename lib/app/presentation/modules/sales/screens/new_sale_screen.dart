import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_mate/app/data/utils/constants/constants.dart';
import 'package:store_mate/app/presentation/bloc/products_cubit.dart';

import '../../../../data/utils/constants/themes.dart';
import '../../../../domain/models/product.dart';

class NewSaleScreen extends StatefulWidget {
  const NewSaleScreen({super.key});

  @override
  State<NewSaleScreen> createState() => _NewSaleScreenState();
}

class _NewSaleScreenState extends State<NewSaleScreen> {
  Product? selected;
  List<Product> selectedProducts = [];

  @override
  Widget build(BuildContext context) {
    List<Product> products = context.read<ProductsCubit>().state;
    String displayStringForOption(Product option) => option.name;

    return Scaffold(
      backgroundColor: kPrimary,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: kNoColor,
        title: const Text(
          'Nueva Venta',
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
              constraints: const BoxConstraints.expand(),
              decoration: const BoxDecoration(
                color: kBackground,
              ),
              padding: const EdgeInsets.all(kDefaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Añadir un producto a la venta',
                    style: TextStyle(
                      color: kOnBackground,
                      fontSize: kLargeText,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: kDefaultGap),
                  SizedBox(
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Autocomplete<Product>(
                            fieldViewBuilder: (context, textEditingController,
                                focusNode, onFieldSubmitted) {
                              return TextFormField(
                                controller: textEditingController,
                                focusNode: focusNode,
                                onFieldSubmitted: (value) {
                                  debugPrint(value);
                                },
                                decoration: const InputDecoration(
                                  hintText: 'Buscar producto',
                                  border: OutlineInputBorder(),
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: kDefaultPadding,
                                    vertical: kDefaultPadding / 2,
                                  ),
                                ),
                              );
                            },
                            onSelected: (option) {
                              setState(() {
                                selected = option;
                              });
                            },
                            displayStringForOption: displayStringForOption,
                            optionsBuilder: (textEditingValue) {
                              if (textEditingValue.text == '') {
                                return products;
                              }
                              return products.where(
                                (Product option) {
                                  return option.name.toLowerCase().contains(
                                      textEditingValue.text.toLowerCase());
                                },
                              );
                            },
                          ),
                        ),
                        ElevatedButton.icon(
                          onPressed: _addProductToSale,
                          icon: const Icon(Icons.add),
                          label: const Text('Agregar'),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: kDefaultGap),
                  Stack(
                    children: [
                      Divider(
                        color:
                            kOnBackground.withOpacity(kDefaultOverlayOpacity),
                        thickness: 1,
                      ),
                      Center(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: kDefaultPadding,
                          ),
                          decoration: const BoxDecoration(
                            color: kBackground,
                          ),
                          child: const Text(
                            'ó',
                            style: TextStyle(
                              color: kOnBackground,
                              fontSize: kLargeText,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: kDefaultGap),
                  Center(
                    child: OutlinedButton(
                      onPressed: () async {
                        ScanResult response = await BarcodeScanner.scan();
                        setState(() {
                          selected = products.firstWhere(
                            (product) =>
                                product.id.toString() ==
                                response.rawContent.toString(),
                          );
                        });
                        _addProductToSale();
                      },
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(
                          color: kPrimary,
                          width: 2,
                        ),
                      ),
                      child: const Text('Escanear QR'),
                    ),
                  ),
                  const SizedBox(height: kDefaultGap),
                  Expanded(
                    child: selectedProducts.isEmpty
                        ? const Center(
                            child: Text(
                              'Aun no hay productos en la venta',
                              style: TextStyle(
                                color: kTextColor,
                                fontSize: kLargeText,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        : ListView.builder(
                            itemCount: selectedProducts.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Text(products[index].name),
                                subtitle:
                                    Text(products[index].price.toString()),
                                trailing: IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () {
                                    // Remove product from sale
                                    setState(() {
                                      selectedProducts.removeAt(index);
                                    });
                                  },
                                ),
                              );
                            },
                          ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _saveNewSale() {}
  void _addProductToSale() {
    if (selected != null) {
      // Add product to sale
      setState(() {
        selectedProducts.add(selected!);
        selected = null;
      });
    } else {
      // Show error message
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            alignment: Alignment.center,
            icon: const Icon(
              Icons.info,
              color: kPrimary,
              size: kCircleDecorationSmallSize,
            ),
            title: const Text('¡Vaya!'),
            content: const Text(
              'Debe seleccionar un producto para agregar a la venta.',
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Aceptar'),
              ),
            ],
          );
        },
      );
    }
  }
}
