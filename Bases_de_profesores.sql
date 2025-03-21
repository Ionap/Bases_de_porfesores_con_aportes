-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1:3306
-- Tiempo de generación: 20-03-2025 a las 23:58:00
-- Versión del servidor: 9.1.0
-- Versión de PHP: 8.3.14

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `Bases_de_profesores`
--

DELIMITER $$
--
-- Procedimientos
--
DROP PROCEDURE IF EXISTS `contar_profesores_por_ente`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `contar_profesores_por_ente` ()   BEGIN
    SELECT 
        e.nombre_ente AS ente,
        COUNT(DISTINCT p.numero_cedula) AS total_profesores
    FROM aportes a
    INNER JOIN entes e ON a.id_entes = e.id_entes
    INNER JOIN profesores p ON a.numero_cedula = p.numero_cedula
    GROUP BY e.nombre_ente
    ORDER BY total_profesores DESC;
END$$

DROP PROCEDURE IF EXISTS `listar_municipios_por_departamento`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `listar_municipios_por_departamento` (IN `id_dep` INT)   BEGIN
    SELECT 
        d.nombre_departamentos AS departamento,
        m.nombre_municipios AS municipio
    FROM municipios m
    INNER JOIN departamentos d ON m.id_departamentos = d.id_departamentos
    WHERE d.id_departamentos = id_dep;
END$$

--
-- Funciones
--
DROP FUNCTION IF EXISTS `obtener_departamento_municipios`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `obtener_departamento_municipios` (`id_dep` INT) RETURNS TEXT CHARSET utf8mb4 COLLATE utf8mb4_spanish_ci DETERMINISTIC BEGIN
    DECLARE resultado TEXT;

    SELECT GROUP_CONCAT(m.nombre_municipios SEPARATOR ', ') 
    INTO resultado
    FROM municipios m
    WHERE m.id_departamentos = id_dep;

    RETURN resultado;
END$$

DROP FUNCTION IF EXISTS `obtener_municipios_por_departamento`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `obtener_municipios_por_departamento` (`id_dep` INT) RETURNS TEXT CHARSET utf8mb4 COLLATE utf8mb4_spanish_ci DETERMINISTIC BEGIN
    DECLARE municipios TEXT;

    SELECT GROUP_CONCAT(nombre_municipios SEPARATOR ', ') 
    INTO municipios 
    FROM municipios 
    WHERE id_departamentos = id_dep;

    RETURN municipios;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `aportes`
--

DROP TABLE IF EXISTS `aportes`;

