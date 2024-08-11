/*
 Copyright 2024 "Charlie's Angels"
	   <HENOC.ROJAS@ucr.ac.cr>
	   <BRAUNNY.MADRIGAL@ucr.ac.cr>
	   <KENDALL.VILLAFUERTE@ucr.ac.cr>
	   <MARCELO.PICADO@ucr.ac.cr>
	   <RODRIGO.CARBALLO@ucr.ac.cr>
*/

#ifndef TOWERS_HPP
#define TOWERS_HPP

#include "FlappyCommon.hpp"

/**
 * @brief Clase para manejar las torres en el juego Flappy.
 */
class Towers {
private:
	sf::Texture towerBotTexture;  /**< Textura de la parte inferior de la torre. */
	sf::Texture towerTopTexture;  /**< Textura de la parte superior de la torre. */
	sf::Sprite tLeftTop;  /**< Sprite de la parte superior de la torre izquierda. */
	sf::Sprite tLeftBot;  /**< Sprite de la parte inferior de la torre izquierda. */
	sf::Sprite tRighTop;  /**< Sprite de la parte superior de la torre derecha. */
	sf::Sprite tRighBot;  /**< Sprite de la parte inferior de la torre derecha. */
	int towerHeight;  /**< Altura de las torres. */
	int towerWidth;  /**< Ancho de las torres. */

private:
	/**
	 * @brief Inicializa las texturas de las torres.
	 *
	 * @throws std::runtime_error si no se puede cargar algun archivo.
	 */
	void initTexture();

	/**
	 * @brief Inicializa los sprites de las torres.
	 */
	void initSprites();

public:
	/**
	 * @brief Constructor de la clase Towers.
	 */
	Towers();

	/**
	 * @brief Destructor de la clase Towers.
	 */
	~Towers();

	/**
	 * @brief Mueve las torres a la izquierda, y las reinicia cuando salen de la pantalla.
	 */
	void moveTowers();

	/**
	 * @brief Obtiene las coordenadas de las torres.
	 *
	 * @return std::vector<int> Vector con las coordenadas de las torres.
	 */
	std::vector<int> getCoordinates();

	/**
	 * @brief Restablece las torres a su posición original.
	 */
	void setOriginalPosition();

	/**
	 * @brief Obtiene el sprite de la parte superior de la torre izquierda.
	 *
	 * @return sf::Sprite Sprite de la parte superior de la torre izquierda.
	 */
	sf::Sprite getTLeftTop();

	/**
	 * @brief Obtiene el sprite de la parte inferior de la torre izquierda.
	 *
	 * @return sf::Sprite Sprite de la parte inferior de la torre izquierda.
	 */
	sf::Sprite getTLeftBot();

	/**
	 * @brief Obtiene el sprite de la parte inferior de la torre derecha.
	 *
	 * @return sf::Sprite Sprite de la parte inferior de la torre derecha.
	 */
	sf::Sprite getTRighBot();

	/**
	 * @brief Obtiene el sprite de la parte superior de la torre derecha.
	 *
	 * @return sf::Sprite Sprite de la parte superior de la torre derecha.
	 */
	sf::Sprite getTRighTop();

	/**
	 * @brief Obtiene la altura de las torres.
	 *
	 * @return int Altura de las torres.
	 */
	int getTowerHeight();

	/**
	 * @brief Obtiene el ancho de las torres.
	 *
	 * @return int Ancho de las torres.
	 */
	int getTowerWidth();
};

#endif  // TOWERS_HPP
