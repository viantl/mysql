-- ������ ��
CREATE database if not EXISTS meteostation;

-- ������ � �������
USE meteostation;

-- �����������
create table if not exists sensor_status(
		num_status tinyint unsigned not null primary key COMMENT "�������� ������� �������",
		description varchar(200) COMMENT "�����������" 
		) COMMENT "���������� �������� ��������";
	
create table if not exists  weather_type(
		num_type tinyint unsigned not null primary key COMMENT "�������� ���� ������",
		description varchar(200) COMMENT "�������� ���� ������" 
		) COMMENT "���������� ����� ������";

-- ������� ������� ���������
create table if not exists measurement (
	id INT unsigned not null auto_increment primary key COMMENT "������������� ������", 
	measure_date DATETIME default NOW() unique COMMENT "����� ���������") COMMENT "����� ���������";		

-- �����������:
create table if not exists temperature (
		id INT unsigned not null auto_increment primary key COMMENT "������������� ������",
		temp_status tinyint unsigned default null COMMENT "������ ������� �����������",
		temp_inst decimal(4,1) default null COMMENT "����������� �������",
		temp_avg decimal(4,1) default null COMMENT "����������� ������� �� 1 ���",
		temp_max decimal(4,1) default null COMMENT "����������� ������������ �� 1 ���",
		temp_min decimal(4,1) default null COMMENT "����������� ����������� �� 1 ���") COMMENT "�����������";

-- ���������
create table if not exists humidity (
		id INT unsigned not null auto_increment primary key COMMENT "������������� ������",
		humidity_status tinyint unsigned default null COMMENT "������ ������� ���������",
  		humidity_inst tinyint unsigned default null COMMENT "��������� �������",
  		humidity_avg tinyint unsigned default null COMMENT "��������� ������� �� 1 ���",
  		humidity_max tinyint unsigned default null COMMENT "��������� ������������ �� 1 ���",
  		humidity_min tinyint unsigned default null COMMENT "��������� ����������� �� 1 ���") COMMENT "���������";
  
-- ����� ����
create table if not exists dewpoint (
		id INT unsigned not null auto_increment primary key COMMENT "������������� ������",
		dewpoint_inst decimal(4,1) default null COMMENT "����� ���� �������",
  		dewpoint_avg decimal(4,1) default null COMMENT "����� ���� ������� �� 1 ���",
  		dewpoint_max decimal(4,1) default null COMMENT "����� ���� ������������ �� 1 ���",
  		dewpoint_min decimal(4,1) default null COMMENT "����� ���� ����������� �� 1 ���") COMMENT "����� ����";
  
 -- ����������� �����
create table if not exists ground (
  		id INT unsigned not null auto_increment primary key COMMENT "������������� ������",
 		ground_status tinyint unsigned default null COMMENT "������ ������� ����������� �����",
  		ground_inst decimal(4,1) default null COMMENT "����������� ����� �������",
  		ground_avg decimal(4,1) default null COMMENT "����������� ����� ������� �� 1 ���",
  		ground_max decimal(4,1) default null COMMENT "����������� ����� ����������� �� 1 ���",
  		ground_min decimal(4,1) default null COMMENT "����������� ����� ������������ �� 1 ���") COMMENT "����������� �����";
		
-- ����������� ��������
create table if not exists pressure (
  		id INT unsigned not null auto_increment primary key COMMENT "������������� ������",
  		pressure_status tinyint unsigned default null COMMENT "������ ������� ������������ ��������",
  		pressure_inst decimal(5,1) unsigned default null COMMENT "����������� �������� �������",
  		pressure_avg decimal(5,1) unsigned default null COMMENT "����������� �������� ����������� �� 1 ���",
  		pressure_max decimal(5,1) unsigned default null COMMENT "����������� �������� ����������� �� 1 ���",
  		pressure_min decimal(5,1) unsigned default null COMMENT "����������� �������� ����������� �� 1 ���",
  		qfe_inst decimal(5,1) unsigned default null COMMENT "���. �������� �� ������ ������� �������",
  		qfe_avg decimal(5,1) unsigned default null COMMENT "���. �������� �� ������ ������� ����������� �� 1 ���",
  		qfe_max decimal(5,1) unsigned default null COMMENT "���. �������� �� ������ ������� ����. �� 1 ���",
  		qfe_min decimal(5,1) unsigned default null COMMENT "���. �������� �� ������ ������� ���. �� 1 ���",
  		qff_inst decimal(5,1) unsigned default null COMMENT "���. �������� �� ������ ���� ������� �� 1 ���",
  		qff_avg decimal(5,1) unsigned default null COMMENT "���. �������� �� ������ ���� ����������� �� 1 ���",
  		qff_max decimal(5,1) unsigned default null COMMENT "���. �������� �� ������ ���� ������������ �� 1 ���",
  		qff_min decimal(5,1) unsigned default null COMMENT "���. �������� �� ������ ���� ����������� �� 1 ���") COMMENT "����������� ��������"; 
   
