import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:online_store/domain/models/product/product_model.dart';

part 'catalog_state.freezed.dart';

@freezed
class CatalogState with _$CatalogState {
  const factory CatalogState.initial() = Initial;
  const factory CatalogState.loading() = Loading;
  const factory CatalogState.loaded({
    required List<ProductModel> newProducts,
    required List<ProductModel> hits,
  }) = Loaded;
  const factory CatalogState.error({required String errorMessage}) = Error;
}