import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_project/data/wishlist_items.dart';
import 'package:firebase_project/features/home/models/home_product_data_models.dart';
import 'package:meta/meta.dart';

part 'wishlist_bloc_event.dart';
part 'wishlist_bloc_state.dart';

class WishlistBlocBloc extends Bloc<WishlistBlocEvent, WishlistBlocState> {
  WishlistBlocBloc() : super(WishlistBlocInitial()) {
    on<WishlistInitialEvent>(wishlistInitialEvent);
    on<WishlistRemoveFromWishlistEvent>(wishlistRemoveFromWishlistEvent);
  }

  FutureOr<void> wishlistInitialEvent(
      WishlistInitialEvent event, Emitter<WishlistBlocState> emit) {
    emit(WishlistSuccessState(wishlistItems: wishlistItems));
  }

  FutureOr<void> wishlistRemoveFromWishlistEvent(
      WishlistRemoveFromWishlistEvent event, Emitter<WishlistBlocState> emit) {
    wishlistItems.remove(event.productDataModel);
    print('Item is removed');
    emit(WishlistRemovedActionState());
    emit(WishlistSuccessState(wishlistItems: wishlistItems));
  }
}
