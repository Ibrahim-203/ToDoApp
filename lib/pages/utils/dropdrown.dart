import 'package:flutter/material.dart';

enum SampleItem { itemOne, itemTwo, itemThree }

class DropDown extends StatefulWidget {
  List<String> list = <String>['One', 'Two', 'Three', 'Four'];
  DropDown({super.key});

  @override
  State<DropDown> createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {
  SampleItem? selectedItem;
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        cardColor: Color(0xff2b3a67),
      ),
      child: PopupMenuButton<SampleItem>(
        initialValue: selectedItem,
        itemBuilder: (BuildContext context) => <PopupMenuEntry<SampleItem>>[
          const PopupMenuItem<SampleItem>(
            value: SampleItem.itemOne,
            child: ListTile(
              leading: Icon(
                Icons.details,
                color: Colors.white,
              ),
              title: Text(
                "Détails",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const PopupMenuItem<SampleItem>(
            value: SampleItem.itemTwo,
            child: ListTile(
              leading: Icon(
                Icons.border_color,
                color: Colors.white,
              ),
              title: Text(
                "Modifié",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const PopupMenuItem<SampleItem>(
            value: SampleItem.itemThree,
            child: ListTile(
              leading: Icon(
                Icons.lock,
                color: Colors.white,
              ),
              title: Text(
                "Privé",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
        onSelected: (value) {
          switch (value) {
            case SampleItem.itemOne:
              print("Numéro 1 choisie");
              break;
            case SampleItem.itemTwo:
              print("Numéro 2 choisie");
              break;
            case SampleItem.itemThree:
              print("Numéro 3 choisie");
              break;
            default:
          }
        },
      ),
    );
  }
}
