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
    // Listen for FetchProductdetalis event and handle it
    on<FetchProductdetalis>((event, emit) async {
      emit(ProductdetalisblocLoding());  // Emitting loading state

      try {

        final List<ProductdetalisModel> productDetails = await productdetalisApi.fetchProductDetails();


        emit(ProductdetalisblocLoaded(productdetalisModel: productDetails));
      } catch (e) {
        // If there's an error, emit the error state with the error message
        emit(ProductdetalisblocError(Errormessage: e.toString()));
      }
    });
  }
}
