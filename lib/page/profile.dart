import 'package:flutter/material.dart';  
import 'package:lovecoffee/helpers/user_info.dart';  

class ProfilePage extends StatelessWidget {  
  @override  
  Widget build(BuildContext context) {  
    return FutureBuilder<Map<String, String?>>(  
      future: _getUserInfo(),
      builder: (context, snapshot) {  
        if (snapshot.connectionState == ConnectionState.waiting) {  
          return Scaffold(  
            appBar: AppBar(  
              backgroundColor: Colors.green,  
              shape: RoundedRectangleBorder(  
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(10)),  
              ),  
              toolbarHeight: 150,  
            ),  
            body: Center(child: CircularProgressIndicator()),  
          );  
        } else if (snapshot.hasError) {  
          return Scaffold(  
            appBar: AppBar(  
              backgroundColor: Colors.green,  
              shape: RoundedRectangleBorder(  
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(10)),  
              ),  
              toolbarHeight: 150,  
            ),  
            body: Center(child: Text('Error loading user info')),  
          );  
        } else {  
          String userName = snapshot.data?['username'] ?? 'User';  
          String userEmail = snapshot.data?['email'] ?? 'Email not available';

          return Scaffold(  
            appBar: AppBar(  
              backgroundColor: Colors.green,  
              shape: RoundedRectangleBorder(  
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(10)),  
              ),  
              toolbarHeight: 150,  
            ),  
            body: Padding(  
              padding: const EdgeInsets.all(20.0),  
              child: Column(  
                crossAxisAlignment: CrossAxisAlignment.start,  
                children: [  
                  // Avatar  
                  Center(  
                    child: CircleAvatar(  
                      radius: 60.0,  
                      backgroundColor: Colors.green,  
                      child: Text(  
                        _getInitials(userName),  
                        style: TextStyle(  
                          fontSize: 40.0,  
                          color: Colors.white,  
                          fontWeight: FontWeight.bold,  
                        ),  
                      ),  
                    ),  
                  ),  
                  SizedBox(height: 20),  
                  Center(  
                    child: Text(  
                      userName,  
                      style: TextStyle(  
                        fontSize: 24.0,  
                        fontWeight: FontWeight.bold,  
                      ),  
                    ),  
                  ),  
                  SizedBox(height: 10),  

                  // Email User  
                  Center(  
                    child: Text(  
                      userEmail,  
                      style: TextStyle(  
                        fontSize: 16.0,  
                        color: Colors.grey,  
                      ),  
                    ),  
                  ),  
                  SizedBox(height: 40),  

                  // Pilihan Menu  
                  Center(  
                    child: ElevatedButton(  
                      onPressed: () {  
                        // Edit Profile  
                      },  
                      child: Text('Edit Profile'),  
                      style: ElevatedButton.styleFrom(  
                        padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 100.0),  
                        backgroundColor: Colors.green,  
                        shape: RoundedRectangleBorder(  
                          borderRadius: BorderRadius.circular(30.0),  
                        ),  
                      ),  
                    ),  
                  ),  
                  SizedBox(height: 20),  
                  Center(  
                    child: ElevatedButton(  
                      onPressed: () {  
                        // Settings  
                      },  
                      child: Text('Settings'),  
                      style: ElevatedButton.styleFrom(  
                        padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 120.0),  
                        backgroundColor: Colors.green,  
                        shape: RoundedRectangleBorder(  
                          borderRadius: BorderRadius.circular(30.0),  
                        ),  
                      ),  
                    ),  
                  ),  
                  SizedBox(height: 20),  
                  Center(  
                    child: ElevatedButton(  
                      onPressed: () async {  
                        // Hapus token untuk logout  
                        await UserInfo().clearUserData();  
                        
                        // Balik ke halaman login setelah logout  
                        Navigator.pushReplacementNamed(context, '/login');
                      },  
                      child: Text('Logout'),  
                      style: ElevatedButton.styleFrom(  
                        padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 120.0),  
                        backgroundColor: Colors.red,  
                        shape: RoundedRectangleBorder(  
                          borderRadius: BorderRadius.circular(30.0),  
                        ),  
                      ),  
                    ),  
                  ),  
                ],  
              ),  
            ),  
          );  
        }  
      },  
    );  
  }  

  // Fungsi untuk mengambil inisial dari nama pengguna  
  String _getInitials(String name) {  
    List<String> nameParts = name.split(' ');  
    String initials = '';  
    for (var part in nameParts) {  
      initials += part[0];  
    }  
    return initials.toUpperCase();  
  }  

  // Fungsi untuk mengambil username dan email dari SharedPreferences  
  Future<Map<String, String?>> _getUserInfo() async {  
    final userInfo = UserInfo();  
    String? username = await userInfo.getUsername();  
    String? email = await userInfo.getEmail();  
    return {  
      'username': username,  
      'email': email,  
    };  
  }  
}