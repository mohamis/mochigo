import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mochigo/models/sm_product_model.dart';
import 'package:mochigo/utils/color.dart';

class MochiDetailsScreen extends StatefulWidget {
  const MochiDetailsScreen({
    Key? key,
    required this.title,
    required this.price,
    required this.description,
    required this.image,
    required this.id,
  }) : super(key: key);
  final String title;
  final double price;
  final String description;
  final String image;
  final String id;

  @override
  State<MochiDetailsScreen> createState() => __MochiDetailsScreenState();
}

class __MochiDetailsScreenState extends State<MochiDetailsScreen> {
  @override
  Widget build(BuildContext context) {
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
            child: Image.network(
              widget.image,
              fit: BoxFit.fill,
            ),
          ),
          Expanded(
            child: Stack(
              children: [
                Container(
                  height: double.infinity,
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
                              widget.title,
                              style: GoogleFonts.poppins(
                                fontSize: 22,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              '€${widget.price}',
                              style: GoogleFonts.poppins(
                                fontSize: 22,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        Text(
                          widget.description,
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
    );
  }
}
