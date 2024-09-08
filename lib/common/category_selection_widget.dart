import 'package:flutter/material.dart';

import '../category_selection/models/category_model.dart';
import '../constants/colors.dart';

class CategorySelectionWidget extends StatelessWidget {
  final CategoryModel category;

  const CategorySelectionWidget({required this.category});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        border: Border.all(
          color: secondryColor.withOpacity(0.5),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            category.patent_name,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.0,
            ),
          ),
          Icon(
            Icons.arrow_right_alt_rounded,
            size: 16.0,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
