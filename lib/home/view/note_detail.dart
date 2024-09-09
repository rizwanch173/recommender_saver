import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recommender_saver/home/cubit/home_cubit.dart';
import '../../category_selection/cubit/category_cubit.dart';
import '../../category_selection/models/category_model.dart';
import '../../common/glass_back_button.dart';
import '../../constants/colors.dart';
import '../model/notes_model.dart';

class NoteDetailPage extends StatelessWidget {
  final HomeCubit homeCubit;
  final int index;

  const NoteDetailPage(
      {super.key, required this.homeCubit, required this.index});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Color(0xff262626), // Background color matching the design
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 60.0),
        child: BlocProvider(
          create: (context) => homeCubit,
          child: BlocBuilder<HomeCubit, NoteState>(
            builder: (context, state) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (state is NoteLoaded)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Back Button with Glass Effect
                        GlassButton(
                          icon: Icons.arrow_back_ios_new_outlined,
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        Text(
                          state.sortedNotes[index].parentName,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 24,
                          ),
                        ),
                        // Share Button with Glass Effect
                        GlassButton(
                          icon: Icons.ios_share_outlined,
                          onPressed: () {},
                        ),
                      ],
                    ),
                  if (state is NoteLoaded)
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 100, left: 20, right: 20),
                      child: Column(
                        children: [
                          _NoteDetailWidget(state.sortedNotes[index]),
                        ],
                      ),
                    ),
                  SizedBox()
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _NoteDetailWidget extends StatelessWidget {
  const _NoteDetailWidget(this.note);
  final NoteModel note;

  @override
  Widget build(BuildContext context) {
    print(note.parentId);
    CategoryModel? category;
    return BlocBuilder<CategoryCubit, CategoryState>(
      builder: (context, state) {
        if (state is CategoryLoaded)
          try {
            category = state.categories
                .firstWhere((category) => category.id == note.parentId);
            print(category!.patent_name); // Output: movie
          } catch (e) {
            print("Category not found");
          }
        return Column(
          children: [
            if (state is CategoryLoaded)
              Container(
                height: 400,
                width: 400,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: secondryColor
                        .withOpacity(0.5), // Purple color for the border
                    width: 1, // 1px border width
                  ),
                  color: Color(0xff262626),
                  borderRadius: BorderRadius.all(
                    Radius.circular(30),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      _dataList(category!.name, note.name),
                      _dataList(category!.detail_01, note.detail01),
                      _dataList(category!.detail_02, note.detail02),
                      _dataList(category!.Recommender, note.recommender),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: DashedLine(),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: Text(
                          '${note.notes}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        );
      },
    );
  }

  Widget _dataList(String title, String data) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '$title:',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
          Spacer(),
          Flexible(
            child: Text(
              '$data',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class DashedLine extends StatelessWidget {
  final double dashWidth;
  final double dashHeight;
  final double dashSpacing;
  final Color color;

  const DashedLine({
    this.dashWidth = 5,
    this.dashHeight = 1,
    this.dashSpacing = 3,
    this.color = Colors.grey,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final boxCount =
            (constraints.constrainWidth() / (dashWidth + dashSpacing)).floor();
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(boxCount, (_) {
            return Container(
              width: dashWidth,
              height: dashHeight,
              color: color,
            );
          }),
        );
      },
    );
  }
}
