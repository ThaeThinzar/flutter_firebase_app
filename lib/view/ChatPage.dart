import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
String defaultUserName ;
class ChatPage extends StatefulWidget {
  String title;

  @override
  ChatPageState createState() {
    return ChatPageState(title);
  }

  ChatPage(this.title);

}
class ChatPageState extends State<ChatPage> with TickerProviderStateMixin {
  String title;

  ChatPageState(this.title);
  final List<Msg> _message = <Msg>[];
  TextEditingController sendMessage = TextEditingController();
  bool isWriting = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    defaultUserName = title;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title),),
      body: new Column(
        children: <Widget>[
           new Flexible(
             child: new ListView.builder(
                 itemBuilder: (_,int index) => _message[index],
                 itemCount: _message.length,
                 reverse: true,
                 padding: new EdgeInsets.all(6.0),
             ),

           ),
          Divider(height: 1.0,),
          new Container(
            child:_buildComposer() ,
            decoration: new BoxDecoration(color: Colors.white70),
          )
        ],
      ),

    );
  }
  Widget _buildComposer(){
    return new IconTheme(
      data: new IconThemeData(color: Colors.blue),
      child: new Container(
        margin: EdgeInsets.symmetric(horizontal: 9),
        child: new Row(
          children: <Widget>[
            new Flexible(
                child: new TextField(
                  controller: sendMessage,
                  onChanged: (String txt){
                    setState(() {
                      isWriting = txt.length> 0;
                    });
                  },
                  onSubmitted: _submitMsg,
                  decoration: new InputDecoration.collapsed(hintText: 'Enter Some text to send message'),

                )
            ),
            new Container(
                margin: new EdgeInsets.symmetric(horizontal: 3.0),
                child: Theme.of(context).platform == TargetPlatform.iOS
                    ? new CupertinoButton(
                    child: new Text("Submit"),
                    onPressed: isWriting ? () => _submitMsg(sendMessage.text)
                        : null
                )
                    : new IconButton(
                  icon: new Icon(Icons.send),
                  onPressed: isWriting
                      ? () => _submitMsg(sendMessage.text)
                      : null,
                )
            ),
          ],
        ),
          decoration: Theme.of(context).platform == TargetPlatform.iOS
              ? new BoxDecoration(
              border:
              new Border(top: new BorderSide(color: Colors.brown))) :
          null
      ),
    );
  }
  void _submitMsg(String txt) {
    sendMessage.clear();
    setState(() {
      isWriting = false;
    });
    Msg msg = new Msg(
      txt: txt,
      animationController: new AnimationController(
          vsync: this,
          duration: new Duration(milliseconds: 800)
      ),
    );
    setState(() {
      _message.insert(0, msg);
    });
    msg.animationController.forward();
  }
  @override
  void dispose() {
    for (Msg msg in _message) {
      msg.animationController.dispose();
    }
    super.dispose();
  }
}

class Msg extends StatelessWidget {
  Msg({this.txt, this.animationController});
  final String txt;
  final AnimationController animationController;

  @override
  Widget build(BuildContext ctx) {
    return new SizeTransition(
      sizeFactor: new CurvedAnimation(
          parent: animationController, curve: Curves.easeOut),
      axisAlignment: 0.0,
      child: new Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        child: new Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Container(
              margin: const EdgeInsets.only(right: 18.0),
              child: new CircleAvatar(child: new Text(defaultUserName)),
            ),
            new Expanded(
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Text(defaultUserName, style: Theme.of(ctx).textTheme.subhead),
                  new Container(
                    margin: const EdgeInsets.only(top: 6.0),
                    child: new Text(txt),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}