import 'package:online_store/domain/models/product/product_model.dart';
import 'package:online_store/domain/repositories/repository_result.dart';

abstract class CatalogRepository {
  Future<RepositoryResult<List<ProductModel>>> getHits();

  Future<RepositoryResult<List<ProductModel>>> getNewProducts();
}
