#circle - corp
SELECT sag2.Circle,sag2.District, sag2.gname,sag2.mon, 
SUM(IFNULL(6265c,0)) AS '6265c',
SUM(IFNULL(6266c,0)) AS '6266c',
SUM(IFNULL(6267c,0)) AS '6267c',

SUM(IFNULL(96c,0)) AS '69c',
SUM(IFNULL(5966c,0)) AS '5966c',
SUM(IFNULL(78c,0)) AS '78c',
SUM(IFNULL(5951c,0)) AS '5951c',
SUM(IFNULL(80c,0)) AS '80c',
SUM(IFNULL(5953c,0)) AS '5953c',
SUM(IFNULL(81c,0)) AS '81c',
SUM(IFNULL(5954c,0)) AS '5954c',

SUM(IFNULL(96p,0)) AS '69p',
SUM(IFNULL(5966p,0)) AS '5966p',
SUM(IFNULL(78p,0)) AS '78p',
SUM(IFNULL(5951p,0)) AS '5951p',
SUM(IFNULL(80p,0)) AS '80p',
SUM(IFNULL(5953p,0)) AS '5953p',
SUM(IFNULL(81p,0)) AS '81p',
SUM(IFNULL(5954p,0)) AS '5954p',

SUM(IFNULL(96l,0)) AS '69l',
SUM(IFNULL(5966l,0)) AS '5966l',
SUM(IFNULL(78l,0)) AS '78l',
SUM(IFNULL(5951l,0)) AS '5951l',
SUM(IFNULL(80l,0)) AS '80l',
SUM(IFNULL(5953l,0)) AS '5953l',
SUM(IFNULL(81l,0)) AS '81l',
SUM(IFNULL(5954l,0)) AS '5954l'


