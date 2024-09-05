import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recommender_saver/app/app.dart';
import 'package:recommender_saver/constants/colors.dart';
import 'package:recommender_saver/category_selection/models/category_model.dart';
import 'package:recommender_saver/hive/notes.dart';
import 'package:recommender_saver/home/home.dart';
import 'package:recommender_saver/home/view/note_category.dart';
import 'package:recommender_saver/home/view/note_detail.dart';
import 'package:recommender_saver/model.dart';
import 'package:intl/intl.dart';

import '../../category_selection/category.dart';
import '../cubit/home_cubit.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static Page<void> page() => const MaterialPage<void>(child: HomePage());

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final user = context.select((AppBloc bloc) => bloc.state.user);
    // List<NoteX> filteredNotes = sampleNotes;
    bool sorted = false;

    // final List<CategoryModel> categories = [
    //   CategoryModel(
    //     cat_id: 'eee',
    //     cat_name: 'food',
    //     createdAt: DateTime.now(),
    //   ),
    // ];

    return Scaffold(
      backgroundColor: primaryColor,
      body: BlocProvider(
        create: (context) => HomeCubit()..init(),
        child: BlocListener<HomeCubit, NoteState>(
            listener: (context, state) {},
            child: BlocBuilder<HomeCubit, NoteState>(
              builder: (context, state) {
                final cubit = BlocProvider.of<HomeCubit>(context);
                return Padding(
                  padding: const EdgeInsets.fromLTRB(16, 40, 16, 0),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Recommends',
                            style: TextStyle(fontSize: 30, color: Colors.white),
                          ),
                          IconButton(
                            onPressed: () {
                              cubit.toggleNotesLoadedStyle();
                              print(state);

                              // setState(() {
                              //   filteredNotes = sortNotesByModifiedTime(filteredNotes);
                              // });

                              // context
                              //     .read<AppBloc>()
                              //     .add(const AppLogoutRequested());
                            },
                            padding: const EdgeInsets.all(0),
                            icon: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade800.withOpacity(.8),
                                  borderRadius: BorderRadius.circular(10)),
                              child: const Icon(
                                Icons.menu_outlined,
                                color: Colors.white,
                              ),
                            ),
                          )
                        ],
                      ),
                      // Avatar(photo: user.photo),
                      // const SizedBox(height: 4),
                      // Text(user.email ?? '', style: textTheme.titleLarge),
                      // const SizedBox(height: 4),
                      // Text(user.name ?? '', style: textTheme.headlineSmall),
                      const SizedBox(
                        height: 20,
                      ),
                      TextField(
                        ///onChanged: onSearchTextChanged,
                        style:
                            const TextStyle(fontSize: 16, color: Colors.white),
                        decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 12),
                          hintText: "Search notes...",
                          hintStyle: const TextStyle(color: Colors.grey),
                          prefixIcon: const Icon(
                            Icons.search,
                            color: Colors.grey,
                          ),
                          fillColor: Colors.grey.shade800,
                          filled: true,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide:
                                const BorderSide(color: Colors.transparent),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide:
                                const BorderSide(color: Colors.transparent),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      NoteCategory(),
                      if (state is NoteInitial)
                        Expanded(
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),

                      if (state is NoteLoaded)
                        Expanded(
                          child: !state.isTrue
                              ? GridView.builder(
                                  padding: EdgeInsets.only(top: 20, bottom: 10),
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 12,
                                    mainAxisSpacing: 12,
                                  ),
                                  itemBuilder: (_, index) => GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) => NoteDetailPage(
                                            homeCubit: cubit,
                                            index: index,
                                          ),
                                        ),
                                      );
                                    },
                                    child: HomeWidget(
                                      index: index,
                                      notes: state.notes[index],
                                    ),
                                  ),
                                  itemCount: state.notes.length,
                                )
                              : ListView.builder(
                                  padding: const EdgeInsets.only(top: 30),
                                  itemCount: state.notes.length,
                                  itemBuilder: (context, index) {
                                    return HomeWidget(
                                      index: index,
                                      notes: state.notes[index],
                                    );
                                  },
                                ),
                        )
                    ],
                  ),
                );
              },
            )),
      ),
      floatingActionButton: GlassFloatingActionButton(
        icon: Icons.add,
        onPressed: () {
          Navigator.of(context).push<void>(CategorySelection.route());
        },
      ),
    );
  }
}

class HomeWidget extends StatelessWidget {
  final int index;
  final NoteModel notes;

  HomeWidget({
    required this.notes,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<HomeCubit>(context);
    return Container(
      width: 200,
      height: 300,
      decoration: BoxDecoration(
        border: Border.all(
          color: secondryColor.withOpacity(0.5), // Purple color for the border
          width: 1, // 1px border width
        ),
        color: Color(0xff262626),
        borderRadius: BorderRadius.only(
          topRight: index % 2 == 0 ? Radius.circular(30) : Radius.circular(0),
          topLeft: index % 2 != 0 ? Radius.circular(30) : Radius.circular(0),
          bottomRight: Radius.circular(30),
          bottomLeft: Radius.circular(30),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Category Name', // Category Name
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Icon(
                    Icons.more_vert,
                    color: Colors.white,
                  ),
                ],
              ),
              Text(
                'Created: Aug 29, 2024', // Date created
                style: TextStyle(
                  color: Colors.white.withOpacity(0.6),
                  fontSize: 12,
                ),
              ),
              Spacer(),
              Text(
                'Movie Name: Inception', // Movie Name
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Recommended by: John Doe', // Recommender Name
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class GlassFloatingActionButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const GlassFloatingActionButton({
    Key? key,
    required this.icon,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Stack(
        alignment: Alignment.center,
        children: [
          // This creates the glass border effect
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              width: 68,
              height: 68,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white.withOpacity(0.3),
                  width: 4,
                ),
                gradient: LinearGradient(
                  colors: [
                    Colors.white.withOpacity(0.1),
                    Colors.white.withOpacity(0.2),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
          ),
          // This is the actual button with black background
          Positioned(
            child: GestureDetector(
              onTap: onPressed,
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: secondryColor.withOpacity(0.5),
                ),
                child: Center(
                  child: Icon(
                    icon,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ThreeSideCurvedContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 300,
      decoration: BoxDecoration(
        color: Colors.orange,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(40),
          bottomRight: Radius.circular(40),
          bottomLeft: Radius.circular(40),
        ),
      ),
      child: Center(
        child: Text(
          'Content Goes Here', // Placeholder for inner content
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
    );
  }
}
