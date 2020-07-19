import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:flutter_icons/flutter_icons.dart';

import '../../../constants/colors.dart';
import '../../../models/models.dart';
import '../../common/common.dart';

class InviteCard extends StatelessWidget {
  const InviteCard({
    @required this.invite,
    this.isReceived = false,
    Key key,
  }) : super(key: key);
  final Invite invite;
  final bool isReceived;

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      shadowColor: AppColors.inviteContainerShadow,
      offset: const Offset(0, 20),
      spreadRadius: 10,
      blurRadius: 40,
      child: SizedBox(
        width: 260,
        height: 124,
        child: Padding(
          padding: const EdgeInsets.only(
            left: 16,
            top: 16,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 28,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: invite.categories.length,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 0,
                      color: AppColors.inviteCardIcon,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 8,
                            right: 8,
                            top: 4,
                            bottom: 4,
                          ),
                          child: Text(
                            invite.categories[index],
                            style: const TextStyle(
                              color: AppColors.inviteCardText,
                              letterSpacing: .5,
                              fontSize: 10,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const VerticalSpacer(
                space: 4,
              ),
              Text(
                isReceived ? invite.sender.name : invite.receiver.name,
                style: const TextStyle(
                  fontSize: 23,
                  letterSpacing: .5,
                ),
              ),
              const VerticalSpacer(
                space: 12,
              ),
              Row(
                children: [
                  const Icon(
                    SimpleLineIcons.calendar,
                    color: AppColors.inviteCardIcon,
                    size: 13,
                  ),
                  const HorizontalSpacer(),
                  Text(
                    timeago.format(
                      DateTime.fromMillisecondsSinceEpoch(invite.date),
                    ),
                    style: const TextStyle(
                      fontSize: 13,
                      letterSpacing: .5,
                      color: AppColors.inviteCardText,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