FROM
(
SELECT sag1.Circle,sag1.District,sag1.gname,sag1.mon,
CASE WHEN dataelementid=6265 AND sag1.time LIKE 'curr' THEN sag1.value END AS '6265c',
CASE WHEN dataelementid=6266 AND sag1.time LIKE 'curr' THEN sag1.value END AS '6266c',
CASE WHEN dataelementid=6267 AND sag1.time LIKE 'curr' THEN sag1.value END AS '6267c',

CASE WHEN dataelementid=96 AND sag1.time LIKE 'curr' THEN sag1.value END AS '96c',
CASE WHEN dataelementid=5966 AND sag1.time LIKE 'curr' THEN sag1.value END AS '5966c',
CASE WHEN dataelementid=78 AND sag1.time LIKE 'curr' THEN sag1.value END AS '78c',
CASE WHEN dataelementid=5951 AND sag1.time LIKE 'curr' THEN sag1.value END AS '5951c',
CASE WHEN dataelementid=80 AND sag1.time LIKE 'curr' THEN sag1.value END AS '80c',
CASE WHEN dataelementid=5953 AND sag1.time LIKE 'curr' THEN sag1.value END AS '5953c',
CASE WHEN dataelementid=81 AND sag1.time LIKE 'curr' THEN sag1.value END AS '81c',
CASE WHEN dataelementid=5954 AND sag1.time LIKE 'curr' THEN sag1.value END AS '5954c',

CASE WHEN dataelementid=96 AND sag1.time LIKE 'prog' THEN sag1.value END AS '96p',
CASE WHEN dataelementid=5966 AND sag1.time LIKE 'prog' THEN sag1.value END AS '5966p',
CASE WHEN dataelementid=78 AND sag1.time LIKE 'prog' THEN sag1.value END AS '78p',
CASE WHEN dataelementid=5951 AND sag1.time LIKE 'prog' THEN sag1.value END AS '5951p',
CASE WHEN dataelementid=80 AND sag1.time LIKE 'prog' THEN sag1.value END AS '80p',
CASE WHEN dataelementid=5953 AND sag1.time LIKE 'prog' THEN sag1.value END AS '5953p',
CASE WHEN dataelementid=81 AND sag1.time LIKE 'prog' THEN sag1.value END AS '81p',
CASE WHEN dataelementid=5954 AND sag1.time LIKE 'prog' THEN sag1.value END AS '5954p',

CASE WHEN dataelementid=96 AND sag1.time LIKE 'lyr' THEN sag1.value END AS '96l',
CASE WHEN dataelementid=5966 AND sag1.time LIKE 'lyr' THEN sag1.value END AS '5966l',
CASE WHEN dataelementid=78 AND sag1.time LIKE 'lyr' THEN sag1.value END AS '78l',
CASE WHEN dataelementid=5951 AND sag1.time LIKE 'lyr' THEN sag1.value END AS '5951l',
CASE WHEN dataelementid=80 AND sag1.time LIKE 'lyr' THEN sag1.value END AS '80l',
CASE WHEN dataelementid=5953 AND sag1.time LIKE 'lyr' THEN sag1.value END AS '5953l',
CASE WHEN dataelementid=81 AND sag1.time LIKE 'lyr' THEN sag1.value END AS '81l',
CASE WHEN dataelementid=5954 AND sag1.time LIKE 'lyr' THEN sag1.value END AS '5954l'

FROM
(
	SELECT sag.Circle,sag.District,sag.gname,CASE WHEN MONTH('2013-10-01') BETWEEN 1 AND 3 THEN MONTH('2013-10-01')+9 
				WHEN MONTH('2013-10-01') BETWEEN 4 AND 12 THEN MONTH('2013-10-01')-3 END AS mon,sag.time,
		sag.dataelementid,SUM(IFNULL(sag.value,0)) AS 'value'
	FROM
	(
		#current month
		
		SELECT asd.Circle,CASE WHEN asd.gname LIKE 'Corporation Group' THEN asd.name END AS 'District',asd.gname,asd.name,'curr' AS 'time',
		asd1.dataelementid,asd1.categoryoptioncomboid,asd1.value,MONTH(startdate)
		FROM
			(
			SELECT ogm.organisationunitid,og.name AS 'gname',ou.name,os.level,ou1.name AS 'Circle',ou2.name AS 'District'
			FROM orgunitgroupmembers ogm
			INNER JOIN orgunitgroup og ON ogm.orgunitgroupid = og.orgunitgroupid
			INNER JOIN organisationunit ou ON ou.organisationunitid = ogm.organisationunitid
			INNER JOIN _orgunitstructure os ON os.organisationunitid = ou.organisationunitid
			INNER JOIN organisationunit ou1 ON ou1.organisationunitid = os.idlevel3
			INNER JOIN organisationunit ou2 ON ou2.organisationunitid = os.idlevel4
			WHERE og.name IN ('Corporation Group')
			AND ou1.name LIKE 'AKOLA Circle'
			)asd

		LEFT JOIN

			(
			SELECT dv.dataelementid,dv.categoryoptioncomboid,dv.value,dv.sourceid,p.startdate
			FROM datavalue dv
			INNER JOIN period p ON p.periodid=dv.periodid 
			WHERE dv.dataelementid IN (96,5966,78,5951,80,5953,81,5954)
			AND dv.categoryoptioncomboid IN (1)
			#AND p.startdate BETWEEN '2013-10-01' AND '2013-10-01'
			AND MONTH(p.startdate)= MONTH('2013-10-01')
			AND YEAR(p.startdate)= YEAR('2013-10-01')
			AND periodtypeid = 3
			
			UNION
			
			SELECT dv.dataelementid,dv.categoryoptioncomboid,dv.value,dv.sourceid,p.startdate
			FROM datavalue dv
			INNER JOIN period p ON p.periodid=dv.periodid 
			WHERE dv.dataelementid IN (6265,6266,6267)
			AND dv.categoryoptioncomboid IN (1)
			AND CASE WHEN MONTH('2013-10-01') BETWEEN 4 AND 12 
					THEN YEAR(p.startdate) = YEAR('2013-10-01') 
						AND MONTH(p.startdate) BETWEEN 4 AND MONTH('2013-10-01')
				WHEN  MONTH('2013-10-01') BETWEEN 1 AND 3 	
					THEN YEAR(p.startdate) BETWEEN YEAR('2013-10-01')-1 AND YEAR('2013-10-01')
						AND p.startdate BETWEEN CONCAT(YEAR('2013-10-01')-1,'-',04,'-',01) AND CONCAT('2013-10-01')
				END	
			)asd1

		ON asd.organisationunitid = asd1.sourceid

	UNION

		#progressive
		SELECT asd.Circle,CASE WHEN asd.gname LIKE 'Corporation Group' THEN asd.name END AS 'District',asd.gname,asd.name,'prog' AS 'time',
		asd1.dataelementid,asd1.categoryoptioncomboid,asd1.value,MONTH(startdate)
		FROM
			(
			SELECT ogm.organisationunitid,og.name AS 'gname',ou.name,os.level,ou1.name AS 'Circle',ou2.name AS 'District'
			FROM orgunitgroupmembers ogm
			INNER JOIN orgunitgroup og ON ogm.orgunitgroupid = og.orgunitgroupid
			INNER JOIN organisationunit ou ON ou.organisationunitid = ogm.organisationunitid
			INNER JOIN _orgunitstructure os ON os.organisationunitid = ou.organisationunitid
			INNER JOIN organisationunit ou1 ON ou1.organisationunitid = os.idlevel3
			INNER JOIN organisationunit ou2 ON ou2.organisationunitid = os.idlevel4
			WHERE og.name IN ('Corporation Group')
			AND ou1.name LIKE 'AKOLA Circle'
			)asd

		LEFT JOIN

			(
			SELECT dv.dataelementid,dv.categoryoptioncomboid,dv.value,dv.sourceid,p.startdate
			FROM datavalue dv
			INNER JOIN period p ON p.periodid=dv.periodid 
			WHERE dv.dataelementid IN (96,5966,78,5951,80,5953,81,5954)
			AND dv.categoryoptioncomboid IN (1)
			AND CASE WHEN MONTH('2013-10-01') BETWEEN 4 AND 12 
					THEN YEAR(p.startdate) = YEAR('2013-10-01') 
						AND MONTH(p.startdate) BETWEEN 4 AND MONTH('2013-10-01')
				WHEN  MONTH('2013-10-01') BETWEEN 1 AND 3 	
					THEN YEAR(p.startdate) BETWEEN YEAR('2013-10-01')-1 AND YEAR('2013-10-01')
						AND p.startdate BETWEEN CONCAT(YEAR('2013-10-01')-1,'-',04,'-',01) AND CONCAT('2013-10-01')
				END	

			AND periodtypeid = 3

			)asd1

		ON asd.organisationunitid = asd1.sourceid
		
	UNION
		#last_year
		SELECT asd.Circle,CASE WHEN asd.gname LIKE 'Corporation Group' THEN asd.name END AS 'District',asd.gname,asd.name,'lyr' AS 'time',
		asd1.dataelementid,asd1.categoryoptioncomboid,asd1.value,MONTH(startdate)
		FROM
		    (
		    SELECT ogm.organisationunitid,og.name AS 'gname',ou.name,os.level,ou1.name AS 'Circle',ou2.name AS 'District'
		    FROM orgunitgroupmembers ogm
		    INNER JOIN orgunitgroup og ON ogm.orgunitgroupid = og.orgunitgroupid
		    INNER JOIN organisationunit ou ON ou.organisationunitid = ogm.organisationunitid
		    INNER JOIN _orgunitstructure os ON os.organisationunitid = ou.organisationunitid
		    INNER JOIN organisationunit ou1 ON ou1.organisationunitid = os.idlevel3
		    INNER JOIN organisationunit ou2 ON ou2.organisationunitid = os.idlevel4
		    WHERE og.name IN ('Corporation Group')
		    AND ou1.name LIKE 'AKOLA Circle'
		    )asd

		LEFT JOIN

		    (
		    SELECT dv.dataelementid,dv.categoryoptioncomboid,dv.value,dv.sourceid,p.startdate
		    FROM datavalue dv
		    INNER JOIN period p ON p.periodid=dv.periodid 
		    WHERE dv.dataelementid IN (96,5966,78,5951,80,5953,81,5954)
		    AND dv.categoryoptioncomboid IN (1)
		    AND CASE WHEN MONTH('2013-10-01') BETWEEN 4 AND 12 
			    THEN YEAR(p.startdate) = YEAR('2013-10-01')-1
				AND MONTH(p.startdate) BETWEEN 4 AND MONTH('2013-10-01')
			WHEN  MONTH('2013-10-01') BETWEEN 1 AND 3     
			THEN p.startdate BETWEEN CONCAT(YEAR('2013-10-01')-2,'-',04,'-',01) AND CONCAT(YEAR('2013-10-01')-1,'-',MONTH('2013-10-01'),'-',DAY('2013-10-01'))
			END    

		    AND periodtypeid = 3

		    )asd1

		ON asd.organisationunitid = asd1.sourceid
		)sag
		GROUP BY District,dataelementid,sag.time
)sag1	
)sag2
GROUP BY Circle,District
ORDER BY gname,District