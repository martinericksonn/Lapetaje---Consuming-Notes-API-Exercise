// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:flutter/material.dart';
import 'package:noto/src/view/form.dart';
import 'package:noto/src/widgets/note_card.dart';

class NotesView extends StatefulWidget {
  const NotesView({Key? key}) : super(key: key);

  @override
  State<NotesView> createState() => _NotesViewState();
}

class _NotesViewState extends State<NotesView> {
  @override
  void initState() {
    super.initState();
  }

  int? tempIndex;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 1,
      child: Scaffold(
        appBar: appTitle(context),
        backgroundColor: Theme.of(context).primaryColor,
        body: appBody(context),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: appFloatingButton(context),
      ),
    );
  }

  FloatingActionButton appFloatingButton(context) {
    return FloatingActionButton.extended(
      onPressed: () => showAddTaskModal(context),
      label: Text(
        "Add Notes",
        style: TextStyle(
          letterSpacing: .5,
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
      icon: Icon(Icons.add_box_rounded),
    );
  }

  Center appBody(BuildContext context) {
    return Center(
      child: Column(children: [
        // SizedBox(
        //   height: 52,
        //   child: ButtonsTabBar(
        //     labelStyle: TextStyle(
        //       fontSize: 16,
        //       fontWeight: FontWeight.bold,
        //       color: Theme.of(context).colorScheme.primary,
        //     ),
        //     unselectedLabelStyle: TextStyle(
        //       fontWeight: FontWeight.bold,
        //       color: Theme.of(context).colorScheme.secondary,
        //     ),
        //     radius: 50,
        //     contentPadding: EdgeInsets.fromLTRB(50, 12, 50, 12),
        //     unselectedBackgroundColor: Theme.of(context).colorScheme.primary,
        //     // ignore: prefer_const_literals_to_create_immutables
        //     tabs: [
        //       const Tab(
        //         text: "Todo",
        //       ),
        //       const Tab(text: "Done"),
        //     ],
        //   ),
        // ),

        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: NoteCard(),
          ),
        ),
        // Expanded(
        //   child: TabBarView(children: [
        //     Padding(padding: const EdgeInsets.all(18.0), child: NoteCard()
        //         //  ActiveList(
        //         //   todoController: _todoController,
        //         //   editTask: showEditTaskModal,
        //         // ),
        //         ),
        //     Padding(padding: const EdgeInsets.all(18.0), child: SizedBox()
        //         //  FinishedTodos(
        //         //   todoController: _todoController,
        //         // ),
        //         ),
        //   ]),
        // )
      ]),
    );
  }

  AppBar appTitle(BuildContext context) {
    return AppBar(
      title: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          'Nōto',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.secondary),
        ),
      ),
      backgroundColor: Colors.white,
      elevation: 0,
    );
  }

  showAddTaskModal(context) async {
    await showModalBottomSheet(
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      context: context,
      builder: (_) {
        return Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: TaskForm(),
        );
      },
    );
  }

  // showEditTaskModal(Todo todo) async {
  //   Todo? task = await showModalBottomSheet<Todo>(
  //     isScrollControlled: true,
  //     shape: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.only(
  //         topLeft: Radius.circular(20),
  //         topRight: Radius.circular(20),
  //       ),
  //     ),
  //     context: context,
  //     builder: (_) {
  //       return Padding(
  //         padding:
  //             EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
  //         child: TaskForm(
  //           currentTask: todo.details,
  //         ),
  //       );
  //     },
  //   );
  //   if (task != null) {
  //     _todoController.updateTask(todo, task.details);
  //   }
  // }
}
