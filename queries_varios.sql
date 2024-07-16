

---------------------------------
--------------------------------------------------------------------------
--------------------------------------------------------------------------

/*Efectos
i. Cuál fue el efecto suscripción neto (suscripciones menos rescates) para un fondo/subcategoría/categoría en el período día/semana/mes/año/ytd/mtd/rango específico?
ii. Cuál fue el efecto precio para un fondo/categoría/subcategoría en el período día/semana/mes/año/ytd/mtd/rango específico?
*/

--EFECTO SUSCRIPCION

--POR AÑO

--CUBO DE DIMENSIONES AÑO, CATEGORIA


select  f2.nroanio , f.categoria, round(sum(c.efectosuscripcion)) 
from cotizaciones c , fondo f , fecha f2 
where c.codfondokey  = f.codfondokey 
and c.codfechakey = f2.codfechakey  
group by cube (f2.nroanio , f.categoria) 
order by f2.nroanio , f.categoria

--CUBO DE DIMENSIONES AÑO, FONDO

select  f2.nroanio, f.nombrefondo , round(sum(c.efectosuscripcion)) 
from cotizaciones c , fondo f , fecha f2 
where c.codfondokey  = f.codfondokey 
and c.codfechakey = f2.codfechakey  
group by cube (f2.nroanio, f.nombrefondo) 
order by f2.nroanio, f.nombrefondo 



--CUBO DE DIMENSIONES AÑO, FAMILIA

select f2.nroanio, f.familia , round(sum(c.efectosuscripcion)) 
from cotizaciones c , fondo f , fecha f2 
where c.codfondokey  = f.codfondokey 
and c.codfechakey = f2.codfechakey  
group by cube (f2.nroanio, f.familia) 
order by f2.nroanio, f.familia 


--CUBO DE DIMENSIONES AÑO, SUBCATEGORIA

select   f2.nroanio, f.subcategoria , round(sum(c.efectosuscripcion)) 
from cotizaciones c , fondo f , fecha f2 
where c.codfondokey  = f.codfondokey 
and c.codfechakey = f2.codfechakey  
group by cube ( f2.nroanio, f.subcategoria) 
order by  f2.nroanio, f.subcategoria 


----
--POR MES

--CUBO DE DIMENSIONES MES, CATEGORIA


select  f2.nromes , f.categoria, round(sum(c.efectosuscripcion)) 
from cotizaciones c , fondo f , fecha f2 
where c.codfondokey  = f.codfondokey 
and c.codfechakey = f2.codfechakey  
and f2.nroanio = :varanio
group by cube (f2.nromes , f.categoria) 
order by f2.nromes, f.categoria

--CUBO DE DIMENSIONES MES, FONDO

select f2.nromes , f.nombrefondo, round(sum(c.efectosuscripcion)) 
from cotizaciones c , fondo f , fecha f2 
where c.codfondokey  = f.codfondokey 
and c.codfechakey = f2.codfechakey  
and f2.nroanio = :varanio
group by cube (f2.nromes, f.nombrefondo) 
order by f2.nromes, f.nombrefondo 



--CUBO DE DIMENSIONES MES, FAMILIA

select  f2.nromes, f.familia , round(sum(c.efectosuscripcion)) 
from cotizaciones c , fondo f , fecha f2 
where c.codfondokey  = f.codfondokey 
and c.codfechakey = f2.codfechakey  
and f2.nroanio = :varanio
group by cube (f2.nromes, f.familia) 
order by f2.nromes, f.familia 


--CUBO DE DIMENSIONES MES, SUBCATEGORIA

select  f2.nromes, f.subcategoria , round(sum(c.efectosuscripcion)) 
from cotizaciones c , fondo f , fecha f2 
where c.codfondokey  = f.codfondokey 
and c.codfechakey = f2.codfechakey  
and f2.nroanio = :varanio
group by cube (f2.nromes, f.subcategoria) 
order by f2.nromes, f.subcategoria 


-----


--POR SEMANA

--CUBO DE DIMENSIONES SEMANA, CATEGORIA


select  f2.semanaanio , f.categoria, round(sum(c.efectosuscripcion)) 
from cotizaciones c , fondo f , fecha f2 
where c.codfondokey  = f.codfondokey 
and c.codfechakey = f2.codfechakey  
and f2.nroanio = :varanio
group by cube (f2.semanaanio , f.categoria) 
order by f2.semanaanio, f.categoria

--CUBO DE DIMENSIONES SEMANA, FONDO

