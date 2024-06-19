part of 'to_do_bloc.dart';

abstract class ToDoEvent extends Equatable {
  // extends equatable
  const ToDoEvent();

  @override
  List<Object?> get props => [];
}

// retrieve previous to do else ready to store some new to do
class ToDoStarted extends ToDoEvent {}

// store new to do
class AddTodo extends ToDoEvent {
  final Todo todo;

  const AddTodo(this.todo);

  @override
  List<Object?> get props => [todo];
}

// remove to do
class RemoveTodo extends ToDoEvent {
  final Todo todo;

  const RemoveTodo(this.todo);

  @override
  List<Object?> get props => [todo];
}

// update to do
class UpdateTodo extends ToDoEvent {
  final int index;

  const UpdateTodo(this.index);

  @override
  List<Object?> get props => [index];
}
