// Baurzhan Tair. Groupe: G1
// Num étudiant: 22212381 
PShape terrain, pylone, eolienne; // Les formes du terrain et des pylones
PImage terrainImage;    // L'image pour la texture du terrain
PShader shader;        // Le shader pour appliquer des effets viuels

// Les params de caméra
float camX = 0;    // Position en X de la caméra
float camY = 0;    // Position en Y de la caméra
float camZ = 50;    // Position en Z de la caméra


// Limites du terrain sur les axes X et Y
float minTerrainX = -135;  // Valeur minimale sur l'axe de X
float maxTerrainX = 127;  // Valeur maximale sur l'axe de X

float minTerrainY = -158;  // Valeur minimale sur l'axe de Y
float maxTerrainY = 159;  // Valeur maximale sur l'axe de Y

int nbPylones = 25; //  Nombre de pylônes à dessiner sur le terrain
int taillePylone = 50; // Taille d'un pylône
int tailleEolienne = 50; // Taille d'une éolienne
int taillePale = 25;    // Taille d'une pale

float newMouseX = 0;  // Dernière position X de la souris
float newMouseY = 0;  // Dernière position Y de la souris

void setup() {
  size(1700, 1055, P3D);  // La taille de la fenêtre en pixels et le mode 3D
  terrain = loadShape("hypersimple.obj");  //Chargement de la forme du terrain 
  shader = loadShader("FragmentShader.glsl","VertexShader.glsl");  // Chargement des shaders 
  terrainImage = loadImage("StAuban_texture.jpg");  // Chargement l'image de texture du terrain
  creerPylone();  // La création de la forme du pylone en utilisant la fonction
  // creerEolienne(); La partie 5 du projet 
}

void draw() {  
  background(200); // La couleur du fond
  //perspective();
  perspective(PI/3.0, float(width)/float(height), 1, (height / 2.0) / tan(PI * 60.0/360.0));  // La configuration de la perspective du caméra
  // Utilisation du shader pour la texture du terrain
  shader(shader);
  shader.set("Image", terrainImage);
  
  // La configuration des lumières et de caméra
  lights();
  
  camera(camX, camY, camZ, 0, 0, 0, 0, 1, 0);
  
  // Affichage du terrain
  translate(5, -150, -120);  // Pour ajuster la position du terrain 
  rotateX(-30);              // Rotation sur l'axe X pour ajuster l'angle de vue
  rotateZ(30);               // Rotation sur l'axe Z pour ajuster l'angle de vue
  shape(terrain);            // Le terrain
  
  //ligneDePylones(4,10, 80, 0,-42);
  //ligneDePylones(nbPylones, 10, 80, 0,0);
  dessineElectriqueLignes(20, 100, 40, -115);  // Les lignes électriques entre les pylônes
  //ligneDeEoliennes(2, 10, 80, 0,-62); // La partie 5 du projet
}

void mouseDragged() {
  // Déplacement de la souris par rapport à la dernière position
  float deltaX = mouseX - newMouseX;
  float deltaY = mouseY - newMouseY;
  
  // Mise à jour des dernières positions de la souris
  newMouseX = mouseX;
  newMouseY = mouseY;
  
  // Ajustement des coordonnées de la caméra en fonction du déplacement de la souris
  bougeCamera(deltaX * 0.1, -deltaY * 0.1, 0);
}

void keyPressed() {
  // Déplacement de la caméra en fonction de la touche pressée
  if (key == 'w' || key == 'W' || keyCode == UP) {
    bougeCamera(0, 0, -4); 
  } else if (key == 's' || key == 'S' || keyCode == DOWN) {
    bougeCamera(0, 0, 4); 
  } else if (key == 'a' || key == 'A' || keyCode == LEFT) {
    bougeCamera(-4, 0, 0); 
  } else if (key == 'd' || key == 'D' || keyCode == RIGHT) {
    bougeCamera(4, 0, 0); 
  } else if (key == ENTER || key == RETURN) {
    camX = 0; // Réinitialisation de la position du caméra
    camY = 0;
    camZ = 50;
  }
}

