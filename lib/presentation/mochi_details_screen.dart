import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:mochigo/controller/product_controller.dart';
import 'package:mochigo/model/sm_product_model.dart';
import 'package:mochigo/utils/color.dart';

class MochiDetailsScreen extends StatelessWidget {
  const MochiDetailsScreen({
    Key? key,
    required this.title,
    required this.price,
    required this.description,
    required this.image,
  }) : super(key: key);
  final String title;
  final double price;
  final String description;
  final String image;

  @override
  Widget build(BuildContext context) {
    final ProductController productController = Get.put(ProductController());

    final List<SmProduct> smProducts = [
      SmProduct(image: 'assets/images/products/mochi-yuzu.jpg'),
      SmProduct(image: 'assets/images/products/mochi-choco.jpg'),
      SmProduct(image: 'assets/images/products/mochi-anko.jpg'),
      SmProduct(image: 'assets/images/products/mochi-noisette.jpg'),
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 211, 245),
        foregroundColor: Colors.black,
      ),
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * .35,
            padding: const EdgeInsets.only(bottom: 30),
            width: double.infinity,
            child: Image.asset(
              image,
              fit: BoxFit.fill,
            ),
          ),
          Expanded(
            child: Stack(
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 40, right: 14, left: 14),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Mochi',
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            color: Colors.grey,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              title,
                              style: GoogleFonts.poppins(
                                fontSize: 22,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              '\€$price',
                              style: GoogleFonts.poppins(
                                fontSize: 22,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        Text(
                          description,
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 15),
                        Text(
                          'Similar to this',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          height: 110,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: smProducts.length,
                            itemBuilder: (BuildContext context, int index) =>
                                Container(
                              margin: const EdgeInsets.only(right: 6),
                              width: 110,
                              height: 110,
                              decoration: BoxDecoration(
                                color: AppColors.kSmProductBgColor,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Center(
                                child: Image(
                                  image: AssetImage(
                                    smProducts[index].image,
                                  ),
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    margin: const EdgeInsets.only(top: 10),
                    width: 50,
                    height: 5,
                    decoration: BoxDecoration(
                      color: AppColors.kGreyColor,
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: 100,
        color: Colors.white,
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: InkWell(
                onTap: () {
                  productController.addToCart();
                },
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 255, 211, 245),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Obx(
                    () => productController.isAddLoading.value
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              color: Colors.black,
                              strokeWidth: 3,
                            ),
                          )
                        : Text(
                            '+ Add to Cart',
                            style: GoogleFonts.poppins(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
