import 'package:meta/meta.dart';
import 'package:amuse_flutter/model/models.dart';

@immutable
class ProductState {
  final bool isLoaded;
  final bool isLoading;
  final List<Product> product;

  ProductState({
    @required this.isLoaded,
    @required this.isLoading,
    @required this.product,
  });

  factory ProductState.empty() {
    return ProductState(
      isLoaded: false,
      isLoading: false,
      product: null,
    );
  }

  factory ProductState.failure() {
    return ProductState(
      isLoaded: false,
      isLoading: false,
      product: null,
    );
  }

  factory ProductState.success({List<Product> product}) {
    return ProductState(
      isLoaded: true,
      isLoading: false,
      product: product,
    );
  }

}
