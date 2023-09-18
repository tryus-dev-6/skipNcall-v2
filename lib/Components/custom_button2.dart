import 'package:flutter/material.dart';

class CustomButton2 extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const CustomButton2({
    super.key,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xfff1504c),
                    Color(0xfff9a31b)
                  ], // Define your gradient colors
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Row(
                children: [
                  Icon(
                    icon,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
