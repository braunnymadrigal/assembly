/*
 Copyright 2024 "Charlie's Angels"
	   <HENOC.ROJAS@ucr.ac.cr>
	   <BRAUNNY.MADRIGAL@ucr.ac.cr>
	   <KENDALL.VILLAFUERTE@ucr.ac.cr>
	   <MARCELO.PICADO@ucr.ac.cr>
	   <RODRIGO.CARBALLO@ucr.ac.cr>
*/

#include "Button.hpp"

void Button::initTextures() {
	if (!this->buttonHelpTexture.loadFromFile("myMedia/help.png")) {
		throw std::runtime_error("Failed to load help.png");
	}
	if (!this->buttonPlayTexture.loadFromFile("myMedia/play.png")) {
		throw std::runtime_error("Failed to load play.png");
	}
}

void Button::initSprites() {
	this->buttonHelpSprite.setTexture(buttonHelpTexture);
	this->buttonHelpSprite.setTextureRect(sf::IntRect(0, 0, this->buttonWidth, this->buttonHeight));
	this->buttonHelpSprite.setPosition(static_cast<float>(this->buttonHelpX), static_cast<float>(this->buttonHelpY));
	this->buttonPlaySprite.setTexture(buttonPlayTexture);
	this->buttonPlaySprite.setTextureRect(sf::IntRect(0, 0, this->buttonWidth, this->buttonHeight));
	this->buttonPlaySprite.setPosition(static_cast<float>(this->buttonPlayX), static_cast<float>(this->buttonPlayY));
}

Button::Button() {
	this->buttonHeight = 50;
	this->buttonWidth = 100;
	this->buttonHelpX = 100;
	this->buttonHelpY = 280;
	this->buttonPlayX = 100;
	this->buttonPlayY = 350;
	this->initTextures();
	this->initSprites();
}

Button::~Button() {}

bool Button::isButtonPlayClicked(int mouseX, int mouseY) {
	bool isMouseXInLine = CheckPointInLine(mouseX, this->buttonPlayX, Sum(this->buttonPlayX, this->buttonWidth)) == 1;
	bool isMouseYInLine = CheckPointInLine(mouseY, this->buttonPlayY, Sum(this->buttonPlayY, this->buttonHeight)) == 1;
	return isMouseXInLine && isMouseYInLine;
}

bool Button::isButtonHelpClicked(int mouseX, int mouseY) {
	bool isMouseXInLine = CheckPointInLine(mouseX, this->buttonHelpX, Sum(this->buttonHelpX, this->buttonWidth)) == 1;
	bool isMouseYInLine = CheckPointInLine(mouseY, this->buttonHelpY, Sum(this->buttonHelpY, this->buttonHeight)) == 1;
	return isMouseXInLine && isMouseYInLine;
}

sf::Sprite Button::getButtonPlay() {return this->buttonPlaySprite;}

sf::Sprite Button::getButtonHelp() {return this->buttonHelpSprite;}
