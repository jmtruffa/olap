
--Creacion Tabla fecha (Dimension)

CREATE TABLE fecha (
	CodFechaKey SERIAL PRIMARY KEY,
    Fecha DATE,
    NroDia INT,
	NroMes INT,
    NroAnio INT, 
	NombreMes VARCHAR(15),
	DiaSemana VARCHAR(10),
    Trimestre INT,
    Cuatrimestre INT,
	Semestre INT,
    SemanaAnio INT
);


--insertar datos en la tabla de dimension fecha

WITH RECURSIVE date_series AS (
    SELECT DATE '2023-01-01' AS fecha
    UNION ALL
    SELECT (fecha + INTERVAL '1 day')::DATE
    FROM date_series
    WHERE (fecha + INTERVAL '1 day') <= '2040-12-31'
);
	
INSERT INTO fecha (fecha, nrodia, nromes, nroanio,nombremes,diasemana,trimestre,cuatrimestre, semestre,semanaanio)
	SELECT 
    fecha,
	EXTRACT(DAY FROM fecha) AS nrodia,
	EXTRACT(MONTH FROM fecha) AS nromes,
    EXTRACT(YEAR FROM fecha) AS nroanio,
    TO_CHAR(fecha, 'Month') AS nombremes,
	TRIM(TO_CHAR(fecha, 'Day')) AS diasemana,
	EXTRACT(QUARTER FROM fecha) AS trimestre,
    trunc((EXTRACT(MONTH FROM fecha) - 1) / 4) + 1 AS cuatrimestre,
    trunc((EXTRACT(MONTH FROM fecha) - 1) / 6) + 1 AS semestre,
	EXTRACT(WEEK FROM fecha) AS semanaanio
FROM date_series;



-- Crear la tabla  de dimension FONDOS con CodFondoKey como serial
CREATE TABLE FONDO (
    CodFondoKey SERIAL PRIMARY KEY,
    NombreFondo VARCHAR(255),
    Familia VARCHAR(255),
    Categoria VARCHAR(255),
    Subcategoria VARCHAR(255),
    Moneda VARCHAR(50),
    FechaDesde DATE,
    FechaHasta DATE
);



-- Insertar datos en la tabla FONDO desde la consulta a claseds
-- Excluye CodFondoKey ya que se generará automáticamente
INSERT INTO FONDO (NombreFondo, Familia, Categoria, Subcategoria, Moneda, FechaDesde, FechaHasta)
SELECT DISTINCT 
    FONDO,
    Familia,
    Categoria,
    Subcategoria,
    'Pesos' as Moneda,
    desde as FechaDesde,
    hasta as FechaHasta
FROM clases;


	
-- Crea la tabla dimension variable_macro

CREATE TABLE variable_macro (
    
    codvariablekey SERIAL PRIMARY KEY,
    NombreVarMacro VARCHAR(15),
	DescripcionVarMacro VARCHAR,
	periodicidadBase varchar(15)
);


--Insert de registros de tabla de dimension variable_macro

Insert into variable_macro (NombreVarmacro,descripcionvarmacro,periodicidadBase) Values ('CCL','cotizacion dolar ccl','diaria');	
Insert into variable_macro (NombreVarmacro,descripcionvarmacro,periodicidadBase) Values ('A3500','cotizacion dolar a3500','diaria');	
Insert into variable_macro (NombreVarmacro,descripcionvarmacro,periodicidadBase) Values ('IPCINDEC','inflacion general','mensual');	
Insert into variable_macro (NombreVarmacro,descripcionvarmacro,periodicidadBase) Values ('USCPI','inflacion EEUU','mensual');
Insert into variable_macro (NombreVarmacro,descripcionvarmacro,periodicidadBase) Values ('MEP','Dolar MEP','diaria');


-- Crea la tabla fact valores_car_macro

CREATE TABLE valores_var_macro (
    
    codvariablekey INT,
	codfechakey INT,
	Valor float,
	ValorBase float,
	PRIMARY KEY (codvariablekey, codfechakey),
    FOREIGN KEY (codvariablekey) REFERENCES variable_macro(codvariablekey),
	FOREIGN KEY (codfechakey) REFERENCES fecha(codfechakey)
	
);

-- inserta registros en la tabla fact valores_car_macro
	

INSERT INTO valores_var_macro (codfechakey, codvariablekey, valor, valorbase)

select 
codfechakey,
1 as codVariableKey,
value as valor,
value_base as valor_base
from tmp_vars_macro Tmp
left join fecha on tmp.date = fecha.fecha
where codfechakey is not null 
and  var = 'CCL'
	
union

select 
codfechakey,
2 as codVariableKey,
value as valor,
value_base as valor_base
from tmp_vars_macro Tmp
left join fecha on tmp.date = fecha.fecha
where codfechakey is not null 
and  var = 'A3500'
	

union

