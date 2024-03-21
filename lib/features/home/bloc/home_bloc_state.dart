part of 'home_bloc_bloc.dart';

@immutable
abstract class HomeBlocState {}

abstract class HomeBlocActionState extends HomeBlocState {}

class HomeBlocInitial extends HomeBlocState {}

class HomeLoadingState extends HomeBlocState {}

class HomeLoadedSuccessState extends HomeBlocState {
  final List<ProductDataModel> products;

  HomeLoadedSuccessState({required this.products});
}

class HomeErrorState extends HomeBlocState {}

class HomeNaigateToWishlistPageActionState extends HomeBlocActionState {}

class HomeNavigateToCartPageActionState extends HomeBlocActionState {}

class HomeProductItemWishlistedActionState extends HomeBlocActionState {}

class HomeProductItemCartedActionState extends HomeBlocActionState {}
