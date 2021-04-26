import 'package:flutter/material.dart';
import 'package:void_chat_beta/contacts/bloc/contact_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:void_chat_beta/styles.dart';
import 'package:void_chat_beta/generated/l10n.dart';

class IncomingPendingRequestTile extends StatefulWidget {
  final String username;
  final String id;
  final String message;
  final String requestSentAt;
  IncomingPendingRequestTile({
    Key key,
    this.username: '',
    this.id: '',
    this.message: '',
    this.requestSentAt: '',
  }) : super(key: key);

  @override
  _IncomingPendingRequestTileState createState() =>
      _IncomingPendingRequestTileState();
}

class _IncomingPendingRequestTileState extends State<IncomingPendingRequestTile>
    with TickerProviderStateMixin {
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _playAnimation() async {
    try {
      if (_animationController.status == AnimationStatus.completed) {
        _animationController.reverse().orCancel;
      } else if (_animationController.status == AnimationStatus.dismissed) {
        _animationController.forward().orCancel;
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Stack(
        children: [
          StageredAnimation(
            controller: _animationController,
            id: widget.id,
            message: widget.message,
            requestSentAt: widget.requestSentAt,
            username: widget.username,
          ),
          Positioned(
            right: 0,
            bottom: 0,
            child: Transform.translate(
              offset: const Offset(20, 0),
              child: MaterialButton(
                onPressed: () {
                  _playAnimation();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class StageredAnimation extends StatelessWidget {
  final String username;
  final String id;
  final String message;
  final String requestSentAt;
  StageredAnimation({
    Key key,
    this.controller,
    this.username,
    this.id,
    this.message,
    this.requestSentAt,
  })  : totalHeight = Tween<double>(begin: 80, end: 160).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(0.0, 0.5, curve: Curves.easeIn),
          ),
        ),
        rseHeight = Tween<double>(begin: 0.0, end: 160.0).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(0.5, 1.0, curve: Curves.easeIn),
          ),
        ),
        rssHeight = Tween<double>(begin: 80, end: 0).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(0.0, 0.5, curve: Curves.easeIn),
          ),
        ),
        imageOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(0.8, 1, curve: Curves.easeIn),
          ),
        ),
        imageHeight = Tween<double>(begin: 0.0, end: 40.0).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(0.0, 0.5, curve: Curves.easeIn),
          ),
        ),
        buttonsHeight = Tween<double>(begin: 39.5, end: 39.5).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(0.8, 0.8, curve: Curves.easeIn),
          ),
        ),
        super(key: key);

  final AnimationController controller;
  final Animation<double> totalHeight;
  final Animation<double> rseHeight;
  final Animation<double> rssHeight;
  final Animation<double> imageOpacity;
  final Animation<double> imageHeight;
  final Animation<double> buttonsHeight;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(animation: controller, builder: _buildAnimation);
  }

  Widget _buildAnimation(BuildContext context, Widget child) {
    return SingleChildScrollView(
      child: Row(
        children: [
          Container(
            width: 50,
            height: totalHeight.value,
            decoration: BoxDecoration(
              color: Theme.of(context).backgroundColor,
            ),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  height: buttonsHeight.value,
                  width: double.infinity,
                  child: IconButton(
                    icon: Icon(Icons.add, color: Colors.green[700]),
                    onPressed: () => context.read<ContactBloc>().add(
                          AcceptFriendshipRequest(
                            contactId: id,
                          ),
                        ),
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor.withOpacity(0.5),
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 0.5),
                Opacity(
                  opacity: imageOpacity.value,
                  child: Container(
                    height: imageHeight.value,
                    width: 50,
                    color: Theme.of(context).backgroundColor,
                    child: CircleAvatar(
                        backgroundImage:
                            Image.asset('assets/images/avatar-placeholder.png')
                                .image),
                  ),
                ),
                const SizedBox(height: 0.5),
                Container(
                  width: double.infinity,
                  height: buttonsHeight.value,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor.withOpacity(0.5),
                    borderRadius: BorderRadius.only(
                      bottomLeft: const Radius.circular(10),
                    ),
                  ),
                  // height: 30,
                  child: IconButton(
                    icon: Icon(Icons.cancel_outlined, color: Colors.red[800]),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                RightSideShort(
                  rssHeight: rssHeight,
                  username: username,
                  id: id,
                ),
                RightSideExpanded(
                  rseHeight: rseHeight,
                  id: id,
                  username: username,
                  requestSentAt: requestSentAt,
                  message: message,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class RightSideExpanded extends StatelessWidget {
  final String username;
  final String id;
  final String message;
  final String requestSentAt;
  const RightSideExpanded({
    Key key,
    @required this.rseHeight,
    this.username: '',
    this.id: '',
    this.message: '',
    this.requestSentAt: '',
  }) : super(key: key);

  final Animation<double> rseHeight;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.only(left: 0),
          height: rseHeight.value,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor.withOpacity(0.5),
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(10),
              bottomRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
            ),
          ),
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(width: 7),
                    Text(
                      S.of(context).contacts_user,
                      style: TextStyles.body2,
                    ),
                    const SizedBox(width: 7),
                    Text(
                      username,
                      style: TextStyles.body2,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(width: 7),
                    Text(
                      S.of(context).contacts_id,
                      style: TextStyles.body2,
                    ),
                    const SizedBox(width: 7),
                    Text(
                      id,
                      style: TextStyles.body2,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(width: 7),
                    Text(
                      S.of(context).contacts_sent_at,
                      style: TextStyles.body2,
                    ),
                    const SizedBox(width: 7),
                    Text(
                      requestSentAt,
                      style: TextStyles.body2,
                    ),
                  ],
                ),
                Divider(
                  color: Theme.of(context).backgroundColor,
                  indent: 7,
                  endIndent: 7,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 7),
                  padding: const EdgeInsets.all(3),
                  height: 80,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(
                        width: 0.5, color: Theme.of(context).primaryColor),
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                    color: Theme.of(context).backgroundColor.withOpacity(0.35),
                  ),
                  child: Text(
                    message,
                    style: TextStyles.body2,
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 3,
          right: 3,
          child: Container(
            alignment: Alignment.center,
            width: 25,
            height: 25,
            decoration: BoxDecoration(
              color: Theme.of(context).backgroundColor.withOpacity(0.5),
              border:
                  Border.all(width: 1, color: Theme.of(context).primaryColor),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Transform.translate(
              offset: const Offset(-4, -4),
              child: Icon(Icons.arrow_drop_up_sharp,
                  size: 32, color: Theme.of(context).primaryColor),
            ),
          ),
        ),
      ],
    );
  }
}

class RightSideShort extends StatelessWidget {
  final String id;
  final String username;
  const RightSideShort({
    Key key,
    @required this.rssHeight,
    this.username: '',
    this.id,
  }) : super(key: key);

  final Animation<double> rssHeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 0),
      width: double.infinity,
      height: rssHeight.value,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(0.5),
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
      ),
      child: SingleChildScrollView(
        child: Row(
          children: [
            Container(
              width: 55,
              height: 80,
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () => context.read<ContactBloc>().add(
                          AcceptFriendshipRequest(
                            contactId: id,
                          ),
                        ),
                    child: Container(
                      height: 39.5,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        S.of(context).contacts_accept,
                        style: TextStyles.body2,
                      ),
                    ),
                  ),
                  Container(
                    width: 55,
                    height: 1,
                    color: Theme.of(context).backgroundColor,
                  ),
                  GestureDetector(
                    onTap: () => context.read<ContactBloc>().add(
                          RemoveContactRequest(
                            contactId: id,
                          ),
                        ),
                    child: Container(
                      height: 39.5,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        S.of(context).contacts_reject,
                        style: TextStyles.body2,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Stack(
              children: [
                ClipOval(
                  child: Container(
                    height: 80,
                    width: 80,
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image:
                            AssetImage('assets/images/avatar-placeholder.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    foregroundDecoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(context)
                              .primaryColor, // background color
                          // color: Color(0xffe0e5ec), // background color
                          spreadRadius: -8.0,
                          blurRadius: 50.0,
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 1,
                  left: 59,
                  child: IncomingIndicator(),
                ),
              ],
            ),
            Expanded(
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    height: 39.5,
                    child: Text(
                      username,
                      style: TextStyles.body2,
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 1,
                    color: Theme.of(context).backgroundColor,
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: 39.5,
                    child: Text(
                      S.of(context).contacts_more_info,
                      style: TextStyles.body2,
                    ),
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

class IncomingIndicator extends StatelessWidget {
  const IncomingIndicator({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        color: const Color(0xFF0E8114),
        border: Border.all(width: 1, color: Theme.of(context).primaryColor),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Transform.translate(
        offset: const Offset(-2, -2),
        child: Icon(
          Icons.keyboard_arrow_left_sharp,
          color: Theme.of(context).primaryColor,
          size: 22,
        ),
      ),
    );
  }
}
