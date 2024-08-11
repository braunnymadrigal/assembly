// Copyright 2024 HENOC ROJAS CARRILLO <HENOC.ROJAS@ucr.ac.cr>
// Copyright 2024 BRAUNNY MADRIGAL BARRANTES <BRAUNNY.MADRIGAL@ucr.ac.cr>
// Copyright 2024 KENDALL VILLAFUERTE BEITA <KENDALL.VILLAFUERTE@ucr.ac.cr>
// Copyright 2024 MARCELO PICADO LEIVA <MARCELO.PICADO@ucr.ac.cr>

/**
 * @file Interface.hpp
 * @brief Definici�n de la clase Interface y sus m�todos para la calculadora vectorial.
 *
 * Este archivo contiene la definici�n de la clase Interface, que proporciona m�todos p�blicos
 * para interactuar con el usuario a trav�s de la consola y ejecutar operaciones de suma y multiplicaci�n
 * de vectores utilizando funciones optimizadas con AVX. Tambi�n incluye m�todos privados para manejar
 * la l�gica interna de la aplicaci�n, como la gesti�n del men� y la obtenci�n de opciones del usuario.
 * Las operaciones y entradas esperadas est�n detalladas en los comentarios de cada m�todo correspondiente.
 */

#pragma once

#include <algorithm>   // Algoritmos gen�ricos
#include <iomanip>     // Manipulaci�n de entrada/salida
#include <iostream>    // Entrada y salida est�ndar
#include <limits>      // L�mites del tipo de datos
#include <memory>      // Operaciones de gesti�n de memoria
#include <regex>       // Expresiones regulares
#include <sstream>     // Flujos de string
#include <stdlib.h>    // Funciones generales de la biblioteca est�ndar
#include <string>      // Manipulaci�n de cadenas de caracteres
#include <stdexcept>   // Excepciones est�ndar
#include <utility>     // Funciones de utilidad de la biblioteca est�ndar
#include <vector>      // Contenedores de vectores

/**
 * @brief Declaraci�n de la funci�n AVXSumTwoVectors.
 *
 * Esta funci�n externa declara la funci�n AVXSumTwoVectors, que est� implementada en c�digo ensamblador.
 * Toma dos punteros a vectores de tipo double y utiliza instrucciones AVX para cargar, sumar y almacenar
 * el resultado de la suma en el primer vector.
 *
 * @param myVector1 Puntero al primer vector de tipo double.
 * @param myVector2 Puntero al segundo vector de tipo double.
 */
extern "C" void AVXSumTwoVectors(double* myVector1, double* myVector2);

/**
 * @brief Declaraci�n de la funci�n AVXMulVecByScalar.
 *
 * Esta funci�n externa declara la funci�n AVXMulVecByScalar, que est� implementada en c�digo ensamblador.
 * Toma un puntero a un vector de tipo double y un puntero a un n�mero double (escalar), y utiliza instrucciones
 * AVX para cargar el vector, multiplicarlo por el escalar y almacenar el resultado en el mismo vector.
 *
 * @param myVector1 Puntero al vector de tipo double.
 * @param myNumber Puntero al n�mero double (escalar) con el cual se multiplicar� el vector.
 */
extern "C" void AVXMulVecByScalar(double* myVector1, double* myNumber);

/**
 * @brief Clase que define la interfaz de usuario para la calculadora vectorial.
 *
 * Esta clase proporciona m�todos para mostrar mensajes de bienvenida, ejecutar pruebas,
 * interactuar con el usuario a trav�s de un men� y realizar operaciones de suma y multiplicaci�n
 * de vectores utilizando funciones externas de AVX para optimizaci�n.
 */
class Interface
{
public:  // public procedures
    /**
    * @brief Muestra el mensaje de bienvenida del programa.
    *
    * Este m�todo imprime en la consola informaci�n relevante sobre el programa, incluyendo la universidad,
    * curso, profesor, ciclo lectivo, t�tulo de la tarea, descripci�n de la calculadora vectorial y los integrantes
    * del equipo. Finalmente, solicita al usuario presionar 'ENTER' para continuar.
    */
    void welcome();

    /**
     * @brief Ejecuta las pruebas del programa y maneja la interacci�n del usuario con el men�.
     *
     * Este m�todo muestra repetidamente el men� principal, obtiene la opci�n del usuario e invoca el
     * m�todo correspondiente en funci�n de la opci�n seleccionada. Si la opci�n es 0, el programa
     * termina su ejecuci�n.
     */
    void tests();

private:  // private procedures
    /**
     * @brief Interfaz para realizar la suma de dos vectores de n�meros flotantes.
     *
     * Este m�todo gu�a al usuario a trav�s del proceso de ingresar el tama�o y los elementos
     * de dos vectores, realizar la suma utilizando una funci�n externa AVXSumTwoVectors,
     * y mostrar el resultado en la consola.
     */
    void sumInterface();

    /**
     * @brief Interfaz para multiplicar un escalar por un vector de n�meros flotantes.
     *
     * Este m�todo gu�a al usuario a trav�s del proceso de ingresar el tama�o y los elementos
     * de un vector, as� como el escalar con el cual multiplicar el vector. Utiliza una funci�n
     * externa AVXMulVecByScalar para realizar la multiplicaci�n y muestra el resultado en la consola.
     */
    void mulInterface();
    
    /**
     * @brief Muestra el manual de usuario de la calculadora vectorial.
     *
     * Este m�todo imprime en la consola un manual detallado que describe las operaciones
     * que la calculadora vectorial puede realizar, incluyendo ejemplos de entrada para
     * sumar dos vectores y multiplicar un escalar por un vector.
     * Tambi�n proporciona notas importantes para asegurar el ingreso correcto de datos.
     */
    void showGuide();
    
    /**
     * @brief Muestra el men� principal del programa.
     *
     * Este m�todo imprime en la consola el men� principal del programa, que incluye opciones para salir del programa,
     * sumar dos vectores, multiplicar un escalar por un vector y mostrar el manual de usuario.
     */
    void printMenu();
    
    /**
     * @brief Obtiene la opci�n seleccionada por el usuario desde la entrada est�ndar.
     *
     * Este m�todo solicita al usuario que ingrese una opci�n mediante la consola.
     * Captura la entrada del usuario como una cadena, la convierte a un entero y
     * devuelve ese entero como la opci�n seleccionada.
     *
     * @return int Opci�n seleccionada por el usuario.
     */
    int getOption();
};
