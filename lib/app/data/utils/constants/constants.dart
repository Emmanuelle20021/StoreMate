import 'package:flutter/material.dart';

import 'themes.dart';

const String kAppTitle = 'Store Mate';
const String kNewSale = 'Nueva Venta';
const String kNewProduct = 'Nuevo Producto';
const String kLabelHome = 'Inicio';
const String kLabelProducts = 'Productos';
final List<Widget> kCircleDecorations = [
  Positioned(
    top: -kCircleDecorationLargeSize * 0.3,
    right: -kCircleDecorationLargeSize * 0.3,
    child: Container(
      height: kCircleDecorationLargeSize,
      width: kCircleDecorationLargeSize,
      decoration: BoxDecoration(
        color: kCircleDecorationLargeColor,
        shape: BoxShape.circle,
      ),
    ),
  ),
  Positioned(
    top: -kCircleDecorationMediumSize * 0.3,
    left: -kCircleDecorationMediumSize * 0.3,
    child: Container(
      height: kCircleDecorationMediumSize,
      width: kCircleDecorationMediumSize,
      decoration: BoxDecoration(
        color: kCircleDecorationMediumColor,
        shape: BoxShape.circle,
      ),
    ),
  ),
  Positioned(
    top: kCircleDecorationMediumSize * 1.5,
    left: -kCircleDecorationMediumSize * 0.3,
    child: Container(
      height: kCircleDecorationMediumSize,
      width: kCircleDecorationMediumSize,
      decoration: BoxDecoration(
        color: kCircleDecorationMediumColor,
        shape: BoxShape.circle,
      ),
    ),
  ),
  Positioned(
    top: kCircleDecorationSmallSize,
    left: kCircleDecorationSmallSize * 3,
    child: Container(
      height: kCircleDecorationSmallSize,
      width: kCircleDecorationSmallSize,
      decoration: BoxDecoration(
        color: kCircleDecorationSmallColor,
        shape: BoxShape.circle,
      ),
    ),
  ),
  Positioned(
    top: kCircleDecorationSmallSize * 3,
    left: kCircleDecorationSmallSize * 5.5,
    child: Container(
      height: kCircleDecorationSmallSize,
      width: kCircleDecorationSmallSize,
      decoration: BoxDecoration(
        color: kCircleDecorationSmallColor,
        shape: BoxShape.circle,
      ),
    ),
  ),
  Positioned(
    top: kCircleDecorationSmallSize * 3.4,
    left: kCircleDecorationSmallSize * 2.5,
    child: Container(
      height: kCircleDecorationSmallSize,
      width: kCircleDecorationSmallSize,
      decoration: BoxDecoration(
        color: kCircleDecorationSmallColor,
        shape: BoxShape.circle,
      ),
    ),
  ),
];
