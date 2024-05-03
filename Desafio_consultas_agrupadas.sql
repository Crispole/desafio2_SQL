create database desafio_consultas_agrupadas;

CREATE TABLE INSCRITOS(cantidad INT, fecha DATE, fuente VARCHAR);
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 44, '01/01/2021', 'Blog' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 56, '01/01/2021', 'Página' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 39, '01/02/2021', 'Blog' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 81, '01/02/2021', 'Página' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 12, '01/03/2021', 'Blog' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 91, '01/03/2021', 'Página' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 48, '01/04/2021', 'Blog' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 45, '01/04/2021', 'Página' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 55, '01/05/2021', 'Blog' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 33, '01/05/2021', 'Página' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 18, '01/06/2021', 'Blog' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 12, '01/06/2021', 'Página' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 34, '01/07/2021', 'Blog' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 24, '01/07/2021', 'Página' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 83, '01/08/2021', 'Blog' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 99, '01/08/2021', 'Página' );

select * from inscritos;

--1. cuantos registros hay?
select count(*) from inscritos;
	-- 16

--2. ¿Cuántos inscritos hay en total?
select sum(cantidad) from inscritos;
	-- 774

--3.  ¿Cuál o cuáles son los registros de mayor antigüedad?
select * from inscritos order by fecha asc limit 3;
	-- 56	2021-01-01	Página
	-- 44	2021-01-01	Blog
	-- 39	2021-02-01	Blog


--4. ¿Cuántos inscritos hay por día? (Indistintamente de la fuente de inscripción)
select date_trunc('day', fecha) as year,
sum(cantidad) as total 
from inscritos
group by year
order by year;
	-- 2021-01-01 00:00:00.000 -0300	100
	-- 2021-02-01 00:00:00.000 -0300	120
	-- 2021-03-01 00:00:00.000 -0300	103
	-- 2021-04-01 00:00:00.000 -0300	93
	-- 2021-05-01 00:00:00.000 -0400	88
	-- 2021-06-01 00:00:00.000 -0400	30
	-- 2021-07-01 00:00:00.000 -0400	58
	-- 2021-08-01 00:00:00.000 -0400	182

--5. ¿Cuántos inscritos hay por fuente?
select fuente, sum(cantidad) from inscritos group by fuente;
	-- Página	441
	-- Blog		333

--6. ¿Qué día se inscribió la mayor cantidad de personas? Y ¿Cuántas personas se inscribieron en ese día?
select fecha, cantidad from inscritos order by cantidad desc;
select fecha,
sum (cantidad) cantidad from inscritos group by fecha order by cantidad desc;
	-- 2021-08-01	182
	-- 2021-02-01	120
	-- 2021-03-01	103
	-- 2021-01-01	100
	-- 2021-04-01	93
	-- 2021-05-01	88
	-- 2021-07-01	58
	-- 2021-06-01	30

--7. ¿Qué días se inscribieron la mayor cantidad de personas utilizando el blog? ¿Cuántas personas fueron?
select cantidad, fecha
from inscritos
where fuente = 'Blog'
order by cantidad desc
limit 3;
	-- 83	2021-08-01
	-- 55	2021-05-01
	-- 48	2021-04-01

--8. ¿Cuál es el promedio de personas inscritas por día? Toma en consideración que la base de datos tiene un registro de 8 días, es decir, se obtendrán 8 promedios.
select fecha, trim_scale(AVG(cantidad))
from inscritos
group by fecha
order by fecha;
	-- 2021-01-01	50
	-- 2021-02-01	60
	-- 2021-03-01	51.5
	-- 2021-04-01	46.5
	-- 2021-05-01	44
	-- 2021-06-01	15
	-- 2021-07-01	29
	-- 2021-08-01	91

--9.  ¿Qué días se inscribieron más de 50 personas?
select fecha, SUM(cantidad) AS total_personas_despedidas
from inscritos
group by fecha
having SUM(cantidad) > 50;
	-- 2021-02-01	120
	-- 2021-08-01	182
	-- 2021-05-01	88
	-- 2021-04-01	93
	-- 2021-07-01	58
	-- 2021-03-01	103
	-- 2021-01-01	100

--10. ¿Cuál es el promedio por día de personas inscritas? Considerando sólo calcular desde el tercer día.
select floor(AVG(cantidad)) as promedio
from inscritos
where fecha >= '2021-01-03';
	-- 48