select 
codfechakey,
3 as codVariableKey,
value as valor,
value_base as valor_base
from tmp_vars_macro Tmp
left join fecha on tmp.date = fecha.fecha
where codfechakey is not null 
and  var = 'IPCINDEC'

	union

select 
codfechakey,
4 as codVariableKey,
value as valor,
value_base as valor_base
from tmp_vars_macro Tmp
left join fecha on tmp.date = fecha.fecha
where codfechakey is not null 
and  var = 'USCPI'

	union

select 
codfechakey,
5 as codVariableKey,
value as valor,
value_base as valor_base
from tmp_vars_macro Tmp
left join fecha on tmp.date = fecha.fecha
where codfechakey is not null 
and  var = 'MEP'	
;

--Crea la tabla fact eventos

CREATE TABLE Eventos (
    
    codeventokey SERIAL PRIMARY KEY,
    codFechaKey INT,
	ClaseEvento VARCHAR(15),
	DescripcionEvento varchar,
	FOREIGN KEY (codfechakey) REFERENCES fecha(codfechakey)
	);



--Crea la tabla fact cotizaciones


CREATE TABLE cotizaciones (
    CodFondoKey INT,
    codfechakey INT,
    ValorCuotaParte DECIMAL,
    CantidadCuotaParte DECIMAL,
	Patrimonio DECIMAL,
    EfectoPrecio DECIMAL,
    EfectoSuscripcion DECIMAL,
    VarPorcentualDiaria DECIMAL,
    VarPorcentualSemana DECIMAL,
	VarPorcentualMes DECIMAL,
	VarPorcentualBimestre DECIMAL,	
    VarPorcentualCuatrimestre DECIMAL,
    VarPorcentualSemestre DECIMAL,
    VarPorcentualAno DECIMAL,
	PRIMARY KEY (codFondokey, codfechakey),
    FOREIGN KEY (codfondokey) REFERENCES fondo(codfondokey),
    FOREIGN KEY (codfechakey) REFERENCES fecha(codfechakey)
);

--Inserta la tabla cotizaciones

INSERT INTO cotizaciones
with week1 as 

(

select 
	fondo,
fecha.fecha + interval '1 WEEK' as fecha_7,
fecha.fecha,
d1.vcp as vcp
from diaria d1
left join fondo 
on d1.fondo = fondo.nombrefondo
left join fecha
on d1.fecha = fecha.fecha


order by codfondokey,codfechakey

),

 month1 as 

(

select 
	fondo,
fecha.fecha + interval '1 MONTH' as fecha_30,
fecha.fecha,
d1.vcp as vcp
from diaria d1
left join fondo 
on d1.fondo = fondo.nombrefondo
left join fecha
on d1.fecha = fecha.fecha


order by codfondokey,codfechakey

),

 month2 as 

(

select 
	fondo,
fecha.fecha + interval '2 MONTH' as fecha_60,
fecha.fecha,
d1.vcp as vcp
from diaria d1
left join fondo 
on d1.fondo = fondo.nombrefondo
left join fecha
on d1.fecha = fecha.fecha


order by codfondokey,codfechakey

),

 four_month as 

(

select 
	fondo,
fecha.fecha + interval '4 MONTH' as fecha_120,
fecha.fecha,
d1.vcp as vcp
from diaria d1
left join fondo 
on d1.fondo = fondo.nombrefondo
left join fecha
on d1.fecha = fecha.fecha


order by codfondokey,codfechakey

),

 semester as 

(

select 
	fondo,
fecha.fecha + interval '6 MONTH' as fecha_180,
fecha.fecha,
d1.vcp as vcp
from diaria d1
left join fondo
on d1.fondo = fondo.nombrefondo
left join fecha
on d1.fecha = fecha.fecha


order by codfondokey,codfechakey

),

 year as 

(

select 
	fondo,
fecha.fecha + interval '1 YEAR' as fecha_360,
fecha.fecha,
d1.vcp as vcp
from diaria d1
left join fondo 
on d1.fondo = fondo.nombrefondo
left join fecha
on d1.fecha = fecha.fecha


order by codfondokey,codfechakey

)


select 
codfondokey,
fecha.codfechakey as codfechakey,
d1.vcp as ValorCuotaParte,
d1.ccp as CantidadCuotaParte,
d1.patrimonio as patrimonio,	
(d1.vcp * lag(d1.ccp, 1) over (partition by codfondokey order by codfechakey))
- (lag(d1.vcp, 1) over (partition by codfondokey order by codfechakey) * lag(d1.ccp, 1) over (partition by codfondokey order by codfechakey)) as EfectoPrecio,

(d1.vcp * d1.ccp)- (lag(d1.vcp, 1) over (partition by codfondokey order by codfechakey) * lag(d1.ccp, 1) over (partition by codfondokey order by codfechakey))-
((d1.vcp * lag(d1.ccp, 1) over (partition by codfondokey order by codfechakey))
- (lag(d1.vcp, 1) over (partition by codfondokey order by codfechakey) * lag(d1.ccp, 1) over (partition by codfondokey order by codfechakey)))as EfectoSuscripcion,
	
