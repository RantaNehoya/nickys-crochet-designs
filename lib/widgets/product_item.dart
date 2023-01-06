import 'package:flutter/material.dart';
import 'package:nickys_designs/utilities/palette.dart';
import 'package:nickys_designs/presentation/screens/product_detail.dart';
import 'package:nickys_designs/presentation/resources/value_manager.dart';
import 'package:nickys_designs/presentation/resources/font_manager.dart';
import 'package:nickys_designs/presentation/resources/asset_manager.dart';

class ProductItem extends StatelessWidget {
  final String name;
  final dynamic image;
  final bool isOutOfStock;

  const ProductItem(
      {Key key,
      @required this.name,
      @required this.image,
      @required this.isOutOfStock})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: SizeManager.s_5,
        vertical: SizeManager.s_10,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(
          RadiusManager.r_5,
        ),
        child: GridTile(
          footer: GridTileBar(
            title: Text(
              name,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeightManager.bold,
                fontSize: FontSizeManager.f_16,
              ),
            ),
            backgroundColor: ColorPalette.colorPalette.shade200,
          ),
          child: GestureDetector(
            onTap: () {
              isOutOfStock
                  ? null
                  : Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: ((context) =>
                            ProductDetailScreen(name: name, image: image)),
                      ),
                    );
            },
            child: (image == '')
                ? Image.asset(
                    AssetManager.logo,
                    fit: BoxFit.cover,
                  )
                : Image.memory(
                    image.bytes,
                    fit: BoxFit.cover,
                    width: size.width * SizeManager.s0_4,
                  ),
          ),
        ),
      ),
    );
  }
}
