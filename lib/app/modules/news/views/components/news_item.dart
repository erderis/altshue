import 'package:altshue/app/constants/colors.dart';
import 'package:altshue/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class NewsItem extends StatelessWidget {
  const NewsItem({
    Key? key,
    required this.index,
  }) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(index != 0 ? 0 : 20),
          topRight: Radius.circular(index != 0 ? 0 : 20)),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            Get.toNamed(Routes.NEWS_DETAIL);
          },
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 21,
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 28,
                ),
                Row(
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(
                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQdRmhKAoSeP_y915jup2ol3qgi1qLa0i2Hbg&usqp=CAU',
                          fit: BoxFit.cover,
                          width: 88,
                          height: 88,
                        )),
                    SizedBox(
                      width: 16,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: Get.width / 2,
                          child: Text(
                              'Daftar Area dengan Jaringan 5G di Indonesia',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Palette.darkTan,
                                  fontSize: 12,
                                  fontFamily: AppFontStyle.montserratBold)),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        SizedBox(
                          width: Get.width / 2,
                          child: Text(
                            'Lorem Ipsum dolor sit amet, lorem ipsum sit amet dolor...',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Palette.mineShaft,
                                fontSize: 10,
                                fontFamily: AppFontStyle.montserratReg),
                          ),
                        ),
                        SizedBox(
                          height: 9,
                        ),
                        Text(
                          '22 Oct 2021',
                          style: TextStyle(
                              color: Palette.dustyGray,
                              fontSize: 10,
                              fontFamily: AppFontStyle.montserratReg),
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: index == 9 ? 0 : 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}