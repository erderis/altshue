import 'package:altshue/app/constants/asset_path.dart';
import 'package:altshue/app/constants/colors.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/news_detail_controller.dart';

class NewsDetailView extends GetView<NewsDetailController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.white,
        body: MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: ListView(
        children: [
          Stack(
            children: [
              Container(
                color: Palette.white,
                height: Get.height,
              ),
              ImageTop(),
              Positioned(
                  top:295,
                  left:0,
                  right:0,
                  child: Column(
                    children:[
                      Title(),
                      Description(),
                    ]
                  )),
            ],
          ),

          SizedBox(height: 40)
        ],
      ),
    ));
  }
}

class Description extends StatelessWidget {
  const Description({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32.0, horizontal: 43),
      child: Text(
        'Jakarta, CNN Indonesia -- Sejumlah operator seluler meluncurkan teknologi jaringan 5G di beberapa kota di Indonesia. Meskipun wilayah cakupannya belum luas, hal ini menjadi sebuah langkah besar untuk dunia telekomunikasi di Indonesia. Perusahaan plat merah Telkomsel menjadi yang pertama menyajikan layanan 5G di Indonesia, dan mulai memberikan layanan 5G bagi pelanggannya sejak 27 Mei 2021. Tak lama setelah peluncuran 5G dari Telkomsel, Indosat Ooredoo mulai menyajikan layanannya di bulan berikutnya. Terhitung sejak 7 Juni 2021, Indosat Ooredoo resmi memberikan layanan 5G bagi pelanggannya.',
        textAlign: TextAlign.justify,
        style: TextStyle(
            color: Palette.mineShaft,
            height: 2,
            fontSize: 13,
            fontFamily: AppFontStyle.robotoReg),
      ),
    );
  }
}

class Title extends StatelessWidget {
  const Title({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 105,
        width: Get.width,
        padding: EdgeInsets.symmetric(horizontal: 35, vertical: 16),
        decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage(AssetName.titleBg))
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Daftar Area dengan Jaringan 5G di Indonesia',
              style: TextStyle(
                  color: Palette.white,
                  fontSize: 20,
                  fontFamily: AppFontStyle.montserratBold),
            ),
            SizedBox(height: 5),
            Text(
              '22 Oct 2021',
              style: TextStyle(
                  color: Palette.amber,
                  fontSize: 14,
                  fontFamily: AppFontStyle.montserratReg),
            ),
          ],
        ));
  }
}

class ImageTop extends StatelessWidget {
  const ImageTop({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.network(
          'https://blog.spoongraphics.co.uk/wp-content/uploads/2015/11/thumbnail9.jpg',
          fit: BoxFit.cover,
          width: Get.width,
          height: 300,
        ),
        Positioned(
          top: 40,
          left: 22,
          child: Row(
            children: [
              InkWell(
                  onTap: () => Get.back(),
                  child: Icon(
                    Icons.arrow_back,
                    color: Palette.white,
                  )),
              SizedBox(
                width: 10,
              ),
              Text('News',
                  style: TextStyle(
                      color: Palette.white,
                      fontSize: 17,
                      fontFamily: AppFontStyle.montserratMed)),
            ],
          ),
        ),
      ],
    );
  }
}
