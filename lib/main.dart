import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:zendesk2/zendesk2.dart';
import 'package:zindesk_ex_app/zendesk_chat.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void zendesk(bool isNativeChat, BuildContext context) async {
    String accountKey = 'y0EHdqQgOxGHSZEwuFW1Yd2eKz74sU3X';
    String appId = '';

    String name = 'des';
    String email = 'des@gmail.com';
    String phoneNumber = '0763901382';

    Zendesk2Chat z = Zendesk2Chat.instance;

    await z.logger(true);

    await z.init(accountKey, appId, iosThemeColor: Colors.yellow);

    await z.setVisitorInfo(
      name: name,
      email: email,
      phoneNumber: phoneNumber,
      tags: ['app', 'zendesk2_plugin'],
    );
    await z.customize(
      departmentFieldStatus: PRE_CHAT_FIELD_STATUS.HIDDEN,
      emailFieldStatus: PRE_CHAT_FIELD_STATUS.HIDDEN,
      nameFieldStatus: PRE_CHAT_FIELD_STATUS.HIDDEN,
      phoneFieldStatus: PRE_CHAT_FIELD_STATUS.HIDDEN,
      transcriptChatEnabled: true,
      agentAvailability: false,
      endChatEnabled: true,
      offlineForms: true,
      preChatForm: true,
      transcript: true,
    );

    if (isNativeChat) {
      await z.startChat(
        toolbarTitle: 'Talk to us',
        backButtonLabel: 'Back',
        botLabel: 'bip bop boting',
      );
    } else {
      await Zendesk2Chat.instance.startChatProviders();

      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => ZendeskChat()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plugin example app'),
      ),
      body: const Center(
        child: Text('Press on FAB to start chat'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'customChat',
        icon: const Icon(FontAwesomeIcons.comments),
        label: const Text('Custom Chat'),
        onPressed: () => zendesk(false, context),
      ),
    );
  }
}
