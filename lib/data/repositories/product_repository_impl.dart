import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:online_store/data/dto/product/product_dto.dart';
import 'package:online_store/data/repositories/base_repository.dart';
import 'package:online_store/domain/models/product/product_model.dart';
import 'package:online_store/domain/repositories/product_repository.dart';
import 'package:online_store/domain/repositories/repository_result.dart';

class ProductRepositoryImpl extends BaseRepository implements ProductRepository {
  ProductRepositoryImpl(super.apiClient);

  @override
  Future<RepositoryResult<ProductModel>> getProduct(int id) async {
    final jsonString = await rootBundle.loadString('assets/hits.json');

    final List<dynamic> jsonList = json.decode(jsonString) as List<dynamic>;
    final Map<String, dynamic>? productMap = jsonList.firstWhere(
          (element) => element['id'] == id,
      orElse: () => null,
    );
    final productDto = ProductDto.fromJson(productMap as Map<String, dynamic>);
    final ProductModel productModel = ProductModel.fromDto(productDto);
    return RepositoryResultSuccess(productModel);
  }

  /// Код при работе с реальным api
  // @override
  // Future<RepositoryResult<ProductModel>> getProduct(int id) =>
  //     GetProductRequest(id: id).execute(apiClient).then(
  //             (value) => RepositoryResult.fromApiResult(
  //               ProductModel.fromDto,
  //               value,
  //             ),
  //     );
}