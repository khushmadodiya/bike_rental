import 'package:bike_rental/globle.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
class BookedDetail extends StatefulWidget {
  const BookedDetail({super.key});

  @override
  State<BookedDetail> createState() => _BookedDetailState();
}

class _BookedDetailState extends State<BookedDetail> {


// Reference to your Firebase Database
  final DatabaseReference _userRef = FirebaseDatabase.instance.ref('user').child(adminuid!);


// Function to fetch user details
  Future<Map<String, dynamic>> fetchUserDetails(String userId) async {
    DataSnapshot snapshot = (await _userRef.once()) as DataSnapshot;
    Map<dynamic, dynamic> data = snapshot.value as Map<dynamic, dynamic>? ?? {};

    if (data.isNotEmpty) {
      return Map<String, dynamic>.from(data);
    } else {
      throw Exception('Failed to fetch user details');
    }
  }

  @override
  Widget build(BuildContext context ) {
    return FutureBuilder<Map<String, dynamic>>(
      future: fetchUserDetails('userId1'), // Provide the user ID
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // Show loading indicator while fetching data
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          if (snapshot.hasData) {
            Map<String, dynamic>? userData = snapshot.data;

            // Create a Container to display the user details
            return Container(
              child: Column(
                children: [
                  Text('Name: ${userData ?['name']}'),
                  Text('Email: ${userData?['email']}'),
                  // Add more widgets to display other details
                ],
              ),
            );
          } else {
            return Text('No data available');
          }
        }
      },
    );
  }
}
