import 'dart:async';
import 'package:amuse_flutter/models/models.dart';
import 'package:amuse_flutter/blocs/product_bloc/bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:rxdart/rxdart.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final _userRepository = UserRepository();


  @override
  ProductState get initialState => ProductState.empty();

  @override
  Stream<ProductState> transformEvents(
      Stream<ProductEvent> events,
      Stream<ProductState> Function(ProductEvent event) next,
      ) {
    return super.transformEvents(
      events.debounceTime(
        Duration(milliseconds: 500),
      ),
      next,
    );
  }

  @override
  Stream<ProductState> mapEventToState(ProductEvent event) async* {
    if (event is ProductLoad) {
      yield* _mapProductLoadToState();
    }
  }

  Stream<ProductState> _mapProductLoadToState() async* {
    try {
      print("]-----] _mapProductLoadToState try [-----[");

      final response = await _userRepository.get('/api/products');

      if(response != null) {
        final contents = response['data'] as List;
        final List<Product> product = contents.map((data){
          return Product.fromJson(data);
        }).toList();

        print("]-----] Product : $product");
        yield ProductState.success(product: product);

      }
    } catch (error) {
      print("]-----] _mapProductLoadToState fail [-----[");
      yield ProductState.failure();
    }
  }

}
