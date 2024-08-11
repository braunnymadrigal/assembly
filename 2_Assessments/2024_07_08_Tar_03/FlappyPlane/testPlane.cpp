/*
 Copyright 2024 "Charlie's Angels"
       <HENOC.ROJAS@ucr.ac.cr>
       <BRAUNNY.MADRIGAL@ucr.ac.cr>
       <KENDALL.VILLAFUERTE@ucr.ac.cr>
       <MARCELO.PICADO@ucr.ac.cr>
       <RODRIGO.CARBALLO@ucr.ac.cr>
*/

#include "MainTest.hpp"
#include "Plane.hpp"

// Funcion para probar la inicializacion del avion
void testPlane() {
    Plane plane;

    // Verificacion de las texturas
    sf::Sprite planeSprite = plane.getPlane();
    sf::Sprite smokeSprite = plane.getSmoke();

    if (!planeSprite.getTexture()) {
        std::cerr << "Error: La textura del avion no se ha inicializado correctamente." << std::endl;
    }
    else {
        std::cout << "La textura del avion se ha inicializado correctamente." << std::endl;
    }

    if (!smokeSprite.getTexture()) {
        std::cerr << "Error: La textura del humo no se ha inicializado correctamente." << std::endl;
    }
    else {
        std::cout << "La textura del humo se ha inicializado correctamente." << std::endl;
    }

    // Verificacion de las posiciones iniciales
    std::vector<int> coordinates = plane.getCoordinates();
    if (coordinates != std::vector<int>{20, 200}) {
        std::cerr << "Error: Las coordenadas iniciales del avion no son correctas." << std::endl;
    }
    else {
        std::cout << "Las coordenadas iniciales del avion son correctas." << std::endl;
    }

    // Prueba de aplicacion de gravedad
    plane.applyGravity();
    coordinates = plane.getCoordinates();
    if (coordinates == std::vector<int>{20, 201}) {
        std::cout << "La aplicacion de gravedad al avion es correcta." << std::endl;
    }
    else {
        std::cerr << "Error: La aplicacion de gravedad al avion no es correcta." << std::endl;
    }

    // Prueba de salto
    plane.jump();
    coordinates = plane.getCoordinates();
    if (coordinates == std::vector<int>{20, 171}) {
        std::cout << "El salto del avion es correcto." << std::endl;
    }
    else {
        std::cerr << "Error: El salto del avion no es correcto." << std::endl;
    }

    // Prueba de restablecimiento de las posiciones originales
    plane.setOriginalPosition();
    coordinates = plane.getCoordinates();
    if (coordinates == std::vector<int>{20, 200}) {
        std::cout << "El restablecimiento de las posiciones originales del avion es correcto." << std::endl;
    }
    else {
        std::cerr << "Error: El restablecimiento de las posiciones originales del avion no es correcto." << std::endl;
    }
}
