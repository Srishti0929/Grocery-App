import 'package:firebase_project/features/wishlist/bloc/wishlist_bloc_bloc.dart';
import 'package:firebase_project/features/wishlist/ui/wishlist_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Wishlist extends StatefulWidget {
  const Wishlist({super.key});

  @override
  State<Wishlist> createState() => _WishlistState();
}

class _WishlistState extends State<Wishlist> {
  final WishlistBlocBloc wishlistBlocBloc = WishlistBlocBloc();

  @override
  void initState() {
    wishlistBlocBloc.add(WishlistInitialEvent());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wishlist Items'),
      ),
      body: BlocConsumer<WishlistBlocBloc, WishlistBlocState>(
        bloc: wishlistBlocBloc,
        listenWhen: (previous, current) => current is WishlistBlocActionState,
        buildWhen: (previous, current) => current is !WishlistBlocActionState,
        listener: (context, state) {
          if(state is WishlistRemovedActionState){
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Your item is removed from wishlist')));
          }
        },
       builder: (context, state) {
          switch (state.runtimeType) {
            case WishlistSuccessState:
              final successState = state as WishlistSuccessState;
              return ListView.builder(
                  itemCount: successState.wishlistItems.length,
                  itemBuilder: (context, index) {
                    return WishlistTileWidget(
                      wishlistBlocBloc: wishlistBlocBloc,
                      productDataModel: successState.wishlistItems[index],
                    );
                  });

            default:
              return SizedBox();
          }
        },
      ),
    );
  }
}
