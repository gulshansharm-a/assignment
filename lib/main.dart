import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';

const TextColor = const Color(0xff002633);
const TextColor2 = const Color(0xff015574);


int text_case = 0;
bool _readOnly = true;

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var title = 'Webview Demo';
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    return new MaterialApp(
      theme: ThemeData(
          appBarTheme: AppBarTheme(
            color: TextColor,
          )),
      title: title,
// debugShowCheckedModeBanner: false,
// home: Page1(),

      home: new MyAppHomePage(),

    );
  }
}

class MyAppHomePage extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

const String flutterUrl = "https://flutter.dev/";
const String wikiUrl = "https://es.wikipedia.org";

class _MyAppState extends State<MyAppHomePage> {
  final _formKey = GlobalKey<FormState>();
  WebViewController _controller;

  _loadPage1(int a) async {
    var url = await _controller.currentUrl();
    _controller.loadUrl(
      url = "https://krishworks.com/",
    );
    print(url);
  }

  _loadPage2() async {
    var url = await _controller.currentUrl();
    _controller.loadUrl(
      url = "https://krishworks.com/about/",
    );
    print(url);
  }

  _loadPage3() async {
    var url = await _controller.currentUrl();
    _controller.loadUrl(
      url = "https://krishworks.com/updates/",
    );
    print(url);
  }

