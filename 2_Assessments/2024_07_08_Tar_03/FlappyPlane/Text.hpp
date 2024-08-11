/*
 Copyright 2024 "Charlie's Angels"
	   <HENOC.ROJAS@ucr.ac.cr>
	   <BRAUNNY.MADRIGAL@ucr.ac.cr>
	   <KENDALL.VILLAFUERTE@ucr.ac.cr>
	   <MARCELO.PICADO@ucr.ac.cr>
	   <RODRIGO.CARBALLO@ucr.ac.cr>
*/

#ifndef TEXT_HPP
#define TEXT_HPP

#include "FlappyCommon.hpp"

/**
 * @brief Clase para manejar los textos en el juego Flappy.
 */
class Text {
private:
	sf::Font font;  /**< Fuente usada para los textos. */
	std::stringstream streamScore;  /**< Stream para el texto de la puntuación. */
	sf::Text textScore;  /**< Texto para la puntuación. */
	std::string stringInfo;  /**< String para la información del juego. */
	sf::Text textInfo;  /**< Texto para la información del juego. */
	std::string stringTitle;  /**< String para el título del juego. */
	sf::Text textTitle;  /**< Texto para el título del juego. */

private:
	/**
	 * @brief Inicializa la fuente del texto.
	 *
	 * @throws std::runtime_error si no se puede cargar el archivo.
	 */
	void initFont();

	/**
	 * @brief Inicializa el texto de la puntuación.
	 */
	void initTextScore();

	/**
	 * @brief Inicializa el texto de la información del juego.
	 */
	void initTextInfo();

	/**
	 * @brief Inicializa el texto del título del juego.
	 */
	void initTextTitle();

public:
	/**
	 * @brief Constructor de la clase Text.
	 */
	Text();

	/**
	 * @brief Destructor de la clase Text.
	 */
	~Text();

	/**
	 * @brief Sobreescribe el texto de la puntuación.
	 *
	 * @param score Puntuación actual del juego.
	 */
	void setTextScore(int score);

	/**
	 * @brief Obtiene el texto de la puntuación.
	 *
	 * @return sf::Text Texto de la puntuación.
	 */

	sf::Text getTextScore();

	/**
	 * @brief Obtiene el texto de la información del juego.
	 *
	 * @return sf::Text Texto de la información del juego.
	 */
	sf::Text getTextInfo();

	/**
	 * @brief Obtiene el texto del título del juego.
	 *
	 * @return sf::Text Texto del título del juego.
	 */
	sf::Text getTextTitle();
};

#endif  // TEXT_HPP