select f2.semanaanio , f.nombrefondo, round(sum(c.efectosuscripcion)) 
from cotizaciones c , fondo f , fecha f2 
where c.codfondokey  = f.codfondokey 
and c.codfechakey = f2.codfechakey  
and f2.nroanio = :varanio
group by cube (f2.semanaanio, f.nombrefondo) 
order by f2.semanaanio, f.nombrefondo 



--CUBO DE DIMENSIONES SEMANA, FAMILIA

select  f2.semanaanio, f.familia , round(sum(c.efectosuscripcion)) 
from cotizaciones c , fondo f , fecha f2 
where c.codfondokey  = f.codfondokey 
and c.codfechakey = f2.codfechakey  
and f2.nroanio = :varanio
group by cube (f2.semanaanio, f.familia) 
order by f2.semanaanio, f.familia 


--CUBO DE DIMENSIONES SEMANA, SUBCATEGORIA

select  f2.semanaanio, f.subcategoria , round(sum(c.efectosuscripcion)) 
from cotizaciones c , fondo f , fecha f2 
where c.codfondokey  = f.codfondokey 
and c.codfechakey = f2.codfechakey  
and f2.nroanio = :varanio
group by cube (f2.semanaanio, f.subcategoria) 
order by f2.semanaanio, f.subcategoria 



------

--RANGO DE FECHA



--CUBO DE DIMENSIONES RANGO DE FECHA, CATEGORIA


select  f2.fecha , f.categoria, round(sum(c.efectosuscripcion)) 
from cotizaciones c , fondo f , fecha f2 
where c.codfondokey  = f.codfondokey 
and c.codfechakey = f2.codfechakey  
and fecha between :varfechadesde and :varfechahasta
group by cube (f2.fecha , f.categoria) 
order by f2.fecha , f.categoria

--CUBO DE DIMENSIONES RANGO DE FECHA, FONDO

select  f2.fecha, f.nombrefondo , round(sum(c.efectosuscripcion)) 
from cotizaciones c , fondo f , fecha f2 
where c.codfondokey  = f.codfondokey 
and c.codfechakey = f2.codfechakey  
and fecha between :varfechadesde and :varfechahasta
group by cube (f2.fecha, f.nombrefondo) 
order by f2.fecha, f.nombrefondo 



--CUBO DE DIMENSIONES RANGO DE FECHA, FAMILIA

select f2.fecha, f.familia , round(sum(c.efectosuscripcion)) 
from cotizaciones c , fondo f , fecha f2 
where c.codfondokey  = f.codfondokey 
and c.codfechakey = f2.codfechakey  
and fecha between :varfechadesde and :varfechahasta
group by cube (f2.fecha, f.familia) 
order by f2.fecha, f.familia 


--CUBO DE DIMENSIONES RANGO DE FECHA, SUBCATEGORIA

select   f2.fecha, f.subcategoria , round(sum(c.efectosuscripcion)) 
from cotizaciones c , fondo f , fecha f2 
where c.codfondokey  = f.codfondokey 
and c.codfechakey = f2.codfechakey  
and fecha between :varfechadesde and :varfechahasta
group by cube ( f2.fecha, f.subcategoria) 
order by  f2.fecha, f.subcategoria 

select * from tmp_vars_macro tvm 


--POR MES PARA TODOS LOS AÑOS PARA UN RANGO DE FECHA

--CUBO DE DIMENSIONES AÑOS, CATEGORIA


select  to_char(f2.nroanio, 'FM0000') || '-' || to_char(f2.nromes, 'FM00'), f.categoria, round(sum(c.efectosuscripcion)) 
from cotizaciones c , fondo f , fecha f2 
where c.codfondokey  = f.codfondokey 
and c.codfechakey = f2.codfechakey  
and fecha between :varfechadesde and :varfechahasta
group by cube (to_char(f2.nroanio, 'FM0000') || '-' || to_char(f2.nromes, 'FM00'), f.categoria) 
order by to_char(f2.nroanio, 'FM0000') || '-' || to_char(f2.nromes, 'FM00'), f.categoria

--CUBO DE DIMENSIONES AÑOS, FONDO

select  to_char(f2.nroanio, 'FM0000') || '-' || to_char(f2.nromes, 'FM00'), f.nombrefondo , round(sum(c.efectosuscripcion)) 
from cotizaciones c , fondo f , fecha f2 
where c.codfondokey  = f.codfondokey 
and c.codfechakey = f2.codfechakey  
and fecha between :varfechadesde and :varfechahasta
group by cube (to_char(f2.nroanio, 'FM0000') || '-' || to_char(f2.nromes, 'FM00'), f.nombrefondo) 
order by to_char(f2.nroanio, 'FM0000') || '-' || to_char(f2.nromes, 'FM00'), f.nombrefondo 



