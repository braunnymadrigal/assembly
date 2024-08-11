// Copyright 2024 HENOC ROJAS CARRILLO <HENOC.ROJAS@ucr.ac.cr>
// Copyright 2024 BRAUNNY MADRIGAL BARRANTES <BRAUNNY.MADRIGAL@ucr.ac.cr>
// Copyright 2024 KENDALL VILLAFUERTE BEITA <KENDALL.VILLAFUERTE@ucr.ac.cr>
// Copyright 2024 MARCELO PICADO LEIVA <MARCELO.PICADO@ucr.ac.cr>

/**
 * @file Interface.hpp
 * @brief Definición de la clase Interface y sus métodos para la calculadora vectorial.
 *
 * Este archivo contiene la definición de la clase Interface, que proporciona métodos públicos
 * para interactuar con el usuario a través de la consola y ejecutar operaciones de suma y multiplicación
 * de vectores utilizando funciones optimizadas con AVX. También incluye métodos privados para manejar
 * la lógica interna de la aplicación, como la gestión del menú y la obtención de opciones del usuario.
 * Las operaciones y entradas esperadas están detalladas en los comentarios de cada método correspondiente.
 */

#pragma once

#include <algorithm>   // Algoritmos genéricos
#include <iomanip>     // Manipulación de entrada/salida
#include <iostream>    // Entrada y salida estándar
#include <limits>      // Límites del tipo de datos
#include <memory>      // Operaciones de gestión de memoria
#include <regex>       // Expresiones regulares
#include <sstream>     // Flujos de string
#include <stdlib.h>    // Funciones generales de la biblioteca estándar
#include <string>      // Manipulación de cadenas de caracteres
#include <stdexcept>   // Excepciones estándar
#include <utility>     // Funciones de utilidad de la biblioteca estándar
#include <vector>      // Contenedores de vectores

/**
 * @brief Declaración de la función AVXSumTwoVectors.
 *
 * Esta función externa declara la función AVXSumTwoVectors, que está implementada en código ensamblador.
 * Toma dos punteros a vectores de tipo double y utiliza instrucciones AVX para cargar, sumar y almacenar
 * el resultado de la suma en el primer vector.
 *
 * @param myVector1 Puntero al primer vector de tipo double.
 * @param myVector2 Puntero al segundo vector de tipo double.
 */
extern "C" void AVXSumTwoVectors(double* myVector1, double* myVector2);

/**
 * @brief Declaración de la función AVXMulVecByScalar.
 *
 * Esta función externa declara la función AVXMulVecByScalar, que está implementada en código ensamblador.
 * Toma un puntero a un vector de tipo double y un puntero a un número double (escalar), y utiliza instrucciones
 * AVX para cargar el vector, multiplicarlo por el escalar y almacenar el resultado en el mismo vector.
 *
 * @param myVector1 Puntero al vector de tipo double.
 * @param myNumber Puntero al número double (escalar) con el cual se multiplicará el vector.
 */
extern "C" void AVXMulVecByScalar(double* myVector1, double* myNumber);

/**
 * @brief Clase que define la interfaz de usuario para la calculadora vectorial.
 *
 * Esta clase proporciona métodos para mostrar mensajes de bienvenida, ejecutar pruebas,
 * interactuar con el usuario a través de un menú y realizar operaciones de suma y multiplicación
 * de vectores utilizando funciones externas de AVX para optimización.
 */
class Interface
{
public:  // public procedures
    /**
    * @brief Muestra el mensaje de bienvenida del programa.
    *
    * Este método imprime en la consola información relevante sobre el programa, incluyendo la universidad,
    * curso, profesor, ciclo lectivo, título de la tarea, descripción de la calculadora vectorial y los integrantes
    * del equipo. Finalmente, solicita al usuario presionar 'ENTER' para continuar.
    */
    void welcome();

    /**
     * @brief Ejecuta las pruebas del programa y maneja la interacción del usuario con el menú.
     *
     * Este método muestra repetidamente el menú principal, obtiene la opción del usuario e invoca el
     * método correspondiente en función de la opción seleccionada. Si la opción es 0, el programa
     * termina su ejecución.
     */
    void tests();

private:  // private procedures
    /**
     * @brief Interfaz para realizar la suma de dos vectores de números flotantes.
     *
     * Este método guía al usuario a través del proceso de ingresar el tamaño y los elementos
     * de dos vectores, realizar la suma utilizando una función externa AVXSumTwoVectors,
     * y mostrar el resultado en la consola.
     */
    void sumInterface();

    /**
     * @brief Interfaz para multiplicar un escalar por un vector de números flotantes.
     *
     * Este método guía al usuario a través del proceso de ingresar el tamaño y los elementos
     * de un vector, así como el escalar con el cual multiplicar el vector. Utiliza una función
     * externa AVXMulVecByScalar para realizar la multiplicación y muestra el resultado en la consola.
     */
    void mulInterface();
    
    /**
     * @brief Muestra el manual de usuario de la calculadora vectorial.
     *
     * Este método imprime en la consola un manual detallado que describe las operaciones
     * que la calculadora vectorial puede realizar, incluyendo ejemplos de entrada para
     * sumar dos vectores y multiplicar un escalar por un vector.
     * También proporciona notas importantes para asegurar el ingreso correcto de datos.
     */
    void showGuide();
    
    /**
     * @brief Muestra el menú principal del programa.
     *
     * Este método imprime en la consola el menú principal del programa, que incluye opciones para salir del programa,
     * sumar dos vectores, multiplicar un escalar por un vector y mostrar el manual de usuario.
     */
    void printMenu();
    
    /**
     * @brief Obtiene la opción seleccionada por el usuario desde la entrada estándar.
     *
     * Este método solicita al usuario que ingrese una opción mediante la consola.
     * Captura la entrada del usuario como una cadena, la convierte a un entero y
     * devuelve ese entero como la opción seleccionada.
     *
     * @return int Opción seleccionada por el usuario.
     */
    int getOption();
};
