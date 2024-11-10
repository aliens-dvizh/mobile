// 🐦 Flutter imports:
import 'package:flutter/cupertino.dart';

// 📦 Package imports:
import 'package:auto_route/auto_route.dart';
import 'package:depend/depend.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// 🌎 Project imports:
import 'package:dvizh_mob/main.dart';
import 'package:dvizh_mob/src/category/bloc/categories_bloc/categories_bloc.dart';
import 'package:dvizh_mob/src/category/data/category_data_source.dart';
import 'package:dvizh_mob/src/category/data/category_repository.dart';

@RoutePage()
class CoreWrappedScreen extends StatelessWidget implements AutoRouteWrapper {
  @override
  Widget build(BuildContext context) => const AutoRouter();

  @override
  Widget wrappedRoute(BuildContext context) => BlocProvider<CategoriesBloc>(
        create: (context) => CategoriesBloc(
          CategoryRepository(
            CategoryDataSource(
                Dependencies.of<RootLibrary>(context).dioService),
          ),
        ),
        child: this,
      );
}
