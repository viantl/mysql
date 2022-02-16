use meteostation;  
-- Сводная таблица метеоданных с усреднением 10 минут     
select DATE_FORMAT(measure_date,'%Y.%m.%d %H:%i') as data,
TRUNCATE(AVG(CASE WHEN t.temp_status=0 THEN t.temp_inst ELSE NULL END),1) AS avg_temp,  						-- средняя температура
TRUNCATE(MAX(CASE WHEN t.temp_status=0 THEN t.temp_max ELSE NULL END),1) AS max_temp,							-- максимальная температура
TRUNCATE(MIN(CASE WHEN t.temp_status=0 THEN t.temp_min ELSE NULL END),1) AS min_temp,							-- минимальная температура
TRUNCATE(0.75*AVG(CASE WHEN p.pressure_status=0 THEN p.pressure_inst ELSE NULL END),1) AS avg_pressure,			-- среднее давление в мм.рт.ст.
TRUNCATE(0.75*MIN(CASE WHEN p.pressure_status=0 THEN p.pressure_min ELSE NULL END),1) AS min_pressure,			-- минимальное давление
TRUNCATE(0.75*MAX(CASE WHEN p.pressure_status=0 THEN p.pressure_max ELSE NULL END),1) AS max_pressure,			-- максимальное давление
TRUNCATE(AVG(CASE WHEN h.humidity_status=0 THEN h.humidity_inst ELSE NULL END),1) AS avg_hum,					-- средняя влажность
TRUNCATE(AVG(CASE WHEN g.ground_status=0 THEN g.ground_inst ELSE NULL END),1) AS avg_ground,					-- средняя температура почвы
TRUNCATE(MIN(CASE WHEN g.ground_status=0 THEN g.ground_min ELSE NULL END),1) AS min_ground,						-- минимальная температура почвы
TRUNCATE(AVG(CASE WHEN w.wind_status=0 THEN w.10min_speed_avg ELSE NULL END),1) AS avg_speed,					-- средняя скорость ветра
TRUNCATE(MAX(CASE WHEN w.wind_status=0 THEN w.10min_speed_max ELSE NULL END),1) AS max_speed,					-- максимальный ветер
TRUNCATE(AVG(CASE WHEN s.solar_inst>0 AND s.solar_status=0 THEN s.solar_inst ELSE NULL END),1) AS avg_solar,	-- средняя солнечная радиация
TRUNCATE(SUM((CASE WHEN w2.weather_status=0 THEN w2.weather_rain_int ELSE NULL END)/60),3) AS rain_sum			-- суммарное количество осадков
from measurement m
left join temperature t on m.id =t.id
left join pressure p on m.id = p.id
left join humidity h on m.id = h.id
left join ground g  on m.id = g.id
left join wind w on m.id = w.id
left join solar s on m.id = s.id
left join weather w2 on m.id = w2.id
GROUP BY CONCAT(DATE_FORMAT(measure_date,'%Y.%m.%d %H:'),FLOOR(DATE_FORMAT(measure_date,'%i')/10)*10) ORDER BY YEAR(data) desc;
            
