import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:leaderboard/responsive.dart';

class MathQuiz extends StatefulWidget {
  const MathQuiz({super.key});

  @override
  State<MathQuiz> createState() => _MathQuizState();
}

List ansers = [1, 2, 3, 4, 5, 6, 7, 8, 9];

class _MathQuizState extends State<MathQuiz> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/image.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: responsiveHeight(201, context),
                    ),
                    Container(
                      width: responsiveWidth(162, context),
                      height: responsiveHeight(12, context),
                      decoration: BoxDecoration(
                        color: Color(0xFFFFF0AE),
                        borderRadius: BorderRadius.circular(26),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: responsiveWidth(54, context),
                            height: responsiveHeight(12, context),
                            decoration: BoxDecoration(
                              color: Color(0xFFF8A815),
                              borderRadius: BorderRadius.circular(26),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: responsiveHeight(45, context),
                    ),
                    SizedBox(
                      width: responsiveWidth(244, context),
                      height: responsiveHeight(57, context),
                      child: Center(
                        child: AutoSizeText(
                          '3 + 4 * 9 = ...',
                          style: GoogleFonts.outfit(
                            fontSize: responsiveText(45, context),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: responsiveHeight(45, context),
                    ),
                    SizedBox(
                      width: responsiveWidth(342, context),
                      height: responsiveHeight(375, context),
                      child: GridView(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: responsiveWidth(36, context),
                            mainAxisSpacing: responsiveHeight(40, context)),
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        children: [
                          for (var answer in ansers)
                            Container(
                              width: responsiveWidth(90, context),
                              height: responsiveHeight(98, context),
                              decoration: BoxDecoration(
                                color: Color(0xFFFFEB8F),
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    width: responsiveWidth(90, context),
                                    height: responsiveHeight(90, context),
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          Color(0xFFFFD07B),
                                          Color(0xFFF7A001)
                                        ],
                                      ),
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                    child: Center(
                                      child: SizedBox(
                                        width: responsiveWidth(44, context),
                                        height: responsiveHeight(48, context),
                                        child: Center(
                                          child: AutoSizeText(
                                            answer.toString(),
                                            maxLines: 1,
                                            style: GoogleFonts.outfit(
                                              textStyle: TextStyle(
                                                color: Colors.white,
                                                fontSize:
                                                    responsiveText(38, context),
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
