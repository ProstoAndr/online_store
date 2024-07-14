import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:online_store/routes/route_names.dart';
import 'package:online_store/ui/screen/catalog/catalog_screen.dart';
import 'package:online_store/ui/screen/product/product_screen.dart';

class RouteConfig {
  static GoRouter returnRouter() {
    return GoRouter(
      initialLocation: '/',
      routes: [
        GoRoute(
          path: '/',
          name: RouteNames.initial,
          pageBuilder: (context, state) {
            return const MaterialPage(child: CatalogScreenStl());
          },
        ),
        GoRoute(
          path: '/product/:id',
          name: RouteNames.product,
          pageBuilder: (context, state) {
            final productId = int.tryParse(state.pathParameters['id']!)!;
            return MaterialPage(child: ProductScreenStl(id: productId));
          },
        ),
      ],
    );
  }
}
