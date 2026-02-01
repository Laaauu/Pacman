import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pacman/chemin.dart';
import 'package:pacman/fantome.dart';
import 'package:pacman/joueur.dart';
import 'package:pacman/pixel.dart';

class PageAccueil extends StatefulWidget {
  const PageAccueil({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PageAccueilState createState() => _PageAccueilState();
}

class _PageAccueilState extends State<PageAccueil> {

  static int nombreParLigne = 11;
  int nombreDeCarre = nombreParLigne * 17;
  List<int> bords =[
    0,1,2,3,4,5,6,7,8,9,10,11,22,33,44,55,66,77,99,110,121,132,143,154,165,176,177,178,179,180,181,182,183,184,185,186,175,164,153,142,131,120,109,87,76,65,54,43,32,21,
    78,79,80,100,101,102,84,85,86,106,107,108,24,35,46,57,30,41,52,63,81,70,59,61,72,83,26,28,37,38,39,123,134,145,156,129,140,151,162,103,114,125,105,116,127,147,148,149,158,160,
  ];
  List<int> nourriture =[];
  int positionJoueur = nombreParLigne * 15 + 1;
  String direction = "droite";
  bool preJeu = true;
  bool boucheFermee = false;
  int score = 0;
  int fantome = nombreParLigne*2-2;
  String directionFantome = "gauche";

  void lancementPartie(){
    if (preJeu){
      preJeu = false;
      ajoutNourriture();
      Duration duration = Duration(milliseconds: 120);
      Timer.periodic(duration, (timer){
        bougerFantome();
        
        setState(() {
         boucheFermee= !boucheFermee;
        });
        if(nourriture.contains(positionJoueur)){
          nourriture.remove(positionJoueur);
          score++;
        }
        if(positionJoueur==fantome){
         setState(() {
           positionJoueur = -1;
         });
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context){
              return AlertDialog(
                title: Center(child: Text("Vous êtes mort"),),
                content: Text("Votre Score: $score"),
                actions: [
                 GestureDetector(
                   onTap: (){
                     setState(() {
                        positionJoueur = nombreParLigne * 15 + 1;
                        fantome = nombreParLigne*2-2;
                        preJeu = false;
                        boucheFermee = false;
                        direction = "droite";
                        nourriture.clear();
                        ajoutNourriture();
                        score = 0;
                        Navigator.pop(context);
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.all(10.0),
                      child: const Text("Recommencer"),
                    ),
                  ),
                ],
              );
            }
          );
        }
        if(score == 87){
          setState(() {
            positionJoueur = -1;
          });
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context){
              return AlertDialog(
                title: Center(child: Text("Vous avez gagné"),),
                content: Text("Votre Score: $score"),
                actions: [
                  GestureDetector(
                    onTap: (){
                      setState(() {
                        positionJoueur = nombreParLigne * 15 + 1;
                        fantome = nombreParLigne*2-2;
                        preJeu = false;
                        boucheFermee = false;
                        direction = "droite";
                        nourriture.clear();
                        ajoutNourriture();
                        score = 0;
                        Navigator.pop(context);
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.all(10.0),
                      child: const Text("Rejouer"),
                    ),
                  ),
                ],
              );
            }
          );
        }
        switch (direction){
          case "gauche":
            deplacementGauche();
            break;
          case "droite":
            deplacementDroite();
            break;
          case "bas":
            deplacementBas();
            break;
          case "haut":
            deplacementHaut();
            break;
        }
      });
    }  
  }
  
  void bougerFantome (){
    switch (directionFantome){
      case "gauche":
        if(!bords.contains(fantome - 1)){
          setState(() {
            fantome --;
          });
        }else if (!bords.contains(fantome + nombreParLigne)){
          setState(() {
            fantome += nombreParLigne;
            directionFantome = "bas";
          });
        }else if (!bords.contains(fantome+1)){
          setState(() {
            fantome ++;
            directionFantome = "droite";
          });
        }else if (!bords.contains(fantome - nombreParLigne)){
          setState(() {
            fantome -= nombreParLigne;
            directionFantome = "haut";
          });
        }
        break;
      case "droite" :
        if(!bords.contains(fantome + 1)){
          setState(() {
            fantome ++;
          });
        }else if (!bords.contains(fantome - nombreParLigne)){
          setState(() {
            fantome -= nombreParLigne;
            directionFantome = "haut";
          });
        }else if (!bords.contains(fantome+ nombreParLigne)){
          setState(() {
            fantome += nombreParLigne;
            directionFantome = "bas";
          });
        }else if (!bords.contains(fantome - 1)){
          setState(() {
            fantome --;
            directionFantome = "gauche";
          });
        }
        break;
      case "haut" :
        if(!bords.contains(fantome - nombreParLigne)){
          setState(() {
            fantome -= nombreParLigne;
          });
        }else if (!bords.contains(fantome + 1)){
          setState(() {
            fantome ++;
            directionFantome = "droite";
          });
        }else if (!bords.contains(fantome-1)){
          setState(() {
            fantome --;
            directionFantome = "gauche";
          });
        }else if (!bords.contains(fantome + nombreParLigne)){
          setState(() {
            fantome += nombreParLigne;
            directionFantome = "bas";
          });
        }
        break;
      case "bas" :
        if(!bords.contains(fantome + nombreParLigne)){
          setState(() {
            fantome += nombreParLigne;
          });
        }else if (!bords.contains(fantome -1 )){
          setState(() {
            fantome --;
            directionFantome = "gauche";
          });
        }else if (!bords.contains(fantome+1)){
          setState(() {
            fantome ++;
            directionFantome = "droite";
          });
        }else if (!bords.contains(fantome - nombreParLigne)){
          setState(() {
            fantome -= nombreParLigne;
            directionFantome = "haut";
          });
        }
        break;
    }
  }

  void ajoutNourriture(){
    for(int i=0; i<nombreDeCarre; i++){
      if(!bords.contains(i)){
        nourriture.add(i);
      }
    }
  }

  void deplacementGauche(){
    if(!bords.contains(positionJoueur - 1)){
      if(positionJoueur == 88){
        setState(() {
          positionJoueur = 98;
        });
      }
      setState(() {
        positionJoueur--;
      });
    }
  }
  void deplacementDroite(){
    if(!bords.contains(positionJoueur + 1)){
      if(positionJoueur == 98){
        setState(() {
          positionJoueur = 88;
        });
      }
      setState(() {
        positionJoueur++;
      });
    }
  }
  void deplacementBas(){
    if(!bords.contains(positionJoueur + nombreParLigne)){
        setState(() {
          positionJoueur += nombreParLigne;
        });
    }
  }
  void deplacementHaut(){
    if(!bords.contains(positionJoueur - nombreParLigne)){
        setState(() {
          positionJoueur -= nombreParLigne;
        });
    }
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            flex: 5,
            child: GestureDetector(
              onVerticalDragUpdate: (details) {
                if(details.delta.dy > 0){
                  direction = "bas";
                }else if(details.delta.dy < 0){
                  direction = "haut";
                }
              },
              onHorizontalDragUpdate: (details){
                if(details.delta.dx > 0){
                  direction = "droite";
                }else if(details.delta.dx < 0){
                  direction = "gauche";
                }
              },
              child: Container(
                child: GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: nombreDeCarre,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: nombreParLigne,
                  ),
                  itemBuilder: (BuildContext context,int index){
                    if(boucheFermee && positionJoueur==index){
                      return Padding(
                        padding: EdgeInsets.all(4),
                        child : Container(
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(245, 182, 45, 1),
                            shape: BoxShape.circle,
                          ),
                        ),
                      );
                    } if(positionJoueur == index){
                      switch (direction){
                        case "gauche" : 
                          return Transform.rotate(angle: pi,child: Joueur(),);
                        case "droite" : 
                          return Joueur();
                        case "bas" : 
                          return Transform.rotate(angle: pi/2,child: Joueur(),);
                        case "haut" : 
                          return Transform.rotate(angle: 3*pi/2,child: Joueur(),);
                        default : 
                          return Joueur();
                      }
                    }else if (fantome == index){
                      switch (directionFantome){
                        case "gauche" : 
                          return Transform.flip(flipX: true, child: Fantome(),);
                        case "droite" : 
                          return Fantome();
                        case "bas" : 
                          return Transform.flip(flipY: true, child: Fantome(),);
                        case "haut" : 
                          return Fantome();
                        default : 
                          return Fantome();
                      }
                    } else if (bords.contains(index)){
                      return Pixel(
                        couleurInt: Colors.blue[800],
                        couleurExt: Colors.blue[900],
                      );
                    }else if(nourriture.contains(index) || preJeu){
                      return Chemin(
                        couleurInt: Colors.yellow,
                        couleurExt: Colors.black,
                      );
                    }else{
                       return Chemin(
                        couleurInt: Colors.black,
                        couleurExt: Colors.black,
                      );
                    }
                  },
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("Score: $score", style: TextStyle(color: Colors.white, fontSize: 40),),
                  GestureDetector(
                    onTap: lancementPartie,
                    child: Text("J O U E R ", style: TextStyle(color: Colors.white, fontSize: 40),)
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}