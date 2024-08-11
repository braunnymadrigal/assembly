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
 * @brief Clase para manejar el avi�n en el juego Flappy.
 */
class Plane {
private:
	sf::Sprite planeSprite;  /**< Sprite del avi�n. */
	sf::Texture planeTexture;  /**< Textura del avi�n. */
	int planeX;  /**< Coordenada X del avi�n. */
	int planeY;  /**< Coordenada Y del avi�n. */
	int planeWidth;  /**< Ancho del avi�n. */
	int planeHeight;  /**< Altura del avi�n. */
	sf::Sprite smokeSprite;  /**< Sprite del humo del avi�n. */
	sf::Texture smokeTexture;  /**< Textura del humo del avi�n. */

private:
	/**
	 * @brief Inicializa las texturas del avi�n y del humo.
	 *
	 * @throws std::runtime_error si no se pueden cargar los archivos.
	 */
	void initTexture();
	void initSprite();

public:
	/**
	 * @brief Inicializa los sprites del avi�n y del humo.
	 */
	Plane();

	/**
	 * @brief Destructor de la clase Plane.
	 */
	~Plane();

	/**
	 * @brief Aplica la gravedad al avi�n.
	 *
	 * Mueve el avi�n y el humo hacia abajo.
	 */
	void applyGravity();

	/**
	 * @brief Realiza un salto del avi�n.
	 *
	 * Mueve el avi�n y el humo hacia arriba.
	 */
	void jump();

	/**
	 * @brief Obtiene el sprite del avi�n.
	 *
	 * @return sf::Sprite Sprite del avi�n.
	 */
	sf::Sprite getPlane();

	/**
	 * @brief Obtiene el sprite del humo.
	 *
	 * @return sf::Sprite Sprite del humo.
	 */
	sf::Sprite getSmoke();

	/**
	 * @brief Establece la posici�n original del avi�n.
	 */
	void setOriginalPosition();

	/**
	 * @brief Obtiene las coordenadas actuales del avi�n.
	 *
	 * @return std::vector<int> Vector con las coordenadas X e Y del avi�n.
	 */
	std::vector<int> getCoordinates();

	/**
	 * @brief Obtiene la altura del avi�n.
	 *
	 * @return int Altura del avi�n.
	 */
	int getPlaneHeight();

	/**
	 * @brief Obtiene el ancho del avi�n.
	 *
	 * @return int Ancho del avi�n.
	 */
	int getPlaneWidth();
};

#endif  // PLANE_HPP
