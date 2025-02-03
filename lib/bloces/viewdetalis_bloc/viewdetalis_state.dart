part of 'viewdetalis_bloc.dart';

@immutable
abstract class ViewdetalisState {}

class ViewdetalisInitial extends ViewdetalisState {}
class ViewdetalisblocLoading extends ViewdetalisState{}
class ViewdetalisblocLoaded extends ViewdetalisState{
  final ViewProductModel viewProductModel;
  ViewdetalisblocLoaded({required this.viewProductModel});
}
class ViewdetalisblocError extends ViewdetalisState{
  final String errormessage;
  ViewdetalisblocError({required this.errormessage});
}
