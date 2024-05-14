// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:api_exam/api/todo_api.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

import '../model/todo_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<ToDoModel> toDo;
  @override
  void initState() {
    super.initState();
    toDo = [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Todo List"),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: getToDoData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text("${snapshot.error}"),
            );
          } else {
            List<ToDoModel>? todoData = snapshot.data;
            return ListView.builder(
              itemCount: todoData!.length,
              itemBuilder: (context, index) {
                final todo = todoData[index];
                return Dismissible(
                  key: ValueKey<ToDoModel>(todo),
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: todo.completed!
                            ? Colors.green.shade100
                            : Colors.red.shade100,
                      ),
                      child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: todo.completed! ? Colors.green : Colors.red,
                            child: Text(
                              "${todo.id}",
                            ),
                          ),
                          title: Text(
                            "${todo.title}",
                            maxLines: 1,
                          ),
                          trailing: Icon(
                            todo.completed! ? Icons.verified : Icons.replay,
                            color: todo.completed!
                                ? Colors.green.shade900
                                : Colors.red.shade900,
                          )),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
