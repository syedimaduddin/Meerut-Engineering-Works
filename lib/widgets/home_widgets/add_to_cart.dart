import 'package:first_flutter_app/core/store.dart';
import 'package:first_flutter_app/models/cart.dart';
import 'package:first_flutter_app/models/catalog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class AddToCart extends StatelessWidget {
  final Item catalog;
  const AddToCart({Key? key, required this.catalog}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // VxState.listen(context, to: []);
    VxState.watch(context, on: [AddMutation, RemoveMutation]);
    final CartModel _cart = (VxState.store as MyStore).cart;
    // final CatalogModel _catalog = (VxState.store as MyStore).catalog;
    bool isInCart = _cart.items.contains(catalog) ? true : false;

    return ElevatedButton(
      onPressed: () {
        if (!isInCart) {
          // isInCart = isInCart.toggle();
          // final _catalog = CatalogModel();
          // _cart.catalog = _catalog;
          // _cart.add(catalog);
          AddMutation(catalog);
          // setState(() {});
        }
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(context.theme.buttonColor),
        shape: MaterialStateProperty.all(
          const StadiumBorder(),
        ),
      ),
      // child: isInCart ? Icon(Icons.done) : "Add to Cart".text.make(),
      child: isInCart ? const Icon(Icons.done) : const Icon(CupertinoIcons.cart_badge_plus),
    );
  }
}
