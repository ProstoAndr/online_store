import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:online_store/domain/models/product/product_model.dart';

part 'product_state.freezed.dart';

@freezed
class ProductState with _$ProductState {
  const factory ProductState.initial() = Initial;
  const factory ProductState.loading() = Loading;
  const factory ProductState.loaded({
    required ProductModel product
  }) = Loaded;
  const factory ProductState.error({required String errorMessage}) = Error;
}