-- ��������� ��������
create table if not exists solar (
  		id INT unsigned not null auto_increment primary key COMMENT "������������� ������",
  		solar_status tinyint unsigned default null COMMENT "������ ������� ��������� ��������",
  		solar_inst smallint unsigned default null COMMENT "��������� �������� �������",
  		solar_avg smallint unsigned default null COMMENT "��������� �������� ����������� �� 1 ���",
  		solar_max smallint unsigned default null COMMENT "��������� �������� ����������� �� 1 ���",
  		solar_min smallint unsigned default null COMMENT "��������� �������� ����������� �� 1 ���") COMMENT "��������� ��������";

-- ������ ��������� ���������
create table if not exists net (
  		id INT unsigned not null auto_increment primary key COMMENT "������������� ������",
  		net_status tinyint unsigned default null COMMENT "������ ������� ������������� �������",
  		net_inst smallint default null COMMENT "������������ ������ �������",
  		net_avg smallint default null COMMENT "������������ ������ ����������� �� 1 ���",
  		net_max smallint default null COMMENT "������������ ������ ������������ �� 1 ���",
  		net_min smallint default null COMMENT "������������ ������ ����������� �� 1 ���") COMMENT "������������ ������"; 
   
 -- �����
create table if not exists wind (
  		id INT unsigned not null auto_increment primary key COMMENT "������������� ������",
  		wind_status tinyint unsigned default null COMMENT "������ ������� �����",
  		2min_speed_inst decimal(3,1) unsigned default null COMMENT "�������� ����� ����������, ����� ��������� 2 ������",
		2min_speed_avg decimal(3,1) unsigned default null COMMENT "�������� ����� ����������, ����� ��������� 2 ������",
		2min_speed_max decimal(3,1) unsigned default null COMMENT "�������� ����� ������������, ����� ��������� 2 ������",
		2min_speed_min decimal(3,1) unsigned default null COMMENT "�������� ����� �����������, ����� ��������� 2 ������",
		2min_dir_inst smallint unsigned default null COMMENT "����������� ����� ����������, ����� ��������� 2 ������",
		2min_dir_avg smallint unsigned default null COMMENT "����������� ����� �����������, ����� ��������� 2 ������",
		2min_dir_max smallint unsigned default null COMMENT "����������� ����� ������������, ����� ��������� 2 ������",
		2min_dir_min smallint unsigned default null COMMENT "����������� ����� �����������, ����� ��������� 2 ������",
		10min_speed_avg decimal(3,1) unsigned default null COMMENT "�������� ����� ����������, ����� ��������� 10 �����",
		10min_speed_max decimal(3,1) unsigned default null COMMENT "�������� ����� ������������, ����� ��������� 10 �����",
		10min_speed_min decimal(3,1) unsigned default null COMMENT "�������� ����� �����������, ����� ��������� 10 �����",
		10min_dir_avg smallint unsigned default null COMMENT "����������� ����� �����������, ����� ��������� 10 �����",
		10min_dir_max smallint unsigned default null COMMENT "����������� ����� ������������, ����� ��������� 10 �����",
		10min_dir_min smallint unsigned default null COMMENT "����������� ����� �����������, ����� ��������� 10 �����") COMMENT "�����";
   
-- ������
create table if not exists weather (
		id INT unsigned not null auto_increment primary key COMMENT "������������� ������",
		weather_status tinyint unsigned default null COMMENT "������ ������� ������",
		weather_inst tinyint unsigned default null COMMENT "��� ������ �������",
  		weather_avg tinyint unsigned default null COMMENT "��� ������ ���������� �� 1 ���",
  		weather_snow_sum decimal(4,1) unsigned default null COMMENT "����� ������� �������",
  		weather_rain_int decimal(4,1) unsigned default null COMMENT "������������� �������",
  		weather_water_sum decimal(4,1) unsigned default null COMMENT "����� ������ �������",
  		visiblity_inst smallint unsigned default null COMMENT "���������� �������� ���������",
  		visiblity_avg smallint unsigned default null COMMENT "��������� ����������� �� 1 ���") COMMENT "������ ������";
   
-- ������
create table if not exists precipitation (
		id INT unsigned not null auto_increment primary key COMMENT "������������� ������",
  		precipitation_status tinyint unsigned default null COMMENT "������ ������� �������",
  		precipitation_1m decimal(4,1) unsigned default null COMMENT "������ �� 1 ���.",
  		precipitation_10m decimal(4,1) unsigned default null COMMENT "������ �� 10 ���.",
  		precipitation_1d decimal(4,1) unsigned default null COMMENT "������ �� 1 ����") COMMENT "������";
   
-- ��������������
create table if not exists voltage (
		id INT unsigned not null auto_increment primary key COMMENT "������������� ������",
		voltage_status  tinyint unsigned default null COMMENT "������ �������� �������",
  		voltage_inst decimal(5,2) unsigned default null COMMENT "������� ���������� �������") COMMENT "�������� ��������������";
  
-- ��������� ������������
create table if not exists category (
		id INT unsigned not null auto_increment primary key COMMENT "������������� ������",
		name_category enum('A','A-B','B','B-C','C','C-D','D','E','F') default null COMMENT "��������� ������������ ���������")
	    COMMENT "��������� ������������ ���������";