--CUBO DE DIMENSIONES AÑOS, FAMILIA

select  to_char(f2.nroanio, 'FM0000') || '-' || to_char(f2.nromes, 'FM00'), f.familia , round(sum(c.efectosuscripcion)) 
from cotizaciones c , fondo f , fecha f2 
where c.codfondokey  = f.codfondokey 
and c.codfechakey = f2.codfechakey  
and fecha between :varfechadesde and :varfechahasta
group by cube (to_char(f2.nroanio, 'FM0000') || '-' || to_char(f2.nromes, 'FM00'), f.familia) 
order by to_char(f2.nroanio, 'FM0000') || '-' || to_char(f2.nromes, 'FM00'), f.familia 


--CUBO DE DIMENSIONES AÑOS, SUBCATEGORIA

select  to_char(f2.nroanio, 'FM0000') || '-' || to_char(f2.nromes, 'FM00'), f.subcategoria , round(sum(c.efectosuscripcion)) 
from cotizaciones c , fondo f , fecha f2 
where c.codfondokey  = f.codfondokey 
and c.codfechakey = f2.codfechakey  
and fecha between :varfechadesde and :varfechahasta
group by cube (to_char(f2.nroanio, 'FM0000') || '-' || to_char(f2.nromes, 'FM00'), f.subcategoria) 
order by to_char(f2.nroanio, 'FM0000') || '-' || to_char(f2.nromes, 'FM00'), f.subcategoria 

--------------------------------------------------------------------------
--------------------------------------------------------------------------
--------------------------------------------------------------------------

--EFECTO PRECIO

--POR AÑO

--CUBO DE DIMENSIONES AÑO, CATEGORIA


select  f2.nroanio , f.categoria, round(sum(c.efectoprecio)) 
from cotizaciones c , fondo f , fecha f2 
where c.codfondokey  = f.codfondokey 
and c.codfechakey = f2.codfechakey  
group by cube (f2.nroanio , f.categoria) 
order by f2.nroanio , f.categoria

--CUBO DE DIMENSIONES AÑO, FONDO

select  f2.nroanio, f.nombrefondo , round(sum(c.efectoprecio)) 
from cotizaciones c , fondo f , fecha f2 
where c.codfondokey  = f.codfondokey 
and c.codfechakey = f2.codfechakey  
group by cube (f2.nroanio, f.nombrefondo) 
order by f2.nroanio, f.nombrefondo 



--CUBO DE DIMENSIONES AÑO, FAMILIA

select f2.nroanio, f.familia , round(sum(c.efectoprecio)) 
from cotizaciones c , fondo f , fecha f2 
where c.codfondokey  = f.codfondokey 
and c.codfechakey = f2.codfechakey  
group by cube (f2.nroanio, f.familia) 
order by f2.nroanio, f.familia 


--CUBO DE DIMENSIONES AÑO, SUBCATEGORIA

select   f2.nroanio, f.subcategoria , round(sum(c.efectoprecio)) 
from cotizaciones c , fondo f , fecha f2 
where c.codfondokey  = f.codfondokey 
and c.codfechakey = f2.codfechakey  
group by cube ( f2.nroanio, f.subcategoria) 
order by  f2.nroanio, f.subcategoria 


----
--POR MES

--CUBO DE DIMENSIONES MES, CATEGORIA


select  f2.nromes , f.categoria, round(sum(c.efectoprecio)) 
from cotizaciones c , fondo f , fecha f2 
where c.codfondokey  = f.codfondokey 
and c.codfechakey = f2.codfechakey  
and f2.nroanio = :varanio
group by cube (f2.nromes , f.categoria) 
order by f2.nromes, f.categoria

--CUBO DE DIMENSIONES MES, FONDO

select f2.nromes , f.nombrefondo, round(sum(c.efectoprecio)) 
from cotizaciones c , fondo f , fecha f2 
where c.codfondokey  = f.codfondokey 
and c.codfechakey = f2.codfechakey  
and f2.nroanio = :varanio
group by cube (f2.nromes, f.nombrefondo) 
order by f2.nromes, f.nombrefondo 



--CUBO DE DIMENSIONES MES, FAMILIA

