import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_store/domain/models/product/product_model.dart';
import 'package:online_store/domain/repositories/product_repository.dart';
import 'package:online_store/domain/repositories/repository_result.dart';
import 'package:online_store/ui/screen/product/bloc/product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final ProductRepository repository;
  final int id;

  ProductCubit(this.repository, this.id) : super(const ProductState.initial());

  Future pageOpened() async {
    try {
      emit(const ProductState.loading());
      final resultProduct = await repository.getProduct(id);
      final ProductModel product = _handleProductResult(resultProduct);

      emit(ProductState.loaded(product: product));
    } catch (e) {
      emit(ProductState.error(errorMessage:'Failed to load data: $e'));
    }
  }

  ProductModel _handleProductResult(RepositoryResult<ProductModel> result) {
    if (result is RepositoryResultSuccess<ProductModel>) {
      return result.data;
    } else if (result is RepositoryResultFailure<ProductModel>) {
      throw Exception('Failed to fetch hits: ${result.errorCode}');
    } else {
      throw Exception('Unexpected result type');
    }
  }
}