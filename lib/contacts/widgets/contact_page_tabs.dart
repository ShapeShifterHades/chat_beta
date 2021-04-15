import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:void_chat_beta/blocs/contactlist/contactlist_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:void_chat_beta/ui/frontside/status_bar/screen_tag.dart';
import 'package:get/get.dart';

class ContactPageTabs extends StatefulWidget {
  const ContactPageTabs({
    Key key,
  }) : super(key: key);

  @override
  _ContactPageTabsState createState() => _ContactPageTabsState();
}

class _ContactPageTabsState extends State<ContactPageTabs> {
  DropListModel dropListModel = DropListModel([
    OptionItem(id: "2", title: 'contacts_pending'.tr),
    OptionItem(id: "3", title: 'contacts_blocked'.tr)
  ]);
  OptionItem optionItemSelected =
      OptionItem(id: "1", title: 'contacts_friends'.tr);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 260,
      child: SelectDropList(
        optionItemSelected,
        dropListModel,
        (optionItem) {
          optionItemSelected = optionItem;
          setState(() {});
        },
      ),
    );
  }
}

class DropListModel {
  DropListModel(this.listOptionItems);

  final List<OptionItem> listOptionItems;
}

class OptionItem {
  final String id;
  final String title;

  OptionItem({@required this.id, @required this.title});
}

class SelectDropList extends StatefulWidget {
  final OptionItem itemSelected;
  final DropListModel dropListModel;
  final Function(OptionItem optionItem) onOptionSelected;

  SelectDropList(this.itemSelected, this.dropListModel, this.onOptionSelected);

  @override
  _SelectDropListState createState() =>
      _SelectDropListState(itemSelected, dropListModel);
}

class _SelectDropListState extends State<SelectDropList>
    with SingleTickerProviderStateMixin {
  OptionItem optionItemSelected;
  final DropListModel dropListModel;

  AnimationController expandController;
  Animation<double> animation;

  bool isShow = false;

  _SelectDropListState(this.optionItemSelected, this.dropListModel);

  @override
  void initState() {
    super.initState();
    expandController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 350));
    animation = CurvedAnimation(
      parent: expandController,
      curve: Curves.fastOutSlowIn,
    );
    _runExpandCheck();
  }

  void _runExpandCheck() {
    if (isShow) {
      expandController.forward();
    } else {
      expandController.reverse();
    }
  }

  @override
  void dispose() {
    expandController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          margin: const EdgeInsets.only(top: 10, left: 10),
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            color: Theme.of(context).backgroundColor,
            border:
                Border.all(color: Theme.of(context).primaryColor, width: 0.3),
          ),
          child: GestureDetector(
            onTap: () {
              this.isShow = !this.isShow;
              _runExpandCheck();
              setState(() {});
            },
            child: Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                    child: Text(
                  optionItemSelected.title,
                  style: GoogleFonts.jura(
                    fontWeight: FontWeight.w300,
                    fontSize: 18,
                    color: Theme.of(context).primaryColor,
                  ),
                )),
                Align(
                  alignment: Alignment(1, 0),
                  child: Icon(
                    isShow ? Icons.arrow_drop_down : Icons.arrow_right,
                    color: Theme.of(context).primaryColor,
                    size: 25,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizeTransition(
            axisAlignment: 1.0,
            sizeFactor: animation,
            child: Container(
                margin: const EdgeInsets.only(bottom: 10, left: 10),
                padding: const EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: const Radius.circular(20),
                      bottomRight: const Radius.circular(20)),
                  color: Theme.of(context).backgroundColor,
                  border: Border.all(
                      color: Theme.of(context).primaryColor, width: 0.3),
                ),
                child: _buildDropListOptions(
                    dropListModel.listOptionItems, context))),
//          Divider(color: Colors.grey.shade300, height: 1,)
      ],
    );
  }

  Column _buildDropListOptions(List<OptionItem> items, BuildContext context) {
    return Column(
      children: items.map((item) => _buildSubMenu(item, context)).toList(),
    );
  }

  Widget _buildSubMenu(OptionItem item, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, top: 5, bottom: 5),
      child: GestureDetector(
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                child: Text(item.title,
                    style: GoogleFonts.jura(
                      fontWeight: FontWeight.w300,
                      fontSize: 18,
                      color: Theme.of(context).primaryColor,
                    ),
                    maxLines: 3,
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.ellipsis),
              ),
            ),
          ],
        ),
        onTap: () {
          this.optionItemSelected = item;
          isShow = false;
          expandController.reverse();
          widget.onOptionSelected(item);
        },
      ),
    );
  }
}

class _BlockTab extends StatelessWidget {
  const _BlockTab({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool active = context.watch<ContactlistBloc>().state is BlocklistState;

    return ScreenTag(
      child: GestureDetector(
        onTap: () {
          context.read<ContactlistBloc>().add(BlocklistClicked());
        },
        child: AnimatedContainer(
          duration: Duration(milliseconds: 700),
          width: active ? 160 : 80,
          height: 62,
          color: active
              ? Theme.of(context).backgroundColor
              : Theme.of(context).primaryColor,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Center(
              child: Text(
                'contacts_blocked'.tr,
                style: GoogleFonts.jura(
                  fontWeight: FontWeight.w300,
                  fontSize: 18,
                  color: active
                      ? Theme.of(context).primaryColor
                      : Theme.of(context).backgroundColor,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _PendingTab extends StatelessWidget {
  const _PendingTab({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool active = context.watch<ContactlistBloc>().state is PendinglistState;

    return ScreenTag(
      child: GestureDetector(
        onTap: () {
          context.read<ContactlistBloc>().add(PendinglistClicked());
        },
        child: AnimatedContainer(
          duration: Duration(milliseconds: 700),
          width: active ? 160 : 80,
          height: 32,
          color: active
              ? Theme.of(context).backgroundColor
              : Theme.of(context).primaryColor,
          child: Center(
            child: Text(
              'contacts_pending'.tr,
              style: GoogleFonts.jura(
                fontWeight: FontWeight.w300,
                fontSize: 18,
                color: active
                    ? Theme.of(context).primaryColor
                    : Theme.of(context).backgroundColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _FriendTag extends StatelessWidget {
  const _FriendTag({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool active = context.watch<ContactlistBloc>().state is FriendlistState;
    return GestureDetector(
      onTap: () {
        context.read<ContactlistBloc>().add(
              FriendlistClicked(),
            );
      },
      child: ScreenTag(
        child: AnimatedContainer(
          duration: Duration(milliseconds: 700),
          width: active ? 160 : 80,
          height: 62,
          color: active
              ? Theme.of(context).backgroundColor
              : Theme.of(context).primaryColor,
          child: Center(
            child: Text(
              'contacts_friends'.tr,
              style: GoogleFonts.jura(
                fontWeight: FontWeight.w300,
                fontSize: 18,
                color: active
                    ? Theme.of(context).primaryColor
                    : Theme.of(context).backgroundColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
