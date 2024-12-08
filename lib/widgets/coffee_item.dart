import 'package:flutter/material.dart';  
import 'package:lovecoffee/widgets/coffee_detail_page.dart';   

class CoffeeItem extends StatelessWidget {  
  final String name;  
  final String imagePath;  
  final String category;   

  const CoffeeItem({  
    Key? key,  
    required this.name,  
    required this.imagePath,  
    required this.category,   
  }) : super(key: key);  

  // Tentukan harga berdasarkan nama item  
  double _getPrice() {  
    switch (name) {  
      case 'Matcha Latte':  
        return 18.000;  
      case 'Iced Salted Caramel Latte':  
        return 22.500;  
      case 'Chai Latte':  
        return 15.000;  
      case 'Oat Milk Latte':  
        return 20.000;  
      case 'Peppermint Tea':  
        return 12.000;  
      case 'Fruit Tea':  
        return 10.000;  
      case 'Floral Tea':  
        return 15.000;  
      case 'Ginger Tea':  
        return 10.000;  
      case 'French Fries':  
        return 18.000;  
      case 'Waffle Ice Cream':  
        return 20.500;  
      case 'French Toast':  
        return 18.000;  
      case 'Croffle':  
        return 12.000;  
      default:  
        return 10.000;  
    }  
  }  

  // Format angka dengan pemisah titik  
  String _formatNumber(double number) {  
    return number.toStringAsFixed(3).replaceAllMapped(  
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),   
      (Match m) => '${m[1]}.'  
    );  
  }  

  @override  
  Widget build(BuildContext context) {  
    return GestureDetector(  
      onTap: () {  
        Navigator.push(  
          context,  
          MaterialPageRoute(  
            builder: (context) => CoffeeDetailPage(  
              name: name,  
              imagePath: imagePath,  
              category: category,  
            ),  
          ),  
        );  
      },  
      child: Card(  
        elevation: 2.0,  
        shape: RoundedRectangleBorder(  
          borderRadius: BorderRadius.circular(20.0),  
        ),  
        child: Column(  
          crossAxisAlignment: CrossAxisAlignment.start,  
          children: [  
            Expanded(  
              child: ClipRRect(  
                borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),  
                child: Image.asset(  
                  imagePath,  
                  fit: BoxFit.cover,  
                  width: double.infinity,  
                ),  
              ),  
            ),  
            Padding(  
              padding: const EdgeInsets.all(8.0),  
              child: Column(  
                crossAxisAlignment: CrossAxisAlignment.start,  
                children: [  
                  Text(  
                    name,  
                    style: TextStyle(  
                      fontSize: 16.0,  
                      fontWeight: FontWeight.bold,  
                    ),  
                    maxLines: 1,  
                    overflow: TextOverflow.ellipsis,  
                  ),  
                  SizedBox(height: 5),  
                  Row(  
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,  
                    children: [  
                      Text(  
                        'Rp${_formatNumber(_getPrice())}',   
                        style: TextStyle(  
                          color: Colors.green,  
                          fontWeight: FontWeight.bold,  
                        ),  
                      ),  
                      Container(  
                        decoration: BoxDecoration(  
                          color: Colors.green,  
                          borderRadius: BorderRadius.circular(20.0),  
                        ),  
                        child: Icon(  
                          Icons.add,  
                          color: Colors.white,  
                          size: 20.0,  
                        ),  
                      ),  
                    ],  
                  ),  
                ],  
              ),  
            ),  
          ],  
        ),  
      ),  
    );  
  }  
}