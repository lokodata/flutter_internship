part of 'to_do_bloc.dart';

// initial = launching , loading = when add / delete / update , success = when success, error = when failed
enum ToDoStatus { initial, loading, success, error }

class ToDoState extends Equatable {
  final List<Todo> todos;
  final ToDoStatus status;
  const ToDoState({
    this.todos = const <Todo>[],
    this.status = ToDoStatus.initial,
  });

  ToDoState copyWith({
    List<Todo>? todos,
    ToDoStatus? status,
  }) {
    return ToDoState(
      todos: todos ?? this.todos,
      status: status ?? this.status,
    );
  }

  @override
  factory ToDoState.fromJson(Map<String, dynamic> json) {
    try {
      var listOfTodos = (json['todo'] as List<dynamic>).map((e) => Todo.fromJson(e! as String)).toList();

      return ToDoState(todos: listOfTodos, status: ToDoStatus.values.firstWhere((element) => element.name.toString() == json['status']));
    } catch (e) {
      rethrow;
    }
  }

  Map<String, dynamic> toJson() {
    return {'todo': todos, 'status': status.name};
  }

  @override
  List<Object?> get props => [todos, status];
}
