/*
 Copyright 2024 "Charlie's Angels"
       <HENOC.ROJAS@ucr.ac.cr>
       <BRAUNNY.MADRIGAL@ucr.ac.cr>
       <KENDALL.VILLAFUERTE@ucr.ac.cr>
       <MARCELO.PICADO@ucr.ac.cr>
       <RODRIGO.CARBALLO@ucr.ac.cr>
*/

#ifndef FLAPPYCOMMON_HPP
#define FLAPPYCOMMON_HPP

#include <stdlib.h>

#include <exception>
#include <iostream>
#include <stdexcept>
#include <string>
#include <sstream> 
#include <vector>

#include "SFML/Audio.hpp"
#include "SFML/Graphics.hpp"

/**
 * @brief Suma dos enteros.
 *
 * @param a Primer entero
 * @param b Segundo entero
 * @return int La suma de los dos enteros
 */
extern "C" int Sum(int a, int b);

/**
 * @brief Obtiene la puntuaci�n del juego basada en la posici�n del avi�n y las torres.
 *
 * @param planeX Coordenada X del avi�n
 * @param towerLX Coordenada X de la torre izquierda
 * @param towerRX Coordenada X de la torre derecha
 * @return int 1 si el avi�n est� alineado con alguna torre, 0 en caso contrario
 */
extern "C" int getGameScore(int planeX, int towerLX, int towerRX);

/**
 * @brief Verifica colisiones entre cuatro operandos.
 *
 * @param op1 Primer operando
 * @param op2 Segundo operando
 * @param op3 Tercer operando
 * @param op4 Cuarto operando
 * @return int 1 si (op1 > op2) && (op3 > op4), 0 en caso contrario
 */
extern "C" int collisions(int op1, int op2, int op3, int op4);

/**
 * @brief Verifica si un punto est� en una l�nea.
 *
 * @param point Punto a verificar
 * @param lineStart Inicio de la l�nea
 * @param lineEnd Fin de la l�nea
 * @return int 1 si el punto est� en la l�nea, 0 en caso contrario
 */
extern "C" int CheckPointInLine(int point, int lineStart, int lineEnd);

#endif  // FLAPPYCOMMON_HPP
