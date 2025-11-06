import 'package:flutter/material.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/programs_and_workout/creater_screen/notification_provider/notification_provider.dart';
import 'package:provider/provider.dart';
import 'package:musculo_app/components/poppins_text.dart';
import 'package:musculo_app/components/shared_appbar.dart';
import 'package:musculo_app/core/constants/const_colors.dart';
import 'package:musculo_app/core/constants/sizes.dart';
import 'package:musculo_app/modules/bottom_navigation_bar/programs_and_workout/component/customlisttile.dart';
import '../component/notification_switch.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () =>
          Provider.of<NotificationProvider>(
            context,
            listen: false,
          ).loadNotifications(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<NotificationProvider>(context);

    if (provider.isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final grouped = {
      'General Notifications': ['phoneNotifications', 'emailNotifications'],
      'User Notifications': [
        'programOrWorkoutNameChanged',
        'programOrWorkoutPriceUpdated',
        'upcomingTrainingReminder',
        'refundNotice',
      ],
      'Creator Notifications': ['receiveFeedbackEmail', 'creatorCancelNotice'],
    };

    final titles = {
      'phoneNotifications': 'Phone Notifications',
      'emailNotifications': 'Email Notifications',
      'programOrWorkoutNameChanged': 'Program or Workout Name Changed',
      'programOrWorkoutPriceUpdated': 'Program or Workout Price Updated',
      'upcomingTrainingReminder': 'Upcoming Training Reminder',
      'refundNotice': 'Refund Notice Before Cancelling Program or Workout',
      'receiveFeedbackEmail': 'Receive Feedback via Email',
      'creatorCancelNotice': 'Notice Before Cancelling Your Program or Workout',
    };

    return Scaffold(
      backgroundColor: ConstColors.white,
      appBar: SharedAppBar(title: 'Notifications'),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Sizes.s16,
          vertical: Sizes.s20,
        ),
        child: ListView(
          children:
              grouped.entries.map((group) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    PoppinsText(
                      text: group.key,
                      fontSize: Sizes.s17,
                      fontWeight: FontWeight.w600,
                    ),
                    const SizedBox(height: 24),
                    ...group.value.map((key) {
                      return CustomListTile(
                        padding: EdgeInsets.zero,
                        title: titles[key]!,
                        titleFontweight: FontWeight.w500,
                        titleFont: Sizes.s15,
                        trailing: NotificationSwitch(
                          useCupertino: true,
                          value: provider.notifications[key] ?? false,
                          onChanged:
                              (value) =>
                                  provider.updateNotification(key, value),
                        ),
                      );
                    }),
                    const SizedBox(height: 20),
                  ],
                );
              }).toList(),
        ),
      ),
    );
  }
}
