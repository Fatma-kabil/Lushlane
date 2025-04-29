
import 'package:flutter/material.dart';

Widget buildProfileInfo(String label, String value, IconData icon) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text(
        label,
        style: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
          color: Colors.grey[600],
        ),
      ),
      SizedBox(height: 5.0),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          children: <Widget>[
            Icon(icon, color: Colors.grey[400]),
            SizedBox(width: 10.0),
            Text(
              value,
              style: TextStyle(fontSize: 18.0, color: Colors.grey[600]),
            ),
          ],
        ),
      ),
      Divider(indent: 15),
    ],
  );
}
