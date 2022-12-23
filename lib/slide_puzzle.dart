import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'dart:ui';

// import 'package:FlutterTutorial/pages/tuto/textStroke.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:image/image.dart' as image;
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:leaderboard/constant.dart';
import 'package:leaderboard/main.dart';
import 'package:leaderboard/responsive.dart';
import 'package:leaderboard/score.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TextStrokeWidget extends StatefulWidget {
  TextStrokeWidget({Key? key}) : super(key: key);

  @override
  _TextStrokeWidgetState createState() => _TextStrokeWidgetState();
}

bool imageLoaded = false;

class _TextStrokeWidgetState extends State<TextStrokeWidget> {
  // lets make a simple statefull widget

  @override
  Widget build(BuildContext context) {
    // lets start
    // ops.. let put shadow also.. :)
    // thanks for watching..

    return Scaffold(
      body: Container(
        color: Colors.blue,
        child: Center(
          child: TextWidget("Hello & World ?",
              fontFamily: "KidZone",
              fontSize: 40,
              strokeWidth: 6,
              strokeColor: Colors.white,
              overrideSizeStroke: true, // nice
              shadow: [
                Shadow(
                    blurRadius: 10, color: Colors.black, offset: Offset(0, 5)),
              ]),
        ),
      ),
    );
  }
}

class TextWidget extends StatelessWidget {
  String text;

  String? fontFamily;
  bool overrideSizeStroke;
  double fontSize;
  double strokeWidth;
  Color strokeColor;
  List<Shadow>? shadow;
  Color color;

  TextWidget(
    this.text, {
    this.fontFamily,
    this.overrideSizeStroke = false,
    this.fontSize = 20,
    this.strokeWidth = 0, // stroke width default
    this.strokeColor = Colors.white,
    Key? key,
    this.shadow,
    this.color = Colors.black,
  }) : super(key: key) {
    if (this.shadow == null) this.shadow = [];

    // stroke to big right, let make automate little

    // this.overrideSizeStroke will disable automate .. so we can set our number
    if (this.strokeWidth != 0 && !this.overrideSizeStroke) {
      // this code will resize stroke so size will set 1/7 of font size, if stroke size is more than 1/7 font size
      // yeayy
      if (this.fontSize / 7 * 1 < this.strokeWidth)
        this.strokeWidth = this.fontSize / 7 * 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    // to make a stroke text we need stack between 2 text..
    // 1 for text & one for stroke effect
    return Stack(
      // redundant right?
      // same effect & lest code later.. :)
      children: List.generate(2, (index) {
        // let declare style for text .. :)
        // index == 0 for effect

        TextStyle textStyle = index == 0
            ? TextStyle(
                fontFamily: this.fontFamily,
                fontSize: this.fontSize,
                shadows: this.shadow,
                foreground: Paint()
                  ..color = this.strokeColor
                  ..strokeWidth = this.strokeWidth
                  ..strokeCap = StrokeCap.round
                  ..strokeJoin = StrokeJoin.round
                  ..style = PaintingStyle.stroke,
              )
            : TextStyle(
                fontFamily: this.fontFamily,
                fontSize: this.fontSize,
                color: this.color,
              );

        // let disable stroke effect if this.strokeWidth == 0
        return Offstage(
          offstage: this.strokeWidth == 0 &&
              index == 0, // put index == 0 so just disable effect only.. yeayy
          child: Text(
            this.text,
            style: textStyle,
          ),
        );
      }).toList(),
    );
  }
}

final _stopwatch = Stopwatch();

// make statefull widget for testing
class SlidePuzzle extends StatefulWidget {
  SlidePuzzle({
    Key? key,
  }) : super(key: key);

