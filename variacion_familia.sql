
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