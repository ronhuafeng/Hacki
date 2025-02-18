import 'package:flutter/material.dart';
import 'package:flutter_fadein/flutter_fadein.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:hacki/models/models.dart';
import 'package:hacki/screens/widgets/widgets.dart';
import 'package:hacki/utils/link_util.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class InboxView extends StatelessWidget {
  const InboxView({
    Key? key,
    required this.refreshController,
    required this.comments,
    required this.unreadCommentsIds,
    required this.onCommentTapped,
    required this.onMarkAllAsReadTapped,
    required this.onLoadMore,
    required this.onRefresh,
  }) : super(key: key);

  final RefreshController refreshController;
  final List<Comment> comments;
  final List<int> unreadCommentsIds;
  final Function(Comment) onCommentTapped;
  final VoidCallback onMarkAllAsReadTapped;
  final VoidCallback onLoadMore;
  final VoidCallback onRefresh;

  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(context).brightness == Brightness.dark
        ? Colors.white
        : Colors.black;
    return Column(
      children: [
        if (unreadCommentsIds.isNotEmpty)
          TextButton(
            onPressed: onMarkAllAsReadTapped,
            child: const Text('Mark all as read'),
          ),
        Expanded(
          child: SmartRefresher(
            enablePullUp: true,
            header: const WaterDropMaterialHeader(
              backgroundColor: Colors.orange,
            ),
            footer: CustomFooter(
              loadStyle: LoadStyle.ShowWhenLoading,
              builder: (context, mode) {
                Widget body;
                if (mode == LoadStatus.idle) {
                  body = const Text('');
                } else if (mode == LoadStatus.loading) {
                  body = const CustomCircularProgressIndicator();
                } else if (mode == LoadStatus.failed) {
                  body = const Text(
                    'loading failed.',
                  );
                } else if (mode == LoadStatus.canLoading) {
                  body = const Text(
                    'loading more.',
                  );
                } else {
                  body = const Text('');
                }
                return SizedBox(
                  height: 55,
                  child: Center(child: body),
                );
              },
            ),
            controller: refreshController,
            onLoading: onLoadMore,
            onRefresh: onRefresh,
            child: ListView(
              children: [
                ...comments.map((e) {
                  return [
                    FadeIn(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 6),
                        child: InkWell(
                          onTap: () => onCommentTapped(e),
                          child: Padding(
                            padding: EdgeInsets.zero,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Flex(
                                  direction: Axis.horizontal,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 8,
                                          horizontal: 6,
                                        ),
                                        child: Linkify(
                                          text: '${e.by} : ${e.text}',
                                          style: TextStyle(
                                            color:
                                                unreadCommentsIds.contains(e.id)
                                                    ? textColor
                                                    : Colors.grey,
                                          ),
                                          maxLines: 4,
                                          onOpen: (link) =>
                                              LinkUtil.launchUrl(link.url),
                                        ),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          e.postedDate,
                                          style: const TextStyle(
                                            color: Colors.grey,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 12,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const Divider(
                                  height: 0,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Divider(
                      height: 0,
                    ),
                  ];
                }).expand((element) => element),
                const SizedBox(
                  height: 40,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
