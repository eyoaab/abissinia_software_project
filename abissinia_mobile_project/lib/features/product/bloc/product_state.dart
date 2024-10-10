part of 'product_bloc.dart';

@immutable
sealed class ProductState {}

final class ProductInitial extends ProductState {}



final class ProductLoadingState extends ProductState{}
final class ProductUpdateLoadingState extends ProductState{}
final class ProductAddLoadingState extends ProductState{}
final class ProductDeletingState extends ProductState{}



 final class ProductErrorState extends ProductState{
      final String message;
      ProductErrorState({required this.message});
  }
  
final class UpdateProductState extends ProductState{
     final ProductModel productModel;
     UpdateProductState({required this.productModel});

  }

  final class DeleteProductState extends ProductState{
     final ProductModel productModel;
     DeleteProductState({required this.productModel});

  }

  final class AddProductState extends ProductState{
    final ProductModel productModel;
    AddProductState({required this.productModel});
  }

  final class ProductLoadedState extends ProductState{
    final List<ProductEntity> loadedProducts;
    ProductLoadedState({required this.loadedProducts});

  }