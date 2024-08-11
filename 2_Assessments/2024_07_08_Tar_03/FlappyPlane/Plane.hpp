/*
 Copyright 2024 "Charlie's Angels"
	   <HENOC.ROJAS@ucr.ac.cr>
	   <BRAUNNY.MADRIGAL@ucr.ac.cr>
	   <KENDALL.VILLAFUERTE@ucr.ac.cr>
	   <MARCELO.PICADO@ucr.ac.cr>
	   <RODRIGO.CARBALLO@ucr.ac.cr>
*/

#ifndef PLANE_HPP
#define PLANE_HPP

#include "FlappyCommon.hpp"

/**
 * @brief Clase para manejar el avión en el juego Flappy.
 */
class Plane {
private:
	sf::Sprite planeSprite;  /**< Sprite del avión. */
	sf::Texture planeTexture;  /**< Textura del avión. */
	int planeX;  /**< Coordenada X del avión. */
	int planeY;  /**< Coordenada Y del avión. */
	int planeWidth;  /**< Ancho del avión. */
	int planeHeight;  /**< Altura del avión. */
	sf::Sprite smokeSprite;  /**< Sprite del humo del avión. */
	sf::Texture smokeTexture;  /**< Textura del humo del avión. */

private:
	/**
	 * @brief Inicializa las texturas del avión y del humo.
	 *
	 * @throws std::runtime_error si no se pueden cargar los archivos.
	 */
	void initTexture();
	void initSprite();

public:
	/**
	 * @brief Inicializa los sprites del avión y del humo.
	 */
	Plane();

	/**
	 * @brief Destructor de la clase Plane.
	 */
	~Plane();

	/**
	 * @brief Aplica la gravedad al avión.
	 *
	 * Mueve el avión y el humo hacia abajo.
	 */
	void applyGravity();

	/**
	 * @brief Realiza un salto del avión.
	 *
	 * Mueve el avión y el humo hacia arriba.
	 */
	void jump();

	/**
	 * @brief Obtiene el sprite del avión.
	 *
	 * @return sf::Sprite Sprite del avión.
	 */
	sf::Sprite getPlane();

	/**
	 * @brief Obtiene el sprite del humo.
	 *
	 * @return sf::Sprite Sprite del humo.
	 */
	sf::Sprite getSmoke();

	/**
	 * @brief Establece la posición original del avión.
	 */
	void setOriginalPosition();

	/**
	 * @brief Obtiene las coordenadas actuales del avión.
	 *
	 * @return std::vector<int> Vector con las coordenadas X e Y del avión.
	 */
	std::vector<int> getCoordinates();

	/**
	 * @brief Obtiene la altura del avión.
	 *
	 * @return int Altura del avión.
	 */
	int getPlaneHeight();

	/**
	 * @brief Obtiene el ancho del avión.
	 *
	 * @return int Ancho del avión.
	 */
	int getPlaneWidth();
};

#endif  // PLANE_HPP
