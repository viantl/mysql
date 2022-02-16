use meteostation;
-- Температура:
alter table temperature
  add constraint temperature_measurement_id_fk 
    FOREIGN KEY (id) REFERENCES measurement(id)
    	ON DELETE cascade;
alter table temperature  
  add constraint temperature_sensor_status_fk 
    FOREIGN KEY (temp_status) REFERENCES sensor_status(num_status);

create index temp_inst_idx ON temperature(temp_inst);
create index temp_max_temp_min_idx ON temperature(temp_max, temp_min);

-- Влажность
alter table humidity
  add constraint humidity_measurement_id_fk 
    FOREIGN KEY (id) REFERENCES measurement(id)
    	ON DELETE cascade;
alter table humidity
  add constraint humidity_sensor_status_fk 
    FOREIGN KEY (humidity_status) REFERENCES sensor_status(num_status);

create index humidity_inst_idx ON humidity(humidity_inst);

-- Точка росы
alter table dewpoint
  add constraint dewpoint_measurement_id_fk 
    FOREIGN KEY (id) REFERENCES measurement(id);

create index dewpoint_inst_idx ON dewpoint(dewpoint_inst);

-- Температура почвы
alter table ground
  add constraint ground_measurement_id_fk 
    FOREIGN KEY (id) REFERENCES measurement(id)
    	ON DELETE cascade;
alter table ground  
  add constraint ground_sensor_status_fk 
    FOREIGN KEY (ground_status) REFERENCES sensor_status(num_status);
 
create index ground_inst_idx ON ground(ground_inst);

-- Атмосферное давление
alter table pressure
  add constraint pressure_measurement_id_fk 
    FOREIGN KEY (id) REFERENCES measurement(id)
    	ON DELETE cascade;
alter table pressure
  add constraint pressure_sensor_status_fk 
    FOREIGN KEY (pressure_status) REFERENCES sensor_status(num_status);
  	
create index pressure_inst_idx ON pressure(pressure_inst);

-- Солнечная радиация
alter table solar
  add constraint solar_measurement_id_fk 
    FOREIGN KEY (id) REFERENCES measurement(id)
    	ON DELETE cascade;
alter table solar
  add constraint solar_sensor_status_fk 
    FOREIGN KEY (solar_status) REFERENCES sensor_status(num_status);
 
create index solar_inst_idx ON solar(solar_inst);   

-- Баланс теплового излучения
alter table net
  add constraint net_measurement_id_fk 
    FOREIGN KEY (id) REFERENCES measurement(id)
    	ON DELETE cascade;
alter table net  
  add constraint net_sensor_status_fk 
    FOREIGN KEY (net_status) REFERENCES sensor_status(num_status);
  	
create index net_inst_idx ON net(net_inst);  

 -- Ветер
alter table wind
  add constraint wind_measurement_id_fk 
    FOREIGN KEY (id) REFERENCES measurement(id)
    	ON DELETE cascade;
alter table wind  
  add constraint wind_sensor_status_fk 
    FOREIGN KEY (wind_status) REFERENCES sensor_status(num_status);

create index 10min_speed_avg_10min_dir_avg_idx ON wind(10min_speed_avg, 10min_dir_avg);
create index 10min_speed_max_idx ON wind(10min_speed_max);

-- Погода
alter table weather
  add constraint weather_measurement_id_fk 
    FOREIGN KEY (id) REFERENCES measurement(id)
    	ON DELETE cascade;
alter table weather  
  add constraint weather_sensor_status_fk 
    FOREIGN KEY (weather_status) REFERENCES sensor_status(num_status),
  add constraint weather_inst_type_fk 
    FOREIGN KEY (weather_inst) REFERENCES weather_type(num_type),
  add constraint weather_avg_type_fk 
    FOREIGN KEY (weather_avg) REFERENCES weather_type(num_type);
    
create index visiblity_inst_idx ON weather(visiblity_inst);
create index weather_inst_idx ON weather(weather_inst);
create index weather_rain_int_idx ON weather(weather_rain_int);   

-- Осадки
alter table precipitation
  add constraint precipitation_measurement_id_fk 
    FOREIGN KEY (id) REFERENCES measurement(id)
    	ON DELETE cascade;
alter table precipitation
  add constraint precipitation_sensor_status_fk 
    FOREIGN KEY (precipitation_status) REFERENCES sensor_status(num_status);
 	
create index precipitation_1m_idx ON precipitation(precipitation_1m);

-- Электропитание
alter table voltage
  add constraint voltage_measurement_id_fk 
    FOREIGN KEY (id) REFERENCES measurement(id)
    	ON DELETE cascade;
alter table voltage  
  add constraint voltage_sensor_status_fk 
    FOREIGN KEY (voltage_status) REFERENCES sensor_status(num_status);
    
-- Категория устойчивости
alter table category
  add constraint category_measurement_id_fk 
    FOREIGN KEY (id) REFERENCES measurement(id);