select  f2.nromes, f.familia , round(sum(c.efectoprecio)) 
from cotizaciones c , fondo f , fecha f2 
where c.codfondokey  = f.codfondokey 
and c.codfechakey = f2.codfechakey  
and f2.nroanio = :varanio
group by cube (f2.nromes, f.familia) 
order by f2.nromes, f.familia 


--CUBO DE DIMENSIONES MES, SUBCATEGORIA

select  f2.nromes, f.subcategoria , round(sum(c.efectoprecio)) 
from cotizaciones c , fondo f , fecha f2 
where c.codfondokey  = f.codfondokey 
and c.codfechakey = f2.codfechakey  
and f2.nroanio = :varanio
group by cube (f2.nromes, f.subcategoria) 
order by f2.nromes, f.subcategoria 


-----


--POR SEMANA

--CUBO DE DIMENSIONES SEMANA, CATEGORIA


select  f2.semanaanio , f.categoria, round(sum(c.efectoprecio)) 
from cotizaciones c , fondo f , fecha f2 
where c.codfondokey  = f.codfondokey 
and c.codfechakey = f2.codfechakey  
and f2.nroanio = :varanio
group by cube (f2.semanaanio , f.categoria) 
order by f2.semanaanio, f.categoria

--CUBO DE DIMENSIONES SEMANA, FONDO

select f2.semanaanio , f.nombrefondo, round(sum(c.efectoprecio)) 
from cotizaciones c , fondo f , fecha f2 
where c.codfondokey  = f.codfondokey 
and c.codfechakey = f2.codfechakey  
and f2.nroanio = :varanio
group by cube (f2.semanaanio, f.nombrefondo) 
order by f2.semanaanio, f.nombrefondo 



--CUBO DE DIMENSIONES SEMANA, FAMILIA

select  f2.semanaanio, f.familia , round(sum(c.efectoprecio)) 
from cotizaciones c , fondo f , fecha f2 
where c.codfondokey  = f.codfondokey 
and c.codfechakey = f2.codfechakey  
and f2.nroanio = :varanio
group by cube (f2.semanaanio, f.familia) 
order by f2.semanaanio, f.familia 


--CUBO DE DIMENSIONES SEMANA, SUBCATEGORIA

select  f2.semanaanio, f.subcategoria , round(sum(c.efectoprecio)) 
from cotizaciones c , fondo f , fecha f2 
where c.codfondokey  = f.codfondokey 
and c.codfechakey = f2.codfechakey  
and f2.nroanio = :varanio
group by cube (f2.semanaanio, f.subcategoria) 
order by f2.semanaanio, f.subcategoria 



------

--RANGO DE FECHA



--CUBO DE DIMENSIONES RANGO DE FECHA, CATEGORIA


select  f2.fecha , f.categoria, round(sum(c.efectoprecio)) 
from cotizaciones c , fondo f , fecha f2 
where c.codfondokey  = f.codfondokey 
and c.codfechakey = f2.codfechakey  
and fecha between :varfechadesde and :varfechahasta
group by cube (f2.fecha , f.categoria) 
order by f2.fecha , f.categoria

--CUBO DE DIMENSIONES RANGO DE FECHA, FONDO

select  f2.fecha, f.nombrefondo , round(sum(c.efectoprecio)) 
from cotizaciones c , fondo f , fecha f2 
where c.codfondokey  = f.codfondokey 
and c.codfechakey = f2.codfechakey  
and fecha between :varfechadesde and :varfechahasta
group by cube (f2.fecha, f.nombrefondo) 
order by f2.fecha, f.nombrefondo 



--CUBO DE DIMENSIONES RANGO DE FECHA, FAMILIA

select f2.fecha, f.familia , round(sum(c.efectoprecio)) 
from cotizaciones c , fondo f , fecha f2 
where c.codfondokey  = f.codfondokey 
and c.codfechakey = f2.codfechakey  
and fecha between :varfechadesde and :varfechahasta
group by cube (f2.fecha, f.familia) 
order by f2.fecha, f.familia 


--CUBO DE DIMENSIONES RANGO DE FECHA, SUBCATEGORIA

select   f2.fecha, f.subcategoria , round(sum(c.efectoprecio)) 
from cotizaciones c , fondo f , fecha f2 
where c.codfondokey  = f.codfondokey 
and c.codfechakey = f2.codfechakey  
and fecha between :varfechadesde and :varfechahasta
group by cube ( f2.fecha, f.subcategoria) 
order by  f2.fecha, f.subcategoria 




