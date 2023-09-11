import 'package:app/presentation/component/constant.dart';
import 'package:flutter/material.dart';

class NavBarButton extends StatelessWidget {
  final String icon;
  final String iconName;
  final bool isSelected;
  final VoidCallback runFunction;
  const NavBarButton(
      {Key? key,
      required this.icon,
      required this.iconName,
      required this.isSelected,
      required this.runFunction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: runFunction,
      child: Container(
        height: double.infinity,
        width: screenWidth(context) * 0.280,
        child: AnimatedContainer(
          duration: Duration(milliseconds: 300),
          width: double.infinity,
          height: screenHeight(context) * 0.1,
          padding:
              EdgeInsets.symmetric(horizontal: screenWidth(context) * (1 / 40)),
          decoration: BoxDecoration(
            color: this.isSelected ? white : null,
            borderRadius: BorderRadius.all(Radius.circular(40)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(
                this.icon,
                scale: 2.5,
              ),
              Text(
                this.iconName,
                style: TextStyle(
                    color: this.isSelected ? blue2 : white,
                    fontSize: screenHeight(context) * (1 / 63),
                    fontWeight: FontWeight.w600),
              )
            ],
          ),
        ),
      ),
    );
  }
}
