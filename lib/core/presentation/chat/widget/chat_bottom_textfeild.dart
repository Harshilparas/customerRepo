import 'package:deride_user/core/presentation/request/provider/socket_provider.dart';
import 'package:deride_user/utils/app_constant/app_colors.dart';
import 'package:deride_user/utils/app_constant/app_image_strings.dart';
import 'package:deride_user/utils/extensions/image_extensions.dart';
import 'package:deride_user/utils/extensions/sizebox_extension.dart';
import 'package:deride_user/utils/extensions/validation_extension.dart';
import 'package:deride_user/utils/fonts.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatBottomTextfeildView extends StatelessWidget {
  const ChatBottomTextfeildView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SocketProvider>(
      builder: (context,sendMesasgs,_) {
        return Column(
          children: [
            Container(
              height: 1,
              width: context.screenWidth,
              color: AppColors.colorWhite,
            ),
            Container(
              color: AppColors.colorEFEDED,
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
                child: Container(
                  height: context.screenHeight * 0.06,
                  width: context.screenWidth,
                  decoration: BoxDecoration(
                      color: AppColors.colorWhite,
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: sendMesasgs.messageCnt,
                            decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: "Enter message...",
                                hintStyle: TextStyle(
                                    fontFamily: FontMixin.regularFamily,
                                    fontWeight: FontMixin.fontWeightRegular,
                                    fontSize: 16,
                                    color: Colors.black)),
                          ),
                        ),
                        InkWell(
                          onTap: (){

                            if(sendMesasgs.messageCnt.text.trim().isNotEmpty){
                              sendMesasgs.sendMessage(message: sendMesasgs.messageCnt.text.trim());
                            }else{
                              context.showAnimatedToast('Please Enter Message');
                            }

                          },
                          child: SizedBox(
                            height: 25,
                            width: 25,
                            child: AppImagesPath.iconSend.svg,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      }
    );
  }
}
