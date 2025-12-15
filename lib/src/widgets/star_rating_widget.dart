import 'package:en_tube/src/constraints/app_color.dart';
import 'package:flutter/material.dart';

List<Widget> buildStarRating(double rating) {
  List<Widget> stars = [];
  int fullStars = rating.floor();
  bool hasHalfStar = (rating - fullStars) >= 0.5;

  for (int i = 0; i < fullStars; i++) {
    stars.add(Icon(Icons.star, color: AppColor.yellow));
  }

  if (hasHalfStar) {
    stars.add(Icon(Icons.star_half, color: AppColor.yellow));
  }

  while (stars.length < 5) {
    stars.add(Icon(Icons.star_border_outlined, color: AppColor.yellow));
  }

  return stars;
}
