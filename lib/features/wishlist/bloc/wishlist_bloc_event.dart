part of 'wishlist_bloc_bloc.dart';

@immutable
abstract class WishlistBlocEvent {}

class WishlistInitialEvent extends WishlistBlocEvent{}

class WishlistRemoveFromWishlistEvent extends WishlistBlocEvent {
  final ProductDataModel productDataModel;

  WishlistRemoveFromWishlistEvent({required this.productDataModel});
  
}