-- Преобладающее направление и средняя скорость ветра        
SELECT CASE 
WHEN (w.10min_dir_avg >= 349 OR w.10min_dir_avg<12) and w.wind_status =0 THEN 'Север'
WHEN w.10min_dir_avg BETWEEN 12 AND 33 THEN 'Север-северо-восток'
WHEN w.10min_dir_avg BETWEEN 34 AND 56 THEN 'Северо-восток'
WHEN w.10min_dir_avg BETWEEN 57 AND 78 THEN 'Восток-северо-восток'
WHEN w.10min_dir_avg BETWEEN 79 AND 101 THEN 'Восток'
WHEN w.10min_dir_avg BETWEEN 102 AND 123 THEN 'Восток-юго-восток'
WHEN w.10min_dir_avg BETWEEN 124 AND 146 THEN 'Юго-восток'
WHEN w.10min_dir_avg BETWEEN 147 AND 168 THEN 'Юг-юго-восток'
WHEN w.10min_dir_avg BETWEEN 169 AND 191 THEN 'Юг'
WHEN w.10min_dir_avg BETWEEN 192 AND 213 THEN 'Юг-юго-запад'
WHEN w.10min_dir_avg BETWEEN 214 AND 236 THEN 'Юго-запад'
WHEN w.10min_dir_avg BETWEEN 237 AND 258 THEN 'Запад-юго-запад'
WHEN w.10min_dir_avg BETWEEN 259 AND 281 THEN 'Запад'
WHEN w.10min_dir_avg BETWEEN 282 AND 303 THEN 'Запад-северо-запад'
WHEN w.10min_dir_avg BETWEEN 304 AND 326 THEN 'Северо-запад'
WHEN w.10min_dir_avg BETWEEN 327 AND 348 THEN 'Север-северо-запад'
END AS rumb, 
count(10min_dir_avg) AS count_direction, 
TRUNCATE(AVG(10min_speed_avg),2) as avg_speed 
FROM wind w
left join measurement m on w.id = m.id 
where m.measure_date like '2022%' and w.wind_status = 0 group by rumb order by count_direction desc limit 1;

           
-- Распределение ветра по направлениям в % - роза ветров
SELECT 
TRUNCATE(COUNT(CASE WHEN w.10min_dir_avg >=337.6 OR w.10min_dir_avg<22.5 THEN 1 ELSE NULL END)*100/COUNT(w.10min_dir_avg),2) as 'СЕВЕР', 
TRUNCATE(COUNT(CASE WHEN w.10min_dir_avg BETWEEN 22.5 AND 67.5 THEN 1 ELSE NULL END)*100/COUNT(w.10min_dir_avg),2) as 'СЕВЕРО-ВОСТОК',
TRUNCATE(COUNT(CASE WHEN w.10min_dir_avg BETWEEN 67.6 AND 112.5 THEN 1 ELSE NULL END)*100/COUNT(w.10min_dir_avg),2) as 'ВОСТОК',
TRUNCATE(COUNT(CASE WHEN w.10min_dir_avg BETWEEN 112.6 AND 157.5 THEN 1 ELSE NULL END)*100/COUNT(w.10min_dir_avg),2) as 'ЮГО-ВОСТОК',
TRUNCATE(COUNT(CASE WHEN w.10min_dir_avg BETWEEN 157.6 AND 202.5 THEN 1 ELSE NULL END)*100/COUNT(w.10min_dir_avg),2) as 'ЮГ',
TRUNCATE(COUNT(CASE WHEN w.10min_dir_avg BETWEEN 202.6 AND 247.5 THEN 1 ELSE NULL END)*100/COUNT(w.10min_dir_avg),2) as 'ЮГО-ЗАПАД',
TRUNCATE(COUNT(CASE WHEN w.10min_dir_avg BETWEEN 247.6 AND 292.5 THEN 1 ELSE NULL END)*100/COUNT(w.10min_dir_avg),2) as 'ЗАПАД',
TRUNCATE(COUNT(CASE WHEN w.10min_dir_avg BETWEEN 292.6 AND 337.5 THEN 1 ELSE NULL END)*100/COUNT(w.10min_dir_avg),2) as 'СЕВЕРО-ЗАПАД'
FROM wind w 
left join  measurement m on w.id = m.id where m.measure_date like '2022%' and w.wind_status = 0;

-- Представления
 
create view p_all_count_weather as select count(case when weather_inst is not null and weather_status=0 then 1 else null end) as col_weather from weather;
select * from p_all_count_weather;


create view p_temp_avg as select TRUNCATE(AVG(case WHEN temp_status=0 THEN temp_inst ELSE NULL END),2) AS avg_temp from temperature 
left join measurement m ON temperature.id =m.id group by DATE_FORMAT(m.measure_date,'%m.%Y'); 

select * from p_temp_avg;

-- Функция

delimiter //			   
create function category_description (category CHAR)
returns varchar(255) no sql
begin
	if (category = 'A') then return "Предельно неустойчивая";
		elseif (category = 'B') then return "Умеренно неустойчивая";
		elseif (category = 'C') then return "Слегка неустойчивая";
		elseif (category = 'D') then return "Нейтральная";
		elseif (category = 'E') then return "Слегка устойчивая";
		elseif (category = 'F') then return "Умеренно устойчивая";
		else return "Не определена";
	end if;
end //
delimiter ;

-- Преобладающая категория устойчивости
SELECT DISTINCT CONCAT(c.name_category,' ',category_description(c.name_category)) as category,
	COUNT(c.name_category) OVER(PARTITION BY c.name_category) AS count_category
from category c 
left join measurement m on c.id =m.id 
where m.measure_date like '2022%' order by count_category desc;
