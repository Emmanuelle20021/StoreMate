import 'dart:io';

import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_mate/app/data/utils/constants/constants.dart';
import 'package:store_mate/app/data/utils/injector.dart';
import 'package:store_mate/app/domain/models/product.dart';
import 'package:store_mate/app/domain/repositories/product_repository.dart';
import 'package:store_mate/app/presentation/bloc/products_cubit.dart';
import 'package:store_mate/app/presentation/global/widgets/light_primary_button.dart';

import '../../../../data/utils/constants/themes.dart';
import '../../../routes/routes.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ProductRepository productRepository =
        Injector.of(context).productRepository;
    ProductsCubit productsCubit = context.watch<ProductsCubit>();
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: kPrimary,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: kNoColor,
        title: const Text(
          'Productos disponibles',
          style: TextStyle(
            color: kOnPrimary,
          ),
        ),
      ),
      body: Stack(
        children: [
          ...kCircleDecorations,
          SafeArea(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
              decoration: const BoxDecoration(
                color: kBackground,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        style: ButtonStyle(
                          fixedSize: MaterialStateProperty.all(
                            const Size(50, 50),
                          ),
                          padding: MaterialStateProperty.all(
                            const EdgeInsets.all(kNone),
                          ),
                          alignment: Alignment.center,
                          backgroundColor: MaterialStateProperty.all(
                            kContainer,
                          ),
                          shape: MaterialStatePropertyAll(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                kDefaultButtonRadius,
                              ),
                            ),
                          ),
                        ),
                        onPressed: () => Navigator.pushNamed(
                          context,
                          Routes.newProduct,
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.add,
                            size: 30,
                          ),
                        ),
                      ),
                      AnimSearchBar(
                        width: MediaQuery.of(context).size.width - 100,
                        textController: searchController,
                        onSuffixTap: () async {
                          searchController.clear();
                          productsCubit.changeProducts(
                            await productRepository.getProducts() ?? [],
                          );
                        },
                        onSubmitted: (value) {
                          List<Product> filteredProducts = productsCubit.state
                              .where(
                                (element) => element.name
                                    .toLowerCase()
                                    .contains(value.toLowerCase()),
                              )
                              .toList();
                          productsCubit.changeProducts(filteredProducts);
                        },
                        color: kPrimary,
                        searchIconColor: kOnPrimary,
                        textFieldColor: kPrimary.withOpacity(.6),
                        textFieldIconColor: kOnPrimary,
                        helpText: 'Buscar productos...',
                        boxShadow: false,
                        style: const TextStyle(
                          color: kOnPrimary,
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: BlocBuilder<ProductsCubit, List<Product>>(
                      builder: (context, products) {
                        if (products.isEmpty) {
                          return const Center(
                            child: Text(
                              'No hay productos disponibles',
                              style: TextStyle(
                                color: kOnSurface,
                                fontSize: kMediumText,
                              ),
                            ),
                          );
                        } else {
                          return GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisSpacing: kDefaultGap,
                              mainAxisSpacing: kDefaultGap,
                              crossAxisCount: 2,
                              mainAxisExtent: 250,
                            ),
                            itemCount: products.length,
                            itemBuilder: (context, index) {
                              final product = products[index];
                              return Container(
                                padding: const EdgeInsets.only(
                                  top: kDefaultPadding * 4,
                                ),
                                decoration: BoxDecoration(
                                  color: kError,
                                  image: DecorationImage(
                                    image: FileImage(
                                      File(
                                        product.imagePath ?? '',
                                      ),
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius: BorderRadius.circular(
                                    kDefaultButtonRadius,
                                  ),
                                ),
                                child: Container(
                                  padding:
                                      const EdgeInsets.all(kDefaultPadding),
                                  decoration: const BoxDecoration(
                                    color: kContainer,
                                  ),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        product.name,
                                        style: const TextStyle(
                                          color: kOnSurface,
                                          fontSize: kMediumText,
                                          fontWeight: FontWeight.bold,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        maxLines: 1,
                                      ),
                                      Text(
                                        '\$${product.price}',
                                        style: const TextStyle(
                                          color: kPrimary,
                                          fontSize: kSmallText,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        product.description,
                                        style: const TextStyle(
                                          color: kLightTextColor,
                                          fontSize: kExtraSmallText,
                                          fontWeight: FontWeight.bold,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        maxLines: 2,
                                      ),
                                      SizedBox(
                                        width: double.infinity,
                                        child: LightPrimaryButton(
                                          onPressed: () {},
                                          text: 'Ver detalles',
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
