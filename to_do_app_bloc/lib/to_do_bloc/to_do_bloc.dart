import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:to_do_app_bloc/data/to_do.dart';

part 'to_do_event.dart';
part 'to_do_state.dart';

class ToDoBloc extends HydratedBloc<ToDoEvent, ToDoState> {
  ToDoBloc() : super(const ToDoState()) {
    on<ToDoStarted>(_onStarted);

    on<AddTodo>(_onAddTodo);

    on<RemoveTodo>(_onRemoveTodo);

    on<UpdateTodo>(_onUpdateTodo);
  }

  void _onStarted(
    ToDoStarted event,
    Emitter<ToDoState> emit,
  ) {
    if (state.status == ToDoStatus.success) return;
    emit(
      state.copyWith(
        todos: state.todos,
        status: ToDoStatus.loading,
      ),
    );
  }

  void _onAddTodo(
    AddTodo event,
    Emitter<ToDoState> emit,
  ) {
    emit(
      state.copyWith(
        status: ToDoStatus.loading,
      ),
    );
    try {
      List<Todo> temp = [];
      temp.addAll(state.todos);
      temp.insert(0, event.todo);
      emit(
        state.copyWith(
          todos: temp,
          status: ToDoStatus.success,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: ToDoStatus.error,
        ),
      );
    }
  }

  void _onRemoveTodo(
    RemoveTodo event,
    Emitter<ToDoState> emit,
  ) {
    emit(
      state.copyWith(
        status: ToDoStatus.loading,
      ),
    );
    try {
      state.todos.remove(event.todo);
      emit(
        state.copyWith(
          todos: state.todos,
          status: ToDoStatus.success,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: ToDoStatus.error,
        ),
      );
    }
  }

  void _onUpdateTodo(
    UpdateTodo event,
    Emitter<ToDoState> emit,
  ) {
    emit(
      state.copyWith(
        status: ToDoStatus.loading,
      ),
    );
    try {
      state.todos[event.index].isDone = !state.todos[event.index].isDone;
      emit(
        state.copyWith(
          todos: state.todos,
          status: ToDoStatus.success,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: ToDoStatus.error,
        ),
      );
    }
  }

  @override
  ToDoState? fromJson(Map<String, dynamic> json) {
    return ToDoState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(ToDoState state) {
    return state.toJson();
  }
}
