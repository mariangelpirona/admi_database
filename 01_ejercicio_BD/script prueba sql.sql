create database prueba;
use prueba; 

create table usuario(id INT, username varchar(50) , password varchar (50));

-- MySQL Script generated by MySQL Workbench
-- Wed Mar 12 12:23:52 2025
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`table1`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`table1` (
)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`tipo usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`tipo usuario` (
  `idtipo usuario` INT NOT NULL AUTO_INCREMENT,
  `nombre_tipo` VARCHAR(50) NOT NULL,
  `descripcion_tipo` VARCHAR(200) NOT NULL,
  PRIMARY KEY (`idtipo usuario`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`usuario` (
  `idusuario` INT NOT NULL AUTO_INCREMENT,
  `nombre_usuario` VARCHAR(100) NOT NULL,
  `password` VARCHAR(100) NOT NULL,
  `gmail` VARCHAR(100) NOT NULL,
  `telefono` VARCHAR(15) NOT NULL,
  `tipo usuario_idtipo usuario` INT NOT NULL,
  PRIMARY KEY (`idusuario`, `tipo usuario_idtipo usuario`),
  UNIQUE INDEX `gmail_UNIQUE` (`gmail` ASC) VISIBLE,
  UNIQUE INDEX `telefono_UNIQUE` (`telefono` ASC) VISIBLE,
  INDEX `fk_usuario_tipo usuario_idx` (`tipo usuario_idtipo usuario` ASC) VISIBLE,
  CONSTRAINT `fk_usuario_tipo usuario`
    FOREIGN KEY (`tipo usuario_idtipo usuario`)
    REFERENCES `mydb`.`tipo usuario` (`idtipo usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
