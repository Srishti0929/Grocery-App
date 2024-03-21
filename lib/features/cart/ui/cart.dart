import 'package:firebase_project/features/cart/bloc/cart_bloc_bloc.dart';
import 'package:firebase_project/features/cart/ui/cart_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  final CartBlocBloc cartBlocBloc = CartBlocBloc();

  @override
  void initState() {
    cartBlocBloc.add(CartInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart Items'),
      ),
      body: BlocConsumer<CartBlocBloc, CartBlocState>(
        bloc: cartBlocBloc,
        listenWhen: (previous, current) => current is CartBlocActionState,
        buildWhen: (previous, current) => current is! CartBlocActionState,
        listener: (context, state) {
          if (state is CartRemovedActionState) {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Your item is removed from cart')));
          }
        },
        builder: (context, state) {
          switch (state.runtimeType) {
            case CartSuccessState:
              final successState = state as CartSuccessState;
              return ListView.builder(
                  itemCount: successState.cartItems.length,
                  itemBuilder: (context, index) {
                    return CartTileWidget(
                      cartBlocBloc: cartBlocBloc,
                      productDataModel: successState.cartItems[index],
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
