
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

Widget buildArticleItem(article, context) => Padding(
  padding: const EdgeInsets.all(20.0),
  child: Row(
    children: [
      Container(
        height: 15.h,
        width: 25.w,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            image: DecorationImage(
                image: NetworkImage('${article['urlToImage']}'),
                // image: NetworkImage('${article['image']}'),         //************** image of products*************
                fit: BoxFit.cover
            )
        ),
      ),
      SizedBox(width: 10.w,),
      Expanded(
        child: SizedBox(
          height: 120,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:  [
              Expanded(
                child: Text(
                  '${article['title']}',
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyText1,

                ),
              ),
              SizedBox(height: 1.h,),
              Text(
                '${article['publishedAt']}',
                // '${article['price']}',        // *************** price of products *********************
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),

              ),
            ],
          ),
        ),
      ),
    ],
  ),
);

Widget buildArticleBuilder(list, context) => ListView.separated(
  physics: const BouncingScrollPhysics(),
  itemBuilder: (context,index) => buildArticleItem(list[index], context),
  separatorBuilder: (context, index) => Padding(
    padding: const EdgeInsetsDirectional.only(start: 10),
    child: Container(
      width: double.infinity,
      height: 1.0,
      color: Colors.grey[300],
    ),
  ),
  itemCount: 10,
);

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  required String label,
  required IconData prefixIcn,
  required FormFieldValidator validate,
  Function(dynamic)? onSubm,
  Function(dynamic)? onChang,
  GestureTapCallback? tap,
  bool isPassword= false,
  IconData? suffixIcn,
  VoidCallback? suffixPressed,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      onFieldSubmitted: onSubm,
      onChanged: onChang,
      onTap: tap,
      validator: validate,
      obscureText: isPassword,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(
          prefixIcn,
        ),
        suffixIcon: suffixIcn!=null ? IconButton(
          onPressed: suffixPressed,
          icon: Icon(
            suffixIcn,
          ),
        ) : null ,
        border: OutlineInputBorder(),
      ),
    );
