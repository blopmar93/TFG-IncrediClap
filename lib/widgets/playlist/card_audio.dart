
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:incredibclap/services/record_service.dart';
import 'package:incredibclap/themes/colors.dart';
import 'package:provider/provider.dart';

class CardAudio extends StatelessWidget {

  const CardAudio({
    Key? key,
    required this.id,
    required this.title,
    required this.onPressed,
    required this.userName,
    required this.isDeleted
  }) : super(key: key);
  
  final String title;
  final String userName;
  final String id;
  final Function onPressed;
  final bool isDeleted;

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    final rs = Provider.of<RecordService>(context);
           
    return GestureDetector(
      onTap: () => onPressed(),
      child: FadeIn(
        duration: const Duration(milliseconds: 500),
        child: _CardBackground( 
          size: size,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                
                SizedBox(
                  width: 100,
                  child: FadeInLeft(
                    duration: const Duration(milliseconds: 800),
                    child: const Image(
                      image: AssetImage('assets/backgrounds/backMusic1.jpg'),
                      alignment: Alignment.centerRight,  
                    ),
                  ),
                ),
                
      
                FadeInRight(
                  duration: const Duration(milliseconds: 800),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [ 
                
                      Text(
                        title,
                        style: GoogleFonts.righteous(
                          textStyle: const TextStyle(
                            color: ThemeColors.darkPrimary, 
                            fontSize: 40, 
                          ),
                        ) 
                      ),
                
                      Text(
                        userName,
                        style: GoogleFonts.righteous(
                          textStyle: const TextStyle(
                            color: ThemeColors.primary, 
                            fontSize: 20, 
                          ), 
                        )
                      ),

                    ]
                  ),
                ),

                isDeleted 
                
                 ? IconButton(
                    onPressed: (){rs.deleteAudiosUser(id);}, 
                    icon: const Icon(Icons.delete_forever, color: ThemeColors.darkPrimary)
                   )
                 : const Icon(Icons.delete_forever, color: Colors.transparent)
              ],
            ),
          ),
        ),
      ),
      
    );
  }
}




class _CardBackground extends StatelessWidget {

  const _CardBackground( { required this.child, required this.size } );

  final Widget child;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(15),
      height: size.height*.13,
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
            spreadRadius: 1,
            color: Colors.black26,
            offset: Offset(0,0),
            blurRadius: 2
          )
        ],
        color: Colors.white,
        borderRadius: BorderRadius.circular(5) 
      ),
      child: child,
    );
  }
}