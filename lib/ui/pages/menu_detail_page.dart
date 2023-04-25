import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loh_coffee_eatery/cubit/menu_cubit.dart';
import 'package:loh_coffee_eatery/models/menu_model.dart';
import '../../cubit/table_cubit.dart';
import '/shared/theme.dart';

class MenuDetailPage extends StatefulWidget {
  MenuModel? inMenu;
  MenuDetailPage({super.key, this.inMenu});

  @override
  State<MenuDetailPage> createState() => _MenuDetailPageState();
}

class _MenuDetailPageState extends State<MenuDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SingleChildScrollView(
        child: Container(
          color: backgroundColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Header
              Container(
                width: double.infinity,
                margin: const EdgeInsets.only(top: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_circle_left_rounded,
                        color: primaryColor,
                        size: 55,
                      ),
                    ),
                  ],
                ),
              ),

              // The detail of the menu selected
              Text(
                'Menu Detail',
                style: greenTextStyle.copyWith(
                  fontSize: 22,
                  fontWeight: black,
                ),
              ),
              const SizedBox(height: 15),
              // image
              Container(
                width: 0.9 * MediaQuery.of(context).size.width,
                height: 400,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(widget.inMenu!.image),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 15),
              // name
              Text(
                widget.inMenu!.title,
                style: greenTextStyle.copyWith(
                  fontSize: 22,
                  fontWeight: black,
                ),
              ),
              const SizedBox(height: 15),
              // price
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Rp ',
                    style: orangeTextStyle.copyWith(
                      fontSize: 22,
                      fontWeight: black,
                    ),
                  ),
                  Text(
                    widget.inMenu!.price.toString(),
                    style: orangeTextStyle.copyWith(
                      fontSize: 22,
                      fontWeight: black,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              // description
              Text(
                widget.inMenu!.description,
                style: greenTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: medium,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              // tag
              Text(
                'Tag: ${widget.inMenu!.tag}',
                style: greenTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: medium,
                ),
              ),
              const SizedBox(height: 15),
              // total loved
              Text(
                'Total Loved: ${widget.inMenu!.totalLoved}',
                style: greenTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: medium,
                ),
              ),
              const SizedBox(height: 15),
              // total ordered
              Text(
                'Total Ordered: ${widget.inMenu!.totalOrdered}',
                style: greenTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: medium,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
