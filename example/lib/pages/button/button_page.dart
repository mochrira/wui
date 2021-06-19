import 'package:flutter/material.dart';
import 'package:wui/utils/message.dart';
import 'package:wui/wui.dart';

class ButtonPage extends StatefulWidget {
  const ButtonPage({ Key? key }) : super(key: key);

  @override
  _ButtonPageState createState() => _ButtonPageState();
}

class _ButtonPageState extends State<ButtonPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(WuiConfig.getValue("apiURL") ?? ""),
                SizedBox(height: 64),
                StreamBuilder<WuiStreamMessage>(
                  stream: WuiMessage.stream(['apiURL']),
                  initialData: null,
                  builder: (BuildContext context, AsyncSnapshot<WuiStreamMessage> snapshot) {
                    return Text(snapshot.data?.value ?? "");
                  }
                ),
                SizedBox(height: 64),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    WuiButton(
                      icon: Icons.cancel_rounded,
                      text: "Batal",
                      theme: WuiButtonTheme.danger,
                      onPressed: () {
                        WuiMessage.broadcast('apiURL', 'Test');
                      },
                    ),
                    SizedBox(width: 16),
                    WuiButton(
                      icon: Icons.save,
                      text: "Simpan",
                      theme: WuiButtonTheme.primary,
                      onPressed: () {

                      },
                    )
                  ],
                ),
                SizedBox(height: 32),
                WuiButton(
                  icon: Icons.lock,
                  text: "MASUK SEKARANG",
                  size: WuiButtonSize.large,
                  onPressed: () {},
                ),
                SizedBox(height: 32),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    WuiButton(
                      rounded: true,
                      text: "Batal",
                    ),
                    SizedBox(width: 16),
                    WuiButton(
                      rounded: true,
                      text: "Simpan",
                    )
                  ],
                ),
                SizedBox(height: 32),
                WuiButton(
                  rounded: true,
                  icon: Icons.arrow_forward,
                  iconPos: WuiButtonIconPos.suffix,
                  text: "MASUK SEKARANG",
                  size: WuiButtonSize.large,
                ),
                SizedBox(height: 32),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    WuiButton(
                      rounded: true,
                      smooth: true,
                      theme: WuiButtonTheme.danger,
                      text: "Batal",
                      onPressed: () {},
                    ),
                    SizedBox(width: 16),
                    WuiButton(
                      rounded: true,
                      smooth: true,
                      theme: WuiButtonTheme.primary,
                      text: "Simpan",
                      onPressed: () {},
                    )
                  ],
                ),
                SizedBox(height: 32),
                WuiButton(
                  rounded: true,
                  smooth: true,
                  text: "MASUK SEKARANG",
                  size: WuiButtonSize.large,
                  onPressed: () {},
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}