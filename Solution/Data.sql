use bddtp4;
drop table if exists employe;
drop table if exists departement;

create table departement (IdDepart int(4) primary key, nom varchar(20),  ville varchar(20));

create table employe (IdEmp int(4) primary key auto_increment, nom varchar(20), profession varchar(20), DateEmb date, salaire float4, IdDepart int(4),

foreign key (IdDepart) references departement(IdDepart));

insert into departement values (1, 'commercial', 'oran');
insert into departement values (2, 'Production', 'Alger');
insert into departement values (3, 'developpement', 'SBA');

insert into employe (nom, profession, DateEmb, salaire, IdDepart) values ('Attou' ,'ingénieur', '2010-10-02','70000',3);
insert into employe (nom, profession, DateEmb, salaire, IdDepart) values ('Ali' ,'ingénieur', '2008-06-22','90000',3);
insert into employe (nom, profession, DateEmb, salaire, IdDepart) values ('Said' ,'technicien', '2010-10-02','40000',3);
insert into employe (nom, profession, DateEmb, salaire, IdDepart) values ('Karim' ,'expert', '2014-09-18','250000',3);

insert into employe (nom, profession, DateEmb, salaire, IdDepart) values ('rachid' ,'ingénieur', '2015-11-10','50000',2);
insert into employe (nom, profession, DateEmb, salaire, IdDepart) values ('ahmed' ,'ingénieur', '2000-01-16','110000',2);
insert into employe (nom, profession, DateEmb, salaire, IdDepart) values ('farid' ,'technicien', '1999-11-22','60000',2);
insert into employe (nom, profession, DateEmb, salaire, IdDepart) values ('tarek' ,'technicien', '2016-09-10','30000',2);

insert into employe (nom, profession, DateEmb, salaire, IdDepart) values ('rachid' ,'Expert', '2015-11-10','150000',1);
insert into employe (nom, profession, DateEmb, salaire, IdDepart) values ('ali' ,'ingénieur', '2010-03-16','80000',1);
insert into employe (nom, profession, DateEmb, salaire, IdDepart) values ('mourad' ,'technicien', '2006-11-22','50000',1);
insert into employe (nom, profession, DateEmb, salaire, IdDepart) values ('tarek' ,'technicien', '2012-04-13','35000',1);
insert into employe (nom, profession, DateEmb, salaire, IdDepart) values ('souad' ,null, '2012-04-13','35000',1);