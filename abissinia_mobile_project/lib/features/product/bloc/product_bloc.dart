import 'dart:developer';

import 'package:abissinia_mobile_project/features/product/product-entity.dart';
import 'package:abissinia_mobile_project/features/product/product-servicies.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductServices productService = ProductServices();

ProductBloc() : super(ProductInitial()) {
     on<LoadAllProductEvent>((event, emit) async {
      emit(ProductLoadingState()); 
      try {
        final List<ProductEntity> Products = await productService.getAllProducts(); 
         for (final product in Products) {
      log('Product: ${product.toString()}');
    }
        emit(ProductLoadedState(loadedProducts: Products));
      } catch (error) {
        emit(ProductErrorState(message: 'Failed to load Products: $error'));
      }
    });

     on<UpdateProductEvent>((event, emit) async {
      emit(ProductUpdateLoadingState()); 
      try {
        final ProductModel productModel = await productService.updateProduct(event.productEntity);
        emit(UpdateProductState (productModel: productModel));
       
      } catch (error) {
        emit(ProductErrorState(message: 'Failed to update Products: $error'));
      }
    });

     on<DeleteProductEvent>((event, emit) async {
      emit(ProductLoadingState()); 
      try {
        final ProductModel productModel = await productService.deleteProduct(event.id);
        emit(DeleteProductState(productModel: productModel));
       
      } catch (error) {
        emit(ProductErrorState(message: 'Failed to Delete Product: $error'));
      }
    });
      on<AddProductEvent>((event, emit) async {
      emit(ProductAddLoadingState()); 
      try {
        final ProductModel productModel = await productService.addproducts(event.productEntity);
        emit(AddProductState(productModel: productModel));
        log('adding response');
        log(productModel.responseMessage);
        
       
      } catch (error) {
        emit(ProductErrorState(message: 'Failed to add Product: $error'));
      }
    });
}
}