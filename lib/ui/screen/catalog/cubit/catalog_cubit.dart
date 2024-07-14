import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_store/domain/models/product/product_model.dart';
import 'package:online_store/domain/repositories/catalog_repository.dart';
import 'package:online_store/domain/repositories/repository_result.dart';
import 'package:online_store/ui/screen/catalog/cubit/catalog_state.dart';

class CatalogCubit extends Cubit<CatalogState> {
  final CatalogRepository repository;

  CatalogCubit(this.repository) : super(const CatalogState.initial());

  Future pageOpened() async {
    try {
      emit(const CatalogState.loading());
      final resultHits = await repository.getHits();
      final List<ProductModel> hits = _handleHitsResult(resultHits);

      final resultNewProducts = await repository.getNewProducts();
      final List<ProductModel> newProducts = _handleNewProductsResult(resultNewProducts);

      emit(CatalogState.loaded(hits: hits, newProducts: newProducts));
    } catch (e) {
      emit(CatalogState.error(errorMessage:'Failed to load data: $e'));
    }
  }

  List<ProductModel> _handleHitsResult(RepositoryResult<List<ProductModel>> result) {
    if (result is RepositoryResultSuccess<List<ProductModel>>) {
      return result.data;
    } else if (result is RepositoryResultFailure<List<ProductModel>>) {
      throw Exception('Failed to fetch hits: ${result.errorCode}');
    } else {
      throw Exception('Unexpected result type');
    }
  }

  List<ProductModel> _handleNewProductsResult(RepositoryResult<List<ProductModel>> result) {
    if (result is RepositoryResultSuccess<List<ProductModel>>) {
      return result.data;
    } else if (result is RepositoryResultFailure<List<ProductModel>>) {
      throw Exception('Failed to fetch new products: ${result.errorCode}');
    } else {
      throw Exception('Unexpected result type');
    }
  }
}
