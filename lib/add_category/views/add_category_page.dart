import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recommender_saver/add_category/views/add_category_form.dart';
import '../../common/glass_back_button.dart';
import '../../constants/colors.dart';
import '../cubit/add_category_cubit.dart';

class AddCategoryPage extends StatelessWidget {
  const AddCategoryPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const AddCategoryPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: primaryColor,
        body: SingleChildScrollView(
          child: BlocProvider(
            create: (context) => AddCategoryCubit(),
            child: BlocBuilder<AddCategoryCubit, AddCategoryState>(
              builder: (context, state) {
                // final cubit = BlocProvider.of<AddNoteCubit>(context);
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 60,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: GlassButton(
                            icon: Icons.arrow_back_ios_new_outlined,
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ),
                        Text(
                          '',
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                        SizedBox(
                          width: 50,
                        )
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    const AddCategoryForm()
                  ],
                );
              },
            ),
          ),
        ));
  }
}