-- =========================================
-- Creación de una nueva tabla
-- =========================================
CREATE TABLE IF NOT EXISTS `aportes` (
  `id_aportes` int NOT NULL AUTO_INCREMENT,
  `numero_cedula` int NOT NULL,
  `descuento` float NOT NULL,
  `codigo_nomina` varchar(20) COLLATE utf8mb4_spanish_ci NOT NULL,
  `year` year NOT NULL,
  `mes` int NOT NULL,
  `id_entes` int NOT NULL,
  `tipo_descuento` varchar(45) COLLATE utf8mb4_spanish_ci NOT NULL,
  PRIMARY KEY (`id_aportes`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

--
-- Volcado de datos para la tabla `aportes`
--


-- Inserción de datos en la tabla correspondiente
INSERT INTO `aportes` (`id_aportes`, `numero_cedula`, `descuento`, `codigo_nomina`, `year`, `mes`, `id_entes`, `tipo_descuento`) VALUES
(1, 123456789, 26072, '20240930', '2024', 9, 2, 'Mensual');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `conyuges`
--

DROP TABLE IF EXISTS `conyuges`;

-- =========================================
-- Creación de una nueva tabla
-- =========================================
CREATE TABLE IF NOT EXISTS `conyuges` (
  `id_conyuges` int NOT NULL AUTO_INCREMENT,
  `nombre_conyuge` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish2_ci NOT NULL,
  `nombre_conyuge2` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish2_ci NOT NULL,
  `apellido_conyuge` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish2_ci NOT NULL,
  `apellido_conyuge2` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish2_ci NOT NULL,
  `numero_celular` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish2_ci NOT NULL,
  `direccion_residencial` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish2_ci NOT NULL,
  `ciudad_residencia` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish2_ci NOT NULL,
  PRIMARY KEY (`id_conyuges`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish2_ci COMMENT='Tabla para datos personales de los conyuges de los docentes.';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `departamentos`
--

DROP TABLE IF EXISTS `departamentos`;

-- =========================================
-- Creación de una nueva tabla
-- =========================================
CREATE TABLE IF NOT EXISTS `departamentos` (
  `id_departamentos` int NOT NULL AUTO_INCREMENT,
  `nombre_departamentos` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  `codigo_departamento` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  PRIMARY KEY (`id_departamentos`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

--
-- Volcado de datos para la tabla `departamentos`
--


-- Inserción de datos en la tabla correspondiente
INSERT INTO `departamentos` (`id_departamentos`, `nombre_departamentos`, `codigo_departamento`) VALUES
(1, 'ANTIOQUIA', '05'),
(2, 'ATLANTICO', '08'),
(3, 'BOGOTA', '11'),
(4, 'BOLIVAR', '13'),
(5, 'BOYACA', '15'),
(6, 'CALDAS', '17'),
(7, 'CAQUETA', '18'),
(8, 'CAUCA', '19'),
(9, 'CESAR', '20'),
(10, 'CORDOBA', '23'),
(11, 'CUNDINAMARCA', '25'),
(12, 'CHOCO', '27'),
(13, 'HUILA', '41'),
(14, 'LA GUAJIRA', '44'),
(15, 'MAGDALENA', '47'),
(16, 'META', '50'),
(17, 'NARIÑO', '52'),
(18, 'N. DE SANTANDER', '54'),
(19, 'QUINDIO', '63'),
(20, 'RISARALDA', '66'),
(21, 'SANTANDER', '68'),
(22, 'SUCRE', '70'),
(23, 'TOLIMA', '73'),
(24, 'VALLE DEL CAUCA', '76'),
(25, 'ARAUCA', '81'),
(26, 'CASANARE', '85'),
(27, 'PUTUMAYO', '86'),
(28, 'SAN ANDRES', '88'),
(29, 'AMAZONAS', '91'),
(30, 'GUAINIA', '94'),
(31, 'GUAVIARE', '95'),
(32, 'VAUPES', '97'),
(33, 'VICHADA', '99');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `directivos`
--

DROP TABLE IF EXISTS `directivos`;

-- =========================================
-- Creación de una nueva tabla
-- =========================================
CREATE TABLE IF NOT EXISTS `directivos` (
  `id_directivos` int NOT NULL AUTO_INCREMENT,
  `clasificacion` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  PRIMARY KEY (`id_directivos`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

--
-- Volcado de datos para la tabla `directivos`
--


-- Inserción de datos en la tabla correspondiente
INSERT INTO `directivos` (`id_directivos`, `clasificacion`) VALUES
(1, 'Administrativo'),
(2, 'Caja'),
(3, 'Comisionado SES'),
(4, 'Comité Municipal'),
(5, 'Delegado Amigo'),
(6, 'Delegado SES'),
(7, 'Directivo de Núcleo'),
(8, 'Directivo Docente'),
(9, 'Directivo SES'),
(10, 'Docente'),
(11, 'Veedor de Salud');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `entes`
--

DROP TABLE IF EXISTS `entes`;

-- =========================================
-- Creación de una nueva tabla
-- =========================================
CREATE TABLE IF NOT EXISTS `entes` (
  `id_entes` int NOT NULL AUTO_INCREMENT,
  `nombre_ente` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  `codigo_ente` int NOT NULL,
  PRIMARY KEY (`id_entes`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

--
-- Volcado de datos para la tabla `entes`
--


-- Inserción de datos en la tabla correspondiente
INSERT INTO `entes` (`id_entes`, `nombre_ente`, `codigo_ente`) VALUES
(1, 'FED', 1),
(2, 'BUCARAMANGA', 2),
(3, 'FLORIDABLANCA', 3),
(4, 'GIRON', 4),
(5, 'PIEDECUESTA', 5),
(6, 'BARRANCABERMEJA', 6),
(7, 'CAJA', 7),
(8, 'CENSO CUT 2018', 10);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `escalafon_salarial`
--

DROP TABLE IF EXISTS `escalafon_salarial`;

-- =========================================
-- Creación de una nueva tabla
-- =========================================
CREATE TABLE IF NOT EXISTS `escalafon_salarial` (
  `id_escalafon_salarial` int NOT NULL AUTO_INCREMENT,
  `categoria` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  `decreto` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  `sueldo` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  `extras` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  `año` year NOT NULL,
  PRIMARY KEY (`id_escalafon_salarial`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `especialidades`
--

DROP TABLE IF EXISTS `especialidades`;

-- =========================================
-- Creación de una nueva tabla
-- =========================================
CREATE TABLE IF NOT EXISTS `especialidades` (
  `id_especialidades` int NOT NULL AUTO_INCREMENT,
  `tipo_especialidades` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  PRIMARY KEY (`id_especialidades`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estado_civil`
--

DROP TABLE IF EXISTS `estado_civil`;

-- =========================================
-- Creación de una nueva tabla
-- =========================================
CREATE TABLE IF NOT EXISTS `estado_civil` (
  `id_estado_civil` int NOT NULL AUTO_INCREMENT,
  `desc_civil` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  PRIMARY KEY (`id_estado_civil`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

--
-- Volcado de datos para la tabla `estado_civil`
--


-- Inserción de datos en la tabla correspondiente
INSERT INTO `estado_civil` (`id_estado_civil`, `desc_civil`) VALUES
(1, 'Soltero'),
(2, 'Casado'),
(3, 'Divorciado'),
(4, 'Viudo'),
(5, 'Unión libre');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `jornada`
--

DROP TABLE IF EXISTS `jornada`;

-- =========================================
-- Creación de una nueva tabla
-- =========================================
CREATE TABLE IF NOT EXISTS `jornada` (
  `id_jornada` int NOT NULL AUTO_INCREMENT,
  `tipo_jornada` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  PRIMARY KEY (`id_jornada`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

--
-- Volcado de datos para la tabla `jornada`
--


-- Inserción de datos en la tabla correspondiente
INSERT INTO `jornada` (`id_jornada`, `tipo_jornada`) VALUES
(1, 'Mañana'),
(2, 'Tarde'),
(3, 'Unica'),
(4, 'Nocturna');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `municipios`
--

DROP TABLE IF EXISTS `municipios`;

-- =========================================
-- Creación de una nueva tabla
-- =========================================
CREATE TABLE IF NOT EXISTS `municipios` (
  `id_municipios` int NOT NULL AUTO_INCREMENT,
  `nombre_municipios` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  `codigo_municipios` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  `id_departamentos` int NOT NULL,
  PRIMARY KEY (`id_municipios`)
) ENGINE=InnoDB AUTO_INCREMENT=1121 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

--
-- Volcado de datos para la tabla `municipios`
--


-- Inserción de datos en la tabla correspondiente
INSERT INTO `municipios` (`id_municipios`, `nombre_municipios`, `codigo_municipios`, `id_departamentos`) VALUES
(1, 'MEDELLIN', '001', 1),
(2, 'ABEJORRAL', '002', 1),
(3, 'ABRIAQUI', '004', 1),
(4, 'ALEJANDRIA', '021', 1),
(5, 'AMAGA', '030', 1),
(6, 'AMALFI', '031', 1),
(7, 'ANDES', '034', 1),
(8, 'ANGELOPOLIS', '036', 1),
(9, 'ANGOSTURA', '038', 1),
(10, 'ANORI', '040', 1),
(11, 'SANTAFE DE ANTIOQUIA', '042', 1),
(12, 'ANZA', '044', 1),
(13, 'APARTADO', '045', 1),
(14, 'ARBOLETES', '051', 1),
(15, 'ARGELIA', '055', 1),
(16, 'ARMENIA', '059', 1),
(17, 'BARBOSA', '079', 1),
(18, 'BELMIRA', '086', 1),
(19, 'BELLO', '088', 1),
(20, 'BETANIA', '091', 1),
(21, 'BETULIA', '093', 1),
(22, 'CIUDAD BOLIVAR', '101', 1),
(23, 'BRICEÑO', '107', 1),
(24, 'BURITICA', '113', 1),
(25, 'CACERES', '120', 1),
(26, 'CAICEDO', '125', 1),
(27, 'CALDAS', '129', 1),
(28, 'CAMPAMENTO', '134', 1),
(29, 'CAÑASGORDAS', '138', 1),
(30, 'CARACOLI', '142', 1),
(31, 'CARAMANTA', '145', 1),
(32, 'CAREPA', '147', 1),
(33, 'EL CARMEN DE VIBORAL', '148', 1),
(34, 'CAROLINA', '150', 1),
(35, 'CAUCASIA', '154', 1),
(36, 'CHIGORODO', '172', 1),
(37, 'CISNEROS', '190', 1),
(38, 'COCORNA', '197', 1),
(39, 'CONCEPCION', '206', 1),
(40, 'CONCORDIA', '209', 1),
(41, 'COPACABANA', '212', 1),
(42, 'DABEIBA', '234', 1),
(43, 'DON MATIAS', '237', 1),
(44, 'EBEJICO', '240', 1),
(45, 'EL BAGRE', '250', 1),
(46, 'ENTRERRIOS', '264', 1),
(47, 'ENVIGADO', '266', 1),
(48, 'FREDONIA', '282', 1),
(49, 'FRONTINO', '284', 1),
(50, 'GIRALDO', '306', 1),
(51, 'GIRARDOTA', '308', 1),
(52, 'GOMEZ PLATA', '310', 1),
(53, 'GRANADA', '313', 1),
(54, 'GUADALUPE', '315', 1),
(55, 'GUARNE', '318', 1),
(56, 'GUATAPE', '321', 1),
(57, 'HELICONIA', '347', 1),
(58, 'HISPANIA', '353', 1),
(59, 'ITAGUI', '360', 1),
(60, 'ITUANGO', '361', 1),
(61, 'JARDIN', '364', 1),
(62, 'JERICO', '368', 1),
(63, 'LA CEJA', '376', 1),
(64, 'LA ESTRELLA', '380', 1),
(65, 'LA PINTADA', '390', 1),
(66, 'LA UNION', '400', 1),
(67, 'LIBORINA', '411', 1),
(68, 'MACEO', '425', 1),
(69, 'MARINILLA', '440', 1),
(70, 'MONTEBELLO', '467', 1),
(71, 'MURINDO', '475', 1),
(72, 'MUTATA', '480', 1),
(73, 'NARIÑO', '483', 1),
(74, 'NECOCLI', '490', 1),
(75, 'NECHI', '495', 1),
(76, 'OLAYA', '501', 1),
(77, 'PEÐOL', '541', 1),
(78, 'PEQUE', '543', 1),
(79, 'PUEBLORRICO', '576', 1),
(80, 'PUERTO BERRIO', '579', 1),
(81, 'PUERTO NARE', '585', 1),
(82, 'PUERTO TRIUNFO', '591', 1),
(83, 'REMEDIOS', '604', 1),
(84, 'RETIRO', '607', 1),
(85, 'RIONEGRO', '615', 1),
(86, 'SABANALARGA', '628', 1),
(87, 'SABANETA', '631', 1),
(88, 'SALGAR', '642', 1),
(89, 'SAN ANDRES DE CUERQUIA', '647', 1),
(90, 'SAN CARLOS', '649', 1),
(91, 'SAN FRANCISCO', '652', 1),
(92, 'SAN JERONIMO', '656', 1),
(93, 'SAN JOSE DE LA MONTAÑA', '658', 1),
(94, 'SAN JUAN DE URABA', '659', 1),
(95, 'SAN LUIS', '660', 1),
(96, 'SAN PEDRO', '664', 1),
(97, 'SAN PEDRO DE URABA', '665', 1),
(98, 'SAN RAFAEL', '667', 1),
(99, 'SAN ROQUE', '670', 1),
(100, 'SAN VICENTE', '674', 1),
(101, 'SANTA BARBARA', '679', 1),
(102, 'SANTA ROSA DE OSOS', '686', 1),
(103, 'SANTO DOMINGO', '690', 1),
(104, 'EL SANTUARIO', '697', 1),
(105, 'SEGOVIA', '736', 1),
(106, 'SONSON', '756', 1),
(107, 'SOPETRAN', '761', 1),
(108, 'TAMESIS', '789', 1),
(109, 'TARAZA', '790', 1),
(110, 'TARSO', '792', 1),
(111, 'TITIRIBI', '809', 1),
(112, 'TOLEDO', '819', 1),
(113, 'TURBO', '837', 1),
(114, 'URAMITA', '842', 1),
(115, 'URRAO', '847', 1),
(116, 'VALDIVIA', '854', 1),
(117, 'VALPARAISO', '856', 1),
(118, 'VEGACHI', '858', 1),
(119, 'VENECIA', '861', 1),
(120, 'VIGIA DEL FUERTE', '873', 1),
(121, 'YALI', '885', 1),
(122, 'YARUMAL', '887', 1),
(123, 'YOLOMBO', '890', 1),
(124, 'YONDO', '893', 1),
(125, 'ZARAGOZA', '895', 1),
(126, 'BARRANQUILLA', '001', 2),
(127, 'BARANOA', '078', 2),
(128, 'CAMPO DE LA CRUZ', '137', 2),
(129, 'CANDELARIA', '141', 2),
(130, 'GALAPA', '296', 2),
(131, 'JUAN DE ACOSTA', '372', 2),
(132, 'LURUACO', '421', 2),
(133, 'MALAMBO', '433', 2),
(134, 'MANATI', '436', 2),
(135, 'PALMAR DE VARELA', '520', 2),
(136, 'PIOJO', '549', 2),
(137, 'POLONUEVO', '558', 2),
(138, 'PONEDERA', '560', 2),
(139, 'PUERTO COLOMBIA', '573', 2),
(140, 'REPELON', '606', 2),
(141, 'SABANAGRANDE', '634', 2),
(142, 'SABANALARGA', '638', 2),
(143, 'SANTA LUCIA', '675', 2),
(144, 'SANTO TOMAS', '685', 2),
(145, 'SOLEDAD', '758', 2),
(146, 'SUAN', '770', 2),
(147, 'TUBARA', '832', 2),
(148, 'USIACURI', '849', 2),
(149, 'BOGOTA, D.C.', '001', 3),
(150, 'CARTAGENA', '001', 4),
(151, 'ACHI', '006', 4),
(152, 'ALTOS DEL ROSARIO', '030', 4),
(153, 'ARENAL', '042', 4),
(154, 'ARJONA', '052', 4),
(155, 'ARROYOHONDO', '062', 4),
(156, 'BARRANCO DE LOBA', '074', 4),
(157, 'CALAMAR', '140', 4),
(158, 'CANTAGALLO', '160', 4),
(159, 'CICUCO', '188', 4),
(160, 'CORDOBA', '212', 4),
(161, 'CLEMENCIA', '222', 4),
(162, 'EL CARMEN DE BOLIVAR', '244', 4),
(163, 'EL GUAMO', '248', 4),
(164, 'EL PEÑON', '268', 4),
(165, 'HATILLO DE LOBA', '300', 4),
(166, 'MAGANGUE', '430', 4),
(167, 'MAHATES', '433', 4),
(168, 'MARGARITA', '440', 4),
(169, 'MARIA LA BAJA', '442', 4),
(170, 'MONTECRISTO', '458', 4),
(171, 'MOMPOS', '468', 4),
(172, 'NOROSI', '490', 4),
(173, 'MORALES', '473', 4),
(174, 'PINILLOS', '549', 4),
(175, 'REGIDOR', '580', 4),
(176, 'RIO VIEJO', '600', 4),
(177, 'SAN CRISTOBAL', '620', 4),
(178, 'SAN ESTANISLAO', '647', 4),
(179, 'SAN FERNANDO', '650', 4),
(180, 'SAN JACINTO', '654', 4),
(181, 'SAN JACINTO DEL CAUCA', '655', 4),
(182, 'SAN JUAN NEPOMUCENO', '657', 4),
(183, 'SAN MARTIN DE LOBA', '667', 4),
(184, 'SAN PABLO', '670', 4),
(185, 'SANTA CATALINA', '673', 4),
(186, 'SANTA ROSA', '683', 4),
(187, 'SANTA ROSA DEL SUR', '688', 4),
(188, 'SIMITI', '744', 4),
(189, 'SOPLAVIENTO', '760', 4),
(190, 'TALAIGUA NUEVO', '780', 4),
(191, 'TIQUISIO', '810', 4),
(192, 'TURBACO', '836', 4),
(193, 'TURBANA', '838', 4),
(194, 'VILLANUEVA', '873', 4),
(195, 'ZAMBRANO', '894', 4),
(196, 'TUNJA', '001', 5),
(197, 'ALMEIDA', '022', 5),
(198, 'AQUITANIA', '047', 5),
(199, 'ARCABUCO', '051', 5),
(200, 'BELEN', '087', 5),
(201, 'BERBEO', '090', 5),
(202, 'BETEITIVA', '092', 5),
(203, 'BOAVITA', '097', 5),
(204, 'BOYACA', '104', 5),
(205, 'BRICEÑO', '106', 5),
(206, 'BUENAVISTA', '109', 5),
(207, 'BUSBANZA', '114', 5),
(208, 'CALDAS', '131', 5),
(209, 'CAMPOHERMOSO', '135', 5),
(210, 'CERINZA', '162', 5),
(211, 'CHINAVITA', '172', 5),
(212, 'CHIQUINQUIRA', '176', 5),
(213, 'CHISCAS', '180', 5),
(214, 'CHITA', '183', 5),
(215, 'CHITARAQUE', '185', 5),
(216, 'CHIVATA', '187', 5),
(217, 'CIENEGA', '189', 5),
(218, 'COMBITA', '204', 5),
(219, 'COPER', '212', 5),
(220, 'CORRALES', '215', 5),
(221, 'COVARACHIA', '218', 5),
(222, 'CUBARA', '223', 5),
(223, 'CUCAITA', '224', 5),
(224, 'CUITIVA', '226', 5),
(225, 'CHIQUIZA', '232', 5),
(226, 'CHIVOR', '236', 5),
(227, 'DUITAMA', '238', 5),
(228, 'EL COCUY', '244', 5),
(229, 'EL ESPINO', '248', 5),
(230, 'FIRAVITOBA', '272', 5),
(231, 'FLORESTA', '276', 5),
(232, 'GACHANTIVA', '293', 5),
(233, 'GAMEZA', '296', 5),
(234, 'GARAGOA', '299', 5),
(235, 'GUACAMAYAS', '317', 5),
(236, 'GUATEQUE', '322', 5),
(237, 'GUAYATA', '325', 5),
(238, 'GsICAN', '332', 5),
(239, 'IZA', '362', 5),
(240, 'JENESANO', '367', 5),
(241, 'JERICO', '368', 5),
(242, 'LABRANZAGRANDE', '377', 5),
(243, 'LA CAPILLA', '380', 5),
(244, 'LA VICTORIA', '401', 5),
(245, 'LA UVITA', '403', 5),
(246, 'VILLA DE LEYVA', '407', 5),
(247, 'MACANAL', '425', 5),
(248, 'MARIPI', '442', 5),
(249, 'MIRAFLORES', '455', 5),
(250, 'MONGUA', '464', 5),
(251, 'MONGUI', '466', 5),
(252, 'MONIQUIRA', '469', 5),
(253, 'MOTAVITA', '476', 5),
(254, 'MUZO', '480', 5),
(255, 'NOBSA', '491', 5),
(256, 'NUEVO COLON', '494', 5),
(257, 'OICATA', '500', 5),
(258, 'OTANCHE', '507', 5),
(259, 'PACHAVITA', '511', 5),
(260, 'PAEZ', '514', 5),
(261, 'PAIPA', '516', 5),
(262, 'PAJARITO', '518', 5),
(263, 'PANQUEBA', '522', 5),
(264, 'PAUNA', '531', 5),
(265, 'PAYA', '533', 5),
(266, 'PAZ DE RIO', '537', 5),
(267, 'PESCA', '542', 5),
(268, 'PISBA', '550', 5),
(269, 'PUERTO BOYACA', '572', 5),
(270, 'QUIPAMA', '580', 5),
(271, 'RAMIRIQUI', '599', 5),
(272, 'RAQUIRA', '600', 5),
(273, 'RONDON', '621', 5),
(274, 'SABOYA', '632', 5),
(275, 'SACHICA', '638', 5),
(276, 'SAMACA', '646', 5),
(277, 'SAN EDUARDO', '660', 5),
(278, 'SAN JOSE DE PARE', '664', 5),
(279, 'SAN LUIS DE GACENO', '667', 5),
(280, 'SAN MATEO', '673', 5),
(281, 'SAN MIGUEL DE SEMA', '676', 5),
(282, 'SAN PABLO DE BORBUR', '681', 5),
(283, 'SANTANA', '686', 5),
(284, 'SANTA MARIA', '690', 5),
(285, 'SANTA ROSA DE VITERBO', '693', 5),
(286, 'SANTA SOFIA', '696', 5),
(287, 'SATIVANORTE', '720', 5),
(288, 'SATIVASUR', '723', 5),
(289, 'SIACHOQUE', '740', 5),
(290, 'SOATA', '753', 5),
(291, 'SOCOTA', '755', 5),
(292, 'SOCHA', '757', 5),
(293, 'SOGAMOSO', '759', 5),
(294, 'SOMONDOCO', '761', 5),
(295, 'SORA', '762', 5),
(296, 'SOTAQUIRA', '763', 5),
(297, 'SORACA', '764', 5),
(298, 'SUSACON', '774', 5),
(299, 'SUTAMARCHAN', '776', 5),
(300, 'SUTATENZA', '778', 5),
(301, 'TASCO', '790', 5),
(302, 'TENZA', '798', 5),
(303, 'TIBANA', '804', 5),
(304, 'TIBASOSA', '806', 5),
(305, 'TINJACA', '808', 5),
(306, 'TIPACOQUE', '810', 5),
(307, 'TOCA', '814', 5),
(308, 'TOGsI', '816', 5),
(309, 'TOPAGA', '820', 5),
(310, 'TOTA', '822', 5),
(311, 'TUNUNGUA', '832', 5),
(312, 'TURMEQUE', '835', 5),
(313, 'TUTA', '837', 5),
(314, 'TUTAZA', '839', 5),
(315, 'UMBITA', '842', 5),
(316, 'VENTAQUEMADA', '861', 5),
(317, 'VIRACACHA', '879', 5),
(318, 'ZETAQUIRA', '897', 5),
(319, 'MANIZALES', '001', 6),
(320, 'AGUADAS', '013', 6),
(321, 'ANSERMA', '042', 6),
(322, 'ARANZAZU', '050', 6),
(323, 'BELALCAZAR', '088', 6),
(324, 'CHINCHINA', '174', 6),
(325, 'FILADELFIA', '272', 6),
(326, 'LA DORADA', '380', 6),
(327, 'LA MERCED', '388', 6),
(328, 'MANZANARES', '433', 6),
(329, 'MARMATO', '442', 6),
(330, 'MARQUETALIA', '444', 6),
(331, 'MARULANDA', '446', 6),
(332, 'NEIRA', '486', 6),
(333, 'NORCASIA', '495', 6),
(334, 'PACORA', '513', 6),
(335, 'PALESTINA', '524', 6),
(336, 'PENSILVANIA', '541', 6),
(337, 'RIOSUCIO', '614', 6),
(338, 'RISARALDA', '616', 6),
(339, 'SALAMINA', '653', 6),
(340, 'SAMANA', '662', 6),
(341, 'SAN JOSE', '665', 6),
(342, 'SUPIA', '777', 6),
(343, 'VICTORIA', '867', 6),
(344, 'VILLAMARIA', '873', 6),
(345, 'VITERBO', '877', 6),
(346, 'FLORENCIA', '001', 7),
(347, 'ALBANIA', '029', 7),
(348, 'BELEN DE LOS ANDAQUIES', '094', 7),
(349, 'CARTAGENA DEL CHAIRA', '150', 7),
(350, 'CURILLO', '205', 7),
(351, 'EL DONCELLO', '247', 7),
(352, 'EL PAUJIL', '256', 7),
(353, 'LA MONTAÑITA', '410', 7),
(354, 'MILAN', '460', 7),
(355, 'MORELIA', '479', 7),
(356, 'PUERTO RICO', '592', 7),
(357, 'SAN JOSE DEL FRAGUA', '610', 7),
(358, 'SAN VICENTE DEL CAGUAN', '753', 7),
(359, 'SOLANO', '756', 7),
(360, 'SOLITA', '785', 7),
(361, 'VALPARAISO', '860', 7),
(362, 'POPAYAN', '001', 8),
(363, 'ALMAGUER', '022', 8),
(364, 'ARGELIA', '050', 8),
(365, 'BALBOA', '075', 8),
(366, 'BOLIVAR', '100', 8),
(367, 'BUENOS AIRES', '110', 8),
(368, 'CAJIBIO', '130', 8),
(369, 'CALDONO', '137', 8),
(370, 'CALOTO', '142', 8),
(371, 'CORINTO', '212', 8),
(372, 'EL TAMBO', '256', 8),
(373, 'FLORENCIA', '290', 8),
(374, 'GUACHENE', '300', 8),
(375, 'GUAPI', '318', 8),
(376, 'INZA', '355', 8),
(377, 'JAMBALO', '364', 8),
(378, 'LA SIERRA', '392', 8),
(379, 'LA VEGA', '397', 8),
(380, 'LOPEZ', '418', 8),
(381, 'MERCADERES', '450', 8),
(382, 'MIRANDA', '455', 8),
(383, 'MORALES', '473', 8),
(384, 'PADILLA', '513', 8),
(385, 'PAEZ', '517', 8),
(386, 'PATIA', '532', 8),
(387, 'PIAMONTE', '533', 8),
(388, 'PIENDAMO', '548', 8),
(389, 'PUERTO TEJADA', '573', 8),
(390, 'PURACE', '585', 8),
(391, 'ROSAS', '622', 8),
(392, 'SAN SEBASTIAN', '693', 8),
(393, 'SANTANDER DE QUILICHAO', '698', 8),
(394, 'SANTA ROSA', '701', 8),
(395, 'SILVIA', '743', 8),
(396, 'SOTARA', '760', 8),
(397, 'SUAREZ', '780', 8),
(398, 'SUCRE', '785', 8),
(399, 'TIMBIO', '807', 8),
(400, 'TIMBIQUI', '809', 8),
(401, 'TORIBIO', '821', 8),
(402, 'TOTORO', '824', 8),
(403, 'VILLA RICA', '845', 8),
(404, 'VALLEDUPAR', '001', 9),
(405, 'AGUACHICA', '011', 9),
(406, 'AGUSTIN CODAZZI', '013', 9),
(407, 'ASTREA', '032', 9),
(408, 'BECERRIL', '045', 9),
(409, 'BOSCONIA', '060', 9),
(410, 'CHIMICHAGUA', '175', 9),
(411, 'CHIRIGUANA', '178', 9),
(412, 'CURUMANI', '228', 9),
(413, 'EL COPEY', '238', 9),
(414, 'EL PASO', '250', 9),
(415, 'GAMARRA', '295', 9),
(416, 'GONZALEZ', '310', 9),
(417, 'LA GLORIA', '383', 9),
(418, 'LA JAGUA DE IBIRICO', '400', 9),
(419, 'MANAURE', '443', 9),
(420, 'PAILITAS', '517', 9),
(421, 'PELAYA', '550', 9),
(422, 'PUEBLO BELLO', '570', 9),
(423, 'RIO DE ORO', '614', 9),
(424, 'LA PAZ', '621', 9),
(425, 'SAN ALBERTO', '710', 9),
(426, 'SAN DIEGO', '750', 9),
(427, 'SAN MARTIN', '770', 9),
(428, 'TAMALAMEQUE', '787', 9),
(429, 'MONTERIA', '001', 10),
(430, 'AYAPEL', '068', 10),
(431, 'BUENAVISTA', '079', 10),
(432, 'CANALETE', '090', 10),
(433, 'CERETE', '162', 10),
(434, 'CHIMA', '168', 10),
(435, 'CHINU', '182', 10),
(436, 'CIENAGA DE ORO', '189', 10),
(437, 'COTORRA', '300', 10),
(438, 'LA APARTADA', '350', 10),
(439, 'LORICA', '417', 10),
(440, 'LOS CORDOBAS', '419', 10),
(441, 'MOMIL', '464', 10),
(442, 'MONTELIBANO', '466', 10),
(443, 'MOÑITOS', '500', 10),
(444, 'PLANETA RICA', '555', 10),
(445, 'PUEBLO NUEVO', '570', 10),
(446, 'PUERTO ESCONDIDO', '574', 10),
(447, 'PUERTO LIBERTADOR', '580', 10),
(448, 'PURISIMA', '586', 10),
(449, 'SAHAGUN', '660', 10),
(450, 'SAN ANDRES SOTAVENTO', '670', 10),
(451, 'SAN ANTERO', '672', 10),
(452, 'SAN BERNARDO DEL VIENTO', '675', 10),
(453, 'SAN CARLOS', '678', 10),
(454, 'SAN PELAYO', '686', 10),
(455, 'TIERRALTA', '807', 10),
(456, 'VALENCIA', '855', 10),
(457, 'AGUA DE DIOS', '001', 11),
(458, 'ALBAN', '019', 11),
(459, 'ANAPOIMA', '035', 11),
(460, 'ANOLAIMA', '040', 11),
(461, 'ARBELAEZ', '053', 11),
(462, 'BELTRAN', '086', 11),
(463, 'BITUIMA', '095', 11),
(464, 'BOJACA', '099', 11),
(465, 'CABRERA', '120', 11),
(466, 'CACHIPAY', '123', 11),
(467, 'CAJICA', '126', 11),
(468, 'CAPARRAPI', '148', 11),
(469, 'CAQUEZA', '151', 11),
(470, 'CARMEN DE CARUPA', '154', 11),
(471, 'CHAGUANI', '168', 11),
(472, 'CHIA', '175', 11),
(473, 'CHIPAQUE', '178', 11),
(474, 'CHOACHI', '181', 11),
(475, 'CHOCONTA', '183', 11),
(476, 'COGUA', '200', 11),
(477, 'COTA', '214', 11),
(478, 'CUCUNUBA', '224', 11),
(479, 'EL COLEGIO', '245', 11),
(480, 'EL PEÑON', '258', 11),
(481, 'EL ROSAL', '260', 11),
(482, 'FACATATIVA', '269', 11),
(483, 'FOMEQUE', '279', 11),
(484, 'FOSCA', '281', 11),
(485, 'FUNZA', '286', 11),
(486, 'FUQUENE', '288', 11),
(487, 'FUSAGASUGA', '290', 11),
(488, 'GACHALA', '293', 11),
(489, 'GACHANCIPA', '295', 11),
(490, 'GACHETA', '297', 11),
(491, 'GAMA', '299', 11),
(492, 'GIRARDOT', '307', 11),
(493, 'GRANADA', '312', 11),
(494, 'GUACHETA', '317', 11),
(495, 'GUADUAS', '320', 11),
(496, 'GUASCA', '322', 11),
(497, 'GUATAQUI', '324', 11),
(498, 'GUATAVITA', '326', 11),
(499, 'GUAYABAL DE SIQUIMA', '328', 11),
(500, 'GUAYABETAL', '335', 11),
(501, 'GUTIERREZ', '339', 11),
(502, 'JERUSALEN', '368', 11),
(503, 'JUNIN', '372', 11),
(504, 'LA CALERA', '377', 11),
(505, 'LA MESA', '386', 11),
(506, 'LA PALMA', '394', 11),
(507, 'LA PEÑA', '398', 11),
(508, 'LA VEGA', '402', 11),
(509, 'LENGUAZAQUE', '407', 11),
(510, 'MACHETA', '426', 11),
(511, 'MADRID', '430', 11),
(512, 'MANTA', '436', 11),
(513, 'MEDINA', '438', 11),
(514, 'MOSQUERA', '473', 11),
(515, 'NARIÑO', '483', 11),
(516, 'NEMOCON', '486', 11),
(517, 'NILO', '488', 11),
(518, 'NIMAIMA', '489', 11),
(519, 'NOCAIMA', '491', 11),
(520, 'VENECIA', '506', 11),
(521, 'PACHO', '513', 11),
(522, 'PAIME', '518', 11),
(523, 'PANDI', '524', 11),
(524, 'PARATEBUENO', '530', 11),
(525, 'PASCA', '535', 11),
(526, 'PUERTO SALGAR', '572', 11),
(527, 'PULI', '580', 11),
(528, 'QUEBRADANEGRA', '592', 11),
(529, 'QUETAME', '594', 11),
(530, 'QUIPILE', '596', 11),
(531, 'APULO', '599', 11),
(532, 'RICAURTE', '612', 11),
(533, 'SAN ANTONIO DEL TEQUENDA', '645', 11),
(534, 'SAN BERNARDO', '649', 11),
(535, 'SAN CAYETANO', '653', 11),
(536, 'SAN FRANCISCO', '658', 11),
(537, 'SAN JUAN DE RIO SECO', '662', 11),
(538, 'SASAIMA', '718', 11),
(539, 'SESQUILE', '736', 11),
(540, 'SIBATE', '740', 11),
(541, 'SILVANIA', '743', 11),
(542, 'SIMIJACA', '745', 11),
(543, 'SOACHA', '754', 11),
(544, 'SOPO', '758', 11),
(545, 'SUBACHOQUE', '769', 11),
(546, 'SUESCA', '772', 11),
(547, 'SUPATA', '777', 11),
(548, 'SUSA', '779', 11),
(549, 'SUTATAUSA', '781', 11),
(550, 'TABIO', '785', 11),
(551, 'TAUSA', '793', 11),
(552, 'TENA', '797', 11),
(553, 'TENJO', '799', 11),
(554, 'TIBACUY', '805', 11),
(555, 'TIBIRITA', '807', 11),
(556, 'TOCAIMA', '815', 11),
(557, 'TOCANCIPA', '817', 11),
(558, 'TOPAIPI', '823', 11),
(559, 'UBALA', '839', 11),
(560, 'UBAQUE', '841', 11),
(561, 'VILLA DE SAN DIEGO DE UBAT', '843', 11),
(562, 'UNE', '845', 11),
(563, 'UTICA', '851', 11),
(564, 'VERGARA', '862', 11),
(565, 'VIANI', '867', 11),
(566, 'VILLAGOMEZ', '871', 11),
(567, 'VILLAPINZON', '873', 11),
(568, 'VILLETA', '875', 11),
(569, 'VIOTA', '878', 11),
(570, 'YACOPI', '885', 11),
(571, 'ZIPACON', '898', 11),
(572, 'ZIPAQUIRA', '899', 11),
(573, 'QUIBDO', '001', 12),
(574, 'ACANDI', '006', 12),
(575, 'ALTO BAUDO', '025', 12),
(576, 'ATRATO', '050', 12),
(577, 'BAGADO', '073', 12),
(578, 'BAHIA SOLANO', '075', 12),
(579, 'BAJO BAUDO', '077', 12),
(580, 'BOJAYA', '099', 12),
(581, 'EL CANTON DEL SAN PABLO', '135', 12),
(582, 'CARMEN DEL DARIEN', '150', 12),
(583, 'CERTEGUI', '160', 12),
(584, 'CONDOTO', '205', 12),
(585, 'EL CARMEN DE ATRATO', '245', 12),
(586, 'EL LITORAL DEL SAN JUAN', '250', 12),
(587, 'ISTMINA', '361', 12),
(588, 'JURADO', '372', 12),
(589, 'LLORO', '413', 12),
(590, 'MEDIO ATRATO', '425', 12),
(591, 'MEDIO BAUDO', '430', 12),
(592, 'MEDIO SAN JUAN', '450', 12),
(593, 'NOVITA', '491', 12),
(594, 'NUQUI', '495', 12),
(595, 'RIO IRO', '580', 12),
(596, 'RIO QUITO', '600', 12),
(597, 'RIOSUCIO', '615', 12),
(598, 'SAN JOSE DEL PALMAR', '660', 12),
(599, 'SIPI', '745', 12),
(600, 'TADO', '787', 12),
(601, 'UNGUIA', '800', 12),
(602, 'UNION PANAMERICANA', '810', 12),
(603, 'NEIVA', '001', 13),
(604, 'ACEVEDO', '006', 13),
(605, 'AGRADO', '013', 13),
(606, 'AIPE', '016', 13),
(607, 'ALGECIRAS', '020', 13),
(608, 'ALTAMIRA', '026', 13),
(609, 'BARAYA', '078', 13),
(610, 'CAMPOALEGRE', '132', 13),
(611, 'COLOMBIA', '206', 13),
(612, 'ELIAS', '244', 13),
(613, 'GARZON', '298', 13),
(614, 'GIGANTE', '306', 13),
(615, 'GUADALUPE', '319', 13),
(616, 'HOBO', '349', 13),
(617, 'IQUIRA', '357', 13),
(618, 'ISNOS', '359', 13),
(619, 'LA ARGENTINA', '378', 13),
(620, 'LA PLATA', '396', 13),
(621, 'NATAGA', '483', 13),
(622, 'OPORAPA', '503', 13),
(623, 'PAICOL', '518', 13),
(624, 'PALERMO', '524', 13),
(625, 'PALESTINA', '530', 13),
(626, 'PITAL', '548', 13),
(627, 'PITALITO', '551', 13),
(628, 'RIVERA', '615', 13),
(629, 'SALADOBLANCO', '660', 13),
(630, 'SAN AGUSTIN', '668', 13),
(631, 'SANTA MARIA', '676', 13),
(632, 'SUAZA', '770', 13),
(633, 'TARQUI', '791', 13),
(634, 'TESALIA', '797', 13),
(635, 'TELLO', '799', 13),
(636, 'TERUEL', '801', 13),
(637, 'TIMANA', '807', 13),
(638, 'VILLAVIEJA', '872', 13),
(639, 'YAGUARA', '885', 13),
(640, 'RIOHACHA', '001', 14),
(641, 'ALBANIA', '035', 14),
(642, 'BARRANCAS', '078', 14),
(643, 'DIBULLA', '090', 14),
(644, 'DISTRACCION', '098', 14),
(645, 'EL MOLINO', '110', 14),
(646, 'FONSECA', '279', 14),
(647, 'HATONUEVO', '378', 14),
(648, 'LA JAGUA DEL PILAR', '420', 14),
(649, 'MAICAO', '430', 14),
(650, 'MANAURE', '560', 14),
(651, 'SAN JUAN DEL CESAR', '650', 14),
(652, 'URIBIA', '847', 14),
(653, 'URUMITA', '855', 14),
(654, 'VILLANUEVA', '874', 14),
(655, 'SANTA MARTA', '001', 15),
(656, 'ALGARROBO', '030', 15),
(657, 'ARACATACA', '053', 15),
(658, 'ARIGUANI', '058', 15),
(659, 'CERRO SAN ANTONIO', '161', 15),
(660, 'CHIBOLO', '170', 15),
(661, 'CIENAGA', '189', 15),
(662, 'CONCORDIA', '205', 15),
(663, 'EL BANCO', '245', 15),
(664, 'EL PIÑON', '258', 15),
(665, 'EL RETEN', '268', 15),
(666, 'FUNDACION', '288', 15),
(667, 'GUAMAL', '318', 15),
(668, 'NUEVA GRANADA', '460', 15),
(669, 'PEDRAZA', '541', 15),
(670, 'PIJIÑO DEL CARMEN', '545', 15),
(671, 'PIVIJAY', '551', 15),
(672, 'PLATO', '555', 15),
(673, 'PUEBLOVIEJO', '570', 15),
(674, 'REMOLINO', '605', 15),
(675, 'SABANAS DE SAN ANGEL', '660', 15),
(676, 'SALAMINA', '675', 15),
(677, 'SAN SEBASTIAN DE BUENAVIS', '692', 15),
(678, 'SAN ZENON', '703', 15),
(679, 'SANTA ANA', '707', 15),
(680, 'SANTA BARBARA DE PINTO', '720', 15),
(681, 'SITIONUEVO', '745', 15),
(682, 'TENERIFE', '798', 15),
(683, 'ZAPAYAN', '960', 15),
(684, 'ZONA BANANERA', '980', 15),
(685, 'VILLAVICENCIO', '001', 16),
(686, 'ACACIAS', '006', 16),
(687, 'BARRANCA DE UPIA', '110', 16),
(688, 'CABUYARO', '124', 16),
(689, 'CASTILLA LA NUEVA', '150', 16),
(690, 'CUBARRAL', '223', 16),
(691, 'CUMARAL', '226', 16),
(692, 'EL CALVARIO', '245', 16),
(693, 'EL CASTILLO', '251', 16),
(694, 'EL DORADO', '270', 16),
(695, 'FUENTE DE ORO', '287', 16),
(696, 'GRANADA', '313', 16),
(697, 'GUAMAL', '318', 16),
(698, 'MAPIRIPAN', '325', 16),
(699, 'MESETAS', '330', 16),
(700, 'LA MACARENA', '350', 16),
(701, 'URIBE', '370', 16),
(702, 'LEJANIAS', '400', 16),
(703, 'PUERTO CONCORDIA', '450', 16),
(704, 'PUERTO GAITAN', '568', 16),
(705, 'PUERTO LOPEZ', '573', 16),
(706, 'PUERTO LLERAS', '577', 16),
(707, 'PUERTO RICO', '590', 16),
(708, 'RESTREPO', '606', 16),
(709, 'SAN CARLOS DE GUAROA', '680', 16),
(710, 'SAN JUAN DE ARAMA', '683', 16),
(711, 'SAN JUANITO', '686', 16),
(712, 'SAN MARTIN', '689', 16),
(713, 'VISTAHERMOSA', '711', 16),
(714, 'PASTO', '001', 17),
(715, 'ALBAN', '019', 17),
(716, 'ALDANA', '022', 17),
(717, 'ANCUYA', '036', 17),
(718, 'ARBOLEDA', '051', 17),
(719, 'BARBACOAS', '079', 17),
(720, 'BELEN', '083', 17),
(721, 'BUESACO', '110', 17),
(722, 'COLON', '203', 17),
(723, 'CONSACA', '207', 17),
(724, 'CONTADERO', '210', 17),
(725, 'CORDOBA', '215', 17),
(726, 'CUASPUD', '224', 17),
(727, 'CUMBAL', '227', 17),
(728, 'CUMBITARA', '233', 17),
(729, 'CHACHAGsI', '240', 17),
(730, 'EL CHARCO', '250', 17),
(731, 'EL PEÑOL', '254', 17),
(732, 'EL ROSARIO', '256', 17),
(733, 'EL TABLON DE GOMEZ', '258', 17),
(734, 'EL TAMBO', '260', 17),
(735, 'FUNES', '287', 17),
(736, 'GUACHUCAL', '317', 17),
(737, 'GUAITARILLA', '320', 17),
(738, 'GUALMATAN', '323', 17),
(739, 'ILES', '352', 17),
(740, 'IMUES', '354', 17),
(741, 'IPIALES', '356', 17),
(742, 'LA CRUZ', '378', 17),
(743, 'LA FLORIDA', '381', 17),
(744, 'LA LLANADA', '385', 17),
(745, 'LA TOLA', '390', 17),
(746, 'LA UNION', '399', 17),
(747, 'LEIVA', '405', 17),
(748, 'LINARES', '411', 17),
(749, 'LOS ANDES', '418', 17),
(750, 'MAGsI', '427', 17),
(751, 'MALLAMA', '435', 17),
(752, 'MOSQUERA', '473', 17),
(753, 'NARIÑO', '480', 17),
(754, 'OLAYA HERRERA', '490', 17),
(755, 'OSPINA', '506', 17),
(756, 'FRANCISCO PIZARRO', '520', 17),
(757, 'POLICARPA', '540', 17),
(758, 'POTOSI', '560', 17),
(759, 'PROVIDENCIA', '565', 17),
(760, 'PUERRES', '573', 17),
(761, 'PUPIALES', '585', 17),
(762, 'RICAURTE', '612', 17),
(763, 'ROBERTO PAYAN', '621', 17),
(764, 'SAMANIEGO', '678', 17),
(765, 'SANDONA', '683', 17),
(766, 'SAN BERNARDO', '685', 17),
(767, 'SAN LORENZO', '687', 17),
(768, 'SAN PABLO', '693', 17),
(769, 'SAN PEDRO DE CARTAGO', '694', 17),
(770, 'SANTA BARBARA', '696', 17),
(771, 'SANTACRUZ', '699', 17),
(772, 'SAPUYES', '720', 17),
(773, 'TAMINANGO', '786', 17),
(774, 'TANGUA', '788', 17),
(775, 'SAN ANDRES DE TUMACO', '835', 17),
(776, 'TUQUERRES', '838', 17),
(777, 'YACUANQUER', '885', 17),
(778, 'CUCUTA', '001', 18),
(779, 'ABREGO', '003', 18),
(780, 'ARBOLEDAS', '051', 18),
(781, 'BOCHALEMA', '099', 18),
(782, 'BUCARASICA', '109', 18),
(783, 'CACOTA', '125', 18),
(784, 'CACHIRA', '128', 18),
(785, 'CHINACOTA', '172', 18),
(786, 'CHITAGA', '174', 18),
(787, 'CONVENCION', '206', 18),
(788, 'CUCUTILLA', '223', 18),
(789, 'DURANIA', '239', 18),
(790, 'EL CARMEN', '245', 18),
(791, 'EL TARRA', '250', 18),
(792, 'EL ZULIA', '261', 18),
(793, 'GRAMALOTE', '313', 18),
(794, 'HACARI', '344', 18),
(795, 'HERRAN', '347', 18),
(796, 'LABATECA', '377', 18),
(797, 'LA ESPERANZA', '385', 18),
(798, 'LA PLAYA', '398', 18),
(799, 'LOS PATIOS', '405', 18),
(800, 'LOURDES', '418', 18),
(801, 'MUTISCUA', '480', 18),
(802, 'OCAÑA', '498', 18),
(803, 'PAMPLONA', '518', 18),
(804, 'PAMPLONITA', '520', 18),
(805, 'PUERTO SANTANDER', '553', 18),
(806, 'RAGONVALIA', '599', 18),
(807, 'SALAZAR', '660', 18),
(808, 'SAN CALIXTO', '670', 18),
(809, 'SAN CAYETANO', '673', 18),
(810, 'SANTIAGO', '680', 18),
(811, 'SARDINATA', '720', 18),
(812, 'SILOS', '743', 18),
(813, 'TEORAMA', '800', 18),
(814, 'TIBU', '810', 18),
(815, 'TOLEDO', '820', 18),
(816, 'VILLA CARO', '871', 18),
(817, 'VILLA DEL ROSARIO', '874', 18),
(818, 'ARMENIA', '001', 19),
(819, 'BUENAVISTA', '111', 19),
(820, 'CALARCA', '130', 19),
(821, 'CIRCASIA', '190', 19),
(822, 'CORDOBA', '212', 19),
(823, 'FILANDIA', '272', 19),
(824, 'GENOVA', '302', 19),
(825, 'LA TEBAIDA', '401', 19),
(826, 'MONTENEGRO', '470', 19),
(827, 'PIJAO', '548', 19),
(828, 'QUIMBAYA', '594', 19),
(829, 'SALENTO', '690', 19),
(830, 'PEREIRA', '001', 20),
(831, 'APIA', '045', 20),
(832, 'BALBOA', '075', 20),
(833, 'BELEN DE UMBRIA', '088', 20),
(834, 'DOSQUEBRADAS', '170', 20),
(835, 'GUATICA', '318', 20),
(836, 'LA CELIA', '383', 20),
(837, 'LA VIRGINIA', '400', 20),
(838, 'MARSELLA', '440', 20),
(839, 'MISTRATO', '456', 20),
(840, 'PUEBLO RICO', '572', 20),
(841, 'QUINCHIA', '594', 20),
(842, 'SANTA ROSA DE CABAL', '682', 20),
(843, 'SANTUARIO', '687', 20),
(844, 'BUCARAMANGA', '001', 21),
(845, 'AGUADA', '013', 21),
(846, 'ALBANIA', '020', 21),
(847, 'ARATOCA', '051', 21),
(848, 'BARBOSA', '077', 21),
(849, 'BARICHARA', '079', 21),
(850, 'BARRANCABERMEJA', '081', 21),
(851, 'BETULIA', '092', 21),
(852, 'BOLIVAR', '101', 21),
(853, 'CABRERA', '121', 21),
(854, 'CALIFORNIA', '132', 21),
(855, 'CAPITANEJO', '147', 21),
(856, 'CARCASI', '152', 21),
(857, 'CEPITA', '160', 21),
(858, 'CERRITO', '162', 21),
(859, 'CHARALA', '167', 21),
(860, 'CHARTA', '169', 21),
(861, 'CHIMA', '176', 21),
(862, 'CHIPATA', '179', 21),
(863, 'CIMITARRA', '190', 21),
(864, 'CONCEPCION', '207', 21),
(865, 'CONFINES', '209', 21),
(866, 'CONTRATACION', '211', 21),
(867, 'COROMORO', '217', 21),
(868, 'CURITI', '229', 21),
(869, 'EL CARMEN DE CHUCURI', '235', 21),
(870, 'EL GUACAMAYO', '245', 21),
(871, 'EL PEÑON', '250', 21),
(872, 'EL PLAYON', '255', 21),
(873, 'ENCINO', '264', 21),
(874, 'ENCISO', '266', 21),
(875, 'FLORIAN', '271', 21),
(876, 'FLORIDABLANCA', '276', 21),
(877, 'GALAN', '296', 21),
(878, 'GAMBITA', '298', 21),
(879, 'GIRON', '307', 21),
(880, 'GUACA', '318', 21),
(881, 'GUADALUPE', '320', 21),
(882, 'GUAPOTA', '322', 21),
(883, 'GUAVATA', '324', 21),
(884, 'GsEPSA', '327', 21),
(885, 'HATO', '344', 21),
(886, 'JESUS MARIA', '368', 21),
(887, 'JORDAN', '370', 21),
(888, 'LA BELLEZA', '377', 21),
(889, 'LANDAZURI', '385', 21),
(890, 'LA PAZ', '397', 21),
(891, 'LEBRIJA', '406', 21),
(892, 'LOS SANTOS', '418', 21),
(893, 'MACARAVITA', '425', 21),
(894, 'MALAGA', '432', 21),
(895, 'MATANZA', '444', 21),
(896, 'MOGOTES', '464', 21),
(897, 'MOLAGAVITA', '468', 21),
(898, 'OCAMONTE', '498', 21),
(899, 'OIBA', '500', 21),
(900, 'ONZAGA', '502', 21),
(901, 'PALMAR', '522', 21),
(902, 'PALMAS DEL SOCORRO', '524', 21),
(903, 'PARAMO', '533', 21),
(904, 'PIEDECUESTA', '547', 21),
(905, 'PINCHOTE', '549', 21),
(906, 'PUENTE NACIONAL', '572', 21),
(907, 'PUERTO PARRA', '573', 21),
(908, 'PUERTO WILCHES', '575', 21),
(909, 'RIONEGRO', '615', 21),
(910, 'SABANA DE TORRES', '655', 21),
(911, 'SAN ANDRES', '669', 21),
(912, 'SAN BENITO', '673', 21),
(913, 'SAN GIL', '679', 21),
(914, 'SAN JOAQUIN', '682', 21),
(915, 'SAN JOSE DE MIRANDA', '684', 21),
(916, 'SAN MIGUEL', '686', 21),
(917, 'SAN VICENTE DE CHUCURI', '689', 21),
(918, 'SANTA BARBARA', '705', 21),
(919, 'SANTA HELENA DEL OPON', '720', 21),
(920, 'SIMACOTA', '745', 21),
(921, 'SOCORRO', '755', 21),
(922, 'SUAITA', '770', 21),
(923, 'SUCRE', '773', 21),
(924, 'SURATA', '780', 21),
(925, 'TONA', '820', 21),
(926, 'VALLE DE SAN JOSE', '855', 21),
(927, 'VELEZ', '861', 21),
(928, 'VETAS', '867', 21),
(929, 'VILLANUEVA', '872', 21),
(930, 'ZAPATOCA', '895', 21),
(931, 'SINCELEJO', '001', 22),
(932, 'BUENAVISTA', '110', 22),
(933, 'CAIMITO', '124', 22),
(934, 'COLOSO', '204', 22),
(935, 'COROZAL', '215', 22),
(936, 'COVEÑAS', '221', 22),
(937, 'CHALAN', '230', 22),
(938, 'EL ROBLE', '233', 22),
(939, 'GALERAS', '235', 22),
(940, 'GUARANDA', '265', 22),
(941, 'LA UNION', '400', 22),
(942, 'LOS PALMITOS', '418', 22),
(943, 'MAJAGUAL', '429', 22),
(944, 'MORROA', '473', 22),
(945, 'OVEJAS', '508', 22),
(946, 'PALMITO', '523', 22),
(947, 'SAMPUES', '670', 22),
(948, 'SAN BENITO ABAD', '678', 22),
(949, 'SAN JUAN DE BETULIA', '702', 22),
(950, 'SAN MARCOS', '708', 22),
(951, 'SAN ONOFRE', '713', 22),
(952, 'SAN PEDRO', '717', 22),
(953, 'SAN LUIS DE SINCE', '742', 22),
(954, 'SUCRE', '771', 22),
(955, 'SANTIAGO DE TOLU', '820', 22),
(956, 'TOLU VIEJO', '823', 22),
(957, 'IBAGUE', '001', 23),
(958, 'ALPUJARRA', '024', 23),
(959, 'ALVARADO', '026', 23),
(960, 'AMBALEMA', '030', 23),
(961, 'ANZOATEGUI', '043', 23),
(962, 'ARMERO', '055', 23),
(963, 'ATACO', '067', 23),
(964, 'CAJAMARCA', '124', 23),
(965, 'CARMEN DE APICALA', '148', 23),
(966, 'CASABIANCA', '152', 23),
(967, 'CHAPARRAL', '168', 23),
(968, 'COELLO', '200', 23),
(969, 'COYAIMA', '217', 23),
(970, 'CUNDAY', '226', 23),
(971, 'DOLORES', '236', 23),
(972, 'ESPINAL', '268', 23),
(973, 'FALAN', '270', 23),
(974, 'FLANDES', '275', 23),
(975, 'FRESNO', '283', 23),
(976, 'GUAMO', '319', 23),
(977, 'HERVEO', '347', 23),
(978, 'HONDA', '349', 23),
(979, 'ICONONZO', '352', 23),
(980, 'LERIDA', '408', 23),
(981, 'LIBANO', '411', 23),
(982, 'MARIQUITA', '443', 23),
(983, 'MELGAR', '449', 23),
(984, 'MURILLO', '461', 23),
(985, 'NATAGAIMA', '483', 23),
(986, 'ORTEGA', '504', 23),
(987, 'PALOCABILDO', '520', 23),
(988, 'PIEDRAS', '547', 23),
(989, 'PLANADAS', '555', 23),
(990, 'PRADO', '563', 23),
(991, 'PURIFICACION', '585', 23),
(992, 'RIOBLANCO', '616', 23),
(993, 'RONCESVALLES', '622', 23),
(994, 'ROVIRA', '624', 23),
(995, 'SALDAÑA', '671', 23),
(996, 'SAN ANTONIO', '675', 23),
(997, 'SAN LUIS', '678', 23),
(998, 'SANTA ISABEL', '686', 23),
(999, 'SUAREZ', '770', 23),
(1000, 'VALLE DE SAN JUAN', '854', 23),
(1001, 'VENADILLO', '861', 23),
(1002, 'VILLAHERMOSA', '870', 23),
(1003, 'VILLARRICA', '873', 23),
(1004, 'CALI', '001', 24),
(1005, 'ALCALA', '020', 24),
(1006, 'ANDALUCIA', '036', 24),
(1007, 'ANSERMANUEVO', '041', 24),
(1008, 'ARGELIA', '054', 24),
(1009, 'BOLIVAR', '100', 24),
(1010, 'BUENAVENTURA', '109', 24),
(1011, 'GUADALAJARA DE BUGA', '111', 24),
(1012, 'BUGALAGRANDE', '113', 24),
(1013, 'CAICEDONIA', '122', 24),
(1014, 'CALIMA', '126', 24),
(1015, 'CANDELARIA', '130', 24),
(1016, 'CARTAGO', '147', 24),
(1017, 'DAGUA', '233', 24),
(1018, 'EL AGUILA', '243', 24),
(1019, 'EL CAIRO', '246', 24),
(1020, 'EL CERRITO', '248', 24),
(1021, 'EL DOVIO', '250', 24),
(1022, 'FLORIDA', '275', 24),
(1023, 'GINEBRA', '306', 24),
(1024, 'GUACARI', '318', 24),
(1025, 'JAMUNDI', '364', 24),
(1026, 'LA CUMBRE', '377', 24),
(1027, 'LA UNION', '400', 24),
(1028, 'LA VICTORIA', '403', 24),
(1029, 'OBANDO', '497', 24),
(1030, 'PALMIRA', '520', 24),
(1031, 'PRADERA', '563', 24),
(1032, 'RESTREPO', '606', 24),
(1033, 'RIOFRIO', '616', 24),
(1034, 'ROLDANILLO', '622', 24),
(1035, 'SAN PEDRO', '670', 24),
(1036, 'SEVILLA', '736', 24),
(1037, 'TORO', '823', 24),
(1038, 'TRUJILLO', '828', 24),
(1039, 'TULUA', '834', 24),
(1040, 'ULLOA', '845', 24),
(1041, 'VERSALLES', '863', 24),
(1042, 'VIJES', '869', 24),
(1043, 'YOTOCO', '890', 24),
(1044, 'YUMBO', '892', 24),
(1045, 'ZARZAL', '895', 24),
(1046, 'ARAUCA', '001', 25),
(1047, 'ARAUQUITA', '065', 25),
(1048, 'CRAVO NORTE', '220', 25),
(1049, 'FORTUL', '300', 25),
(1050, 'PUERTO RONDON', '591', 25),
(1051, 'SARAVENA', '736', 25),
(1052, 'TAME', '794', 25),
(1053, 'YOPAL', '001', 26),
(1054, 'AGUAZUL', '010', 26),
(1055, 'CHAMEZA', '015', 26),
(1056, 'HATO COROZAL', '125', 26),
(1057, 'LA SALINA', '136', 26),
(1058, 'MANI', '139', 26),
(1059, 'MONTERREY', '162', 26),
(1060, 'NUNCHIA', '225', 26),
(1061, 'OROCUE', '230', 26),
(1062, 'PAZ DE ARIPORO', '250', 26),
(1063, 'PORE', '263', 26),
(1064, 'RECETOR', '279', 26),
(1065, 'SABANALARGA', '300', 26),
(1066, 'SACAMA', '315', 26),
(1067, 'SAN LUIS DE PALENQUE', '325', 26),
(1068, 'TAMARA', '400', 26),
(1069, 'TAURAMENA', '410', 26),
(1070, 'TRINIDAD', '430', 26),
(1071, 'VILLANUEVA', '440', 26),
(1072, 'MOCOA', '001', 27),
(1073, 'COLON', '219', 27),
(1074, 'ORITO', '320', 27),
(1075, 'PUERTO ASIS', '568', 27),
(1076, 'PUERTO CAICEDO', '569', 27),
(1077, 'PUERTO GUZMAN', '571', 27),
(1078, 'LEGUIZAMO', '573', 27),
(1079, 'SIBUNDOY', '749', 27),
(1080, 'SAN FRANCISCO', '755', 27),
(1081, 'SAN MIGUEL', '757', 27),
(1082, 'SANTIAGO', '760', 27),
(1083, 'VALLE DEL GUAMUEZ', '865', 27),
(1084, 'VILLAGARZON', '885', 27),
(1085, 'SAN ANDRES', '001', 28),
(1086, 'PROVIDENCIA', '564', 28),
(1087, 'LETICIA', '001', 29),
(1088, 'EL ENCANTO', '263', 29),
(1089, 'LA CHORRERA', '405', 29),
(1090, 'LA PEDRERA', '407', 29),
(1091, 'LA VICTORIA', '430', 29),
(1092, 'MIRITI - PARANA', '460', 29),
(1093, 'PUERTO ALEGRIA', '530', 29),
(1094, 'PUERTO ARICA', '536', 29),
(1095, 'PUERTO NARIÑO', '540', 29),
(1096, 'PUERTO SANTANDER', '669', 29),
(1097, 'TARAPACA', '798', 29),
(1098, 'INIRIDA', '001', 30),
(1099, 'BARRANCO MINAS', '343', 30),
(1100, 'MAPIRIPANA', '663', 30),
(1101, 'SAN FELIPE', '883', 30),
(1102, 'PUERTO COLOMBIA', '884', 30),
(1103, 'LA GUADALUPE', '885', 30),
(1104, 'CACAHUAL', '886', 30),
(1105, 'PANA PANA', '887', 30),
(1106, 'MORICHAL', '888', 30),
(1107, 'SAN JOSE DEL GUAVIARE', '001', 31),
(1108, 'CALAMAR', '015', 31),
(1109, 'EL RETORNO', '025', 31),
(1110, 'MIRAFLORES', '200', 31),
(1111, 'MITU', '001', 32),
(1112, 'CARURU', '161', 32),
(1113, 'PACOA', '511', 32),
(1114, 'TARAIRA', '666', 32),
(1115, 'PAPUNAUA', '777', 32),
(1116, 'YAVARATE', '889', 32),
(1117, 'PUERTO CARREÑO', '001', 33),
(1118, 'LA PRIMAVERA', '524', 33),
(1119, 'SANTA ROSALIA', '624', 33),
(1120, 'CUMARIBO', '773', 33);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `profesores`
--

DROP TABLE IF EXISTS `profesores`;

-- =========================================
-- Creación de una nueva tabla
-- =========================================
CREATE TABLE IF NOT EXISTS `profesores` (
  `id_profesores` int NOT NULL,
  `numero_cedula` int NOT NULL,
  `lugar_expedicion` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish2_ci NOT NULL,
  `nombre` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish2_ci NOT NULL,
  `nombre2` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish2_ci NOT NULL,
  `apellido` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish2_ci NOT NULL,
  `apellido2` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish2_ci NOT NULL,
  `fecha_nacimiento` date NOT NULL,
  `ciudad_nacimiento` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish2_ci NOT NULL,
  `sexo` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish2_ci NOT NULL,
  `id_estado_civil` int NOT NULL,
  `direccion_residencial` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish2_ci NOT NULL,
  `ciudad_residencia` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish2_ci NOT NULL,
  `telefono_residencia` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish2_ci NOT NULL,
  `numero_celular` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish2_ci NOT NULL,
  `numero_celular2` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish2_ci DEFAULT NULL,
  `correo_electronico` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish2_ci NOT NULL,
  `id_jornada` int DEFAULT NULL,
  `id_sede_principal` int NOT NULL,
  `id_sub_sedes` int NOT NULL,
  `id_titulo` int NOT NULL,
  `id_especialidades` int DEFAULT NULL,
  PRIMARY KEY (`id_profesores`),
  UNIQUE KEY `numero_cedula_UNIQUE` (`numero_cedula`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci COMMENT='Tabla con datos personales de los docentes.';

--
-- Volcado de datos para la tabla `profesores`
--


-- Inserción de datos en la tabla correspondiente
INSERT INTO `profesores` (`id_profesores`, `numero_cedula`, `lugar_expedicion`, `nombre`, `nombre2`, `apellido`, `apellido2`, `fecha_nacimiento`, `ciudad_nacimiento`, `sexo`, `id_estado_civil`, `direccion_residencial`, `ciudad_residencia`, `telefono_residencia`, `numero_celular`, `numero_celular2`, `correo_electronico`, `id_jornada`, `id_sede_principal`, `id_sub_sedes`, `id_titulo`, `id_especialidades`) VALUES
(0, 123456789, '876', 'Pepito', '', 'Perez', 'ADARME', '1967-11-05', '844', 'M', 0, 'CALLE 196 C #27D-15 EL RECREO', '002', '', '', NULL, '', NULL, 0, 0, 0, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `prueba_fecha`
--

DROP TABLE IF EXISTS `prueba_fecha`;

-- =========================================
-- Creación de una nueva tabla
-- =========================================
CREATE TABLE IF NOT EXISTS `prueba_fecha` (
  `COL 1` varchar(2) DEFAULT NULL,
  `COL 2` date DEFAULT NULL,
  `COL 3` date DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;

--
-- Volcado de datos para la tabla `prueba_fecha`
--


-- Inserción de datos en la tabla correspondiente
INSERT INTO `prueba_fecha` (`COL 1`, `COL 2`, `COL 3`) VALUES
('id', '0000-00-00', '0000-00-00'),
('1', '2025-03-11', '2024-09-02'),
('2', '2025-03-12', '2024-09-03'),
('3', '2025-03-13', '2024-09-04'),
('4', '2025-03-14', '2024-09-05'),
('5', '2025-03-15', '2024-09-06'),
('6', '2025-03-16', '2024-09-07'),
('1', '2025-03-11', '2024-09-02'),
('2', '2025-03-12', '2024-09-03'),
('3', '2025-03-13', '2024-09-04'),
('4', '2025-03-14', '2024-09-05'),
('5', '2025-03-15', '2024-09-06'),
('6', '2025-03-16', '2024-09-07');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sede_principal`
--

DROP TABLE IF EXISTS `sede_principal`;

-- =========================================
-- Creación de una nueva tabla
-- =========================================
CREATE TABLE IF NOT EXISTS `sede_principal` (
  `id_sede_principal` int NOT NULL AUTO_INCREMENT,
  `nombre_sede` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish2_ci NOT NULL,
  `direccion_sede` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish2_ci NOT NULL,
  `numero_telefono` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish2_ci NOT NULL,
  `director` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish2_ci NOT NULL,
  `correo_institucion` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  `estado` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  PRIMARY KEY (`id_sede_principal`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci COMMENT='Tabla con los datos de la sede principal.';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sub_sedes`
--

DROP TABLE IF EXISTS `sub_sedes`;

-- =========================================
-- Creación de una nueva tabla
-- =========================================
CREATE TABLE IF NOT EXISTS `sub_sedes` (
  `id_sub_sedes` int NOT NULL AUTO_INCREMENT,
  `id_sede_principal` int NOT NULL,
  `nombre_sede` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish2_ci NOT NULL,
  `direccion` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish2_ci NOT NULL,
  `numero_telefono` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish2_ci NOT NULL,
  `coordinador` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish2_ci NOT NULL,
  `correo_institucion` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  PRIMARY KEY (`id_sub_sedes`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci COMMENT='Tabla con los datos de las subsedes.';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `titulo`
--

DROP TABLE IF EXISTS `titulo`;

-- =========================================
-- Creación de una nueva tabla
-- =========================================
CREATE TABLE IF NOT EXISTS `titulo` (
  `id_titulo` int NOT NULL AUTO_INCREMENT,
  `tipos_titulo` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  `id_especialidades` int NOT NULL,
  PRIMARY KEY (`id_titulo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `vista_aportes_profesores`
-- (Véase abajo para la vista actual)
--
DROP VIEW IF EXISTS `vista_aportes_profesores`;

-- =========================================
-- Creación de una nueva tabla
-- =========================================
CREATE TABLE IF NOT EXISTS `vista_aportes_profesores` (
`id_aportes` int
,`numero_cedula` int
,`nombre_completo` varchar(183)
,`correo_electronico` varchar(45)
,`numero_celular` varchar(45)
,`nombre_ente` varchar(30)
,`descuento` float
,`codigo_nomina` varchar(20)
,`year` year
,`mes` int
,`tipo_descuento` varchar(45)
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `vista_departamentos_municipios`
-- (Véase abajo para la vista actual)
--
DROP VIEW IF EXISTS `vista_departamentos_municipios`;

-- =========================================
-- Creación de una nueva tabla
-- =========================================
CREATE TABLE IF NOT EXISTS `vista_departamentos_municipios` (
`departamento` varchar(50)
,`municipio` varchar(50)
);

-- --------------------------------------------------------

--
-- Estructura para la vista `vista_aportes_profesores`
--
DROP TABLE IF EXISTS `vista_aportes_profesores`;

DROP VIEW IF EXISTS `vista_aportes_profesores`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vista_aportes_profesores`  AS SELECT `a`.`id_aportes` AS `id_aportes`, `p`.`numero_cedula` AS `numero_cedula`, concat(`p`.`nombre`,' ',`p`.`nombre2`,' ',`p`.`apellido`,' ',`p`.`apellido2`) AS `nombre_completo`, `p`.`correo_electronico` AS `correo_electronico`, `p`.`numero_celular` AS `numero_celular`, `e`.`nombre_ente` AS `nombre_ente`, `a`.`descuento` AS `descuento`, `a`.`codigo_nomina` AS `codigo_nomina`, `a`.`year` AS `year`, `a`.`mes` AS `mes`, `a`.`tipo_descuento` AS `tipo_descuento` FROM ((`aportes` `a` join `profesores` `p` on((`a`.`numero_cedula` = `p`.`numero_cedula`))) join `entes` `e` on((`a`.`id_entes` = `e`.`id_entes`))) ;

-- --------------------------------------------------------

--
-- Estructura para la vista `vista_departamentos_municipios`
--
DROP TABLE IF EXISTS `vista_departamentos_municipios`;

DROP VIEW IF EXISTS `vista_departamentos_municipios`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vista_departamentos_municipios`  AS SELECT `d`.`nombre_departamentos` AS `departamento`, `m`.`nombre_municipios` AS `municipio` FROM (`municipios` `m` join `departamentos` `d` on((`m`.`id_departamentos` = `d`.`id_departamentos`))) ;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
