CREATE DATABASE IF NOT EXISTS app_adocao; 
USE app_adocao;
#--------------------------------------------------------------------------------------------------------
#----- Criacao das Tabelas
#-------------------------------------------------------------------------------------------------------- 

CREATE TABLE IF NOT EXISTS usuario(
    id INT NOT NULL AUTO_INCREMENT  PRIMARY KEY,
    isOnline TINYINT(1) NOT NULL DEFAULT 1,
    createdAt DATE NOT NULL DEFAULT CURRENT_DATE,
    user_password CHAR(16) NOT NULL,
    isAdmin TINYINT(1) NOT NULL DEFAULT 0,
    registerConfirmed TINYINT(1) NOT NULL DEFAULT 0,
    firstName VARCHAR(30) NOT NULL,
    lastName VARCHAR(30) NOT NULL,
    phone INT NOT NULL,
    email VARCHAR(30) NOT NULL,
    facebookProfile VARCHAR(30),
    gender CHAR(1) NOT NULL CHECK(gender  = 'M' or gender  = 'F' or gender = 'U'),
    birthdayDate DATE,
    imageId INT
);
#--------------------------------------------------------------------------------------------------------
#--------------------------------------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS imagem(
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    uri VARCHAR(255) NOT NULL
);

ALTER TABLE usuario ADD FOREIGN KEY(imageId) 
				REFERENCES imagem(id) 
                    		ON DELETE CASCADE;
#--------------------------------------------------------------------------------------------------------
#--------------------------------------------------------------------------------------------------------
  
CREATE TABLE IF NOT EXISTS localizacao(
    id INT NOT NULL AUTO_INCREMENT  PRIMARY KEY, 
    address VARCHAR(60) NOT NULL, 
    number INT NOT NULL,  
    city VARCHAR(30) NOT NULL, 
    state VARCHAR(30) NOT NULL, 
    zipcode INT NOT NULL,
    complement CHAR(20),
	neighborhood VARCHAR(30) NOT NULL
);
#--------------------------------------------------------------------------------------------------------
#--------------------------------------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS localizacoes(
    idLocalizacao INT NOT NULL,
    idUsuario INT NOT NULL,
    PRIMARY KEY(idUsuario, idLocalizacao),
	FOREIGN KEY (idLocalizacao) 
		REFERENCES localizacao(id),
	FOREIGN KEY (idUsuario) 
		REFERENCES usuario(id)
);
#--------------------------------------------------------------------------------------------------------
#--------------------------------------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS pet(
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY, 
    name VARCHAR(30) NOT NULL, 
    specie VARCHAR(30) NOT NULL, 
    gender CHAR(1) NOT NULL CHECK (gender = 'M' or gender  = 'F'), 
    simpleDescription CHAR(60), 
    detailedDescription CHAR(200), 
    size INT,
    birthdayDate DATE, 
    createdAt DATE NOT NULL DEFAULT CURRENT_DATE 
    protectorId INT NOT NULL, 
    imageID INT,
    FOREIGN KEY (protectorId)
    	REFERENCES usuario(id),
    FOREIGN KEY (imageID)
    	REFERENCES imagem(id)
    	ON DELETE CASCADE
);
#--------------------------------------------------------------------------------------------------------
#--------------------------------------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS adocao(
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY, 
    message CHAR(200), 
    approvedAt DATE,
    cancelledAt DATE, 
    createdAt DATE NOT NULL DEFAULT CURRENT_DATE, 
    adopterId INT NOT NULL,
	petId INT NOT NULL,
    FOREIGN KEY (adopterId)
    	REFERENCES usuario(id),
    FOREIGN KEY (petId)
    	REFERENCES pet(Id)
);
#--------------------------------------------------------------------------------------------------------
#--------------------------------------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS avalia(
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY, 
    createdAt DATE NOT NULL DEFAULT CURRENT_DATE, 
    ratedAs CHAR(1) NOT NULL CHECK (ratedAs = 'A' or ratedAs  = 'P'), 
    score INT(1) NOT NULL CHECK ( 0 <= score <= 5),
    told CHAR(200), 
    userId INT NOT NULL, 
    adoptionId INT NOT NULL,
    FOREIGN KEY (userId)
    	REFERENCES usuario(id),
    FOREIGN KEY (adoptionId)
    	REFERENCES adocao(id)
);
#--------------------------------------------------------------------------------------------------------
#--------------------------------------------------------------------------------------------------------