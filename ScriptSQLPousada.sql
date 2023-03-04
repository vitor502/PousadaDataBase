-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema pousada
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema pousada
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `pousada` DEFAULT CHARACTER SET utf8mb4 ;
USE `pousada` ;

-- -----------------------------------------------------
-- Table `pousada`.`funcionario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pousada`.`funcionario` (
  `ID` INT(11) NOT NULL AUTO_INCREMENT,
  `NOME` VARCHAR(100) NOT NULL,
  `DATA_NASC` DATE NOT NULL,
  `CPF` VARCHAR(9) NOT NULL,
  `RG` VARCHAR(15) NULL DEFAULT NULL,
  `ADMISSAO` DATE NOT NULL,
  `DEMISSAO` DATE NULL DEFAULT NULL,
  PRIMARY KEY (`ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `pousada`.`cargo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pousada`.`cargo` (
  `ID` INT(11) NOT NULL AUTO_INCREMENT,
  `PERIODO` VARCHAR(5) NOT NULL,
  `SALARIO` FLOAT(7,2) NOT NULL,
  `DATA_ENTRADA` DATETIME NOT NULL,
  `DATA_SAIDA` DATETIME NOT NULL,
  `DESCRICAO` TEXT NOT NULL,
  `funcionario_ID` INT(11) NOT NULL,
  PRIMARY KEY (`ID`),
  INDEX `fk_cargo_funcionario1_idx` (`funcionario_ID` ASC),
  CONSTRAINT `fk_cargo_funcionario1`
    FOREIGN KEY (`funcionario_ID`)
    REFERENCES `pousada`.`funcionario` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `pousada`.`cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pousada`.`cliente` (
  `ID` INT(11) NOT NULL AUTO_INCREMENT,
  `NOME` VARCHAR(100) NOT NULL,
  `CPF` VARCHAR(45) NOT NULL,
  `PASSWORD` VARCHAR(10) NOT NULL,
  `RG` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `pousada`.`cartao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pousada`.`cartao` (
  `ID` INT(11) NOT NULL AUTO_INCREMENT,
  `NUMERO` VARCHAR(16) NOT NULL,
  `VALIDADE` VARCHAR(5) NOT NULL,
  `CVV` VARCHAR(3) NOT NULL,
  `TIPO` VARCHAR(22) NOT NULL,
  `cliente_ID` INT(11) NOT NULL,
  PRIMARY KEY (`ID`),
  INDEX `fk_cartao_cliente1_idx` (`cliente_ID` ASC),
  CONSTRAINT `fk_cartao_cliente1`
    FOREIGN KEY (`cliente_ID`)
    REFERENCES `pousada`.`cliente` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `pousada`.`email_cli`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pousada`.`email_cli` (
  `ID` INT(11) NOT NULL,
  `EMAIL` VARCHAR(60) NOT NULL,
  `cliente_ID` INT(11) NOT NULL,
  PRIMARY KEY (`ID`),
  INDEX `fk_email_cli_cliente_idx` (`cliente_ID` ASC),
  CONSTRAINT `fk_email_cli_cliente`
    FOREIGN KEY (`cliente_ID`)
    REFERENCES `pousada`.`cliente` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `pousada`.`email_func`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pousada`.`email_func` (
  `ID` INT(11) NOT NULL AUTO_INCREMENT,
  `EMAIL` VARCHAR(60) NOT NULL,
  `funcionario_ID` INT(11) NOT NULL,
  PRIMARY KEY (`ID`),
  INDEX `fk_email_func_funcionario1_idx` (`funcionario_ID` ASC),
  CONSTRAINT `fk_email_func_funcionario1`
    FOREIGN KEY (`funcionario_ID`)
    REFERENCES `pousada`.`funcionario` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `pousada`.`endereco_cli`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pousada`.`endereco_cli` (
  `ID` INT(11) NOT NULL AUTO_INCREMENT,
  `LOGRADOURO` VARCHAR(35) NOT NULL,
  `NUMERO` VARCHAR(5) NOT NULL,
  `CIDADE` VARCHAR(20) NOT NULL,
  `UF` VARCHAR(2) NOT NULL,
  `BAIRRO` VARCHAR(20) NOT NULL,
  `CEP` VARCHAR(8) NOT NULL,
  `COMPLEMENTO` VARCHAR(4) NULL DEFAULT NULL,
  `cliente_ID` INT(11) NOT NULL,
  PRIMARY KEY (`ID`),
  INDEX `fk_endereco_cli_cliente1_idx` (`cliente_ID` ASC),
  CONSTRAINT `fk_endereco_cli_cliente1`
    FOREIGN KEY (`cliente_ID`)
    REFERENCES `pousada`.`cliente` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `pousada`.`endereco_func`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pousada`.`endereco_func` (
  `ID` INT(11) NOT NULL AUTO_INCREMENT,
  `LOGRADOURO` VARCHAR(35) NOT NULL,
  `NUMERO` VARCHAR(5) NOT NULL,
  `CIDADE` VARCHAR(20) NOT NULL,
  `UF` VARCHAR(2) NOT NULL,
  `BAIRRO` VARCHAR(20) NOT NULL,
  `CEP` VARCHAR(8) NOT NULL,
  `COMPLEMENTO` VARCHAR(4) NOT NULL,
  `funcionario_ID` INT(11) NOT NULL,
  PRIMARY KEY (`ID`),
  INDEX `fk_endereco_func_funcionario1_idx` (`funcionario_ID` ASC),
  CONSTRAINT `fk_endereco_func_funcionario1`
    FOREIGN KEY (`funcionario_ID`)
    REFERENCES `pousada`.`funcionario` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `pousada`.`pagamento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pousada`.`pagamento` (
  `ID` INT(11) NOT NULL AUTO_INCREMENT,
  `TIPO` VARCHAR(22) NOT NULL,
  `PRECO` FLOAT(4,2) NOT NULL,
  `cartao_ID` INT(11) NOT NULL,
  PRIMARY KEY (`ID`),
  INDEX `fk_pagamento_cartao1_idx` (`cartao_ID` ASC),
  CONSTRAINT `fk_pagamento_cartao1`
    FOREIGN KEY (`cartao_ID`)
    REFERENCES `pousada`.`cartao` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `pousada`.`status`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pousada`.`status` (
  `ID` INT(11) NOT NULL AUTO_INCREMENT,
  `STATUS` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `pousada`.`pedido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pousada`.`pedido` (
  `ID` INT(11) NOT NULL,
  `DATA_ATUAL` DATETIME NOT NULL,
  `DATA_FINAL` DATETIME NOT NULL,
  `MOTIVO_NEGATIVO` VARCHAR(45) NOT NULL,
  `ACOMPANHANTES` INT(11) NOT NULL,
  `cliente_ID` INT(11) NOT NULL,
  `funcionario_ID` INT(11) NOT NULL,
  `status_ID` INT(11) NOT NULL,
  PRIMARY KEY (`ID`),
  INDEX `fk_pedido_cliente1_idx` (`cliente_ID` ASC),
  INDEX `fk_pedido_funcionario1_idx` (`funcionario_ID` ASC),
  INDEX `fk_pedido_status1_idx` (`status_ID` ASC),
  CONSTRAINT `fk_pedido_cliente1`
    FOREIGN KEY (`cliente_ID`)
    REFERENCES `pousada`.`cliente` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pedido_funcionario1`
    FOREIGN KEY (`funcionario_ID`)
    REFERENCES `pousada`.`funcionario` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pedido_status1`
    FOREIGN KEY (`status_ID`)
    REFERENCES `pousada`.`status` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `pousada`.`quartos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pousada`.`quartos` (
  `ID` INT(11) NOT NULL AUTO_INCREMENT,
  `QUARTO` VARCHAR(50) NOT NULL,
  `status_ID` INT(11) NOT NULL,
  PRIMARY KEY (`ID`, `status_ID`),
  INDEX `fk_quartos_status1_idx` (`status_ID` ASC),
  CONSTRAINT `fk_quartos_status1`
    FOREIGN KEY (`status_ID`)
    REFERENCES `pousada`.`status` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `pousada`.`reserva`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pousada`.`reserva` (
  `ID` INT(11) NOT NULL AUTO_INCREMENT,
  `status_ID` INT(11) NOT NULL,
  `pedido_ID` INT(11) NOT NULL,
  `quartos_ID` INT(11) NOT NULL,
  `quartos_status_ID` INT(11) NOT NULL,
  PRIMARY KEY (`ID`),
  INDEX `fk_reserva_status1_idx` (`status_ID` ASC),
  INDEX `fk_reserva_pedido1_idx` (`pedido_ID` ASC),
  INDEX `fk_reserva_quartos1_idx` (`quartos_ID` ASC, `quartos_status_ID` ASC),
  CONSTRAINT `fk_reserva_status1`
    FOREIGN KEY (`status_ID`)
    REFERENCES `pousada`.`status` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_reserva_pedido1`
    FOREIGN KEY (`pedido_ID`)
    REFERENCES `pousada`.`pedido` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_reserva_quartos1`
    FOREIGN KEY (`quartos_ID` , `quartos_status_ID`)
    REFERENCES `pousada`.`quartos` (`ID` , `status_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `pousada`.`telefone_cli`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pousada`.`telefone_cli` (
  `ID` INT(11) NOT NULL AUTO_INCREMENT,
  `CELULAR` VARCHAR(16) NOT NULL,
  `TELEFONE` VARCHAR(14) NOT NULL,
  `cliente_ID` INT(11) NOT NULL,
  PRIMARY KEY (`ID`),
  INDEX `fk_telefone_cli_cliente1_idx` (`cliente_ID` ASC),
  CONSTRAINT `fk_telefone_cli_cliente1`
    FOREIGN KEY (`cliente_ID`)
    REFERENCES `pousada`.`cliente` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `pousada`.`telefone_func`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pousada`.`telefone_func` (
  `ID` INT(11) NOT NULL AUTO_INCREMENT,
  `CELULAR` VARCHAR(16) NOT NULL,
  `TELEFONE` VARCHAR(14) NOT NULL,
  `funcionario_ID` INT(11) NOT NULL,
  PRIMARY KEY (`ID`),
  INDEX `fk_telefone_func_funcionario1_idx` (`funcionario_ID` ASC),
  CONSTRAINT `fk_telefone_func_funcionario1`
    FOREIGN KEY (`funcionario_ID`)
    REFERENCES `pousada`.`funcionario` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;