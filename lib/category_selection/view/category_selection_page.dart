import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recommender_saver/category_selection/cubit/category_cubit.dart';

class CategorySelection extends StatelessWidget {
  const CategorySelection({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const CategorySelection());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryCubit, CategoryState>(
      builder: (context, state) {
        final cubit = BlocProvider.of<CategoryCubit>(context);

        return Center(
          child: IconButton(
              onPressed: () {
                cubit.init();
              },
              splashColor: Colors.amber,
              splashRadius: 100,
              icon: Icon(
                Icons.add,
                color: Colors.white,
                size: 100,
              )),
        );
      },
    );
  }
}
