USE app_adocao;
#--------------------------------------------------------------------------------------------------------
#----- Usuarios
#--------------------------------------------------------------------------------------------------------
INSERT INTO usuario (user_password, firstName, lastName, phone, 
                     email, facebookProfile, gender, birthdayDate)	
VALUES (123, 'Thiago', 'Porto', 999, 'trporto@inf.edu.br', 'Thiago Porto', 'M','1994-01-07');

INSERT INTO usuario (user_password, isAdmin, firstName, lastName, phone, 
                     email, registerConfirmed, gender, birthdayDate)	
VALUES (789, 1, 'Fulano', 'DiTal', 9998, 'fulano@gmail.com', 1, 'M','1989-05-27');

INSERT INTO usuario (user_password, isAdmin, firstName, lastName, phone, 
                     email, registerConfirmed, gender,facebookProfile, birthdayDate)	
VALUES (789, 1, 'Ciclano', 'Silva', 9789, 'ciclano@hotmail.com', 1, 'M', 'Ciclano', '1989-05-27');

INSERT INTO usuario (user_password, firstName, lastName, phone, 
                     email, gender, birthdayDate)	
VALUES (666, 'Morgana', 'Le Fay', 7891, 'mlfay@yahoo.com','F','1150-02-06');

INSERT INTO usuario (user_password, firstName, lastName, phone, 
                     email, gender, facebookProfile, birthdayDate)	
VALUES (567, 'Morrighan', 'WW', 0291, 'mrrghan@hotmail.com','F','Morrighan', '2009-11-03');

INSERT INTO usuario (user_password, firstName, lastName, phone, 
                     email, gender, birthdayDate)	
VALUES (679, 'Jon', 'Irenicus', 1646, 'jirenicus@gmail.com','M','2000-11-21');
#--------------------------------------------------------------------------------------------------------
#--------------------------------------------------------------------------------------------------------

#--------------------------------------------------------------------------------------------------------
#----- Imagens
#--------------------------------------------------------------------------------------------------------
INSERT INTO imagem(uri)
VALUES ('https://www.rd.com/wp-content/uploads/2021/01/GettyImages-1175550351.jpg?resize=1536,1004'),
       ('https://itpetblog.com.br/wp-content/uploads/2019/07/grumpy-cat.jpg'),
       ('https://www.dci.com.br/wp-content/uploads/2020/09/1300x0_1568662224_5d7fe2d09bccd-450x300.jpeg'),
       ('https://www.azpetshop.com.br/blog/wp-content/uploads/2020/12/husky-siberiano-raca-683x1024.jpg');
#--------------------------------------------------------------------------------------------------------
#--------------------------------------------------------------------------------------------------------

#--------------------------------------------------------------------------------------------------------
#----- Localizacoes
#--------------------------------------------------------------------------------------------------------
INSERT INTO localizacao (address, number, city, state, zipcode, complement, neighborhood)
VALUES ('Rua Baker', 221, 'Londrina', 'Parana', 8910, 'B', 'Vivendas do Arvoredo'), 
       ('Rua Abilio Braga', 167, 'Canguçu', 'Rio Grande do Sul', 96600000, 'B', 'Centro'); 

INSERT INTO localizacao (address, number, city, state, zipcode, neighborhood)
VALUES ('Citadel Street', 6103, 'Baldurs Gate', 'Rio de Janeiro', 57550348, 'Upper City'), 
       ('Rua Carlos Dreher Neto', 6107, 'Bento Gonçalves', 'Rio Grande do Sul', 8910, 'Industrial'), 
       ('Avenida Assis Brasil', 456, 'Porto Alegre', 'Rio Grande do Sul', 843250, 'Passo da Areia'),  
       ('Rua Gomes Carneiro', 01, 'Pelotas', 'Rio Grande do Sul', 96010610, 'Balsa'), 
       ('Avenida Getúlio Vargas', 221, 'São Lourenço do Sul', 'Rio Grande do Sul', 8910, 'Nereidas'), 
       ('Avenida São João', 401, 'São Lourenço do Sul', 'Rio Grande do Sul', 546545, 'Nereidas'), 
       ('Rua Serra de Bragança', 762, 'Jundiaí', 'São Paulo', 03318000, 'Vila Joana'), 
       ('Rua Alfredo Dreschler', 366, 'Gramado', 'Rio Grande do Sul', 95670000, 'Lago Negro');
#--------------------------------------------------------------------------------------------------------
#--------------------------------------------------------------------------------------------------------

#--------------------------------------------------------------------------------------------------------
#----- Usuarios\Localizacoes
#--------------------------------------------------------------------------------------------------------
INSERT INTO localizacoes(idUsuario, idLocalizacao)
VALUES (1, 2), (1, 7),
       (2, 1), (2, 9),
       (3, 6), (3, 9),
       (4, 10), (4, 4),
       (5, 8),
       (6, 3), (6, 5);         
#--------------------------------------------------------------------------------------------------------
#--------------------------------------------------------------------------------------------------------

#--------------------------------------------------------------------------------------------------------
#----- Pets
#--------------------------------------------------------------------------------------------------------
INSERT INTO pet(name, specie, gender, protectorId, imageID)
VALUES ('Morgana', 'Gato', 'F', 6, 2),
       ('REX', 'Cachorro', 'M', 4, 3),
       ('Salen', 'Gato', 'M', 5, 1),
       ('Natasha', 'Cachorro', 'F', 1, 4);
#--------------------------------------------------------------------------------------------------------
#--------------------------------------------------------------------------------------------------------

#--------------------------------------------------------------------------------------------------------
#----- Adocoes
#--------------------------------------------------------------------------------------------------------
INSERT INTO adocao (adopterId, petId)
VALUES (1, 1), (1, 3),
       (6, 2); 
#--------------------------------------------------------------------------------------------------------
#--------------------------------------------------------------------------------------------------------

#--------------------------------------------------------------------------------------------------------
#----- Avaliacoes
#--------------------------------------------------------------------------------------------------------
INSERT INTO avalia( ratedAs, score, told, userId, adoptionId)
VALUES ('A', 4, 'BLA BLA BLA', 1, 1),
       ('P', 3, 'BLA BLA', 6, 3);   
#--------------------------------------------------------------------------------------------------------
#--------------------------------------------------------------------------------------------------------