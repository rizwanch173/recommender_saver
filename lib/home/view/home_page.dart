import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:intl/intl.dart';
import 'package:rebirth/rebirth.dart';
import 'package:recommender_saver/app/app.dart';
import 'package:recommender_saver/constants/colors.dart';
import 'package:recommender_saver/drawer_category/drawer_category_page.dart';
import 'package:recommender_saver/home/view/note_category.dart';
import 'package:recommender_saver/home/view/note_detail.dart';
import '../../category_selection/category.dart';
import '../../common/glass_floating_action_button.dart';
import '../cubit/home_cubit.dart';
import '../model/notes_model.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key, required this.isChange});

  static Page<void> page() => MaterialPage<void>(
        child: HomePage(
          isChange: true,
        ),
      );
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isChange;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      key: _scaffoldKey,
      drawer: Drawer(
        width: 200,
        backgroundColor: primaryColor,
        elevation: 0,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              // No profile or header, just the menu options
              ListTile(
                leading: Icon(
                  Icons.category,
                  color: Colors.white,
                ),
                title: Text(
                  'Categories',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DrawerCategoryPage()),
                  );
                },
              ),
              // Divider(), // Optional: To separate the two buttons visually
              ListTile(
                leading: Icon(
                  Icons.logout,
                  color: Colors.white,
                ),
                title: Text(
                  'Logout',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onTap: () async {
                  context.read<HomeCubit>().logout();
                  context.read<CategoryCubit>().logout();

                  await Future.delayed(
                    Duration(microseconds: 500),
                  );

                  context.read<AppBloc>().add(
                        const AppLogoutRequested(),
                      );
                  // WidgetRebirth.createRebirth(context: context);
                  Phoenix.rebirth(context);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
      body: BlocBuilder<HomeCubit, NoteState>(
        builder: (context, state) {
          final cubit = BlocProvider.of<HomeCubit>(context);
          if (isChange) {
            print({"fetchAllNotesX"});
            context.read<HomeCubit>().fetchAllNotes();
            context.read<CategoryCubit>().fetchAllCategory();
            isChange = false;
          }

          return Padding(
            padding: const EdgeInsets.fromLTRB(16, 50, 16, 0),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: HamburgerMenuIcon(),
                      onPressed: () {
                        // Open the drawer when the icon is pressed
                        _scaffoldKey.currentState?.openDrawer();
                      },
                    ),

                    const Text(
                      'My notes',
                      style: TextStyle(fontSize: 30, color: Colors.white),
                    ),
                    SizedBox(
                      width: 40,
                    )
                    // IconButton(
                    //   onPressed: () async {
                    //     // cubit.toggleNotesLoadedStyle();
                    //     // print(state);

                    //     // setState(() {
                    //     //   filteredNotes = sortNotesByModifiedTime(filteredNotes);
                    //     // });
                    //     context.read<HomeCubit>().logout();

                    //     await Future.delayed(Duration(microseconds: 500));

                    //     context.read<AppBloc>().add(
                    //           const AppLogoutRequested(),
                    //         );

                    //     // Restart the app
                    //     //  RestartWidget.restartApp(context);
                    //   },
                    //   padding: const EdgeInsets.all(0),
                    //   icon: Container(
                    //     width: 40,
                    //     height: 40,
                    //     decoration: BoxDecoration(
                    //         color: Colors.grey.shade800.withOpacity(.8),
                    //         borderRadius: BorderRadius.circular(10)),
                    //     child: const Icon(
                    //       Icons.exit_to_app,
                    //       color: Colors.white,
                    //     ),
                    //   ),
                    // )
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
                  BlocListener<HomeCubit, NoteState>(
                    listener: (context, state) {
                      if (state is NoteLoaded) {
                        print(state.sortedNotes.length);
                        print("state.sortedNotes.length");
                      }
                    },
                    child: Expanded(
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
                                        notesf: state.sortedNotes[index],
                                        parentName:
                                            state.sortedNotes[index].parentName,
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
        borderRadius: BorderRadius.only(
          topRight: index % 2 == 0 ? Radius.circular(30) : Radius.circular(0),
          topLeft: index % 2 != 0 ? Radius.circular(30) : Radius.circular(0),
          bottomRight: Radius.circular(30),
          bottomLeft: Radius.circular(30),
        ),
        border: Border.all(
          color: secondryColor.withOpacity(0.5),
          width: 1,
        ),
        color: Color(0xff262626),
        gradient: LinearGradient(
          begin: Alignment.topLeft, // 45° angle
          end: Alignment.bottomRight,
          colors: [
            Colors.white, // white at the beginning
            Color(0xFFFBE293), // #fbe293 color
            Color(0xFFFFC817), // #ffc817 color
          ],
        ),
      ),

      // decoration: BoxDecoration(
      //   border: Border.all(
      //     color: secondryColor.withOpacity(0.5),
      //     width: 1,
      //   ),
      //   color: Color(0xff262626),
      //   borderRadius: BorderRadius.only(
      //     topRight: index % 2 == 0 ? Radius.circular(30) : Radius.circular(0),
      //     topLeft: index % 2 != 0 ? Radius.circular(30) : Radius.circular(0),
      //     bottomRight: Radius.circular(30),
      //     bottomLeft: Radius.circular(30),
      //   ),
      // ),
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
                        color: Colors.black,
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
                      color: Colors.black,
                      fontSize: 12,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  Flexible(
                    child: Text(
                      '${notes.name}',
                      style: TextStyle(
                        color: Colors.black,
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
                      color: Colors.black,
                      fontSize: 12,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  Flexible(
                    child: Text(
                      '${notes.recommender}',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontStyle: FontStyle.normal,
                      ),
                    ),
                  ),
                ],
              ),
              // Center(
              //   child: Text(
              //     '${notes.notes}',
              //     style: TextStyle(
              //       color: Colors.white,
              //       fontSize: 10,
              //     ),
              //   ),
              // ),
              Center(
                child: Text(
                  DateFormat('MMM d, yyyy, HH:mm').format(notes.createdAt),
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.6),
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

class HamburgerMenuIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 15, // Smallest line
          height: 3,
          color: Colors.white,
        ),
        SizedBox(height: 6), // Space between lines
        Container(
          width: 20, // Medium line
          height: 3,
          color: Colors.white,
        ),
        SizedBox(height: 6),
        Container(
          width: 25, // Largest line
          height: 3,
          color: Colors.white,
        ),
      ],
    );
  }
}
