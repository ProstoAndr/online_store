import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:online_store/data/dto/product/product_dto.dart';

part 'product_model.freezed.dart';

@freezed
class ProductModel with _$ProductModel {
  const factory ProductModel({
    @Default(-1) int id,
    required String title,
    required String category,
    required double price,
    @Default([]) List<String> images,
    @Default(0.0) double rating,
    required String description,
  }) = _ProductModel;

  factory ProductModel.fromDto(ProductDto dto) => ProductModel(
    id: dto.id,
    title: dto.title,
    category: dto.category,
    price: dto.price,
    images: dto.images,
    rating: dto.rating,
    description: dto.description
  );
}