  _loadGallery() async {
    var url = await _controller.currentUrl();
    _controller.loadUrl(
      url = "https://krishworks.com/gallery/",
    );
    print(url);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(
                Icons.settings,
              ),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        content: Stack(
                          overflow: Overflow.visible,
                          children: <Widget>[
                            Positioned(
                              right: -40.0,
                              top: -40.0,
                              child: InkResponse(
                                onTap: () {
                                  child:
                                  Text("Developer Passcode");
                                  Navigator.of(context).pop();
                                },
                              ),
                            ),
                            Form(
                              key: _formKey,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text("Developer Passcode"),
                                  ),
                                  OTPTextField(
                                    length: 6,
                                    width: MediaQuery.of(context).size.width,
                                    fieldWidth: 80,
                                    style: TextStyle(fontSize: 17),
                                    textFieldAlignment:
                                    MainAxisAlignment.spaceAround,
                                    fieldStyle: FieldStyle.box,
                                    onCompleted: (pin) {
                                      int pass;
                                      DateTime now = new DateTime.now();
                                      DateTime date = new DateTime(now.year, now.month, now.day);
                                      pass = now.year * now.month * now.day;
                                      if(pin == pass){
                                        Scaffold.of(this.context).openDrawer();
                                      }
                                      print("Completed: " + pin);
                                    },

                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(20.0))),
                      );
                    });
                Scaffold.of(context).openDrawer();
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
        centerTitle: true,
        title: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: TextColor2,
          ),
          child: SizedBox(
            width: 350.0,
            height: 50.0,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    width: 100.0,
                    height: 35.0,
                    child: ElevatedButton(
                        onPressed: () => _loadPage1(0),
                        child: const Text("Home"),
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(TextColor2),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
// side: const BorderSide(color: Colors.red)
                            ))
                        )
                    ),
                  ),
                  const SizedBox(width: 15),
                  SizedBox(
                    width: 100.0,
                    height: 35.0,
                    child: ElevatedButton(
                        onPressed: _loadPage2,
                        child: const Text("About Us"),
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(TextColor2),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
// side: const BorderSide(color: Colors.red)
                              ),

                            )
                        )
                    ),
                  ),
                  const SizedBox(width: 15),
                  SizedBox(
                    width: 100.0,
                    height: 35.0,
                    child: ElevatedButton(
                        onPressed: _loadPage3,
                        child: const Text("Updates"),
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(TextColor2),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
// side: const BorderSide(color: Colors.red)
                            )))),
                  ),
                ]),
          ),
        ),
        actions: <Widget>[],
      ),
      body: SafeArea(
        child: WebView(
          key: Key("webview"),
          initialUrl: "https://krishworks.com/",
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
            _controller = webViewController;
          },
        ),
      ),
      drawer: Drawer(
// Add a ListView to the drawer. This ensures the user can scroll
// through the options in the drawer if there isn't enough vertical
// space to fit everything.
        child: ListView(
// Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            SizedBox(
              height: 100,
              child: const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Text('Drawer Header'),
              ),
            ),
            ListTile(
              title: const Text('Gallery'),
              onTap: () {
// Update the state of the app.
// ...
                _loadGallery();
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Contact Us'),
              onTap: () {
// Update the state of the app.
// ...
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class KeyboardDemo extends StatefulWidget {
  @override
  _KeyboardDemoState createState() => _KeyboardDemoState();
}

class _KeyboardDemoState extends State<KeyboardDemo> {
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          SizedBox(height: 50),

          Spacer(),
          CustomKeyboard(
            onTextInput: (myText) {
              _insertText(myText);
            },
            onBackspace: () {
            },
          ),
        ],
      ),
    );
  }

  void _insertText(String myText) {
    final text = _controller.text;
    final textSelection = _controller.selection;
    final newText = text.replaceRange(
      textSelection.start,
      textSelection.end,
      myText,
    );
    final myTextLength = myText.length;
    _controller.text = newText;
    _controller.selection = textSelection.copyWith(
      baseOffset: textSelection.start + myTextLength,
      extentOffset: textSelection.start + myTextLength,
    );
  }

  bool _isUtf16Surrogate(int value) {
    return value & 0xF800 == 0xD800;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class CustomKeyboard extends StatelessWidget {
  CustomKeyboard({
    Key key,
    this.onTextInput,
    this.onBackspace,
  }) : super(key: key);

  final ValueSetter<String> onTextInput;
  final VoidCallback onBackspace;

  void _textInputHandler(String text) => onTextInput?.call(text);

  void _backspaceHandler() => onBackspace?.call();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      color: TextColor,
      child: Column(
        children: [
          buildRowOne(),
        ],
      ),
    );
  }

  Expanded buildRowOne() {
    return Expanded(
      child: Row(
        children: [
          TextKey(
            text: '1',
            onTextInput: _textInputHandler,

          ),
          TextKey(
            text: '2',
            onTextInput: _textInputHandler,
          ),
          TextKey(
            text: '3',
            onTextInput: _textInputHandler,
          ),
          TextKey(
            text: '4',
            onTextInput: _textInputHandler,
          ),
          TextKey(
            text: '5',
            onTextInput: _textInputHandler,
          ),
          TextKey(
            text: '6',
            onTextInput: _textInputHandler,
          ),
          TextKey(
            text: '7',
            onTextInput: _textInputHandler,
          ),
          TextKey(
            text: '8',
            onTextInput: _textInputHandler,
          ),
          TextKey(
            text: '9',
            onTextInput: _textInputHandler,
          ),
          TextKey(
            text: '0',
            onTextInput: _textInputHandler,
          ),

        ],
      ),
    );
  }
}

class TextKey extends StatelessWidget {
  const TextKey({
    Key key,
    @required this.text,
    this.onTextInput,
    this.flex = 1,
  }) : super(key: key);

  final String text;
  final ValueSetter<String> onTextInput;
  final int flex;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Padding(
        padding: const EdgeInsets.all(1.0),
        child: Material(
          color: Colors.blue.shade300,
          child: InkWell(
            onTap: () {
              onTextInput?.call(text);
            },
            child: Container(
              child: Center(child: Text(text)),
            ),
          ),
        ),
      ),
    );
  }
}

class BackspaceKey extends StatelessWidget {
  const BackspaceKey({
    Key key,
    this.onBackspace,
    this.flex = 1,
  }) : super(key: key);

  final VoidCallback onBackspace;
  final int flex;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Padding(
        padding: const EdgeInsets.all(1.0),
        child: Material(
          color: Colors.blue.shade300,
          child: InkWell(
            onTap: () {
              onBackspace?.call();
            },
            child: Container(
              child: Center(
                child: Icon(Icons.backspace),
              ),
            ),
          ),
        ),
      ),
    );
  }
}