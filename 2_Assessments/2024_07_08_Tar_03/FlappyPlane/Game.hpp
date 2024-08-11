/*
 Copyright 2024 "Charlie's Angels"
       <HENOC.ROJAS@ucr.ac.cr>
       <BRAUNNY.MADRIGAL@ucr.ac.cr>
       <KENDALL.VILLAFUERTE@ucr.ac.cr>
       <MARCELO.PICADO@ucr.ac.cr>
       <RODRIGO.CARBALLO@ucr.ac.cr>
*/

#ifndef GAME_HPP
#define GAME_HPP

#include "Audios.hpp"
#include "Button.hpp"
#include "GameStates.hpp"
#include "Plane.hpp"
#include "Text.hpp"
#include "Towers.hpp"
#include "MainTest.hpp"

/**
 * @brief Clase principal para manejar el juego Flappy Plane.
 */
class Game {
private:
    sf::RenderWindow* window;  /**< Ventana principal del juego. */
    sf::VideoMode videoMode;  /**< Modo de video para la ventana. */
    std::string windowName;  /**< Nombre de la ventana del juego. */
    sf::Event event;  /**< Evento de SFML. */
    GameState gameState;  /**< Estado actual del juego. */
    Text text;  /**< Maneja los textos del juego. */
    Button button;  /**< Maneja los botones del juego. */
    Plane plane;  /**< Maneja el avión del juego. */
    Audios audios;  /**< Maneja los sonidos del juego. */
    Towers towers;  /**< Maneja las torres del juego. */
    int gameScore;  /**< Puntaje del juego. */

private:
    /**
     * @brief Inicializa la ventana del juego.
     */
	void initWindow();

    /**
     * @brief Maneja los eventos del juego.
     */
	void pollEvents();

    /**
     * @brief Actualiza el puntaje del juego.
     */
	void updateGameScore();

    /**
     * @brief Verifica colisiones entre el avión y las torres.
     * Algoritmo obtenido:
     * https://stackoverflow.com/questions/31022269/collision-detection-between-two-rectangles-in-java
     *
     * @return true si hay una colisión, false en caso contrario.
     */
	bool checkCollisions();

public:
    /**
     * @brief Constructor de la clase Game.
     */
	Game();

    /**
     * @brief Destructor de la clase Game.
     */
	~Game();

    /**
     * @brief Actualiza el estado del juego.
     */
	void update();

    /**
     * @brief Renderiza los elementos del juego en la ventana.
     */
	void render();

    /**
     * @brief Verifica si el juego está corriendo.
     *
     * @return true si la ventana del juego está abierta, false en caso contrario.
     */
	const bool isRunning() const;
};

#endif  // GAME_HPP
