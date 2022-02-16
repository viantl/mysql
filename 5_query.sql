use meteostation;  
-- ������� ������� ����������� � ����������� 10 �����     
select DATE_FORMAT(measure_date,'%Y.%m.%d %H:%i') as data,
TRUNCATE(AVG(CASE WHEN t.temp_status=0 THEN t.temp_inst ELSE NULL END),1) AS avg_temp,  						-- ������� �����������
TRUNCATE(MAX(CASE WHEN t.temp_status=0 THEN t.temp_max ELSE NULL END),1) AS max_temp,							-- ������������ �����������
TRUNCATE(MIN(CASE WHEN t.temp_status=0 THEN t.temp_min ELSE NULL END),1) AS min_temp,							-- ����������� �����������
TRUNCATE(0.75*AVG(CASE WHEN p.pressure_status=0 THEN p.pressure_inst ELSE NULL END),1) AS avg_pressure,			-- ������� �������� � ��.��.��.
TRUNCATE(0.75*MIN(CASE WHEN p.pressure_status=0 THEN p.pressure_min ELSE NULL END),1) AS min_pressure,			-- ����������� ��������
TRUNCATE(0.75*MAX(CASE WHEN p.pressure_status=0 THEN p.pressure_max ELSE NULL END),1) AS max_pressure,			-- ������������ ��������
TRUNCATE(AVG(CASE WHEN h.humidity_status=0 THEN h.humidity_inst ELSE NULL END),1) AS avg_hum,					-- ������� ���������
TRUNCATE(AVG(CASE WHEN g.ground_status=0 THEN g.ground_inst ELSE NULL END),1) AS avg_ground,					-- ������� ����������� �����
TRUNCATE(MIN(CASE WHEN g.ground_status=0 THEN g.ground_min ELSE NULL END),1) AS min_ground,						-- ����������� ����������� �����
TRUNCATE(AVG(CASE WHEN w.wind_status=0 THEN w.10min_speed_avg ELSE NULL END),1) AS avg_speed,					-- ������� �������� �����
TRUNCATE(MAX(CASE WHEN w.wind_status=0 THEN w.10min_speed_max ELSE NULL END),1) AS max_speed,					-- ������������ �����
TRUNCATE(AVG(CASE WHEN s.solar_inst>0 AND s.solar_status=0 THEN s.solar_inst ELSE NULL END),1) AS avg_solar,	-- ������� ��������� ��������
TRUNCATE(SUM((CASE WHEN w2.weather_status=0 THEN w2.weather_rain_int ELSE NULL END)/60),3) AS rain_sum			-- ��������� ���������� �������
from measurement m
left join temperature t on m.id =t.id
left join pressure p on m.id = p.id
left join humidity h on m.id = h.id
left join ground g  on m.id = g.id
left join wind w on m.id = w.id
left join solar s on m.id = s.id
left join weather w2 on m.id = w2.id
GROUP BY CONCAT(DATE_FORMAT(measure_date,'%Y.%m.%d %H:'),FLOOR(DATE_FORMAT(measure_date,'%i')/10)*10) ORDER BY YEAR(data) desc;
            
