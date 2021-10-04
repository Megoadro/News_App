import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:news_app/modules/web_view/web_view_screen.dart';


Widget buildArticleItem (article,  context ) =>  InkWell(
  onTap: (){
    navigateTo(context, WebViewScreen(article['url']));
  },
  child:   Padding(
    padding: const EdgeInsets.all(15),
    child: Row(
      children: [
        Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: NetworkImage(
                    '${article['urlToImage']}'),
                fit: BoxFit.cover,
              )),
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: Container(
            height: 120,
            child: Column(
              //mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    '${article['title']}',
                    style: Theme.of(context).textTheme.bodyText1,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    //  textAlign: ,
                  ),
                ),
                Text(
                  '${article['publishedAt']}',
                  style: TextStyle(
                    fontSize: 15,
                    // fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  ),
);
Widget articleBuilder (list,context) => ConditionalBuilder(
  // بيشوف لو الداتا مش جاهزه او ال api فيه مشكله يكون في صفحة تحميل من غير م يجيب ايرور
  condition: list.length > 0,
  //هبدا ابني اللليست بتاعتي علي ctx  الل واقف عليها
  builder: (context) =>
      ListView.separated(
        //عشان الاسكرول كله ينزل لتحت يعمل زي شيفتنج كدا
        physics: BouncingScrollPhysics(),
        //الايتم الواحد هيكون عباره عن تصميم الللس موجود في compenents  عبارة عن الصورة و التكست
        itemBuilder: (context, index) =>
            buildArticleItem(list[index],context),
        // دا الخط الفاصل بين كل card
        separatorBuilder:
            (context, index) => Padding(
          padding: const EdgeInsets.all(5),
          child: Container(
            height: 2,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
        // دا عدد الايتمز الل هيكونو في الاسكرينه
        itemCount: 10,
      ),

  fallback: (context) => Center(child: CircularProgressIndicator()),

);
Widget defaultFormField({
  @required TextEditingController controller,
  @required TextInputType type,
  Function onSubmit,
  Function onChange,
  Function onTap,
  bool isPassword = false,
  @required Function validate,
  @required String label,
  @required IconData prefix,
  IconData suffix,
  Function suffixPressed,
  bool isClickable = true,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      enabled: isClickable,
      onFieldSubmitted: onSubmit,
      onChanged: onChange,
      onTap: onTap,
      validator: validate,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: suffix != null
            ? IconButton(
          onPressed: suffixPressed,
          icon: Icon(
            suffix,
          ),
        )
            : null,
        border: OutlineInputBorder(),
      ),
    );

void navigateTo(context, widget) => Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => widget,
  ),
);

