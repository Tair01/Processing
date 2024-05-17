uniform sampler2D Image;    // Une texture 2D
varying vec2 texCoordOut;   // Coordonnées de texture interpolées en sortie
varying float interZ;       // Valeur de Z interpolée

void main() {
    // La couleur de la texture à la position donnée qui est (texCoordOut)
    vec4 terrainColor = texture2D(Image, texCoordOut);
    float resultat = mod(interZ, 2); // Le resultat du reste de la division de interZ par 2
    
    // Vérification: Si la valeur de Z interpolée est dans une plage spécifique
    if ((interZ > -195) && (resultat >= 0.1 && resultat <= 0.2)) {
        gl_FragColor = terrainColor * vec4(0.0, 0.0, 0.0, 1.0); // en noir
    }else if (interZ < -195.0) {
        gl_FragColor = terrainColor * vec4(0.0, 1.0, 0.0, 1.0); // en vert
    }else {
        gl_FragColor = terrainColor; // couleur de la texture
    }
}