  @override
  _SlidePuzzleState createState() => _SlidePuzzleState();
}

bool _loading = true;
dynamic _data;

class _SlidePuzzleState extends State<SlidePuzzle> {
  // default put 2
  int valueSlider = 3;
  GlobalKey<_SlidePuzzleWidgetState> globalKey = GlobalKey();

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      var response = await http.get(
        Uri.parse(
          'https://api.halftiicket.com/getContests',
        ),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      ).then((response) {
        setState(() {
          _loading = false;
          _data = jsonDecode(response.body) as Map;
        });
      });
      Timer.periodic(Duration(seconds: 1), (s) {
        setState(() {});
      });
      // Future.delayed(Duration(minutes: 2), () {
      //   Navigator.push(
      //       context, MaterialPageRoute(builder: (context) => MainScreen()));
      // });
    });
  }

  @override
  Widget build(BuildContext context) {
    double border = 5;

    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      body: Row(
        children: [
          Expanded(
            child: Image.network(
              imageSponsor,
              fit: BoxFit.fill,
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width / 3,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                colors: [Color(0xFFFFD18B), Color(0xFFFBE43C)],
              ),
            ),
            child: SafeArea(
              child: Container(
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return Container(
                      width: constraints.biggest.width,
                      // comment of this so our box can extends height
                      // height: constraints.biggest.width,

                      // if setup decoration,color must put inside
                      // make puzzle widget
                      child: SlidePuzzleWidget(
                        key: globalKey,
                        size: constraints.biggest,
                        id: '639cda5575f95e42b54ff971',
                        // set size puzzle
                        sizePuzzle: 3,
                        imageBckGround: Image(
                          // u can use your own image
                          image: NetworkImage(_data['contests']
                              .toList()
                              .where(
                                  (i) => i['_id'] == '639cda5575f95e42b54ff971')
                              .toList()[0]['img']
                              .toString()),
                        ),
                      ),
                    );
                  },
                ),
                // child: ,
              ),
            ),
          ),
          Expanded(
            child: Image.network(
              imageSponsor,
              fit: BoxFit.fill,
            ),
          ),
        ],
      ),
    );
  }
}

// statefull widget
class SlidePuzzleWidget extends StatefulWidget {
  Size size;
  // set inner padding
  double innerPadding;
  // set image use for background
  Image imageBckGround;
  int sizePuzzle;
  String id;
  SlidePuzzleWidget({
    Key? key,
    required this.id,
    this.size = const Size(1, 2),
    this.innerPadding = 5,
    this.imageBckGround = const Image(
      image: NetworkImage(
          'https://upload.wikimedia.org/wikipedia/commons/thumb/b/b6/Image_created_with_a_mobile_phone.png/640px-Image_created_with_a_mobile_phone.png'),
    ),
    this.sizePuzzle = 1,
  }) : super(key: key);

  @override
  _SlidePuzzleWidgetState createState() => _SlidePuzzleWidgetState();
}

class _SlidePuzzleWidgetState extends State<SlidePuzzleWidget> {
  GlobalKey _globalKey = GlobalKey();
  Size? size;

