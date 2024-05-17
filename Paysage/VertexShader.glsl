uniform mat4 transform;     // Une matrice de transformation uniforme
attribute vec4 color;       // Des attributs pour la couleur
attribute vec2 texCoord;    // Les coordonnées de la texture
attribute vec4 position;    // La position

// La déclaration des sorties: 
varying vec4 vertColor;     // La couleur interpolée
varying vec2 texCoordOut;   // Les coordonnées de la texture interpolées
varying float interZ;       // La valeur de Z interpolé

void main() {
    // Je passe la couleur de l'attribut color à la sortie vertColor
    vertColor = color;
    
    // Je passe la composante Z de la position à la sortie interZ
    interZ = position.z; 
    
    // Je passe les coordonnées de texture de l'attribut texCoord à la sortie texCoordOut
    texCoordOut = texCoord;
    
    // Application de la transformation à la position de l'attribut position
    // Puis je passe le résultat à gl_Position
    gl_Position = transform * position; 
}

