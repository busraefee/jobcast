import 'package:flutter/material.dart';
import 'package:jobjob/models/homemodel.dart';
import 'package:jobjob/models/usermodel.dart';
import 'package:kartal/kartal.dart';
import '../../feature/descriptionPage/view/description_page_view.dart';
import '../../feature/favoritePage/favorite_page_view.dart';

class CustomCard extends StatelessWidget {
  final JobsModel job;
  final UserModel user;
  const CustomCard({Key? key, required this.job, required this.user})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DescriptionPageView(
                job: job,
                user: user,
              ),
            ));
      },
      child: Card(
        child: Column(
          children: [
            ListTile(
              leading: SizedBox(
                  child: job.jobImage != null
                      ? Image.network(job.jobImage ?? "")
                      : Image.network("https://picsum.photos/400/300")),
              title: Text(
                job.jobName ?? "",
                maxLines: 2,
              ),
              subtitle: Text(
                job.jobDetail ?? "",
                maxLines: 2,
              ),
              trailing: IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FavoriteView(),
                        ));
                  },
                  icon: Icon(Icons.star)),
            ),
            Padding(
              padding: context.paddingLow,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(job.jobTime ?? "sdasdads"),
                  Text(job.cost ?? "")
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
