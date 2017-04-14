-- phpMyAdmin SQL Dump
-- version 4.0.10deb1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generato il: Set 07, 2015 alle 14:15
-- Versione del server: 5.5.44-0ubuntu0.14.04.1
-- Versione PHP: 5.5.9-1ubuntu4.11

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `LiquoriVeneto`
--
CREATE DATABASE IF NOT EXISTS `LiquoriVeneto` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `LiquoriVeneto`;

DELIMITER $$
--
-- Procedure
--
DROP PROCEDURE IF EXISTS `nuovafattura`$$
CREATE DEFINER=`asasso`@`localhost` PROCEDURE `nuovafattura`(IN `fid` VARCHAR(5), IN `fdata` DATE, IN `fvenditore` VARCHAR(16), IN `fcliente` CHAR(11))
begin
declare ftotale decimal(8,2);
			SELECT sum(totu) into ftotale
			FROM (SELECT fattura, prodotto, SUM( prezzo ) * unita as totu
				FROM prodotto, riga_fattura
				WHERE prodotto.codice = riga_fattura.prodotto
				GROUP BY fattura, prodotto) AS p
            where fattura=fid
			GROUP BY fattura;
insert into fattura(id,data,venditore,cliente,totale) values(fid,fdata,fvenditore,fcliente,ftotale);
end$$

DROP PROCEDURE IF EXISTS `nuovovenditore`$$
CREATE DEFINER=`asasso`@`localhost` PROCEDURE `nuovovenditore`(IN `vcod_fis` VARCHAR(16), IN `vkm_cor` DECIMAL(8,2))
begin
if exists(select * from dipendente where cod_fis=vcod_fis and mansione="vendite") 
then insert into venditore(cod_fis,km_cor) values(vcod_fis,vkm_cor);
else insert into venditore select* from venditore limit 1; end if; end$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Struttura della tabella `autovettura`
--

