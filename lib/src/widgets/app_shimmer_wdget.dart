import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Widget buildShimmerItem({required double height, required double width, double? borderRadius}) {
  return Shimmer(
    gradient: const LinearGradient(
      begin: Alignment.centerRight,
      end: Alignment.centerLeft,
      colors: <Color>[
        Color.fromRGBO(231, 235, 240, 1),
        Color.fromRGBO(231, 235, 240, 1),
        Color.fromRGBO(251, 251, 251, 0.8),
        Color.fromRGBO(231, 235, 240, 1),
        Color.fromRGBO(231, 235, 240, 1),
      ],
      stops: <double>[0, 0.35, 0.5, 0.65, 2],
    ),
    period: const Duration(seconds: 2),
    direction: ShimmerDirection.ltr,
    child: Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(borderRadius??8),
      ),
    ),
  );
}
