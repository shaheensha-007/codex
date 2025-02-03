part of 'viewdetalis_bloc.dart';

@immutable
abstract class ViewdetalisEvent {}
class Fetchviewdetalis extends ViewdetalisEvent{
  final String id;
  Fetchviewdetalis({
    required this.id,
});
}
