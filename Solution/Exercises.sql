use bddtp4;

/*Q1 Donner les noms et les salaires des employés :*/
select nom, salaire from employe;

/*Q2 Donner les professions des employés (après élimination des duplicatas) :*/
select distinct profession from employe;

/*Q3 Donner les dates d’embauche des techniciens :*/
select DateEMb from employe where (profession='technicien');

/*Q4 Faire le produit cartésien entre employe et département : */
select * from employe, departement;

/*Q5 Donner les noms des employés et les noms de leur département :*/
select employe.nom , departement.nom from employe, departement where (employe.IdDepart)=(departement.IdDepart);

select e.nom, d.nom from employe e, departement d where (e.IdDepart=d.IdDepart);

/*Q6 Donner les numéros des employés travaillant à Alger :*/
select e.idemp from employe e, departement d where (e.IdDepart=d.IdDepart) and (d.ville='alger');

/*Q7 Donner les noms des employés des départements 1 et 3, et dont le salaire est supérieur à 80000. 
Proposer trois solutions :*/
/*Solution 1 : utilisation de l'opérateur in*/
select e.nom from employe e where (e.IdDepart in (1,3)) and (salaire>80000);
 
/*Solution 2 : utilisation du or logique*/ 
select nom from employe where ((iddepart=1) or (iddepart=3))  and (salaire>80000);
 
/*Solution 3 : utilisation de l'opérateur d'union*/ 
select nom  from employe where (iddepart=1) and (salaire>80000)
 
union  all
 
select nom  from employe where (iddepart=3) and (salaire>80000);

/*Q8 Donner les noms des employés dont la profession n’est pas définie :*/
select nom from employe where (profession is null);

/*Q9 Donner les noms des employés dont la date d’embauche est spécifié:*/
select nom from employe where (DateEmb is not null);

/*Q10 Afficher pour chaque employé la concaténation de son nom et sa profession 
séparés par un espace en utilisant la fonction « concat » et lui donner comme 
libellé à l’affichage « Nom & Profession » :*/
select e.IdEmp, concat('Nom & Profession', e.nom, ' ', e.profession) from employe e;

/*Q11 Donner le nombre des employés :*/
select count(*) from employe;

/*Q12 Donner le nombre des employés qui ont été recrutés entre le 2010-01-01 et 2015-12-31 :*/
select count(*) from employe e where e.DateEmb BETWEEN '2010-01-01' and '2015-12-31';

/*Q13 Donner le nombre des ingénieurs travaillant à SBA :*/
select count(*) 
from employe e, departement d 
where (e.profession='ingenieur') and (e.IdDepart=d.IdDepart) and (d.ville='SBA');

/*Q14 Donner le nombre de professions dans le département de developpement :*/
select count(distinct e.profession) 
from employe e, Departement d 
where (e.IdDepart=d.IdDepart) and (d.nom='developpement');

/*Q15 Donner les noms des employés dont le nom commence par ‘a’ :*/
select e.nom from employe e where (e.nom like 'a%');

/*Q16 Donner le nombre des employés dont le nom contient la chaine ‘chi’ :*/
select count(e.IdEmp) from employe e where (e.nom like '%chi%');

/*Q17 Donner le nombre des noms contenant la chaine ‘chi’ :*/
/*Solution qui compte seulement les noms des employés contenant la chaine chi*/
select count(distinct e.nom) from employe e where (e.nom like '%chi%'); 

/*Solution qui compte le nombre des noms des employés et des départements contenant la chaine chi*/
select count(nomsed.nom) from ((select e.nom from employe e)
								union
							   (select d.nom from departement d)) as nomsed;

/*Q18 Afficher la différence entre le salaire le plus élevé et le salaire le plus bas. 
Nommer le résultat « Différence » :*/
select (max(e.salaire)-min(e.salaire)) as difference from employe e;

/*Q19 Donner les noms des employés travaillant dans un département avec au moins un ingénieur :*/
select distinct e2.* 
from employe e, employe e2 
where (e.IdDepart=e2.IdDepart) and (e.IdEmp!= e2.IdEmp) and (e.profession='ingénieur');

Select e.nom 
from employe e 
where (e.IdDepart is not null) and exists (select * 
										   from employe e2 
                                           where (e2.IdDepart=e.IdDepart) and (e2.profession='ingenieur'));

/*Q20 Donner le salaire et le nom des employés gagnant le salaire le plus bas :*/
select e.nom, e.salaire from employe e where e.salaire= (select min(salaire) from employe);

/*Q21 Donner le salaire et le nom des employés gagnant le meilleur salaire :*/
select e.nom, e.salaire from employe e where e.salaire= (select max(salaire) from employe);

/*Q22 Donner le salaire et le nom des employés dont le salaire est supérieur eu salaire 
moyen du département commercial :*/
select e.nom, e.salaire 
from employe e 
where e.salaire > (select avg(e.salaire) 
                   from employe e, departement d 
                   where (e.IdDepart=d.IdDepart) and (d.nom='commercial'));
                   
/*Q23 Donner le salaire et le nom des employés gagnant plus qu’un (au moins un) ingénieur :*/
select  e.IdEmp, e.nom, e.salaire 
from employe e 
where e.salaire > any (select salaire 
                       from employe 
                       where (profession='ingénieur'));
                   
/*Q24 Donner le salaire et le nom des employés gagnant plus que tous les ingénieurs :*/
select   e.nom, e.salaire 
from employe e 
where e.salaire > all (select salaire 
                       from employe 
                       where (profession='ingénieur'));
                       
