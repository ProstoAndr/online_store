import 'package:online_store/domain/models/product/product_model.dart';
import 'package:online_store/domain/repositories/repository_result.dart';

abstract class ProductRepository {
  Future<RepositoryResult<ProductModel>> getProduct(int id);
}
