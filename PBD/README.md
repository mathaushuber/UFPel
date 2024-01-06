# Animal Adoption App Database

## Overview

This repository contains the database schema for an Animal Adoption App. The SQL script defines tables and relationships to manage users, pets, adoption records, locations, images, and evaluations.

## Database Structure

### User Table (`usuario`)

- **Columns:**
  - `id`: User ID (Primary Key)
  - `isOnline`: Online status (1 for online, 0 for offline)
  - `createdAt`: Date of user registration
  - `user_password`: User password
  - `isAdmin`: Admin status (1 for admin, 0 for regular user)
  - `registerConfirmed`: Confirmation status of user registration
  - `firstName`: First name of the user
  - `lastName`: Last name of the user
  - `phone`: User's phone number
  - `email`: User's email address
  - `facebookProfile`: User's Facebook profile (optional)
  - `gender`: User's gender (M, F, or U for undefined)
  - `birthdayDate`: User's date of birth
  - `imageId`: Foreign key referencing the `imagem` table

### Image Table (`imagem`)

- **Columns:**
  - `id`: Image ID (Primary Key)
  - `uri`: Image URI (file path or URL)

### Location Table (`localizacao`)

- **Columns:**
  - `id`: Location ID (Primary Key)
  - `address`: Street address
  - `number`: Street number
  - `city`: City
  - `state`: State
  - `zipcode`: Zip code
  - `complement`: Additional address details (optional)
  - `neighborhood`: Neighborhood

### User Location Table (`localizacoes`)

- **Columns:**
  - `idLocalizacao`: Foreign key referencing the `localizacao` table
  - `idUsuario`: Foreign key referencing the `usuario` table (User ID)
  - *Primary Key:* Composite key of `idUsuario` and `idLocalizacao`

### Pet Table (`pet`)

- **Columns:**
  - `id`: Pet ID (Primary Key)
  - `name`: Pet name
  - `specie`: Pet species
  - `gender`: Pet gender (M or F)
  - `simpleDescription`: Brief description of the pet
  - `detailedDescription`: Detailed description of the pet
  - `size`: Pet size
  - `birthdayDate`: Pet's date of birth
  - `createdAt`: Date of pet registration
  - `protectorId`: Foreign key referencing the `usuario` table (User ID)
  - `imageID`: Foreign key referencing the `imagem` table

### Adoption Table (`adocao`)

- **Columns:**
  - `id`: Adoption ID (Primary Key)
  - `message`: Adoption message
  - `approvedAt`: Date of adoption approval
  - `cancelledAt`: Date of adoption cancellation
  - `createdAt`: Date of adoption request
  - `adopterId`: Foreign key referencing the `usuario` table (Adopter's User ID)
  - `petId`: Foreign key referencing the `pet` table

### Evaluation Table (`avalia`)

- **Columns:**
  - `id`: Evaluation ID (Primary Key)
  - `createdAt`: Date of evaluation
  - `ratedAs`: Rating status (A for positive, P for negative)
  - `score`: Numeric score (0 to 5)
  - `told`: Additional comments about the adoption experience
  - `userId`: Foreign key referencing the `usuario` table (User ID)
  - `adoptionId`: Foreign key referencing the `adocao` table

## Conclusion

This database schema is designed to effectively manage data for an Animal Adoption App. The structure includes tables for users, pets, adoptions, locations, images, and evaluations, providing a comprehensive solution for the application's needs. Refer to individual table descriptions for detailed information on each entity and its relationships.
