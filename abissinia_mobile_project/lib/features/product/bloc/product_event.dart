part of 'product_bloc.dart';

@immutable
sealed class ProductEvent {}


class LoadAllProductEvent extends ProductEvent{}
class InitialProductEvent extends ProductEvent{}
class DeleteProductEvent extends ProductEvent{
  int id;
  DeleteProductEvent({required this.id});
}


class AddProductEvent extends ProductEvent{
  ProductSend productEntity;
  AddProductEvent({required this.productEntity});
}

class UpdateProductEvent extends ProductEvent{
  ProductSend productEntity;
  UpdateProductEvent({required this.productEntity});
}