void bougeCamera(float x, float y, float z) {
  camX += x;  // Déplacement du caméra sur l'axe de X
  camY += y;  // Déplacement du caméra sur l'axe de Y
  camZ += z;  // Déplacement du caméra sur l'axe de Z
}

// Fonction pour obtenir la hauteur du terrain à partir d'une position (x et y)
float getTerrainHauteur(float x, float y) {
  float z = 0;  // La hauteur = 0
  float distMinimale = Float.MAX_VALUE;  // La distance minimale à la plus grande valeur  qui est  possible
  // Parcours de tous les  points du terrain
  for (int i = 0; i < terrain.getChildCount(); i++) {
    PShape c = terrain.getChild(i);  // L'obtention d'un point du terrain 
    if (c.getVertexCount() > 0) {    // Vérification: Est-ce que la forme contient des sommets
      for (int j = 0; j < c.getVertexCount(); j++) {  // Parcours de tous les sommets de la forme
        PVector vertex = c.getVertex(j);  // L'obtention d'un sommet de la forme
        float dist = dist(x, y, vertex.x, vertex.y);  // La distance entre (x et y) et le sommet
        // Vérification: Si la distance actuelle est plus petite que la distance minimale
        if (distMinimale > dist) {
          distMinimale = dist;  // Mise à jour de la distance minimale
          z = vertex.z;        //  Mise à jour de la hauteur 
        }
      }
    }
  }
  return z;  // La hauteur du terrain à la position (x et y)
}

// Fonction pour créer la for,e du pylône 
void creerPylone() {
  pylone = createShape(GROUP);  // La création d'une forme de groupe pour le pylône

  // Ajoute des faces du pylône
  for (int i = 0; i < 4; i++) {
    PShape face = creerFace(taillePylone);  // La création d'une face du pylône
    if (i == 1 || i == 3) {
      face.rotateY(PI/2);  // Rotation de 90 degrés autour de l'axe Y pour les faces qui sont latérales
    }
    if (i == 2 || i == 3) {
      face.translate(0, 0, taillePylone);  // Translation sur l'axe Z pour les faces qui sot supérieure
    }
    pylone.addChild(face);  // Ajoute la face au groupe du pylône
  }
  
  // Redimensionnement et rotation du pylône
  pylone.rotateX(-PI/2);  // Rotation de -90 degrés autour de l'axe X
  pylone.rotateZ(PI/2);  // Rotation de 90 degrés autour de l'axe Z 
  pylone.scale(1.0/50.0);  // Changement de la taille du pylône (ca doit réduire la taille)
}
// Fonction pour créer une face du pylône en utilisant les lignes
PShape creerFace(float taille) {
  PShape face = createShape(); 
  face.beginShape(LINES);
  face.stroke(255, 0, 0); // La couleur de la ligne = rouge
  face.strokeWeight(18); // L'épaisseur de la ligne
  
  // Les lignes verticales et horizontales de la face
  for (int i = 0; i < 10; i++) {
    // Les lignes verticales
    face.vertex(0, -i * taille);
    face.vertex(taille, -i * taille);
    
    // Les lignes horizontales
    face.vertex(taille, -i * taille);
    face.vertex(taille, -(i + 1) * taille);
    face.vertex(taille, -(i + 1) * taille);
    face.vertex(0, -(i + 1) * taille);
    face.vertex(0, -(i + 1) * taille);
    face.vertex(0, -i * taille);
    
    // La connexion entre les extrémités des lignes
    face.vertex(0, -i * taille);
    face.vertex(taille, -(i + 1) * taille);
    face.vertex(taille, -i * taille);
    face.vertex(0, -(i + 1) * taille);
  }
  face.endShape(); 
  return face; // La forme de la face du pylône
}
// Fonction pour créer un pylône à une position donnée avec 3 points(x, y, z)
void creerPylone_3(float x, float y, float z) {
  pushMatrix();
  translate(x, y, z); // Translate à la position (x, y, z)
  shape(pylone); // Le pylône
  popMatrix(); 
}
// Fonction pour dessiner une ligne de pylônes entre deux points (x et y) avec une distance spéciale
void ligneDePylones(int nbPylones, float distance, float r, float xDep, float yDep){
  float radianDeR = radians(r); // Convertation de l'angle vers radians.
  
  // Les distances sur les axes X et Y en fonction (angle et distance)
  float dX = cos(radianDeR) * distance;
  float dY = sin(radianDeR) * distance;
  
  // Les coordonnées du point de fin de la ligne( limites)
  float xFin = xDep + dX * (nbPylones - 1);
  float yFin = yDep + dY * (nbPylones - 1);
  
  // Vérification: si les points (xFin et yFin) sont en dehors des limites du terrain
  if (xFin > maxTerrainX || xFin < minTerrainX || yFin > maxTerrainY || yFin < minTerrainY) {
    
    //Le nombre maximum de pylônes pouvant être placés dans les limites du terrain en utilisant(maxTerrainX et maxTerrainY)
    int maxPylonesX = min(floor((maxTerrainX - xDep) / dX), floor((maxTerrainX - yDep) / dY));
    int maxPylonesY = min(floor((maxTerrainY - yDep) / dY), floor((maxTerrainY - xDep) / dX));
    int maxPylones = min(maxPylonesX, maxPylonesY);
    
    //Le nombre minimum de pylônes pouvant être placés dans les limites inversées du terrain en utilisant (minTerrainX et minTerrainY)
    int minPylonesX = max(ceil((minTerrainX - xDep) / dX), ceil((minTerrainY - yDep) / dY));
    int minPylonesY = max(ceil((minTerrainY - yDep) / dY), ceil((minTerrainX - xDep) / dX));
    int minPylones = max(minPylonesX, minPylonesY);
    
    // Ajustement de nombre de pylônes pour qu'il soit dans les limites du terrain
    nbPylones = constrain(nbPylones, minPylones, maxPylones);
  }
  
  // Crée les pylônes le long de la ligne
  for(int i = 0; i < nbPylones; i++){
    float newX = xDep + i * dX; // La nouvelle coordonnée X du pylône
    float newY = yDep + i * dY; // La nouvelle coordonnée Y du pylône
    float newZ = getTerrainHauteur(newX, newY); //La hauteur du terrain à la position du pylône
    
    creerPylone_3(newX, newY, newZ); // Création d'un pylône à la position calculée
  }
}

