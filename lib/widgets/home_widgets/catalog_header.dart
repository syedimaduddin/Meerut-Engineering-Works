import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class CatalogHeader extends StatelessWidget {
  const CatalogHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        "Hans Engineering Works".text.xl2.bold.color(context.theme.accentColor).make(),
        "Quality Products".text.lg.make(),
      ],
    );
  }
}