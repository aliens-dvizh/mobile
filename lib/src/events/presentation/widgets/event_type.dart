// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:auto_size_text/auto_size_text.dart';

// 🌎 Project imports:
import 'package:dvizh_mob/src/events/models/event_type_model.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    required this.selected,
    required this.category,
    super.key,
  });
  final CategoryModel category;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.width * 0.2;
    return GestureDetector(
      onTap: () {},
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(
            color: selected ? Colors.black : Colors.grey,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: SizedBox(
            width: size,
            height: size,
            child: Column(
              children: [
                Icon(
                  category.icon,
                  size: 35,
                  color: selected ? Colors.black : Colors.grey,
                ),
                const SizedBox(
                  height: 10,
                ),
                AutoSizeText(
                  category.name,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: selected ? Colors.black : Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
