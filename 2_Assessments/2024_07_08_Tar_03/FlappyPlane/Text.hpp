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
	std::stringstream streamScore;  /**< Stream para el texto de la puntuaci�n. */
	sf::Text textScore;  /**< Texto para la puntuaci�n. */
	std::string stringInfo;  /**< String para la informaci�n del juego. */
	sf::Text textInfo;  /**< Texto para la informaci�n del juego. */
	std::string stringTitle;  /**< String para el t�tulo del juego. */
	sf::Text textTitle;  /**< Texto para el t�tulo del juego. */

private:
	/**
	 * @brief Inicializa la fuente del texto.
	 *
	 * @throws std::runtime_error si no se puede cargar el archivo.
	 */
	void initFont();

	/**
	 * @brief Inicializa el texto de la puntuaci�n.
	 */
	void initTextScore();

	/**
	 * @brief Inicializa el texto de la informaci�n del juego.
	 */
	void initTextInfo();

	/**
	 * @brief Inicializa el texto del t�tulo del juego.
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
	 * @brief Sobreescribe el texto de la puntuaci�n.
	 *
	 * @param score Puntuaci�n actual del juego.
	 */
	void setTextScore(int score);

	/**
	 * @brief Obtiene el texto de la puntuaci�n.
	 *
	 * @return sf::Text Texto de la puntuaci�n.
	 */

	sf::Text getTextScore();

	/**
	 * @brief Obtiene el texto de la informaci�n del juego.
	 *
	 * @return sf::Text Texto de la informaci�n del juego.
	 */
	sf::Text getTextInfo();

	/**
	 * @brief Obtiene el texto del t�tulo del juego.
	 *
	 * @return sf::Text Texto del t�tulo del juego.
	 */
	sf::Text getTextTitle();
};

#endif  // TEXT_HPP
