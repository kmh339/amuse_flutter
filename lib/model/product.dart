import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product.g.dart';

@JsonSerializable(nullable: true, explicitToJson: true)
class Product extends Equatable {
  final int id;
  final String title;
  final String subtitle;
  final String description;
  final String basePrice;


  const Product({
    this.id,
    this.title,
    this.subtitle,
    this.description,
    this.basePrice,

  });

  factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);

  @override
  List<Object> get props => [id];

  @override
  String toString() => 'Product { id: $id }';
}