// Fonction pour dessiner une ligne électrique entre deux points avec une gravité
void dessineElectriqueLigne(float x1, float y1, float z1, float x2, float y2, float z2) {
  float distXY = dist(x1, y1, x2, y2); // La distance horizontale entre les deux points
  float gravite = 0.01; // Gravité de la ligne électrique
  
  beginShape(); //La définition de la forme
  for (float i = 0; i <= 1; i += 0.05) {
    float x = lerp(x1, x2, i); // Interpolation de la coordonnée X entre les deux points
    float y = lerp(y1, y2, i); // Interpolation de la coordonnée Y entre les deux points
    float z = lerp(z1, z2, i); // Interpolation de la coordonnée Z entre les deux points
    
    //La variation de la hauteur en fonction de la distance horizontale
    float newY = map(dist(x, y, x1, y1), 0, distXY, 0, gravite * distXY);
    
    vertex(x, y, z + newY); // Ajoute un sommet à la forme avec la variation de hauteur
  }
  endShape(); 
}


// Fonction pour dessiner des lignes électriques entre deux points avec des pylônes qui sont intermédiaires
void dessineElectriqueLignes(float xDep, float yDep, float xFin, float yFin) {  
  // La distance entre les deux points
  float distance = dist(xDep, yDep, xFin, yFin);
  
  // L'angle entre les deux points
  float angle = atan2(yFin - yDep, xFin - xDep);
  
  // Placement des pylônes le long de la ligne
  ligneDePylones(nbPylones, distance / (nbPylones - 1), degrees(angle), xDep, yDep);
  
  // Dessine les lignes électriques entre les pylônes
  for (int i = 0; i < nbPylones - 1; i++) {
    //lLes coordonnées des deux extrémités du segment de ligne électrique
    float x1 = xDep + i * (xFin - xDep) / (nbPylones - 1);
    float y1 = yDep + i * (yFin - yDep) / (nbPylones - 1);
    float x2 = xDep + (i + 1) * (xFin - xDep) / (nbPylones - 1);
    float y2 = yDep + (i + 1) * (yFin - yDep) / (nbPylones - 1);
    
    //La hauteur du pylône le plus haut pour chaque segment
    float z1 = getTerrainHauteur(x1, y1) + taillePylone / 5; 
    float z2 = getTerrainHauteur(x2, y2) + taillePylone / 5; 
    
    // La ligne électrique entre les deux pylônes
    dessineElectriqueLigne(x1, y1, z1, x2, y2, z2);
  }
}