/*Q25 Donner les départements qui n’ont pas d’employés :*/
select nom from departement where IdDepart not in (select IdDepart from employe);
   
select d.IdDepart from departement d where not exists (select * 
                                                       from employe e 
                                                       where (e.IdDepart=d.IdDepart));
                                                       
/*Q26 Donner les noms des employés du département commercial embauchés le même jour
 qu’un employé du département production :*/
select e.nom 
from employe e, departement d 
where (e.IdDepart=d.IdDepart) and (d.nom='commercial') 
      and (e.DateEmb = ANY (select e2.DateEmb 
                            from Employe e2, Departement d2 
                            where (e2.IdDepart=d2.IdDepart) and (d2.nom='production')));

select e1.nom
from employe e1 join departement d1 on e1.IdDepart=d1.IdDepart
where (d1.nom='commercial') and exists (select *
                                        from employe e2 join departement d2 on e2.IdDepart=d2.IdDepart
										where e2.DateEmb=e1.DateEmb and d2.nom='production');                            

create view R1 as (select IdEmp, nom, DateEmb 
                   from employe 
                   where IdDepart = (select IdDepart 
                                     from departement
                                     where (nom='commercial')));
create view R2 as (select IdEmp, nom, DateEmb 
                   from employe 
                   where IdDepart = (select IdDepart 
                                     from departement
                                     where (nom='production')));
select distinct R1.IdEmp, R1.nom
from R1, R2
where (R1.DateEmb=R2.DateEmb);

/*Q27 Donner les noms des employés embauchés avant tous les employés du département 1 :*/
select e.nom 
from employe e 
where e.DateEmb <= all (select e2.DateEmb 
                        from employe e2 
						where (e2.IdDepart=1));


/*Q28 Donner les noms, professions et salaires des employés par profession croissante 
et, pour chaque profession, par salaire décroissant :*/
select nom, profession , salaire from employe order by profession asc, salaire desc;
                        
/*Q29 Donner les numéros de département et leur salaire maximum :*/
select IdDepart, max(salaire) from employe group by IdDepart;

/*Q30 Donner le salaire minimal de chaque département dont le nombre d’ingénieurs est supérieur ou égale à 2 :*/
/*Cette requête est fausse, elle trouve le salaire minimal des ingénieurs de chaque département dont le nombre d'ingénieur est supérieur ou égale à 2*/
select IdDepart, min(salaire) 
from employe 
where (profession='ingénieur') 
group by IdDepart  
having count(*)>=2;

select IdDepart, count(*), min(salaire)
from employe e
where (select count(IdEmp)
       from employe e1
	   where profession='ingénieur' and (e.IdDepart=e1.IdDepart))>=2
group by IdDepart;

select e1.IdDepart, count(*), min(e1.salaire)
from employe e1
group by e1.IdDepart
having 2<=(select count(*) 
		   from employe e2
           where (e2.profession='ingénieur') and (e1.IdDepart=e2.IdDepart)); 

select IdDepart, min(salaire)
from employe
where IdDepart in (select IdDepart 
                   from employe
                   where profession='ingénieur'
                   group by IdDepart
                   having count(profession)>='2')
group by IdDepart;

/*Q31 Donner les noms des employés ayant le salaire maximum de chaque département :*/
select  e.IdEmp, e.nom 
from employe e 
where e.salaire = (select max(e2.salaire) 
                   from employe e2 
                   where (e2.iddepart=e.iddepart));

select e.IdEmp, e.nom 
from employe e 
where (e.IdDepart,e.salaire) in (select e2.IdDepart, max(e2.salaire) 
                                 from employe e2 
								 group by e2.IdDepart);

select nom, IdDepart, salaire
from employe
where salaire in (select max(salaire)
				  from employe
                  group by IdDepart);
                  
/*Q32 Donner le salaire moyen des employés :*/
select avg(e.salaire) from employe e;

/*Q33 Donner le nombre d’employés du département production :*/
select count(e.IdEmp) 
from employe e, departement d 
where (e.IdDepart=d.IdDepart) and (d.nom='production');

/*Q34 Donner les profession et leur salaire moyen :*/
select e.profession, avg(e.salaire) 
from employe e 
group by e.profession;

/*Q35 Donner le salaire le plus bas par profession :*/
create view V1 as (select e.profession as profession, avg(e.salaire) as salaire
				  from employe e
                  group by e.profession);

select profession, salaire
from V1
where salaire =
(select min(salaire)
from V1);

/*Le département qui contient le plus d'employés*/
select d.*, count(*)
from departement d, employe e
where (e.IdDepart=d.IdDepart)
group by d.IdDepart
having count(*) > all (select count(*) 
					   from departement d2, employe e2 
					   where (e2.IdDepart=d2.IdDepart) and (d2.IdDepart!=d.IdDepart)
					   group by d2.IdDepart);
                       
select d.*, count(*)
from employe e join departement d on e.IdDepart=d.IdDepart
group by d.IdDepart
having count(*) >= all (select count(*) 
						from employe
                        group by IdDepart);
                        
select d1.IdDepart, count(*)
from departement d1 join employe e1 on (d1.IdDepart=e1.IdDepart)
group by d1.IdDepart 
having count(*) = (select count(*)
				   from departement d2 join employe e2 on (d2.IdDepart=e2.IdDepart)
				   group by d2.IdDepart
				   order by count(*) desc limit 1);