(d1.vcp / (lag(d1.vcp, 1) over (partition by codfondokey order by codfechakey)) - 1) * 100 as VarPorcentualDiaria,
((d1.vcp / (coalesce(week1.vcp, 
					lag(week1.vcp) over (partition by codfondokey order by codfechakey),
					lag(week1.vcp, 2) over (partition by codfondokey order by codfechakey),
					lag(week1.vcp, 3) over (partition by codfondokey order by codfechakey),
					lag(week1.vcp, 4) over (partition by codfondokey order by codfechakey),
					lag(week1.vcp, 5) over (partition by codfondokey order by codfechakey))
					)
					) - 1 ) * 100 as VarPorcentualSemana,
((d1.vcp / (coalesce(month1.vcp, 
					lag(month1.vcp) over (partition by codfondokey order by codfechakey),
					lag(month1.vcp, 2) over (partition by codfondokey order by codfechakey),
					lag(month1.vcp, 3) over (partition by codfondokey order by codfechakey),
					lag(month1.vcp, 4) over (partition by codfondokey order by codfechakey),
					lag(month1.vcp, 5) over (partition by codfondokey order by codfechakey))
					)
					) - 1 ) * 100 as VarPorcentualmes,
((d1.vcp / (coalesce(month2.vcp, 
					lag(month2.vcp) over (partition by codfondokey order by codfechakey),
					lag(month2.vcp, 2) over (partition by codfondokey order by codfechakey),
					lag(month2.vcp, 3) over (partition by codfondokey order by codfechakey),
					lag(month2.vcp, 4) over (partition by codfondokey order by codfechakey),
					lag(month2.vcp, 5) over (partition by codfondokey order by codfechakey))
					)
					) - 1 ) * 100 as VarPorcentualBimestre,
((d1.vcp / (coalesce(four_month.vcp, 
					lag(four_month.vcp) over (partition by codfondokey order by codfechakey),
					lag(four_month.vcp, 2) over (partition by codfondokey order by codfechakey),
					lag(four_month.vcp, 3) over (partition by codfondokey order by codfechakey),
					lag(four_month.vcp, 4) over (partition by codfondokey order by codfechakey),
					lag(four_month.vcp, 5) over (partition by codfondokey order by codfechakey))
					)
					) - 1 ) * 100 as VarPorcentualCuatrimestre,
((d1.vcp / (coalesce(semester.vcp, 
					lag(semester.vcp) over (partition by codfondokey order by codfechakey),
					lag(semester.vcp, 2) over (partition by codfondokey order by codfechakey),
					lag(semester.vcp, 3) over (partition by codfondokey order by codfechakey),
					lag(semester.vcp, 4) over (partition by codfondokey order by codfechakey),
					lag(semester.vcp, 5) over (partition by codfondokey order by codfechakey))
					)
					) - 1 ) * 100 as VarPorcentualSemestre,
((d1.vcp / (coalesce(year.vcp, 
					lag(year.vcp) over (partition by codfondokey order by codfechakey),
					lag(year.vcp, 2) over (partition by codfondokey order by codfechakey),
					lag(year.vcp, 3) over (partition by codfondokey order by codfechakey),
					lag(year.vcp, 4) over (partition by codfondokey order by codfechakey),
					lag(year.vcp, 5) over (partition by codfondokey order by codfechakey))
					)
					) - 1 ) * 100 as VarPorcentualAno
					
					

from diaria d1
left join fondo 
on d1.fondo = fondo.nombrefondo
left join fecha
on d1.fecha = fecha.fecha

left join week1 
on week1.fecha_7 = fecha.fecha and week1.fondo = d1.fondo 

left join month1 
on month1.fecha_30 = fecha.fecha and month1.fondo = d1.fondo 
	and substr(to_char(month1.fecha,'DD-MM-YYYY'),1,2)	 = substr(to_char(month1.fecha_30,'DD-MM-YYYY'),1,2)	

	
left join month2 
on month2.fecha_60 = fecha.fecha and month2.fondo = d1.fondo
	and substr(to_char(month2.fecha,'DD-MM-YYYY'),1,2)	 = substr(to_char(month2.fecha_60,'DD-MM-YYYY'),1,2)	

	
left join four_month 
on four_month.fecha_120 = fecha.fecha and four_month.fondo = d1.fondo
	and substr(to_char(four_month.fecha,'DD-MM-YYYY'),1,2)	 = substr(to_char(four_month.fecha_120,'DD-MM-YYYY'),1,2)	

left join semester 
on semester.fecha_180 = fecha.fecha and semester.fondo = d1.fondo
	and substr(to_char(semester.fecha,'DD-MM-YYYY'),1,2)	 = substr(to_char(semester.fecha_180,'DD-MM-YYYY'),1,2)	

	
left join year 
on year.fecha_360 = fecha.fecha and semester.fondo = d1.fondo

where codfondokey is not null	
	
order by codfondokey,codfechakey;