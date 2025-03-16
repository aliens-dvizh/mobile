// 🐦 Flutter imports:

// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 🌎 Project imports:
import 'package:dvizh_mob/src/category/models/category_model.dart';

// 📦 Package imports:

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    required this.selected,
    required this.category,
    super.key,
    this.size,
    this.padding,
  });

  final CategoryModel category;
  final bool selected;
  final double? size;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) => Padding(
        padding: padding ?? EdgeInsets.zero,
        child: LayoutBuilder(
            builder: (context, constraints) => GestureDetector(
                  onTap: () {},
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: selected ? Colors.black : Colors.grey,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: SizedBox(
                      width: size ?? constraints.maxHeight,
                      height: size ?? constraints.maxHeight,
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FittedBox(
                              child: Text(
                                category.name,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: selected ? Colors.black : Colors.grey,
                                ),
                                maxLines: 2,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )),
      );
}
