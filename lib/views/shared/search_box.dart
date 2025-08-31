import 'package:flutter/material.dart';

class SearchBox extends StatelessWidget {
  const SearchBox({
    super.key,
    required this.text,
    this.icon = Icons.search_outlined,
     this.showBackground = true,
     this.showBorder = true, this.onTap,
  });

  final String text;
  final IconData? icon;
  final bool showBackground, showBorder;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Container(
          decoration: BoxDecoration(
            color:
                showBackground
                    ? Colors.white.withOpacity(0.9)
                    : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            border: showBorder ? Border.all(color: Colors.white30) : null,
          ),
          child: Row(
            children: [
              Icon(icon, color: Colors.black),
              SizedBox(width: 5),
              Text(text),
            ],
          ),
        ),
      ),
    );
  }
}
