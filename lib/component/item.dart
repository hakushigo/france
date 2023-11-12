import 'package:french/component/cardtitle.dart';
import 'package:flutter/material.dart';

class ItemCard extends StatelessWidget {
  final String name;
  final String city;
  final String itemId;

  const ItemCard(this.name, this.city, this.itemId, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Card(
          child: Padding(
              padding: EdgeInsets.all(20),
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CardTitle(this.name),
                        SizedBox(height: 15),
                        Text("ville d'origine : ${this.city}")
                      ],
                    ),
                  ],
                ),
              ))),
    );
  }

  void Destroy() {}

  @override
  bool operator == (Object other) {
    if (identical(this, other)) return true;

    return other is ItemCard &&
        other.name == name &&
        other.city == city &&
        other.itemId == itemId;
  }

  @override
  int get hashCode => name.hashCode ^ city.hashCode ^ itemId.hashCode;
}
