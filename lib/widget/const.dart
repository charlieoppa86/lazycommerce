import 'package:lazyclub/models/products_model.dart';

class Consts {
  static final List<String> offerImages = [
    'assets/logo.png',
    'assets/logo.png',
    'assets/logo.png',
  ];

  static List<String> authImagesPaths = [
    'assets/user7.jpg',
    'assets/user3.jpg',
    'assets/user5.jpg',
  ];

  static List<ProductModel> productsList = [
    ProductModel(
        id: '0',
        title: '딸기',
        imgUrl:
            'https://images.unsplash.com/photo-1601004890684-d8cbf643f5f2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=830&q=80',
        productCategoryName: '과일',
        price: 0.88,
        salePrice: 0.67,
        isOnSale: true,
        isPiece: false),
    ProductModel(
        id: '1',
        title: '바나나',
        imgUrl:
            'https://images.unsplash.com/photo-1601004890684-d8cbf643f5f2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=830&q=80',
        productCategoryName: '과일',
        price: 1.28,
        salePrice: 0.97,
        isOnSale: true,
        isPiece: false),
    ProductModel(
        id: '2',
        title: '복숭아',
        imgUrl:
            'https://images.unsplash.com/photo-1601004890684-d8cbf643f5f2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=830&q=80',
        productCategoryName: '과일',
        price: 2.18,
        salePrice: 1.67,
        isOnSale: false,
        isPiece: true),
    ProductModel(
        id: '3',
        title: '오이',
        imgUrl:
            'https://images.unsplash.com/photo-1601004890684-d8cbf643f5f2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=830&q=80',
        productCategoryName: '채소',
        price: 0.88,
        salePrice: 0.67,
        isOnSale: true,
        isPiece: false),
    ProductModel(
        id: '4',
        title: '수박',
        imgUrl:
            'https://images.unsplash.com/photo-1601004890684-d8cbf643f5f2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=830&q=80',
        productCategoryName: '과일',
        price: 1.98,
        salePrice: 1.67,
        isOnSale: false,
        isPiece: true),
    ProductModel(
        id: '5',
        title: '양파',
        imgUrl:
            'https://images.unsplash.com/photo-1601004890684-d8cbf643f5f2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=830&q=80',
        productCategoryName: '채소',
        price: 3.12,
        salePrice: 1.12,
        isOnSale: false,
        isPiece: true),
    ProductModel(
        id: '6',
        title: '양배추',
        imgUrl:
            'https://images.unsplash.com/photo-1601004890684-d8cbf643f5f2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=830&q=80',
        productCategoryName: '채소',
        price: 2.62,
        salePrice: 1.52,
        isOnSale: false,
        isPiece: true),
  ];
}