DROP TABLE IF EXISTS `autovettura`;
CREATE TABLE IF NOT EXISTS `autovettura` (
  `targa` char(7) NOT NULL,
  `modello` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`targa`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dump dei dati per la tabella `autovettura`
--

INSERT INTO `autovettura` (`targa`, `modello`) VALUES
('DV361GT', 'Opel Astra'),
('EA204RR', 'Renault  Clio'),
('EX579ZC', 'Seat Ibiza');

-- --------------------------------------------------------

--
-- Struttura della tabella `cliente`
--

DROP TABLE IF EXISTS `cliente`;
CREATE TABLE IF NOT EXISTS `cliente` (
  `p_iva` char(11) NOT NULL DEFAULT '',
  `nome` varchar(20) DEFAULT NULL,
  `indirizzo` varchar(50) DEFAULT NULL,
  `telefono` varchar(13) DEFAULT NULL,
  `CAP` decimal(5,0) DEFAULT NULL,
  PRIMARY KEY (`p_iva`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dump dei dati per la tabella `cliente`
--

INSERT INTO `cliente` (`p_iva`, `nome`, `indirizzo`, `telefono`, `CAP`) VALUES
('00114601006', 'Luca Bini', 'via Pascoli 79', '0416598764', 35041),
('00137770210', 'Sergio Celli', 'via Spanna 1', '0494576345', 35031),
('00195530043', 'Marino Galli', 'via Verdi 90', '0495634765', 35036),
('00243180239', 'Hotel Terme Patria', 'Via Flacco 32', '0494534566', 35031),
('00488410010', 'Hotel Torino', 'via Romano 56', '0495326345', 35100),
('00962280962', 'Hotel Venezia', 'Via Monteortone 46', '0415676754', 35100),
('01406960284', 'Antenore Bar', 'via S.Pietro 32', '0497610456', 35100),
('02095460982', 'Luciano Testa', 'via Piemonte 2', '0494567342', 35031),
('03231640487', 'Rossi Mario', 'Via Guglielmo 13', '0494657543', 35020),
('03334750589', 'Nicola Belli', 'via Garigliano 65', '0494565432', 35035),
('05927271006', 'Piero Bitti', 'via Roma 41', '0416533875', 35041),
('06954820152', 'Maria Mioni', 'via Rubattino 94', '0498945644', 35031),
('12283130156', 'Bar Nazionale', 'via Settimi 2', '0496523456', 35100),
('12654765431', 'Ciro Silli', 'via Appia Monterosso 4', '0493423100', 36036),
('12717510155', 'Hotel Garden', 'viale Terme 6', '0497623123', 35036),
('12934530150', 'Gino Luci', 'via Europa 11', '0494575357', 35041),
('20128183028', 'Paolo Rossini', 'via Camillo Guidi 22 ', '0498654345', 35100),
('22454410289', 'Da Umberto', 'piazza Meridiana 8', '0497610456', 35100);

-- --------------------------------------------------------

--
-- Struttura della tabella `dipendente`
--

DROP TABLE IF EXISTS `dipendente`;
CREATE TABLE IF NOT EXISTS `dipendente` (
  `cod_fis` varchar(16) NOT NULL,
  `nome` varchar(20) DEFAULT NULL,
  `cognome` varchar(20) DEFAULT NULL,
  `mansione` varchar(20) DEFAULT NULL,
  `indirizzo` varchar(50) DEFAULT NULL,
  `cellulare` varchar(13) DEFAULT NULL,
  PRIMARY KEY (`cod_fis`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dump dei dati per la tabella `dipendente`
--

INSERT INTO `dipendente` (`cod_fis`, `nome`, `cognome`, `mansione`, `indirizzo`, `cellulare`) VALUES
('FRTCLD67A10A546P', 'Claudio', 'Forti', 'contabile', 'via Giove 5', '3384567100'),
('FSSLNZ89C29F342D', 'Lorenzo', 'Fisso', 'vendite', 'via Saluti 9', '3474345331'),
('NRELRT80D14Q231F', 'Alberto', 'Neri', 'vendite', 'via Manzoni 102', '3934565111'),
('NTONDR79T23G456T', 'Andrea', 'Noto', 'vendite', 'via Sorio 73', '3389854322'),
('PLIFLP70L30U765T', 'Filippo', 'Pioli', 'acquisti', 'piazza Scala 3', '3473456765'),
('RNLGRG75L10A432G', 'Giorgio', 'Rinaldi', 'magazziniere', 'via Norma 1', '3934509812'),
('RSSMRA85A21A562S', 'Rossi', 'Mara', 'segretaria', 'via Merola 12', '3474576533');

-- --------------------------------------------------------

--
-- Struttura della tabella `fattura`
--

DROP TABLE IF EXISTS `fattura`;
CREATE TABLE IF NOT EXISTS `fattura` (
  `id` varchar(5) NOT NULL DEFAULT '',
  `data` date NOT NULL DEFAULT '0000-00-00',
  `venditore` varchar(16) DEFAULT NULL,
  `cliente` char(11) DEFAULT NULL,
  `totale` decimal(8,2) DEFAULT NULL,
  `IVA` decimal(8,2) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `cliente` (`cliente`),
  KEY `venditore` (`venditore`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dump dei dati per la tabella `fattura`
--

INSERT INTO `fattura` (`id`, `data`, `venditore`, `cliente`, `totale`, `IVA`) VALUES
('160', '2015-05-02', 'NRELRT80D14Q231F', '00488410010', 50.00, 10.00),
('161', '2015-05-02', 'NRELRT80D14Q231F', '06954820152', 135.00, 27.00),
('162', '2015-05-05', 'FSSLNZ89C29F342D', '01406960284', 120.00, 24.00),
('163', '2015-05-11', 'NTONDR79T23G456T', '00962280962', 143.50, 28.70),
('164', '2015-05-16', 'NTONDR79T23G456T', '00243180239', 587.00, 117.40),
('165', '2015-05-18', 'NRELRT80D14Q231F', '00114601006', 130.00, 26.00),
('166', '2015-06-23', 'NTONDR79T23G456T', '02095460982', 1127.00, 225.40),
('167', '2015-05-25', 'FSSLNZ89C29F342D', '03231640487', 1225.00, 245.00),
('168', '2015-06-01', 'NRELRT80D14Q231F', '03334750589', 81.00, 16.20),
('169', '2015-06-02', 'FSSLNZ89C29F342D', '05927271006', 1300.00, 260.00),
('170', '2015-06-05', 'NTONDR79T23G456T', '06954820152', 600.00, 120.00),
('171', '2015-06-07', 'FSSLNZ89C29F342D', '12654765431', 1237.00, 247.40),
('172', '2015-06-10', 'NRELRT80D14Q231F', '12934530150', 664.00, 132.80),
('173', '2015-06-10', 'NTONDR79T23G456T', '20128183028', 924.40, 184.88),
('174', '2015-06-11', 'FSSLNZ89C29F342D', '22454410289', 1237.50, 247.50),
('175', '2015-06-16', 'NTONDR79T23G456T', '12717510155', 954.00, 190.80),
('176', '2015-06-25', 'NTONDR79T23G456T', '12283130156', 1408.00, 281.60),
('177', '2015-06-27', 'FSSLNZ89C29F342D', '01406960284', 1951.00, 390.20),
('178', '2015-07-01', 'NTONDR79T23G456T', '00962280962', 1456.00, 291.20),
('179', '2015-07-21', 'NTONDR79T23G456T', '00243180239', 2140.25, 428.05),
('180', '2015-07-06', 'FSSLNZ89C29F342D', '00243180239', 2873.00, 574.60),
('181', '2015-07-07', 'NTONDR79T23G456T', '03334750589', 386.50, 77.30),
('182', '2015-07-14', 'FSSLNZ89C29F342D', '00114601006', 45.00, 9.00),
('183', '2015-07-18', 'NRELRT80D14Q231F', '00137770210', 181.50, 36.30),
('184', '2015-07-19', 'FSSLNZ89C29F342D', '00195530043', 101.50, 20.30),
('189', '2015-07-20', 'FSSLNZ89C29F342D', '02095460982', 264.00, 52.80);

--
-- Trigger `fattura`
--
DROP TRIGGER IF EXISTS `calcoloagg`;
DELIMITER //
CREATE TRIGGER `calcoloagg` BEFORE UPDATE ON `fattura`
 FOR EACH ROW set new.IVA=new.totale*20/100
//
DELIMITER ;
DROP TRIGGER IF EXISTS `calcoloiva`;
DELIMITER //
CREATE TRIGGER `calcoloiva` BEFORE INSERT ON `fattura`
 FOR EACH ROW set new.IVA=new.totale*20/100
//
DELIMITER ;

-- --------------------------------------------------------

--
-- Struttura della tabella `prodotto`
--

DROP TABLE IF EXISTS `prodotto`;
CREATE TABLE IF NOT EXISTS `prodotto` (
  `codice` varchar(6) NOT NULL,
  `nome` varchar(40) DEFAULT NULL,
  `marca` varchar(20) DEFAULT NULL,
  `tipo` varchar(20) DEFAULT NULL,
  `nazione` varchar(20) DEFAULT NULL,
  `disponibilita` decimal(9,0) NOT NULL,
  `prezzo` decimal(8,2) NOT NULL,
  `litri` decimal(8,2) DEFAULT NULL,
  `gradazione` decimal(4,1) DEFAULT NULL,
  PRIMARY KEY (`codice`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dump dei dati per la tabella `prodotto`
--

INSERT INTO `prodotto` (`codice`, `nome`, `marca`, `tipo`, `nazione`, `disponibilita`, `prezzo`, `litri`, `gradazione`) VALUES
('22000', 'Gordon''s London Dry Gin', 'Gordon', 'gin', 'UK', 1388, 14.50, 0.70, 40.0),
('22001', 'Hayman''s London Dry Gin', 'Hayman', 'gin', 'UK', 1026, 16.00, 0.75, 40.0),
('22002', 'Hayman''s Old Tom Gin', 'Hayman', 'gin', 'UK', 1690, 18.90, 0.70, 40.0),
('22003', 'Gin Hendrick''s', 'Hendricks', 'gin', 'Scozia', 1065, 27.00, 0.70, 44.0),
('22004', 'Tanqueray London Dry Gin', 'Tanqueray', 'gin', 'Scozia', 1200, 13.00, 0.70, 43.0),
('22005', 'Tanqueray Strong', 'Tanqueray', 'gin', 'Scozia', 1064, 20.00, 0.70, 47.0),
('22006', 'Aviation', 'House Spirits ', 'gin', 'USA', 2009, 28.00, 0.70, 42.0),
('22007', 'Bombay Sapphire ', 'Bombay', 'gin', 'UK', 1130, 28.00, 0.70, 40.0),
('22008', 'Gibson''s London Dry Gin', 'Gibsons', 'gin', 'UK', 1031, 7.50, 0.70, 40.0),
('25432', 'Grey Goose', 'Grey Goose Importing', 'vodka', 'Francia', 1020, 30.00, 1.00, 40.0),
('25433', 'Grey Goose Cherry Noir', 'Grey Goose Importing', 'vodka', 'Francia', 520, 32.00, 1.00, 40.0),
('25434', 'Grey Goose Le Melon', 'Grey Goose Importing', 'vodka', 'Francia', 515, 32.00, 1.00, 40.0),
('33001', 'Calvados La Fontaine', 'La Fontaine', 'brandy', 'Francia', 690, 15.90, 0.70, 40.0),
('33002', 'Courvoisier VSOP', 'Courvoisier', 'cognac', 'Francia', 628, 26.40, 0.70, 40.0),
('33003', 'Remy Martin VSOP', 'Remy Martin', 'cognac', 'Francia', 651, 26.00, 0.70, 40.0),
('33009', 'Angostura', 'Angostura ltd', 'amaro', 'Trinidad e Tobago', 390, 11.00, 0.20, 44.0),
('33010', 'Brandy Stock', 'Stock', 'Brandy', 'Italia', 554, 13.00, 1.00, 28.0),
('33011', 'Hennessy Fine Cognac', 'Hennessy', 'Cognac', 'Francia', 453, 35.00, 0.70, 40.0),
('33012', 'Camus VSOP', 'Camus Cognac', 'cognac', 'Francia', 466, 42.00, 0.70, 40.0),
('33013', 'Cuvee Louis Alexandre', 'Grand Marnier ', 'Cognac', 'Francia', 576, 43.00, 0.70, 40.0),
('33014', 'China Martini', 'Martini', 'Amaro', 'Italia', 652, 14.00, 1.00, 16.0),
('33016', 'Cynar', 'Campari', 'amaro', 'Italia', 669, 11.00, 1.00, 16.0),
('33017', 'Ron Zacapa', 'Rum Creation', 'rum', 'Guatemala', 445, 48.00, 1.00, 40.0),
('33020', 'Matusalem', 'Matusalem', 'rum', 'Repubblica dominican', 434, 18.00, 1.00, 40.0),
('44000', 'Sciroppo Amarena', 'Fabbri', 'sciroppo', 'Italia', 325, 5.00, 1.50, 0.0),
('44001', 'Sciroppo Fragola ', 'Fabbri', 'sciroppo', 'Italia', 438, 5.00, 1.50, 0.0),
('44002', 'Sciroppo Mela Verde', 'Fabbri', 'sciroppo', 'Italia', 446, 5.00, 1.50, 0.0),
('44003', 'Sciroppo Menta ', 'Fabbri', 'sciroppo', 'Italia', 408, 5.00, 1.50, 0.0),
('44004', 'Sciroppo Liquerizia', 'Fabbri', 'sciroppo', 'Italia', 341, 5.00, 1.50, 0.0),
('44005', 'Zucchero di Canna Luiquido', 'Fabbri', 'zucchero', 'Italia', 347, 5.00, 1.50, 0.0),
('55435', 'Grey Goose Le Citron', 'Grey Goose Importing', 'vodka', 'Francia', 530, 32.00, 1.00, 40.0),
('55436', 'Grey Goose VX Vodka Exeptionelle', 'Grey Goose Importing', 'vodka', 'Francia', 520, 98.00, 1.00, 40.0),
('55606', 'Roberto Cavalli Vodka', ' Roberto Cavalli ', 'vodka', 'Italia', 6, 50.00, 0.70, 40.0),
('55678', 'SKYY', 'SKYY Spirits LLC', 'vodka', 'USA', 1070, 11.00, 1.00, 40.0),
('55700', 'Russian Standard', 'Russian Standard', 'vodka', 'Russia', 2010, 12.00, 1.00, 40.0),
('55701', 'Russian Standard Platinum', 'Russian Standard ', 'vodka', 'Russia', 112, 20.00, 1.00, 40.0),
('55710', 'Belvedere ', 'Belvedere', 'vodka', 'Polonia', 1459, 35.00, 1.00, 40.0),
('55720', 'Beluga', 'Beluga', 'vodka', 'Russia', 1023, 175.00, 0.70, 40.0),
('55750', 'Smirnoff', 'PA Smirnoff', 'vodka', 'Russia', 1079, 9.00, 1.00, 37.5),
('55751', 'Smirnoff Black', 'PA Smirnoff', 'vodka', 'Russia', 720, 16.00, 1.00, 37.5),
('55752', 'Smirnoff Espresso', 'PA Smirnoff', 'vodka', 'Russia', 712, 16.00, 1.00, 37.5),
('55760', 'Wyborowa Wodka', 'Wyborowa ', 'vodka', 'Polonia', 1791, 14.00, 1.00, 40.0),
('55770', 'Zubrowka', 'Zubrowka', 'vodka', 'Polonia', 1668, 15.00, 1.00, 40.0),
('55790', 'Absolut', 'Absolut Vodka', 'vodka', 'Svezia', 1450, 17.00, 1.00, 40.0),
('55791', 'Absolut 100', 'Absolut Vodka', 'vodka', 'Svezia', 1002, 30.00, 1.00, 40.0),
('55792', 'Absolut Apple Orient', 'Absolut Vodka', 'vodka', 'Svezia', 540, 20.00, 1.00, 40.0),
('55793', 'Absolut Berri Acai', 'Absolut Vodka', 'vodka', 'Svezia', 516, 20.00, 1.00, 40.0),
('66001', 'Aguardiente Antioqueno', 'Fábrica de Licores', 'liquore', 'Colombia', 852, 13.50, 1.00, 29.0),
('66002', 'Amaretto Disaronno', 'Disaronno', 'amaro', 'Italia', 290, 18.00, 1.00, 28.0),
('66003', 'Amaro Averna', 'Averna', 'amaro', 'Italia', 420, 15.00, 0.70, 32.0),
('66004', 'Amaro Ramazzotti', 'Ramazzotti', 'amaro', 'Italia', 508, 16.00, 1.00, 30.0),
('66005', 'Aperol', 'Campari', 'bitter', 'Italia', 3709, 14.00, 0.70, 11.0),
('66006', 'Baileys Irish Cream', 'Baileys', 'crema', 'Irlanda', 807, 12.00, 0.70, 17.0),
('66007', 'Benedictine', 'Benedictine', 'liquore', 'Francia', 271, 20.00, 0.70, 40.0),
('66008', 'Bonet', 'Destilerias Bonet', 'liquore', 'Barbados', 243, 12.00, 70.00, 40.0),
('66009', 'Cachaca', 'Leblon', 'acquavite', 'Brasile', 648, 12.00, 1.00, 40.0),
('66010', 'Campari', 'Campari', 'aperitivo', 'Italia', 3046, 15.50, 1.00, 25.0),
('66011', 'Chartreuse', 'Chartreuse Difusion', 'liquore', 'Francia', 640, 22.00, 0.70, 55.0),
('66012', 'Fernet Branca', 'Fernet Branca', 'amaro', 'Italia', 860, 12.00, 0.70, 40.0),
('66013', 'Branca Menta', 'Fernet Branca', 'amaro', 'Italia', 958, 12.00, 0.70, 35.0),
('66014', 'Cordon Rouge', 'Grand Marnier', 'liquore', 'Francia', 237, 18.60, 1.00, 40.0),
('66015', 'Jagermeister', 'Jagermeister', 'liquore', 'Germania', 703, 12.00, 1.00, 35.0),
('66016', 'Triple Sec ', 'Orangeau', 'liquore', 'spagna', 902, 9.50, 1.00, 12.0),
('66017', 'Tia Maria', 'Tia Maria', 'liquore', 'Irlanda', 233, 12.00, 1.00, 20.0),
('66018', 'Maraschino', 'Luxardo', 'liquore', 'Italia', 763, 7.25, 0.70, 29.0),
('66019', 'Midori Melone', 'Suntory', 'liquore', 'Giappone', 220, 17.00, 1.00, 20.0),
('66020', 'Batida de Coco', 'Mangaroca', 'liquore', 'Brasile', 461, 10.00, 0.70, 16.0);

-- --------------------------------------------------------

--
-- Struttura della tabella `riga_fattura`
--

DROP TABLE IF EXISTS `riga_fattura`;
CREATE TABLE IF NOT EXISTS `riga_fattura` (
  `fattura` varchar(5) NOT NULL,
  `prodotto` char(6) NOT NULL,
  `unita` decimal(9,0) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dump dei dati per la tabella `riga_fattura`
--

INSERT INTO `riga_fattura` (`fattura`, `prodotto`, `unita`) VALUES
('183', '22000', 7),
('184', '22000', 7),
('189', '33002', 10),
('183', '22001', 5),
('182', '22008', 6),
('181', '22000', 9),
('181', '25434', 8),
('180', '22000', 30),
('180', '22002', 20),
('180', '22007', 10),
('180', '25432', 18),
('180', '55760', 14),
('180', '33001', 10),
('180', '66005', 30),
('180', '66010', 30),
('179', '66018', 5),
('179', '66013', 12),
('179', '66006', 8),
('179', '66010', 40),
('179', '66005', 56),
('179', '66004', 10),
('179', '66003', 20),
('178', '22008', 20),
('178', '22006', 16),
('178', '33016', 14),
('178', '33014', 16),
('178', '55770', 32),
('177', '55678', 20),
('177', '44005', 5),
('177', '66009', 18),
('176', '66010', 40),
('177', '22003', 42),
('177', '22007', 10),
('177', '66016', 8),
('1776', '66019', 3),
('176', '55793', 4),
('175', '66015', 10),
('174', '66020', 10),
('173', '66014', 4),
('172', '66007', 16),
('171', '66002', 20),
('170', '55790', 20),
('169', '55750', 20),
('168', '66001', 6),
('167', '55720', 7),
('166', '55700', 20),
('165', '33010', 10),
('164', '33020', 6),
('163', '44000', 10),
('162', '44005', 4),
('161', '44000', 5),
('176', '66005', 30),
('176', '66013', 10),
('176', '66009', 14),
('175', '66017', 7),
('175', '55790', 30),
('175', '55700', 20),
('174', '44003', 6),
('174', '44005', 4),
('174', '22000', 20),
('174', '25432', 18),
('174', '33009', 10),
('174', '33003', 4),
('174', '66018', 6),
('173', '66010', 20),
('173', '66005', 30),
('173', '66012', 10),
('172', '55752', 8),
('172', '55750', 12),
('171', '55720', 4),
('172', '66001', 8),
('171', '66001', 6),
('171', '66004', 6),
('170', '66017', 7),
('170', '55678', 16),
('169', '33017', 7),
('169', '55710', 4),
('169', '66005', 46),
('166', '22006', 17),
('166', '25434', 7),
('166', '55678', 17),
('164', '55700', 20),
('164', '33014', 6),
('164', '66010', 10),
('163', '44001', 5),
('163', '66018', 6),
('163', '44005', 5),
('162', '44005', 5),
('162', '44001', 4),
('162', '44003', 6),
('162', '44004', 6),
('161', '33009', 10),
('160', '44005', 10);

--
-- Trigger `riga_fattura`
--
DROP TRIGGER IF EXISTS `riduzioneagg`;
DELIMITER //
CREATE TRIGGER `riduzioneagg` AFTER UPDATE ON `riga_fattura`
 FOR EACH ROW update prodotto set prodotto.disponibilita=disponibilita-new.unita+old.unita where prodotto.codice=new.prodotto
//
DELIMITER ;
DROP TRIGGER IF EXISTS `riduzionescorte`;
DELIMITER //
CREATE TRIGGER `riduzionescorte` AFTER INSERT ON `riga_fattura`
 FOR EACH ROW update prodotto set prodotto.disponibilita=disponibilita-new.unita where prodotto.codice=new.prodotto
//
DELIMITER ;
DROP TRIGGER IF EXISTS `scorte`;
DELIMITER //
CREATE TRIGGER `scorte` BEFORE INSERT ON `riga_fattura`
 FOR EACH ROW begin
if new.unita>(select disponibilita
			  from prodotto
              where new.prodotto=prodotto.codice)

then 
	insert into riga_fattura select * from riga_fattura LIMIT 1;
end if;
end
//
DELIMITER ;

-- --------------------------------------------------------

--
-- Struttura della tabella `stipendio`
--

DROP TABLE IF EXISTS `stipendio`;
CREATE TABLE IF NOT EXISTS `stipendio` (
  `dipendente` varchar(16) NOT NULL,
  `ammontare` decimal(8,2) DEFAULT NULL,
  PRIMARY KEY (`dipendente`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dump dei dati per la tabella `stipendio`
--

INSERT INTO `stipendio` (`dipendente`, `ammontare`) VALUES
('FRTCLD67A10A546P', 1250.00),
('FSSLNZ89C29F342D', 1400.00),
('NRELRT80D14Q231F', 1100.00),
('NTONDR79T23G456T', 2000.00),
('PLIFLP70L30U765T', 1540.00),
('RNLGRG75L10A432G', 1700.00),
('RSSMRA85A21A562S', 1100.00);

-- --------------------------------------------------------

--
-- Struttura della tabella `utilizzo_vettura`
--

DROP TABLE IF EXISTS `utilizzo_vettura`;
CREATE TABLE IF NOT EXISTS `utilizzo_vettura` (
  `vettura` char(7) DEFAULT NULL,
  `dipendente` varchar(16) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dump dei dati per la tabella `utilizzo_vettura`
--

INSERT INTO `utilizzo_vettura` (`vettura`, `dipendente`) VALUES
('EX579ZC', 'NTONDR79T23G456T'),
('EX579ZC', 'RSSMRA85A21A562S'),
('EA204RR', 'NTONDR79T23G456T'),
('DV361GT', 'NRELRT80D14Q231F');

-- --------------------------------------------------------

--
-- Struttura della tabella `venditore`
--

DROP TABLE IF EXISTS `venditore`;
CREATE TABLE IF NOT EXISTS `venditore` (
  `cod_fis` varchar(16) NOT NULL DEFAULT '',
  `rimborso_cor` decimal(8,2) DEFAULT NULL,
  `km_cor` decimal(8,0) DEFAULT NULL,
  PRIMARY KEY (`cod_fis`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dump dei dati per la tabella `venditore`
--

INSERT INTO `venditore` (`cod_fis`, `rimborso_cor`, `km_cor`) VALUES
('FSSLNZ89C29F342D', 73.60, 46),
('NRELRT80D14Q231F', 32.00, 20),
('NTONDR79T23G456T', 112.00, 70);

--
-- Trigger `venditore`
--
DROP TRIGGER IF EXISTS `rimborsi`;
DELIMITER //
CREATE TRIGGER `rimborsi` BEFORE INSERT ON `venditore`
 FOR EACH ROW set new.rimborso_cor=new.km_cor*1.60
//
DELIMITER ;
DROP TRIGGER IF EXISTS `rimborsiagg`;
DELIMITER //
CREATE TRIGGER `rimborsiagg` BEFORE UPDATE ON `venditore`
 FOR EACH ROW set new.rimborso_cor=new.km_cor*1.60
//
DELIMITER ;

--
-- Limiti per le tabelle scaricate
--

--
-- Limiti per la tabella `fattura`
--
ALTER TABLE `fattura`
  ADD CONSTRAINT `fattura_ibfk_1` FOREIGN KEY (`cliente`) REFERENCES `cliente` (`p_iva`),
  ADD CONSTRAINT `fattura_ibfk_2` FOREIGN KEY (`venditore`) REFERENCES `venditore` (`cod_fis`);

--
-- Limiti per la tabella `stipendio`
--
ALTER TABLE `stipendio`
  ADD CONSTRAINT `stipendio_ibfk_1` FOREIGN KEY (`dipendente`) REFERENCES `dipendente` (`cod_fis`);

--
-- Limiti per la tabella `venditore`
--
ALTER TABLE `venditore`
  ADD CONSTRAINT `venditore_ibfk_1` FOREIGN KEY (`cod_fis`) REFERENCES `dipendente` (`cod_fis`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
