import 'package:flutter/material.dart';  
import 'package:lovecoffee/services/favourite_service.dart';  

class FavouritePage extends StatefulWidget {  
  const FavouritePage({Key? key}) : super(key: key);  

  @override  
  _FavouritePageState createState() => _FavouritePageState();  
}  

class _FavouritePageState extends State<FavouritePage> {  
  final FavouriteService _favouriteService = FavouriteService();  
  List<dynamic> _favouriteItems = [];  
  bool _isLoading = true;  

  @override  
  void initState() {  
    super.initState();  
    _fetchFavourites();  
  }  

  Future<void> _fetchFavourites() async {  
    setState(() {  
      _isLoading = true;  
    });  

    try {  
      final favourites = await _favouriteService.getFavourites();  
      setState(() {  
        _favouriteItems = favourites;  
        _isLoading = false;  
      });  
    } catch (e) {  
      setState(() {  
        _isLoading = false;  
      });  
      ScaffoldMessenger.of(context).showSnackBar(  
        SnackBar(content: Text('Failed to load favourites: $e')),  
      );  
    }  
  }  

  void _removeFromFavourite(String itemId) async {  
    bool removed = await _favouriteService.removeFromFavourite(itemId);  
    if (removed) {  
      _fetchFavourites();  
    }  
  }  

  @override  
  Widget build(BuildContext context) {  
    return Scaffold(  
      appBar: AppBar(  
        title: Text('Favourites'),  
        centerTitle: true,  
      ),  
      body: _isLoading  
          ? Center(child: CircularProgressIndicator())  
          : _favouriteItems.isEmpty  
              ? Center(child: Text('No favourite items'))  
              : ListView.builder(  
                  itemCount: _favouriteItems.length,  
                  itemBuilder: (context, index) {  
                    final item = _favouriteItems[index];  
                    return Card(  
                      color: Colors.grey[200],  
                      elevation: 0,  
                      child: ListTile(  
                        leading: Container(  
                          width: 60,  
                          height: 60,  
                          decoration: BoxDecoration(  
                            borderRadius: BorderRadius.circular(10),  
                            image: DecorationImage(  
                              image: AssetImage(  
                                'assets/images/${item['itemname'].replaceAll(' ', '')}.jpg',  
                              ),  
                              fit: BoxFit.cover,  
                            ),  
                          ),  
                        ),  
                        title: Text(item['itemname']),  
                        subtitle: Text('Rp ${item['price']}'),  
                        trailing: IconButton(  
                          icon: Icon(Icons.delete, color: Colors.red),  
                          onPressed: () => _removeFromFavourite(item['id']),  
                        ),  
                      ),  
                    );  
                  },  
                ),  
    );  
  }  
} 