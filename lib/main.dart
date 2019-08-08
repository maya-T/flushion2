import 'package:flutter/material.dart';
import 'package:flutterfirebase/Ecommerce/homePage2.dart';
import 'package:flutterfirebase/Ecommerce/pages/loginPage.dart';
import 'package:flutterfirebase/Ecommerce/adminSide/admin.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'dart:async';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

import 'Ecommerce/pages/splash.dart';
import 'Ecommerce/provider/userProvider.dart';

void main() {
//  ThemeData theme=ThemeData();
//  print(theme.hintColor.toString());
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {
    runApp(
        ChangeNotifierProvider(
      builder: (_) => UserProvider.initialize(),
      child: MaterialApp(
        theme: ThemeData(
          unselectedWidgetColor: Color(0x8a000000),
          primaryColor: Colors.red.shade900,
        ),
        routes: <String, WidgetBuilder>{
          "/homePage": (BuildContext context) {
            return HomePage2();
          },
        },
        debugShowCheckedModeBanner: false,
        home: ScreenController(),
      ),
    ));
  });
}

class ScreenController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    switch (user.status) {
      case Status.UNINITIALIZED:
        return Splash();
        break;
      case Status.AUTHENTICATED:
        return HomePage2();
        break;
      case Status.AUTHENTICATING:
        return Login();
        break;
      case Status.UNAUTHENTICATED:
        return Login();
        break;
      default: return Login();
    }
  }
}

// admin side app begin

//void main(){
////  ThemeData theme=ThemeData();
////  print(theme.hintColor.toString());
//  SystemChrome.setPreferredOrientations(
//      [DeviceOrientation.portraitUp,DeviceOrientation.portraitDown])
//      .then((_) {
//    runApp(
//        MaterialApp(
//          theme: ThemeData(
//            unselectedWidgetColor:Color(0x8a000000),
//          ),
//          debugShowCheckedModeBanner: false,
//          home: Admin(),
//        )
//    );
//  });
//}
//admin side end

//void main() {
//  runApp(MyApp());
//}
//
//class MyApp extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//      title: 'Image Picker Demo',
//      home: MyHomePage(title: 'Image Picker Example'),
//    );
//  }
//}
//
//class MyHomePage extends StatefulWidget {
//  MyHomePage({Key key, this.title}) : super(key: key);
//
//  final String title;
//
//  @override
//  _MyHomePageState createState() => _MyHomePageState();
//}
//
//class _MyHomePageState extends State {
//  File _imageFile;
//  dynamic _pickImageError;
//  String _retrieveDataError;
//
//  void _onImageButtonPressed(ImageSource source) async {
//
//      try {
//        _imageFile = await ImagePicker.pickImage(source: source);
//      } catch (e) {
//        _pickImageError = e;
//      }
//      setState(() {});
//  }
//
//
//  @override
//
//
//  Widget _previewImage() {
//    final Text retrieveError = _getRetrieveErrorWidget();
//    if (retrieveError != null) {
//      return retrieveError;
//    }
//    if (_imageFile != null) {
//      return Image.file(_imageFile);
//    } else if (_pickImageError != null) {
//      return Text(
//        'Pick image error: $_pickImageError',
//        textAlign: TextAlign.center,
//      );
//    } else {
//      return const Text(
//        'You have not yet picked an image.',
//        textAlign: TextAlign.center,
//      );
//    }
//  }
//
//  Future retrieveLostData() async {
//    print("retrieve lost data");
//    final LostDataResponse response = await ImagePicker.retrieveLostData();
//    if (response.isEmpty) {
//      return;
//    }
//    if (response.file != null) {
//      setState(() {
//        if (response.type == RetrieveType.video) {
//
//        } else {
//          _imageFile = response.file;
//        }
//      });
//    } else {
//      _retrieveDataError = response.exception.code;
//    }
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(
//      ),
//      body: Center(
//        child: Platform.isAndroid
//            ? FutureBuilder(
//          future: retrieveLostData(),
//          builder: (BuildContext context, AsyncSnapshot snapshot) {
//            switch (snapshot.connectionState) {
//              case ConnectionState.none:
//              case ConnectionState.waiting:
//                return const Text(
//                  'You have not yet picked an image.',
//                  textAlign: TextAlign.center,
//                );
//                case ConnectionState.done:
//                  return
//                     _previewImage();
//                default:
//                if (snapshot.hasError) {
//                  return Text(
//                    'Pick image/video error: ${snapshot.error}}',
//                    textAlign: TextAlign.center,
//                  );
//                } else {
//                  const Text(
//                    'You have not yet picked an image.',
//                    textAlign: TextAlign.center,
//                  );
//                }
//            }
//          },
//        )
//            : ( _previewImage()),
//      ),
//      floatingActionButton: Column(
//        mainAxisAlignment: MainAxisAlignment.end,
//        children: [
//          FloatingActionButton(
//            onPressed: () {
//              _onImageButtonPressed(ImageSource.gallery);
//            },
//            heroTag: 'image0',
//            tooltip: 'Pick Image from gallery',
//            child: const Icon(Icons.photo_library),
//          ),
//        ],
//      ),
//    );
//  }
//
//  Text _getRetrieveErrorWidget() {
//    if (_retrieveDataError != null) {
//      final Text result = Text(_retrieveDataError);
//      _retrieveDataError = null;
//      return result;
//    }
//    return null;
//  }
//}

//}
