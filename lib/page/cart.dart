// lib/pages/cart_page.dart  
import 'package:flutter/material.dart';  
import 'package:lovecoffee/model/item_model.dart';  
import 'package:lovecoffee/services/cart_service.dart';  
import 'package:lovecoffee/widgets/cart_tile.dart';  

class CartPage extends StatefulWidget {  
  const CartPage({Key? key}) : super(key: key);  

  @override  
  _CartPageState createState() => _CartPageState();  
}  

class _CartPageState extends State<CartPage> {  
  final CartService _cartService = CartService();  
  List<CartItem> _cartItems = [];  
  bool _isLoading = true;  
  String _errorMessage = '';  

  @override  
  void initState() {  
    super.initState();  
    _fetchCartItems();  
  }  

  Future<void> _fetchCartItems() async {  
    setState(() {  
      _isLoading = true;  
      _errorMessage = '';  
    });  

    try {  
      final items = await _cartService.getCartItems();  
      setState(() {  
        _cartItems = items;  
        _isLoading = false;  
      });  
    } catch (e) {  
      setState(() {  
        _errorMessage = e.toString();  
        _isLoading = false;  
      });  
    }  
  }  

  double _calculateTotal() {  
    return _cartItems.fold(  
      0.0,   
      (total, item) => total + (item.price * item.quantity)  
    );  
  }  

  void _removeItem(CartItem item) async {  
    try {  
      bool removed = await _cartService.removeFromCart(item.id.toString());  
      if (removed) {  
        setState(() {  
          _cartItems.remove(item);  
        });  
      }  
    } catch (e) {  
      ScaffoldMessenger.of(context).showSnackBar(  
        SnackBar(content: Text('Gagal hapus item: $e')),  
      );  
    }  
  }  

  void _updateItemQuantity(CartItem updatedItem) {  
    setState(() {  
      int index = _cartItems.indexWhere((item) => item.id == updatedItem.id);  
      if (index != -1) {  
        _cartItems[index] = updatedItem;  
      }  
    });  
  }  

  @override  
  Widget build(BuildContext context) {  
    return Scaffold(  
      appBar: AppBar(  
        title: Text('Your Cart'),  
        centerTitle: true,  
      ),  
      body: RefreshIndicator(  
        onRefresh: _fetchCartItems,  
        child: _isLoading  
          ? Center(child: CircularProgressIndicator())  
          : _errorMessage.isNotEmpty  
            ? Center(child: Text(_errorMessage))  
            : _cartItems.isEmpty  
              ? ListView(  
                  physics: AlwaysScrollableScrollPhysics(),
                  children: [  
                    Center(child: Text('Keranjang kosong')),  
                  ],  
                )  
              : Column(  
                  children: [  
                    Expanded(  
                      child: ListView.builder(  
                        physics: AlwaysScrollableScrollPhysics(),
                        itemCount: _cartItems.length,  
                        itemBuilder: (context, index) {  
                          return CartTile(  
                            cartItem: _cartItems[index],  
                            onRemove: () => _removeItem(_cartItems[index]),  
                            onUpdate: _updateItemQuantity,  
                          );  
                        },  
                      ),  
                    ),  
                    Padding(  
                      padding: const EdgeInsets.all(16.0),  
                      child: Row(  
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,  
                        children: [  
                          Text(  
                            'Total',  
                            style: TextStyle(  
                              fontSize: 18,  
                              fontWeight: FontWeight.bold,  
                            ),  
                          ),  
                          Text(  
                            'Rp ${_calculateTotal().toStringAsFixed(3)}',  
                            style: TextStyle(  
                              fontSize: 18,  
                              fontWeight: FontWeight.bold,  
                              color: Colors.green,  
                            ),  
                          ),  
                        ],  
                      ),  
                    ),  
                    Padding(  
                      padding: const EdgeInsets.all(16.0),  
                      child: ElevatedButton(  
                        onPressed: _cartItems.isEmpty ? null : () {  
                          // Logika checkout  
                        },  
                        child: Text('Checkout'),  
                        style: ElevatedButton.styleFrom(  
                          minimumSize: Size(double.infinity, 50),  
                        ),  
                      ),  
                    ),  
                  ],  
                ),  
      ),  
    );  
  }  
}