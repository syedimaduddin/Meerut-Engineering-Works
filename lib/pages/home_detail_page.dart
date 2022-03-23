import 'package:first_flutter_app/models/catalog.dart';
import 'package:first_flutter_app/widgets/home_widgets/add_to_cart.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class HomeDetailPage extends StatelessWidget {
  final Item catalog;

  const HomeDetailPage({Key? key, required this.catalog})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: context.canvasColor,
      
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Hero(
              tag: Key(catalog.id.toString()),
              child: Image.network(catalog.image),
            ).h32(context),
            Expanded(
              child: VxArc(
                height: 30,
                arcType: VxArcType.CONVEY,
                edge: VxEdge.TOP,
                child: Container(
                  width: context.screenWidth,
                  color: context.cardColor,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        catalog.name.text.center.xl4
                            .color(context.accentColor)
                            .make().px(8),
                        catalog.desc.text.xl.color(Vx.gray400).make().px(8),
                        10.heightBox,
                        "Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem vLorem vLoremLorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem vLorem vLorem Loremv LoremLorem LoremLoremLoremLoremLoremLoremLoremLorem Lorem".text.sm.color(Vx.gray400).make().p16(),
                      ],
                    ).py64(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),

      bottomNavigationBar: Container(
        color: context.cardColor,
        child: ButtonBar(
          alignment: MainAxisAlignment.spaceBetween,
          buttonPadding: EdgeInsets.zero,
          children: [
            "₹${catalog.price}".text.xl4.red500.make(),
            AddToCart(catalog: catalog,).wh(130, 50),
          ],
        ).p32(),
      ),
    );
  }
}
