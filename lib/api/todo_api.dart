import 'package:dio/dio.dart';
import '../model/todo_model.dart';

Future<List<ToDoModel>> getToDoData() async{
  String url = 'https://jsonplaceholder.typicode.com/todos';
  Response res = await Dio().get(url);
  if (res.statusCode == 200) {
    print(res.data);
    var data = (res.data as List);
    return data.map<ToDoModel>((e) => ToDoModel.fromJson(e)).toList();
  }
  return res.data;
}