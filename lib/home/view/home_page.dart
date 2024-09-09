import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:recommender_saver/app/app.dart';
import 'package:recommender_saver/constants/colors.dart';
import 'package:recommender_saver/home/view/note_category.dart';
import 'package:recommender_saver/home/view/note_detail.dart';
import '../../category_selection/category.dart';
import '../../common/glass_floating_action_button.dart';
import '../cubit/home_cubit.dart';
import '../model/notes_model.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static Page<void> page() => const MaterialPage<void>(child: HomePage());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: BlocBuilder<HomeCubit, NoteState>(
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
                      'My notes',
                      style: TextStyle(fontSize: 30, color: Colors.white),
                    ),
                    IconButton(
                      onPressed: () {
                        // cubit.toggleNotesLoadedStyle();
                        // print(state);

                        // setState(() {
                        //   filteredNotes = sortNotesByModifiedTime(filteredNotes);
                        // });

                        context.read<AppBloc>().add(const AppLogoutRequested());
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
                if (state is NoteLoaded)
                  TextField(
                    onChanged: cubit.onSearchTextChanged,
                    style: const TextStyle(fontSize: 16, color: Colors.white),
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(vertical: 12),
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
                        borderSide: const BorderSide(color: Colors.transparent),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(color: Colors.transparent),
                      ),
                    ),
                  ),
                SizedBox(
                  height: 20,
                ),
                const NoteCategory(),
                if (state is NoteInitial)
                  Expanded(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),

                if (state is NoteLoaded)
                  Expanded(
                    child: !state.isList
                        ? GridView.builder(
                            padding: EdgeInsets.only(top: 20, bottom: 10),
                            gridDelegate:
                                SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent:
                                  200, // Max width for each item
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 10,
                              childAspectRatio: 1.4,
                            ),
                            // gridDelegate:
                            //     SliverGridDelegateWithFixedCrossAxisCount(
                            //   crossAxisCount: 2,
                            //   crossAxisSpacing: 12,
                            //   mainAxisSpacing: 12,
                            //   childAspectRatio: 1.4,
                            // ),
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
                              child: SizedBox(
                                child: HomeWidget(
                                  index: index,
                                  notes: state.sortedNotes[index],
                                ),
                              ),
                            ),
                            itemCount: state.sortedNotes.length,
                          )
                        : ListView.builder(
                            padding: const EdgeInsets.only(top: 30),
                            itemCount: state.sortedNotes.length,
                            itemBuilder: (context, index) {
                              return HomeWidget(
                                index: index,
                                notes: state.sortedNotes[index],
                              );
                            },
                          ),
                  )
              ],
            ),
          );
        },
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
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: secondryColor.withOpacity(0.5),
          width: 1,
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
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: secondryColor
                          .withOpacity(0.5), // Purple color for the border
                      width: 1, // 1px border width
                    ),
                    borderRadius: BorderRadius.only(
                      topRight: index % 2 == 0
                          ? Radius.circular(30)
                          : Radius.circular(0),
                      topLeft: index % 2 != 0
                          ? Radius.circular(30)
                          : Radius.circular(0),
                      bottomRight: Radius.circular(30),
                      bottomLeft: Radius.circular(30),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Text(
                      '${notes.parentName}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Name:',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  Flexible(
                    child: Text(
                      '${notes.name}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontStyle: FontStyle.normal,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Recommender:',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  Flexible(
                    child: Text(
                      '${notes.recommender}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontStyle: FontStyle.normal,
                      ),
                    ),
                  ),
                ],
              ),
              Center(
                child: Text(
                  '${notes.notes}',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                  ),
                ),
              ),
              Center(
                child: Text(
                  DateFormat('MMM d, yyyy, HH:mm').format(notes.createdAt),
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.6),
                    fontSize: 10,
                  ),
                ),
              ),
            ],
          ),
        ),
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
