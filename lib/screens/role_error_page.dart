import 'package:flutter/material.dart';

class RoleError extends StatelessWidget {
  const RoleError({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Error'),
      ),
      body: Center(
        child: Text('User has unauthrized role.'),
      ),
    );
  }
}
