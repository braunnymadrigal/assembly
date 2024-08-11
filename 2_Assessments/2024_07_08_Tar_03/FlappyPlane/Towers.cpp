/*
 Copyright 2024 "Charlie's Angels"
       <HENOC.ROJAS@ucr.ac.cr>
       <BRAUNNY.MADRIGAL@ucr.ac.cr>
       <KENDALL.VILLAFUERTE@ucr.ac.cr>
       <MARCELO.PICADO@ucr.ac.cr>
       <RODRIGO.CARBALLO@ucr.ac.cr>
*/

#include "Towers.hpp"

void Towers::initTexture() {
    if (!this->towerBotTexture.loadFromFile("myMedia/towerBot.png")) {
        throw std::runtime_error("Failed to load towerBot.png");
    }
    if (!this->towerTopTexture.loadFromFile("myMedia/towerTop.png")) {
        throw std::runtime_error("Failed to load towerTop.png");
    }
}

void Towers::initSprites() {
    this->tLeftTop.setTexture(towerTopTexture);
    this->tLeftTop.setTextureRect(sf::IntRect(0, 0, this->towerWidth, this->towerHeight));
    this->tLeftTop.setPosition(140.f, -70.f);
    this->tLeftBot.setTexture(towerBotTexture);
    this->tLeftBot.setTextureRect(sf::IntRect(0, 0, this->towerWidth, this->towerHeight));
    this->tLeftBot.setPosition(140.f, 240.f);
    this->tRighTop.setTexture(towerTopTexture);
    this->tRighTop.setTextureRect(sf::IntRect(0, 0, this->towerWidth, this->towerHeight));
    this->tRighTop.setPosition(330.f, -70.f);
    this->tRighBot.setTexture(towerBotTexture);
    this->tRighBot.setTextureRect(sf::IntRect(0, 0, this->towerWidth, this->towerHeight));
    this->tRighBot.setPosition(330.f, 240.f);
}

Towers::Towers() {
    this->towerHeight = 230;
    this->towerWidth = 74;
    this->initTexture();
    this->initSprites();
}

Towers::~Towers() {}

void Towers::moveTowers() {
    int speed = 2;
    if (tLeftBot.getPosition().x <= -74) {
        int max = 70;
        int min = -70;
        int yAdder = rand() % Sum((Sum(max, -min), 1), min);
        this->tLeftTop.setPosition(static_cast<float>(Sum(300, speed)), static_cast<float>(Sum(- 70, yAdder)));
        this->tLeftBot.setPosition(static_cast<float>(Sum(300, speed)), static_cast<float>(Sum(240, yAdder)));
    } else if (tRighBot.getPosition().x <= -74) {
        int max = 70;
        int min = -70;
        int yAdder = rand() % Sum( (Sum(max,-min),1 ), min);
        this->tRighTop.setPosition(static_cast<float>(Sum(300, speed)), static_cast<float>(Sum(-70, yAdder)));
        this->tRighBot.setPosition(static_cast<float>(Sum(300, speed)), static_cast<float>(Sum(240, yAdder)));
    }
    speed = speed * (-1);
    this->tLeftBot.move(static_cast<float>(speed), 0.f);
    this->tLeftTop.move(static_cast<float>(speed), 0.f);
    this->tRighTop.move(static_cast<float>(speed), 0.f);
    this->tRighBot.move(static_cast<float>(speed), 0.f);
}

std::vector<int> Towers::getCoordinates() {
    sf::Vector2f tLeftBotCoord = this->tLeftBot.getPosition();
    sf::Vector2f tLeftTopCoord = this->tLeftTop.getPosition();
    sf::Vector2f tRighTopCoord = this->tRighTop.getPosition();
    sf::Vector2f tRighBotCoord = this->tRighBot.getPosition();
    int tLeftBotX = static_cast<int>(tLeftBotCoord.x);
    int tLeftBotY = static_cast<int>(tLeftBotCoord.y);
    int tLeftTopX = static_cast<int>(tLeftTopCoord.x);
    int tLeftTopY = static_cast<int>(tLeftTopCoord.y);
    int tRighBotX = static_cast<int>(tRighBotCoord.x);
    int tRighBotY = static_cast<int>(tRighBotCoord.y);
    int tRighTopX = static_cast<int>(tRighTopCoord.x);
    int tRighTopY = static_cast<int>(tRighTopCoord.y);
    return std::vector<int>{tLeftBotX,tLeftBotY,tLeftTopX,tLeftTopY,tRighBotX,tRighBotY,tRighTopX,tRighTopY};
}

void Towers::setOriginalPosition() {
    this->tLeftTop.setPosition(140.f, -70.f);
    this->tLeftBot.setPosition(140.f, 240.f);
    this->tRighTop.setPosition(330.f, -70.f);
    this->tRighBot.setPosition(330.f, 240.f);
}

sf::Sprite Towers::getTLeftTop() {return this->tLeftTop;}

sf::Sprite Towers::getTLeftBot() {return this->tLeftBot;}

sf::Sprite Towers::getTRighBot() {return this->tRighBot;}

sf::Sprite Towers::getTRighTop() {return this->tRighTop;}

int Towers::getTowerHeight() {return this->towerHeight;}

int Towers::getTowerWidth() {return this->towerWidth;}
