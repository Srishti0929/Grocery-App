part of 'wishlist_bloc_bloc.dart';

@immutable
abstract class WishlistBlocState {}

abstract class WishlistBlocActionState extends WishlistBlocState {}

final class WishlistBlocInitial extends WishlistBlocState {}

class WishlistSuccessState extends WishlistBlocState{
  final List<ProductDataModel> wishlistItems ;

  WishlistSuccessState({required this.wishlistItems});
}

class WishlistRemovedActionState extends WishlistBlocActionState {}
