import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:online_store/data/dto/product/product_dto.dart';
import 'package:online_store/data/repositories/base_repository.dart';
import 'package:online_store/domain/models/product/product_model.dart';
import 'package:online_store/domain/repositories/catalog_repository.dart';
import 'package:online_store/domain/repositories/repository_result.dart';

class CatalogRepositoryImpl extends BaseRepository implements CatalogRepository {
  CatalogRepositoryImpl(super.apiClient);

  @override
  Future<RepositoryResult<List<ProductModel>>> getHits() async {
    final jsonString = await rootBundle.loadString('assets/hits.json');

    final List<dynamic> jsonList = json.decode(jsonString) as List<dynamic>;
    final List<ProductDto> productDto = jsonList
        .map((json) => ProductDto.fromJson(json as Map<String, dynamic>))
        .toList();
    final List<ProductModel> productModels = productDto.map((dto) => ProductModel.fromDto(dto)).toList();
    return RepositoryResultSuccess(productModels);
  }

  @override
  Future<RepositoryResult<List<ProductModel>>> getNewProducts() async {
    final jsonString = await rootBundle.loadString('assets/new_products.json');

    final List<dynamic> jsonList = json.decode(jsonString) as List<dynamic>;
    final List<ProductDto> productDto = jsonList
        .map((json) => ProductDto.fromJson(json as Map<String, dynamic>))
        .toList();
    final List<ProductModel> productModels = productDto.map((dto) => ProductModel.fromDto(dto)).toList();
    return RepositoryResultSuccess(productModels);
  }
  /// Код при работе с реальным api
  // @override
  // Future<RepositoryResult<List<ProductModel>>> getHits() =>
  //     GetHitsRequest().execute(apiClient).then(
  //           (value) => RepositoryResult.fromApiResult(
  //             (data) => data.map(ProductModel.fromDto).toList(),
  //             value,
  //           ),
  //         );
  //
  // @override
  // Future<RepositoryResult<List<ProductModel>>> getNewProducts() =>
  //     GetNewProductsRequest().execute(apiClient).then(
  //           (value) => RepositoryResult.fromApiResult(
  //             (data) => data.map(ProductModel.fromDto).toList(),
  //         value,
  //       ),
  //     );
}
