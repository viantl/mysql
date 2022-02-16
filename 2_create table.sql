-- Создаём БД
CREATE database if not EXISTS meteostation;

-- Делаем её текущей
USE meteostation;

-- Справочники
create table if not exists sensor_status(
		num_status tinyint unsigned not null primary key COMMENT "Значение статуса датчика",
		description varchar(200) COMMENT "Расшифровка" 
		) COMMENT "Справочник статусов датчиков";
	
create table if not exists  weather_type(
		num_type tinyint unsigned not null primary key COMMENT "Значение типа погоды",
		description varchar(200) COMMENT "Описание типа погоды" 
		) COMMENT "Справочник типов погоды";

-- Таблица времени измерений
create table if not exists measurement (
	id INT unsigned not null auto_increment primary key COMMENT "Идентификатор строки", 
	measure_date DATETIME default NOW() unique COMMENT "Время измерения") COMMENT "Время измерения";		

-- Температура:
create table if not exists temperature (
		id INT unsigned not null auto_increment primary key COMMENT "Идентификатор строки",
		temp_status tinyint unsigned default null COMMENT "Статус датчика температуры",
		temp_inst decimal(4,1) default null COMMENT "Температура текущая",
		temp_avg decimal(4,1) default null COMMENT "Температура средняя за 1 час",
		temp_max decimal(4,1) default null COMMENT "Температура максимальная за 1 час",
		temp_min decimal(4,1) default null COMMENT "Температура минимальная за 1 час") COMMENT "Температура";

-- Влажность
create table if not exists humidity (
		id INT unsigned not null auto_increment primary key COMMENT "Идентификатор строки",
		humidity_status tinyint unsigned default null COMMENT "Статус датчика влажности",
  		humidity_inst tinyint unsigned default null COMMENT "Влажность текущая",
  		humidity_avg tinyint unsigned default null COMMENT "Влажность средняя за 1 час",
  		humidity_max tinyint unsigned default null COMMENT "Влажность максимальная за 1 час",
  		humidity_min tinyint unsigned default null COMMENT "Влажность минимальная за 1 час") COMMENT "Влажность";
  
-- Точка росы
create table if not exists dewpoint (
		id INT unsigned not null auto_increment primary key COMMENT "Идентификатор строки",
		dewpoint_inst decimal(4,1) default null COMMENT "Точка росы текущая",
  		dewpoint_avg decimal(4,1) default null COMMENT "Точка росы средняя за 1 час",
  		dewpoint_max decimal(4,1) default null COMMENT "Точка росы максимальная за 1 час",
  		dewpoint_min decimal(4,1) default null COMMENT "Точка росы минимальная за 1 час") COMMENT "Точка росы";
  
 -- Температура почвы
create table if not exists ground (
  		id INT unsigned not null auto_increment primary key COMMENT "Идентификатор строки",
 		ground_status tinyint unsigned default null COMMENT "Статус датчика температуры почвы",
  		ground_inst decimal(4,1) default null COMMENT "Температура почвы текущая",
  		ground_avg decimal(4,1) default null COMMENT "Температура почвы средняя за 1 час",
  		ground_max decimal(4,1) default null COMMENT "Температура почвы минимальная за 1 час",
  		ground_min decimal(4,1) default null COMMENT "Температура почвы максимальная за 1 час") COMMENT "Температура почвы";
		
-- Атмосферное давление
create table if not exists pressure (
  		id INT unsigned not null auto_increment primary key COMMENT "Идентификатор строки",
  		pressure_status tinyint unsigned default null COMMENT "Статус датчика атмосферного давления",
  		pressure_inst decimal(5,1) unsigned default null COMMENT "Атмосферное давление текущее",
  		pressure_avg decimal(5,1) unsigned default null COMMENT "Атмосферное давление усредненное за 1 час",
  		pressure_max decimal(5,1) unsigned default null COMMENT "Атмосферное давление максиальное за 1 час",
  		pressure_min decimal(5,1) unsigned default null COMMENT "Атмосферное давление минимальное за 1 час",
  		qfe_inst decimal(5,1) unsigned default null COMMENT "Атм. давление на уровне станции текущее",
  		qfe_avg decimal(5,1) unsigned default null COMMENT "Атм. давление на уровне станции усредненное за 1 час",
  		qfe_max decimal(5,1) unsigned default null COMMENT "Атм. давление на уровне станции макс. за 1 час",
  		qfe_min decimal(5,1) unsigned default null COMMENT "Атм. давление на уровне станции мин. за 1 час",
  		qff_inst decimal(5,1) unsigned default null COMMENT "Атм. давление на уровне моря текущее за 1 час",
  		qff_avg decimal(5,1) unsigned default null COMMENT "Атм. давление на уровне моря усредненное за 1 час",
  		qff_max decimal(5,1) unsigned default null COMMENT "Атм. давление на уровне моря максимальное за 1 час",
  		qff_min decimal(5,1) unsigned default null COMMENT "Атм. давление на уровне моря минимальное за 1 час") COMMENT "Атмосферное давление"; 
   
