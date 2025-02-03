import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:codex/Apies/ProductApis/productApis.dart';
import 'package:codex/Modelclass/ProductModels/Productdetalis.dart';
import 'package:meta/meta.dart';

part 'productdetalis_event.dart';
part 'productdetalis_state.dart';

class ProductdetalisBloc extends Bloc<ProductdetalisEvent, ProductdetalisState> {
  ProductdetalisApi productdetalisApi=ProductdetalisApi();
  ProductdetalisBloc() : super(ProductdetalisInitial()) {
    on<FetchProductdetalis>((event, emit) async {
      emit(ProductdetalisblocLoding());
      try {
        final List<ProductdetalisModel> productDetails = await productdetalisApi.fetchProductDetails();
        emit(ProductdetalisblocLoaded(productdetalisModel: productDetails));
      } catch (e) {
        emit(ProductdetalisblocError(Errormessage: e.toString()));
      }
    });
  }
}