--POR MES PARA TODOS LOS AÑOS

--CUBO DE DIMENSIONES AÑOS, CATEGORIA


select  to_char(f2.nroanio, 'FM0000') || '-' || to_char(f2.nromes, 'FM00'), f.categoria, round(sum(c.efectoprecio)) 
from cotizaciones c , fondo f , fecha f2 
where c.codfondokey  = f.codfondokey 
and c.codfechakey = f2.codfechakey  
group by cube (to_char(f2.nroanio, 'FM0000') || '-' || to_char(f2.nromes, 'FM00'), f.categoria) 
order by to_char(f2.nroanio, 'FM0000') || '-' || to_char(f2.nromes, 'FM00'), f.categoria

--CUBO DE DIMENSIONES AÑOS, FONDO

select  to_char(f2.nroanio, 'FM0000') || '-' || to_char(f2.nromes, 'FM00'), f.nombrefondo , round(sum(c.efectoprecio)) 
from cotizaciones c , fondo f , fecha f2 
where c.codfondokey  = f.codfondokey 
and c.codfechakey = f2.codfechakey  
group by cube (to_char(f2.nroanio, 'FM0000') || '-' || to_char(f2.nromes, 'FM00'), f.nombrefondo) 
order by to_char(f2.nroanio, 'FM0000') || '-' || to_char(f2.nromes, 'FM00'), f.nombrefondo 



--CUBO DE DIMENSIONES AÑOS, FAMILIA

select  to_char(f2.nroanio, 'FM0000') || '-' || to_char(f2.nromes, 'FM00'), f.familia , round(sum(c.efectoprecio)) 
from cotizaciones c , fondo f , fecha f2 
where c.codfondokey  = f.codfondokey 
and c.codfechakey = f2.codfechakey  
group by cube (to_char(f2.nroanio, 'FM0000') || '-' || to_char(f2.nromes, 'FM00'), f.familia) 
order by to_char(f2.nroanio, 'FM0000') || '-' || to_char(f2.nromes, 'FM00'), f.familia 


--CUBO DE DIMENSIONES AÑOS, SUBCATEGORIA

select  to_char(f2.nroanio, 'FM0000') || '-' || to_char(f2.nromes, 'FM00'), f.subcategoria , round(sum(c.efectoprecio)) 
from cotizaciones c , fondo f , fecha f2 
where c.codfondokey  = f.codfondokey 
and c.codfechakey = f2.codfechakey  
group by cube (to_char(f2.nroanio, 'FM0000') || '-' || to_char(f2.nromes, 'FM00'), f.subcategoria) 
order by to_char(f2.nroanio, 'FM0000') || '-' || to_char(f2.nromes, 'FM00'), f.subcategoria 


/*
Evolución
i. Evolución del valor de cuota parte para de un fondo determinado en el período dia/semana/mes/año/ytd/mtd/rango específico.
ii. Evolución del valor de cuota parte agregada para una familia de fondos/categoria/subcategoria en un período dia/semana/mes/año/ytd/mtd/rango específico (aquí hay que calcular un valor de cuotaparte a nivel agregado)
iii. Evolución de un determinado fondo/familia/categoria/sub-categoria (con las implicancias de construcción de cuota parte a nivel agregado) en un período dia/semana/mes/año/ytd/mtd/rango específico, ajustado por:
1. Inflación
2. Tipo de cambio oficial
3. Tipo de cambio MEP
4. Tipo de cambio CCL
iv. Evolución del patrimonio de un fondo a lo largo del tiempo divido por moneda.*/


select   f2.fecha, f.nombrefondo , c.valorcuotaparte , varporcentualdiaria ,varporcentualsemana 
from cotizaciones c , fondo f , fecha f2 
where c.codfondokey  = f.codfondokey 
and c.codfechakey = f2.codfechakey  
and fecha between :varfechadesde and :varfechahasta
--group by cube ( f2.fecha, f.subcategoria) 
order by  f.nombrefondo , f2.fecha


select   f2.fecha, f.subcategoria , avg(varporcentualdiaria) prom_dia ,avg(varporcentualsemana) prom_semana
from cotizaciones c , fondo f , fecha f2 
where c.codfondokey  = f.codfondokey 
and c.codfechakey = f2.codfechakey  
and fecha between :varfechadesde and :varfechahasta
and (:varsubcateg is null or f.subcategoria = :varsubcateg)
group by  f2.fecha, f.subcategoria
order by  f2.fecha, f.subcategoria

