import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:online_store/data/dto/product/product_dto.dart';
import 'package:online_store/data/requests/base_request.dart';

class GetProductRequest extends BaseRequest<ProductDto> {
  GetProductRequest({required int id}) : super("https://fakestoreapi.com/products/$id");

  @override
  FutureOr<ProductDto> processResponse(Map<String, dynamic> data) {
    return compute(ProductDto.fromJson, data['data'] as Map<String, dynamic>);
  }
}