import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

class ProductLoad extends ProductEvent {
  final int id;

  const ProductLoad({
    @required this.id,
  });

  @override
  List<Object> get props => [id];

  @override
  String toString() => 'ProductLoad';
}
