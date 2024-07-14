import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_store/data/repositories/catalog_repository_impl.dart';
import 'package:online_store/data/repositories/product_repository_impl.dart';
import 'package:online_store/data/requests/api_client.dart';
import 'package:online_store/domain/repositories/catalog_repository.dart';
import 'package:online_store/domain/repositories/product_repository.dart';
import 'package:online_store/routes/route_config.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<CatalogRepository>(
          create: (context) => CatalogRepositoryImpl(ApiClient('')),
        ),
        RepositoryProvider<ProductRepository>(
          create: (context) => ProductRepositoryImpl(ApiClient('')),
        ),
      ],
      child: MaterialApp.router(
        title: 'Онлайн магазин',
        debugShowCheckedModeBanner: false,
        routerConfig: RouteConfig.returnRouter(),
      ),
    );
  }
}
