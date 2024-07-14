import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:online_store/data/dto/product/product_dto.dart';
import 'package:online_store/data/requests/base_request.dart';

class GetHitsRequest extends BaseRequest<List<ProductDto>> {
  GetHitsRequest() : super("https://fakestoreapi.com/products");

  @override
  FutureOr<List<ProductDto>> processResponse(Map<String, dynamic> data) {
    return compute(
          (Map<String, dynamic> data) {
        final List<dynamic> list = data['data'] as List<dynamic>;
        return list.map((e) => ProductDto.fromJson(e as Map<String, dynamic>)).toList();
      },
      data,
    );
  }
}