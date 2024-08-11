/*
 Copyright 2024 "Charlie's Angels"
	   <HENOC.ROJAS@ucr.ac.cr>
	   <BRAUNNY.MADRIGAL@ucr.ac.cr>
	   <KENDALL.VILLAFUERTE@ucr.ac.cr>
	   <MARCELO.PICADO@ucr.ac.cr>
	   <RODRIGO.CARBALLO@ucr.ac.cr>
*/

#include "Text.hpp"

void Text::initFont() {
	if (!this->font.loadFromFile("myMedia/arial.ttf")) {
		throw std::runtime_error("Failed to load arial.ttf");
	}
}

void Text::initTextScore() {
	this->streamScore << "SCORE: 0";
	this->textScore.setFont(this->font);
	this->textScore.setString(this->streamScore.str());
	this->textScore.setCharacterSize(14);
	this->textScore.setFillColor(sf::Color::Green);
	this->textScore.setOutlineColor(sf::Color::Black);
	this->textScore.setOutlineThickness(1.f);
	this->textScore.setPosition(0.f, 0.f);
}

void Text::initTextInfo() {
	this->stringInfo = "How to Play:\n\n\n";
	this->stringInfo += "\t- Click left mouse button to jump.\n\n";
	this->stringInfo += "\t- Avoid hitting towers.\n\n";
	this->stringInfo += "\t- Avoid hitting the ground.\n\n";
	this->stringInfo += "\t- Avoid flying too high.\n\n";
	this->stringInfo += "\t- Score by passing through gaps.\n\n\n";
	this->stringInfo += "Developed by: Charlie's Angels";
	this->textInfo.setFont(this->font);
	this->textInfo.setString(this->stringInfo);
	this->textInfo.setCharacterSize(16);
	this->textInfo.setFillColor(sf::Color::White);
	this->textInfo.setOutlineColor(sf::Color::Black);
	this->textInfo.setOutlineThickness(1.f);
	this->textInfo.setPosition(15.f, 5.f);
}

void Text::initTextTitle() {
	this->stringTitle = "FLAPPY PLANE";
	this->textTitle.setFont(this->font);
	this->textTitle.setString(this->stringTitle);
	this->textTitle.setCharacterSize(24);
	this->textTitle.setFillColor(sf::Color::Yellow);
	this->textTitle.setOutlineColor(sf::Color::Magenta);
	this->textTitle.setOutlineThickness(2.f);
	this->textTitle.setPosition(50.f, 100.f);
	this->textTitle.setStyle(sf::Text::Bold);
}

Text::Text() {
	this->initFont();
	this->initTextScore();
	this->initTextInfo();
	this->initTextTitle();
}

Text::~Text() {}

void Text::setTextScore(int score) {
	this->streamScore.str("");
	this->streamScore << "SCORE: ";
	this->streamScore << score;
	this->textScore.setString(this->streamScore.str());
}

sf::Text Text::getTextScore() {return this->textScore;}

sf::Text Text::getTextInfo() {return this->textInfo;}

sf::Text Text::getTextTitle() {return this->textTitle;}
