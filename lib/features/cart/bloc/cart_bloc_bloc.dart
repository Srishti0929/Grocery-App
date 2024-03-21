import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_project/data/cart_items.dart';
import 'package:firebase_project/features/home/models/home_product_data_models.dart';
import 'package:meta/meta.dart';

part 'cart_bloc_event.dart';
part 'cart_bloc_state.dart';

class CartBlocBloc extends Bloc<CartBlocEvent, CartBlocState> {
  CartBlocBloc() : super(CartBlocInitial()) {
    on<CartInitialEvent>(cartInitialEvent);
    on<CartRemoveFromCartEvent>(cartRemoveFromCartEvent);
  }

  FutureOr<void> cartInitialEvent(
      CartInitialEvent event, Emitter<CartBlocState> emit) {
    emit(CartSuccessState(cartItems: cartItems));
  }

  FutureOr<void> cartRemoveFromCartEvent(
      CartRemoveFromCartEvent event, Emitter<CartBlocState> emit) {
    cartItems.remove(event.productDataModel);
    print('Item is removed');
    emit(CartRemovedActionState());
    emit(CartSuccessState(cartItems: cartItems));
    
  }
}