-- Солнечная радиация
create table if not exists solar (
  		id INT unsigned not null auto_increment primary key COMMENT "Идентификатор строки",
  		solar_status tinyint unsigned default null COMMENT "Статус датчика солнечной радиации",
  		solar_inst smallint unsigned default null COMMENT "Солнечная радиация текущая",
  		solar_avg smallint unsigned default null COMMENT "Солнечная радиация усредненная за 1 час",
  		solar_max smallint unsigned default null COMMENT "Солнечная радиация максиальная за 1 час",
  		solar_min smallint unsigned default null COMMENT "Солнечная радиация минимальная за 1 час") COMMENT "Солнечная радиация";

-- Баланс теплового излучения
create table if not exists net (
  		id INT unsigned not null auto_increment primary key COMMENT "Идентификатор строки",
  		net_status tinyint unsigned default null COMMENT "Статус датчика радиационного баланса",
  		net_inst smallint default null COMMENT "Радиационный баланс текущий",
  		net_avg smallint default null COMMENT "Радиационный баланс усредненный за 1 час",
  		net_max smallint default null COMMENT "Радиационный баланс максимальный за 1 час",
  		net_min smallint default null COMMENT "Радиационный баланс минимальный за 1 час") COMMENT "Радиационный баланс"; 
   
 -- Ветер
create table if not exists wind (
  		id INT unsigned not null auto_increment primary key COMMENT "Идентификатор строки",
  		wind_status tinyint unsigned default null COMMENT "Статус датчика ветра",
  		2min_speed_inst decimal(3,1) unsigned default null COMMENT "Скорость ветра мгновенная, время измерения 2 минуты",
		2min_speed_avg decimal(3,1) unsigned default null COMMENT "Скорость ветра усреднённая, время измерения 2 минуты",
		2min_speed_max decimal(3,1) unsigned default null COMMENT "Скорость ветра максимальная, время измерения 2 минуты",
		2min_speed_min decimal(3,1) unsigned default null COMMENT "Скорость ветра минимальная, время измерения 2 минуты",
		2min_dir_inst smallint unsigned default null COMMENT "Направление ветра мгновенное, время измерения 2 минуты",
		2min_dir_avg smallint unsigned default null COMMENT "Направление ветра усредненное, время измерения 2 минуты",
		2min_dir_max smallint unsigned default null COMMENT "Направление ветра максимальное, время измерения 2 минуты",
		2min_dir_min smallint unsigned default null COMMENT "Направление ветра минимальное, время измерения 2 минуты",
		10min_speed_avg decimal(3,1) unsigned default null COMMENT "Скорость ветра усреднённая, время измерения 10 минут",
		10min_speed_max decimal(3,1) unsigned default null COMMENT "Скорость ветра максимальная, время измерения 10 минут",
		10min_speed_min decimal(3,1) unsigned default null COMMENT "Скорость ветра минимальная, время измерения 10 минут",
		10min_dir_avg smallint unsigned default null COMMENT "Направление ветра усредненное, время измерения 10 минут",
		10min_dir_max smallint unsigned default null COMMENT "Направление ветра максимальное, время измерения 10 минут",
		10min_dir_min smallint unsigned default null COMMENT "Направление ветра минимальное, время измерения 10 минут") COMMENT "Ветер";
   
-- Погода
create table if not exists weather (
		id INT unsigned not null auto_increment primary key COMMENT "Идентификатор строки",
		weather_status tinyint unsigned default null COMMENT "Статус датчика погоды",
		weather_inst tinyint unsigned default null COMMENT "Тип погоды текущий",
  		weather_avg tinyint unsigned default null COMMENT "Тип погоды усреднённый за 1 час",
  		weather_snow_sum decimal(4,1) unsigned default null COMMENT "Сумма твердых осадков",
  		weather_rain_int decimal(4,1) unsigned default null COMMENT "Инденсивность осадков",
  		weather_water_sum decimal(4,1) unsigned default null COMMENT "Сумма жидких осадков",
  		visiblity_inst smallint unsigned default null COMMENT "Мгновенное значение видимости",
  		visiblity_avg smallint unsigned default null COMMENT "Видимость усредненная за 1 час") COMMENT "Датчик погоды";
   
-- Осадки
create table if not exists precipitation (
		id INT unsigned not null auto_increment primary key COMMENT "Идентификатор строки",
  		precipitation_status tinyint unsigned default null COMMENT "Статус датчика осадков",
  		precipitation_1m decimal(4,1) unsigned default null COMMENT "Осадки за 1 мин.",
  		precipitation_10m decimal(4,1) unsigned default null COMMENT "Осадки за 10 мин.",
  		precipitation_1d decimal(4,1) unsigned default null COMMENT "Осадки за 1 день") COMMENT "Осадки";
   
-- Электропитание
create table if not exists voltage (
		id INT unsigned not null auto_increment primary key COMMENT "Идентификатор строки",
		voltage_status  tinyint unsigned default null COMMENT "Статус контроля питания",
  		voltage_inst decimal(5,2) unsigned default null COMMENT "Текущее напряжение питания") COMMENT "Контроль электропитания";
  
-- Категория устойчивости
create table if not exists category (
		id INT unsigned not null auto_increment primary key COMMENT "Идентификатор строки",
		name_category enum('A','A-B','B','B-C','C','C-D','D','E','F') default null COMMENT "Категория устойчивости атмосферы")
	    COMMENT "Категория устойчивости атмосферы";


