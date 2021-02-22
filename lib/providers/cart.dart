import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gerencimento_estado/providers/product.dart';

class CartItem {
  final String id;
  final String productId;
  final String title;
  final int quantity;
  final double price;

  CartItem({
    @required this.id,
    @required this.price,
    @required this.productId,
    @required this.quantity,
    @required this.title,
  });
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemsCount {
    return _items.length;
  }

  double get totalAmount {
    double total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

  void addItem(Product product) {
    //caso ja existe vai aumentar a quantidade
    if (_items.containsKey(product.id)) {
      _items.update(product.id, (existingItem) {
        return CartItem(
          id: existingItem.id,
          productId: product.id,
          price: existingItem.price,
          quantity: existingItem.quantity + 1,
          title: existingItem.title,
        );
      });
    } else {
      //caso nao existe vai adicionar um novo
      _items.putIfAbsent(
        product.id,
        () => CartItem(
          id: Random().nextDouble().toString(),
          price: product.price,
          productId: product.id,
          quantity: 1,
          title: product.title,
        ),
      );
    }
    notifyListeners();
  }

  void removeSingleItem(String productId) {
    //se nao tem nao faz nada
    if (!_items.containsKey(productId)) {
      return;
    }
    // se a quantidade for 1 remover
    if (items[productId].quantity == 1) {
      _items.remove(productId);
    } else {
      _items.update(productId, (existingItem) {
        return CartItem(
          id: existingItem.id,
          productId: productId,
          price: existingItem.price,
          quantity: existingItem.quantity - 1,
          title: existingItem.title,
        );
      });
    }

    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }
}
