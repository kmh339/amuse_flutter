import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

class ProductLoad extends ProductEvent {


  @override
  List<Object> get props => [];

  @override
  String toString() => 'ProductLoad';
}
