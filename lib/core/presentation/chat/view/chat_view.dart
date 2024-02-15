import 'package:deride_user/core/presentation/chat/widget/chat_bottom_textfeild.dart';
import 'package:deride_user/core/presentation/chat/widget/chat_top_view.dart';
import 'package:deride_user/core/presentation/request/provider/socket_provider.dart';
import 'package:deride_user/utils/app_constant/app_colors.dart';
import 'package:deride_user/utils/extensions/sizebox_extension.dart';
import 'package:deride_user/utils/widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../network/locator/locator.dart';

class ChatView extends StatefulWidget {
  String? image;
  String? name;

  ChatView({super.key, this.name, this.image});
  static const routeName = '/chatView';

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  final socketProvider = locator<SocketProvider>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    socketProvider.joinRoom();
    socketProvider.listenGetChat();
    socketProvider.messageCnt=TextEditingController();
  }

  @override
  void dispose() {
    socketProvider.ExitRoom();
    socketProvider.updateUnreadCount("0");
    socketProvider.messageCnt.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PopScope(
        canPop: true,
        onPopInvoked: (didPop) {
          FocusScope.of(context).unfocus();
        },
        child: SafeArea(
          child: Column(
            children: [
              const ChatTopView(),
              context.sizeH(1),
              Container(
                height: 1,
                width: context.screenWidth,
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                      offset: const Offset(2, 0),
                      blurRadius: 50,
                      spreadRadius: 0,
                      color: AppColors.color001E00.withOpacity(0.02))
                ]),
              ),
              Expanded(
                flex: 4,
                child: Consumer<SocketProvider>(builder: (context, provider, _) {
                  return Container(
                    color: AppColors.colorEFEDED,
                    child: Column(
                      children: [
                        context.sizeH(2),
                        Expanded(
                          child: CustomScrollView(
                            reverse: true,
                            slivers: [
                              SliverList(
                                  delegate: SliverChildBuilderDelegate(
                                      childCount: provider.chatList.length,
                                      (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: provider.chatList[index].senderType !=
                                          'Driver'
                                      ? Align(
                                          alignment: Alignment.topRight,
                                          child: Container(
                                            constraints: BoxConstraints(
                                                maxWidth:
                                                    context.screenWidth * 0.7),
                                            decoration: const BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                    topRight: Radius.circular(15),
                                                    topLeft: Radius.circular(15),
                                                    bottomLeft:
                                                        Radius.circular(0),
                                                    bottomRight:
                                                        Radius.circular(15)),
                                                color: Colors.black),
                                            child: Padding(
                                              padding: const EdgeInsets.all(15.0),
                                              child: TextWidget(
                                                msg: provider
                                                    .chatList[index].message,
                                                color: AppColors.colorWhite,
                                              ),
                                            ),
                                          ),
                                        )
                                      : Align(
                                          alignment: Alignment.topLeft,
                                          child: Container(
                                            constraints: BoxConstraints(
                                                maxWidth:
                                                    context.screenWidth * 0.7),
                                            decoration: const BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                    topRight: Radius.circular(15),
                                                    topLeft: Radius.circular(15),
                                                    bottomLeft:
                                                        Radius.circular(15)),
                                                color: AppColors.colorWhite),
                                            child: Padding(
                                              padding: const EdgeInsets.all(15.0),
                                              child: TextWidget(
                                                msg: provider
                                                    .chatList[index].message,
                                                color: AppColors.color001E00,
                                              ),
                                            ),
                                          ),
                                        ),
                                );
                              }))
                            ],
                          ),
                        ),
                        const ChatBottomTextfeildView()
                      ],
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
