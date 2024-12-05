// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:carousel_slider/carousel_slider.dart';

// 🌎 Project imports:
import 'package:dvizh_mob/src/category/models/category_model.dart';
import 'package:dvizh_mob/src/category/widgets/category_card.dart';
import 'package:dvizh_mob/src/core/models/list_data/list_data_model.dart';
import 'package:dvizh_mob/src/shared/widgets/media_query_scope.dart';

class CarouselCategories extends StatefulWidget {
  const CarouselCategories({required this.categories, super.key});

  final ListDataModel<CategoryModel> categories;

  @override
  State<CarouselCategories> createState() => _CarouselCategoriesState();
}

class _CarouselCategoriesState extends State<CarouselCategories> {
  late CarouselSliderController _sliderController;
  final _optionsMedia = {
    MediaType.sm: _CarouselOption(
      aspectRatio: 3.5,
      viewportFraction: 0.33,
      countPage: 4,
    ),
    MediaType.md: _CarouselOption(
      aspectRatio: 5.5,
      viewportFraction: 0.2,
      countPage: 5,
    ),
    MediaType.lg: _CarouselOption(
      aspectRatio: 6.5,
      viewportFraction: 0.167,
      countPage: 6,
    )
  };

  @override
  void initState() {
    super.initState();
    _sliderController = CarouselSliderController();
  }

  @override
  Widget build(BuildContext context) {
    final option = _optionsMedia[MediaQueryScope.ofType(context)];
    return AspectRatio(
      aspectRatio: option!.aspectRatio,
      child: Stack(
        children: [
          CarouselSlider.builder(
            carouselController: _sliderController,
            itemCount: widget.categories.list.length,
            itemBuilder: (context, index, pageViewIndex) => CategoryCard(
              padding: const EdgeInsets.only(
                right: 16,
              ),
              selected: true,
              category: widget.categories.list[index],
              size: double.infinity,
            ),
            options: CarouselOptions(
              aspectRatio: option.aspectRatio,
              enableInfiniteScroll: false,
              viewportFraction: option.viewportFraction,
              disableCenter: true,
              padEnds: false,
            ),
          ),
        ],
      ),
    );
  }
}

class _CarouselOption {
  _CarouselOption({
    required this.aspectRatio,
    required this.viewportFraction,
    required this.countPage,
  });

  final double aspectRatio;
  final double viewportFraction;
  final int countPage;
}
