___________________________________
2.
mysql> SHOW DATABASES;
+--------------------+
| Database           |
+--------------------+
| information_schema |
| mysql              |
| performance_schema |
| shop               |
| sys                |
+--------------------+
5 rows in set (0.00 sec)

mysql> CREATE DATABASE example;
Query OK, 1 row affected (0.01 sec)

mysql> USE example;
Database changed

mysql> CREATE TABLE users (id SERIAL PRIMARY KEY, name VARCHAR(255) COMMENT 'Имя пользователя');
Query OK, 0 rows affected (0.02 sec)
mysql> exit
Bye
___________________________________
3.
C:\Users\Олег Иванович>mysqldump example > sample.sql
C:\Users\Олег Иванович>mysql
mysql> CREATE DATABASE sample;
Query OK, 1 row affected (0.01 sec)
mysql> exit
Bye

mysqldump example > sample.sql
--Переместила дамп sample.sql на диск С (чтобы путь короче стал). Создала файл dump_import.bat такого содержания:
cd /D C:\Program Files\MySQL\MySQL Server 8.0\bin
mysql -u root sample < C:\sample.sql

--Из командной строки:
C:\>dump_import.bat

mysql> use sample
Database changed
mysql> SHOW TABLES;
+------------------+
| Tables_in_sample |
+------------------+
| users            |
+------------------+
1 row in set (0.00 sec)

___________________________________
4.
mysqldump --databases mysql --tables help_keyword --where="1 limit 100" > help_keyword.sql