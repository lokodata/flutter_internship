import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:to_do_app_bloc/data/to_do.dart';
import 'package:to_do_app_bloc/to_do_bloc/to_do_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // to do methods
  // add to do
  addTodo(Todo todo) {
    context.read<ToDoBloc>().add(
          AddTodo(todo),
        );
  }

  // remove to do
  removeTodo(Todo todo) {
    context.read<ToDoBloc>().add(
          RemoveTodo(todo),
        );
  }

  // update to do
  updateTodo(int index) {
    context.read<ToDoBloc>().add(UpdateTodo(index));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,

        //
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            //
            showDialog(
                context: context,
                builder: (context) {
                  TextEditingController titleTextController = TextEditingController();
                  TextEditingController subtitleTextController = TextEditingController();

                  //
                  return AlertDialog(
                    //
                    title: const Text(
                      'Add a Task',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),

                    //
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        //
                        TextField(
                          controller: titleTextController,
                          cursorColor: Theme.of(context).colorScheme.secondary,
                          decoration: InputDecoration(
                            hintText: 'Task Title...',
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(color: Colors.black),
                            ),
                          ),
                        ),

                        //
                        const SizedBox(height: 10),

                        //
                        TextField(
                          controller: subtitleTextController,
                          cursorColor: Theme.of(context).colorScheme.secondary,
                          decoration: InputDecoration(
                            hintText: 'Task Description...',
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(color: Colors.grey),
                            ),
                          ),
                        ),
                      ],
                    ),

                    //
                    actions: [
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: TextButton(
                            onPressed: () {
                              addTodo(
                                Todo(
                                  title: titleTextController.text,
                                  subtitle: subtitleTextController.text,
                                ),
                              );
                              titleTextController.text = '';
                              subtitleTextController.text = '';
                              Navigator.pop(context);
                            },
                            style: TextButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  color: Theme.of(context).colorScheme.secondary,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              foregroundColor: Theme.of(context).colorScheme.secondary,
                            ),

                            //
                            child: SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: Icon(
                                  CupertinoIcons.check_mark,
                                  color: Theme.of(context).colorScheme.secondary,
                                ))),
                      )
                    ],
                  );
                });
          },
          backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
          child: const Icon(
            CupertinoIcons.add,
            color: Colors.black,
            size: 30,
          ),
        ),

        //
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
          elevation: 0,
          title: const Text(
            'My ToDo App',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),

        //
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocBuilder<ToDoBloc, ToDoState>(
            builder: (context, state) {
              if (state.status == ToDoStatus.success) {
                return ListView.builder(
                    itemCount: state.todos.length,
                    itemBuilder: (context, int i) {
                      return Card(
                        color: Theme.of(context).colorScheme.primaryContainer,
                        elevation: 1,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),

                        //
                        child: Slidable(
                            key: const ValueKey(0),
                            startActionPane: ActionPane(
                              motion: const ScrollMotion(),
                              children: [
                                SlidableAction(
                                  onPressed: (_) {
                                    removeTodo(state.todos[i]);
                                  },
                                  backgroundColor: Theme.of(context).colorScheme.error,
                                  foregroundColor: Colors.white,
                                  icon: Icons.delete,
                                  label: 'Delete',
                                ),
                              ],
                            ),

                            //
                            child: ListTile(
                                title: Text(state.todos[i].title),
                                subtitle: Text(state.todos[i].subtitle),
                                trailing: Checkbox(
                                    value: state.todos[i].isDone,
                                    activeColor: Theme.of(context).colorScheme.primary,
                                    onChanged: (value) {
                                      updateTodo(i);
                                    }))),
                      );
                    });
                //
              } else if (state.status == ToDoStatus.initial) {
                return const Center(child: CircularProgressIndicator());

                // error
              } else {
                return const Center(
                  child: Text('Error'),
                );
              }
            },
          ),
        ));
  }
}
