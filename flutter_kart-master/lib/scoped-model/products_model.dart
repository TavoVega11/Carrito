import 'package:scoped_model/scoped_model.dart';
import 'package:flutter_kart/model/Product.dart';
import 'package:flutter_kart/model/hotel.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class ProductsModel extends Model {
  List<Hotel> _hotelList = [];
  List<Product> _products = [];
  List<Product> _cartList = [];
  final baseUrl = 'http://api.flutterapp.in/api/';

  ProductsModel() {
    _products.add(Product(
      'NI UNA DIETA MÁS',
      'proteína whey isolate (delicioso chocolate) 0 carbohidratos, 0 Lactosa',
      300,
      'https://images-na.ssl-images-amazon.com/images/I/71kfuJvWmJL._SL1500_.jpg',
    ));

    _products.add(Product(
      'Optimum Nutrition',
      'Whey Gold Standard, Fresa 2 lb',
      200,
      'https://images-na.ssl-images-amazon.com/images/I/71Z3sns2bpL._SL1500_.jpg',
    ));

    _products.add(Product(
      'Parrot Greens & Protein Birdman',
      'Súper Alimento Verde y Proteína (Vegano) en Polvo Certificado Kosher Sabor Berry-Vainilla',
      500,
      'https://images-na.ssl-images-amazon.com/images/I/61xX2z0jyrL._SL1080_.jpg',
    ));

    _products.add(Product(
      'MDN Wheyner',
      'Isolate Chocolate 3lbs',
      120,
      'https://images-na.ssl-images-amazon.com/images/I/919B-M6AScL._SL1500_.jpg',
    ));

    _products.add(Product(
      'EGG PROTEIN:',
      'Ovoalbúmina clara de huevo 1,750gr (VAINILLA FRANCESA)',
      450,
      'https://images-na.ssl-images-amazon.com/images/I/711-PKbl9uL._SL1500_.jpg',
    ));

    _hotelList.add(Hotel(
        'Amazon',
        'http://pngtransparent.com/images/amazon-logo-png-948x537_abf78dd4.png',
        'USA',
        '2-5 dias',
        4.8,
        500));

    _hotelList.add(Hotel(
        'Mercado Libre',
        'http://www.silvioraij.com/wp-content/uploads/2015/02/MercadoLibre-Logo-1.jpg',
        'Mexico',
        '3-5 dias',
        4.3,
        500));
  }

  List<Product> get products {
    return List.from(_products);
  }

  List<Product> get getCartList {
    return List.from(_cartList);
  }

  List<Hotel> get getHotelList {
    return List.from(_hotelList);
  }

  double get getCartPrice {
    double price = 0;
    getCartList.forEach((Product pro) {
      price += pro.price;
    });
    return price;
  }

  void addProduct(Product product) {
    final Map<String, dynamic> productMap = {
      'title': product.title,
      'description': product.description,
      'price': product.price,
      'image':
          'https://www.dinneratthezoo.com/wp-content/uploads/2016/10/veggie-fried-rice-6-500x500.jpg',
    };

    http.post(
      baseUrl + 'products',
      body: json.encode(productMap),
      headers: {
        'Content-Type': 'application/json',
      },
    ).then(
      (response) {
        print("Response status: ${response.statusCode}");
        print("Response body: ${response.body}");
      },
    );
    _products.add(product);
    notifyListeners();
  }

 getProductList() async {
  final data = await  http
        .get(
      baseUrl + 'products',
    )
        .then(
      (response) {
       
      },
    );
    
  }

  void addToCart(Product product) {
    _cartList.add(product);
    notifyListeners();
  }
}