/*
void creerEolienne() {
  eolienne = createShape(GROUP);  // Création d'une forme de groupe pour l'éolienne

  // Ajout des faces de l'éolienne
  for (int i = 0; i < 4; i++) {
    PShape face = creerFace(tailleEolienne);  // Création d'une face de l'éolienne
    if (i == 1 || i == 3) {
      face.rotateY(PI/2);  // Rotation de 90 degrés autour de l'axe Y pour les faces qui sont latérales
    }
    if (i == 2 || i == 3) {
      face.translate(0, 0, tailleEolienne);  // Translation sur l'axe Z pour les faces qui sont supérieures
    }
    eolienne.addChild(face);  // Ajout de la face au groupe de l'éolienne
  }
  
  // Création et ajout de la forme de pale
  PShape pale = creerPale(tailleEolienne); // Création de la forme de la pale
  eolienne.addChild(pale); // Ajout de la pale au groupe de l'éolienne
  
  // Redimensionnement et rotation de l'éolienne
  eolienne.rotateX(-PI/2);  // Rotation de -90 degrés autour de l'axe X
  eolienne.rotateZ(PI/2);  // Rotation de 90 degrés autour de l'axe Z 
  eolienne.scale(1.0/50.0);  // Réduction de la taille de l'éolienne
}

// Fonction pour créer la forme de la pale de l'éolienne
PShape creerPale(float taille) {
  // Création d'une forme de pâle
  PShape pale = createShape();
  pale.beginShape(TRIANGLES); 
  
  // Coordonnées des sommets de la pale
  pale.vertex(0, 0); // Sommet de la pale
  pale.vertex(taille/2, -taille*2); // Sommet supérieur de la pale
  pale.vertex(-taille/2, -taille*2); // Sommet supérieur de la pale
  
  pale.endShape(); 
  
  return pale; 
}

void creerEolienne_3(float x, float y, float z){
  pushMatrix();
  translate(x, y, z); // Translate à la position (x, y, z)
  shape(eolienne); // L'éolienne
  popMatrix(); 
}
void ligneDeEoliennes(int nbEoliennes, float distance, float r, float xDep, float yDep){
  float radianDeR = radians(r); // Conversion de l'angle en radians.
  float dX = cos(radianDeR) * distance;
  float dY = sin(radianDeR) * distance;
  float xFin = xDep + dX * (nbEoliennes - 1);
  float yFin = yDep + dY * (nbEoliennes - 1);
  if (xFin > maxTerrainX || xFin < minTerrainX || yFin > maxTerrainY || yFin < minTerrainY) {
    int maxEoliennesX = min(floor((maxTerrainX - xDep) / dX), floor((maxTerrainX - yDep) / dY));
    int maxEoliennesY = min(floor((maxTerrainY - yDep) / dY), floor((maxTerrainY - xDep) / dX));
    int maxEoliennes = min(maxEoliennesX, maxEoliennesY);
    int minEoliennesX = max(ceil((minTerrainX - xDep) / dX), ceil((minTerrainY - yDep) / dY));
    int minEoliennesY = max(ceil((minTerrainY - yDep) / dY), ceil((minTerrainX - xDep) / dX));
    int minEoliennes = max(minEoliennesX, minEoliennesY);
    nbEoliennes = constrain(nbEoliennes, minEoliennes, maxEoliennes);
  }
  for(int i = 0; i < nbEoliennes; i++){
    float newX = xDep + i * dX; // Nouvelle coordonnée X de l'éolienne
    float newY = yDep + i * dY; // Nouvelle coordonnée Y de l'éolienne
    float newZ = getTerrainHauteur(newX, newY); // Hauteur du terrain à la position de l'éolienne
    
    creerEolienne_3(newX, newY, newZ); // Création d'une éolienne à la position calculée
  }
}
*/
