import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:codex/Modelclass/viewproductmodel/ViewProductModel.dart';
import 'package:meta/meta.dart';

import '../../Apies/ViewproductApi/ViewProductApi.dart';

part 'viewdetalis_event.dart';
part 'viewdetalis_state.dart';

class ViewdetalisBloc extends Bloc<ViewdetalisEvent, ViewdetalisState> {
  ViewdetalisApi viewdetalisApi=ViewdetalisApi();
  ViewdetalisBloc() : super(ViewdetalisInitial()) {
    on<Fetchviewdetalis>((event, emit) async{
      emit(ViewdetalisblocLoading());
   try{
     final isviewloan=await viewdetalisApi.fetchViewProductDetails(id: event.id);
     emit(ViewdetalisblocLoaded(viewProductModel: isviewloan));
     }catch(e){
     emit(ViewdetalisblocError(errormessage: e.toString()));
   }
    });
  }
}