-- ������������� ����������� � ������� �������� �����        
SELECT CASE 
WHEN (w.10min_dir_avg >= 349 OR w.10min_dir_avg<12) and w.wind_status =0 THEN '�����'
WHEN w.10min_dir_avg BETWEEN 12 AND 33 THEN '�����-������-������'
WHEN w.10min_dir_avg BETWEEN 34 AND 56 THEN '������-������'
WHEN w.10min_dir_avg BETWEEN 57 AND 78 THEN '������-������-������'
WHEN w.10min_dir_avg BETWEEN 79 AND 101 THEN '������'
WHEN w.10min_dir_avg BETWEEN 102 AND 123 THEN '������-���-������'
WHEN w.10min_dir_avg BETWEEN 124 AND 146 THEN '���-������'
WHEN w.10min_dir_avg BETWEEN 147 AND 168 THEN '��-���-������'
WHEN w.10min_dir_avg BETWEEN 169 AND 191 THEN '��'
WHEN w.10min_dir_avg BETWEEN 192 AND 213 THEN '��-���-�����'
WHEN w.10min_dir_avg BETWEEN 214 AND 236 THEN '���-�����'
WHEN w.10min_dir_avg BETWEEN 237 AND 258 THEN '�����-���-�����'
WHEN w.10min_dir_avg BETWEEN 259 AND 281 THEN '�����'
WHEN w.10min_dir_avg BETWEEN 282 AND 303 THEN '�����-������-�����'
WHEN w.10min_dir_avg BETWEEN 304 AND 326 THEN '������-�����'
WHEN w.10min_dir_avg BETWEEN 327 AND 348 THEN '�����-������-�����'
END AS rumb, 
count(10min_dir_avg) AS count_direction, 
TRUNCATE(AVG(10min_speed_avg),2) as avg_speed 
FROM wind w
left join measurement m on w.id = m.id 
where m.measure_date like '2022%' and w.wind_status = 0 group by rumb order by count_direction desc limit 1;

           
-- ������������� ����� �� ������������ � % - ���� ������
SELECT 
TRUNCATE(COUNT(CASE WHEN w.10min_dir_avg >=337.6 OR w.10min_dir_avg<22.5 THEN 1 ELSE NULL END)*100/COUNT(w.10min_dir_avg),2) as '�����', 
TRUNCATE(COUNT(CASE WHEN w.10min_dir_avg BETWEEN 22.5 AND 67.5 THEN 1 ELSE NULL END)*100/COUNT(w.10min_dir_avg),2) as '������-������',
TRUNCATE(COUNT(CASE WHEN w.10min_dir_avg BETWEEN 67.6 AND 112.5 THEN 1 ELSE NULL END)*100/COUNT(w.10min_dir_avg),2) as '������',
TRUNCATE(COUNT(CASE WHEN w.10min_dir_avg BETWEEN 112.6 AND 157.5 THEN 1 ELSE NULL END)*100/COUNT(w.10min_dir_avg),2) as '���-������',
TRUNCATE(COUNT(CASE WHEN w.10min_dir_avg BETWEEN 157.6 AND 202.5 THEN 1 ELSE NULL END)*100/COUNT(w.10min_dir_avg),2) as '��',
TRUNCATE(COUNT(CASE WHEN w.10min_dir_avg BETWEEN 202.6 AND 247.5 THEN 1 ELSE NULL END)*100/COUNT(w.10min_dir_avg),2) as '���-�����',
TRUNCATE(COUNT(CASE WHEN w.10min_dir_avg BETWEEN 247.6 AND 292.5 THEN 1 ELSE NULL END)*100/COUNT(w.10min_dir_avg),2) as '�����',
TRUNCATE(COUNT(CASE WHEN w.10min_dir_avg BETWEEN 292.6 AND 337.5 THEN 1 ELSE NULL END)*100/COUNT(w.10min_dir_avg),2) as '������-�����'
FROM wind w 
left join  measurement m on w.id = m.id where m.measure_date like '2022%' and w.wind_status = 0;

-- �������������
 
create view p_all_count_weather as select count(case when weather_inst is not null and weather_status=0 then 1 else null end) as col_weather from weather;
select * from p_all_count_weather;


create view p_temp_avg as select TRUNCATE(AVG(case WHEN temp_status=0 THEN temp_inst ELSE NULL END),2) AS avg_temp from temperature 
left join measurement m ON temperature.id =m.id group by DATE_FORMAT(m.measure_date,'%m.%Y'); 

select * from p_temp_avg;

-- �������

delimiter //			   
create function category_description (category CHAR)
returns varchar(255) no sql
begin
	if (category = 'A') then return "��������� ������������";
		elseif (category = 'B') then return "�������� ������������";
		elseif (category = 'C') then return "������ ������������";
		elseif (category = 'D') then return "�����������";
		elseif (category = 'E') then return "������ ����������";
		elseif (category = 'F') then return "�������� ����������";
		else return "�� ����������";
	end if;
end //
delimiter ;

-- ������������� ��������� ������������
SELECT DISTINCT CONCAT(c.name_category,' ',category_description(c.name_category)) as category,
	COUNT(c.name_category) OVER(PARTITION BY c.name_category) AS count_category
from category c 
left join measurement m on c.id =m.id 
where m.measure_date like '2022%' order by count_category desc;
