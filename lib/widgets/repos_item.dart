import 'package:flutter/material.dart';
import 'package:flutter_application/common/component_index.dart';

class ReposItem extends StatelessWidget {
  final String labelId;
  final ReposModel model;
  final bool isHome;

  const ReposItem(
    this.model,
    {
      this.labelId,
      Key key,
      this.isHome
    }):super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {

      },
      child: Container(
        height: 160.0,
        padding: EdgeInsets.only(left: 16, top: 16, right: 16, bottom: 10),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    model.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyles.listTitle,
                  ),
                  Gaps.vGap10,
                  Expanded(
                    flex: 1,
                    child: Text(
                      model.desc,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                      style: TextStyles.listContent,
                    ),
                  ),
                  Gaps.vGap5,
                  Row(
                    children: <Widget>[
                      // TODO like button
                      LikeBtn(),
                      Gaps.hGap10,
                      Text(
                        model.author,
                        style: TextStyles.listExtra,
                      ),
                      Gaps.hGap10,
                      Text(
                        Utils.getTimeLine(context, model.publishTime),
                        style: TextStyles.listExtra,
                      )
                    ],
                  )
                ],
              ),
            ),
            Container(
              width: 72,
              alignment: Alignment.center,
              margin: EdgeInsets.all(10.0),
              child: CachedNetworkImage(
                width: 72,
                height: 128,
                fit: BoxFit.fill,
                imageUrl: model.envelopePic,
                placeholder: (BuildContext context, String url) {
                  return ProgressView();
                },
                errorWidget: (BuildContext context, String url, Object error) {
                  return Icon(Icons.error);
                },
              ),
            )
          ],
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(width: 0.33, color: Colours.divider)
          )
        ),
      ),
    );
  }
}