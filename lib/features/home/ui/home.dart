import 'package:firebase_project/features/cart/ui/cart.dart';
import 'package:firebase_project/features/home/bloc/home_bloc_bloc.dart';
import 'package:firebase_project/features/home/ui/product_tile_widget.dart';
import 'package:firebase_project/features/wishlist/ui/wishlist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    homeBlocBloc.add(HomeInitialEvent());
    super.initState();
  }

  HomeBlocBloc homeBlocBloc = HomeBlocBloc();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBlocBloc, HomeBlocState>(
      bloc: homeBlocBloc,
      listenWhen: (previous, current) => current is HomeBlocActionState,
      buildWhen: (previous, current) => current is! HomeBlocActionState,
      listener: (context, state) {
        if (state is HomeNavigateToCartPageActionState) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Cart()));
        } else if (state is HomeNaigateToWishlistPageActionState) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Wishlist()));
        } else if (state is HomeProductItemCartedActionState){
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Item is added to Cart')));
        }else if (state is HomeProductItemWishlistedActionState){
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Wishlisted Item')));
        }

      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case HomeLoadingState:
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          case HomeLoadedSuccessState:
            final successState = state as HomeLoadedSuccessState;
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.teal,
                title: Text(
                  'Your Grocery App',
                  style: TextStyle(color: Colors.white),
                ),
                actions: [
                  IconButton(
                      onPressed: () {
                        homeBlocBloc.add(HomeWishlistButtonNavigateEvent());
                      },
                      icon: Icon(
                        Icons.favorite,
                        color: Colors.white,
                      )),
                  IconButton(
                      onPressed: () {
                        homeBlocBloc.add(HomeCartButtonNavigateEvent());
                      },
                      icon: Icon(
                        Icons.shopping_basket,
                        color: Colors.white,
                      ))
                ],
              ),
              body: ListView.builder(
                  itemCount: successState.products.length,
                  itemBuilder: (context, index) {
                    return ProductTileWidget(
                      productDataModel: successState.products[index],
                      homeBlocBloc: homeBlocBloc,
                    );
                  }),
            );
          case HomeErrorState:
            return Scaffold(
              body: Center(
                child: Text('Error Here'),
              ),
            );
          default:
            return SizedBox();
        }
      },
    );
  }
}