  // list array slide objects
  List<SlideObject>? slideObjects;
  // image load with renderer
  image.Image? fullImage;
  // success flag
  bool success = false;
  // flag already start slide
  bool startSlide = false;
  // save current swap process for reverse checking
  List<int>? process;
  // flag finish swap
  bool finishSwap = false;
  Widget result = SizedBox();
  @override
  Widget build(BuildContext context) {
    size = Size(widget.size.width - widget.innerPadding * 2,
        widget.size.width - widget.innerPadding);

    return Column(
      mainAxisSize: MainAxisSize.min,
      // let make ui
      children: [
        SizedBox(
          height: responsiveHeight(57, context),
          width: responsiveWidth(325, context),
          child: AutoSizeText(
            (_stopwatch.elapsed.inSeconds).toString(),
            style: GoogleFonts.outfit(
              textStyle: TextStyle(
                fontSize: responsiveText(40, context),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        result,
        // make 2 column, 1 for puzzle box, 2nd for button testing
        Container(
          width: widget.size.width,
          height: widget.size.width,
          padding: EdgeInsets.all(widget.innerPadding),
          child: Stack(
            children: [
              // we use stack stack our background & puzzle box
              // 1st show image use

              if (slideObjects == null) ...[
                RepaintBoundary(
                  key: _globalKey,
                  child: Container(
                    color: Colors.transparent,
                    height: double.maxFinite,
                    child: widget.imageBckGround,
                  ),
                )
              ],
              // 2nd show puzzle with empty
              if (slideObjects != null)
                ...slideObjects!.where((slideObject) => slideObject.empty).map(
                  (slideObject) {
                    return Positioned(
                      left: slideObject.posCurrent.dx,
                      top: slideObject.posCurrent.dy,
                      child: SizedBox(
                        width: slideObject.size.width,
                        height: slideObject.size.height,
                        child: Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.all(2),
                          color: Colors.white24,
                          child: Stack(
                            children: [
                              if (slideObject.image != null) ...[
                                Opacity(
                                  opacity: success ? 1 : 0.3,
                                  child: slideObject.image,
                                )
                              ]
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ).toList(),
              // this for box with not empty flag
              if (slideObjects != null)
                ...slideObjects!.where((slideObject) => !slideObject.empty).map(
                  (slideObject) {
                    // change to animated position
                    // disabled checking success on swap process
                    return AnimatedPositioned(
                      duration: Duration(milliseconds: 200),
                      curve: Curves.ease,
                      left: slideObject.posCurrent.dx,
                      top: slideObject.posCurrent.dy,
                      child: GestureDetector(
                        onTap: () =>
                            changePos(slideObject.indexCurrent, widget.id),
                        child: SizedBox(
                          width: slideObject.size.width,
                          height: slideObject.size.height,
                          child: Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              border: Border.all(
                                color: Colors.white,
                                width: 2,
                              ),
                            ),
                            child: Stack(
                              children: [
                                if (slideObject.image != null) ...[
                                  slideObject.image
                                ],
                                Center(
                                  child: TextWidget(
                                    "${slideObject.indexDefault}",
                                    color: Color(0xff225f87),
                                    strokeColor: Colors.white,
                                    strokeWidth: 8,
                                    fontFamily: "KidZone",
                                    fontSize: 40,
                                    overrideSizeStroke: false,
                                  ),
                                ),

                                // nice one.. lets make it random
                              ],
                            ),
                            // nice one
                          ),
                        ),
                      ),
                    );
                  },
                ).toList()

              // now not show at all because we dont generate slideObjects yet.. lets generate
            ],
          ),
        ),
        Spacer(),
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // u can use any button
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    generatePuzzle(widget.id);
                    _stopwatch.start();
                    setState(() {
                      result = Column(
                        children: [
                          SizedBox(
                            height: responsiveHeight(57, context),
                            width: responsiveWidth(325, context),
                            child: Center(
                              child: AutoSizeText(
                                'Arrange in order:-',
                                style: GoogleFonts.outfit(
                                  textStyle: TextStyle(
                                    fontSize: responsiveText(40, context),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: responsiveWidth(200, context),
                            height: responsiveHeight(200, context),
                            decoration: BoxDecoration(
                                image: DecorationImage(
                              image: NetworkImage(_data['contests']
                                  .toList()
                                  .where((i) =>
                                      i['_id'] == '639cda5575f95e42b54ff971')
                                  .toList()[0]['img']
                                  .toString()),
                            )),
                          ),
                        ],
                      );
                    });
                  },
                  child: imageLoaded == true
                      ? SizedBox()
                      : Container(
                          height: responsiveHeight(58, context),
                          width: responsiveWidth(326, context),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.white,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(37),
                            gradient: LinearGradient(
                              colors: [
                                Color(0xFFFFB2B2),
                                Color(0xFFFBC63C),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                          child: Center(
                            child: SizedBox(
                              height: responsiveHeight(25, context),
                              width: responsiveWidth(106, context),
                              child: Center(
                                child: AutoSizeText(
                                  'Start',
                                  style: GoogleFonts.outfit(
                                    textStyle: TextStyle(
                                      color: Colors.white,
                                      fontSize: responsiveText(20, context),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
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
    );
  }

  // setup method use

  // get render image
  // same as jigsaw puzzle method before

  _getImageFromWidget() async {
    RenderRepaintBoundary? boundary =
        _globalKey.currentContext?.findRenderObject() as RenderRepaintBoundary?;

    size = boundary!.size;
    var img = await boundary.toImage();
    var byteData = await img.toByteData(format: ImageByteFormat.png);
    var pngBytes = byteData!.buffer.asUint8List();

    return image.decodeImage(pngBytes);
  }

  // method to generate our puzzle
  generatePuzzle(String id) async {
    // dclare our array puzzle
    finishSwap = false;
    setState(() {});
    // 1st load render image to crop, we need load just once
    if (this.fullImage == null) this.fullImage = await _getImageFromWidget();

    print(this.fullImage!.width);
    // ok nice..full image loaded
    setState(() {
      imageLoaded = true;
    });

    // calculate box size for each puzzle
    Size sizeBox =
        Size(size!.width / widget.sizePuzzle, size!.width / widget.sizePuzzle);

    // let proceed with generate box puzzle
    // power of 2 because we need generate row & column same number
    slideObjects =
        List.generate(widget.sizePuzzle * widget.sizePuzzle, (index) {
      // we need setup offset 1st
      Offset offsetTemp = Offset(
        index % widget.sizePuzzle * sizeBox.width,
        index ~/ widget.sizePuzzle * sizeBox.height,
      );

      // set image crop for nice effect, check also if image is null
      image.Image tempCrop;
      // if (this.fullImage != null)
      tempCrop = image.copyCrop(
        fullImage!,
        offsetTemp.dx.round(),
        offsetTemp.dy.round(),
        sizeBox.width.round(),
        sizeBox.height.round(),
      );

      return SlideObject(
        posCurrent: offsetTemp,
        posDefault: offsetTemp,
        indexCurrent: index,
        indexDefault: index + 1,
        size: sizeBox,
        image: Image.memory(
          Uint8List.fromList(image.encodePng(tempCrop)),
          fit: BoxFit.contain,
        ),
      );
    }); //let set empty on last child

    slideObjects!.last.empty = true;

    // make random.. im using smple method..just rndom with move it.. haha

    // setup moveMethod 1st
    // proceed with swap block place
    // swap true - we swap horizontal line.. false - vertical
    bool swap = true;
    process = [];

    // 20 * size puzzle shuffle
    for (var i = 0; i < widget.sizePuzzle * 20; i++) {
      for (var j = 0; j < widget.sizePuzzle / 2; j++) {
        SlideObject slideObjectEmpty = getEmptyObject();

        // get index of empty slide object
        int emptyIndex = slideObjectEmpty.indexCurrent;
        process!.add(emptyIndex);
        int randKey;

        if (swap) {
          // horizontal swap
          int row = emptyIndex ~/ widget.sizePuzzle;
          randKey =
              row * widget.sizePuzzle + new Random().nextInt(widget.sizePuzzle);
        } else {
          int col = emptyIndex % widget.sizePuzzle;
          randKey =
              widget.sizePuzzle * new Random().nextInt(widget.sizePuzzle) + col;
        }

        // call change pos method we create before to swap place

        changePos(randKey, id);
        // ops forgot to swap
        // hmm bug.. :).. let move 1st with click..check whther bug on swap or change pos
        swap = !swap;
      }
    }

    startSlide = false;
    finishSwap = true;
    setState(() {});
  }
  // eyay.. end

  // get empty slide object from list
  SlideObject getEmptyObject() {
    return slideObjects!.firstWhere((element) => element.empty);
  }

  changePos(int indexCurrent, String id) async {
    // problem here i think..
    SlideObject slideObjectEmpty = getEmptyObject();

    // get index of empty slide object
    int emptyIndex = slideObjectEmpty.indexCurrent;

    // min & max index based on vertical or horizontal

    int minIndex = min(indexCurrent, emptyIndex);
    int maxIndex = max(indexCurrent, emptyIndex);

    // temp list moves involves
    List<SlideObject> rangeMoves = [];

    // check if index current from vertical / horizontal line
    if (indexCurrent % widget.sizePuzzle == emptyIndex % widget.sizePuzzle) {
      // same vertical line
      rangeMoves = slideObjects!
          .where((element) =>
              element.indexCurrent % widget.sizePuzzle ==
              indexCurrent % widget.sizePuzzle)
          .toList();
    } else if (indexCurrent ~/ widget.sizePuzzle ==
        emptyIndex ~/ widget.sizePuzzle) {
      rangeMoves = slideObjects!;
    } else {
      rangeMoves = [];
    }

    rangeMoves = rangeMoves
        .where((puzzle) =>
            puzzle.indexCurrent >= minIndex &&
            puzzle.indexCurrent <= maxIndex &&
            puzzle.indexCurrent != emptyIndex)
        .toList();

    // check empty index under or above current touch
    if (emptyIndex < indexCurrent)
      rangeMoves.sort((a, b) => a.indexCurrent < b.indexCurrent ? 1 : 0);
    else
      rangeMoves.sort((a, b) => a.indexCurrent < b.indexCurrent ? 0 : 1);

    // check if rangeMOves is exist,, then proceed switch position
    if (rangeMoves.length > 0) {
      int tempIndex = rangeMoves[0].indexCurrent;

      Offset tempPos = rangeMoves[0].posCurrent;

      // yeayy.. sorry my mistake.. :)
      for (var i = 0; i < rangeMoves.length - 1; i++) {
        rangeMoves[i].indexCurrent = rangeMoves[i + 1].indexCurrent;
        rangeMoves[i].posCurrent = rangeMoves[i + 1].posCurrent;
      }

      rangeMoves.last.indexCurrent = slideObjectEmpty.indexCurrent;
      rangeMoves.last.posCurrent = slideObjectEmpty.posCurrent;

      // haha ..i forget to setup pos for empty puzzle box.. :p
      slideObjectEmpty.indexCurrent = tempIndex;
      slideObjectEmpty.posCurrent = tempPos;
    }

    // this to check if all puzzle box already in default place.. can set callback for success later
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    if (slideObjects!
                .where((slideObject) =>
                    slideObject.indexCurrent == slideObject.indexDefault - 1)
                .length ==
            slideObjects!.length &&
        finishSwap) {
      _stopwatch.stop();
      final response = await http
          .post(
            Uri.parse('https://api.halftiicket.com/addPlayerContest'),
            headers: {
              'Content-Type': 'application/json',
            },
            body: jsonEncode({
              'user_id': _preferences.getString('_id').toString(),
              'contest_id': '639cda5575f95e42b54ff971',
              'time': _stopwatch.elapsed.inMilliseconds / 1000,
            }),
          )
          .then((value) => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ScorePage(
                        timeElapsed: _stopwatch.elapsed,
                        id: id,
                        rank: int.parse(
                            jsonDecode(value.body)['rank'].toString()),
                      ))));
      setState(() {});
      success = true;
    } else {
      success = false;
    }

    startSlide = true;
    setState(() {});
  }

  clearPuzzle() {
    setState(() {
      // checking already slide for reverse purpose
      startSlide = true;
      slideObjects = null;
      finishSwap = true;
    });
  }

  reversePuzzle() async {
    startSlide = true;
    finishSwap = true;
    setState(() {});

    await Stream.fromIterable(process!.reversed)
        .asyncMap((event) async =>
            await Future.delayed(Duration(milliseconds: 50))
                .then((value) => changePos(event, widget.id)))
        .toList();

    // yeayy
    process = [];
    setState(() {});
  }
}

// lets start class use
class SlideObject {
  // setup offset for default / current position
  Offset posDefault;
  Offset posCurrent;
  // setup index for default / current position
  int indexDefault;
  int indexCurrent;
  // status box is empty
  bool empty;
  // size each box
  Size size;
  // Image field for crop later
  Image image;

  SlideObject({
    this.empty = false,
    this.image = const Image(
        image: NetworkImage(
            'https://upload.wikimedia.org/wikipedia/commons/thumb/b/b6/Image_created_with_a_mobile_phone.png/640px-Image_created_with_a_mobile_phone.png')),
    this.indexCurrent = 1,
    this.indexDefault = 1,
    this.posCurrent = const Offset(1, 2),
    this.posDefault = const Offset(1, 2),
    this.size = const Size(1, 2),
  });
}
