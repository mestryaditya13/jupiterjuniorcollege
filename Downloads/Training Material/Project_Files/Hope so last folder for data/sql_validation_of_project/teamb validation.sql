

--no of student
select stream,
cast(count(distinct stud_Skey) as float)/495*100 c from [Fact_Student] t1
join Dim_Region t2
on t1.Region_Skey=t2.Region_Skey
join Dim_student t3
on t1.stud_Skey=t3.Stud_Skey
where class like 'FYJC'
group by stream--,Subject_key
order by c desc
--no of students--
select stream,SUBJECT,
cast(count(distinct stud_Skey) as float)/93*100
c from [Fact_Student] t1
join Dim_Region t2
on t1.Region_Skey=t2.Region_id
join Dim_student t3
on t1.stud_Skey=t3.STUD_id
join Dim_Subject t4
on t1.Subject_key=t4.Sub_id
where class like 'FYJC' and GENDER='F' and Stream= 'commerce'
group by stream,SUBJECT
order by SUBJECT,c desc


select count(distinct stud_Skey) from [Fact_Student] t1
join Dim_student t3
on t1.stud_Skey=t3.STUD_id
where Stream= 'arts'
select count(distinct stud_Skey) from [Fact_Student] t1
join Dim_student t3
on t1.stud_Skey=t3.STUD_id
where Stream= 'commerce'
select count(distinct stud_Skey) from [Fact_Student] t1
join Dim_student t3
on t1.stud_Skey=t3.STUD_id
where Stream= 'science'

select count(distinct stud_Skey) from [Fact_Student]
select count(distinct STUD_id) from Dim_student


select * from FACT_SUBJECTWISE_DEFAULTERS
select avg(cast(replace(Monthly_Percentage,'%','') as float)) from Fact_Monthly_Defaulter

declare @n int = 4
select count(iif(year(End_of_Month)=2022 and months=@n-1 and Monthly_Defaulters='Defaulter',1,null)) prev,
count(iif(year(End_of_Month)=2022 and months=@n and Monthly_Defaulters='Defaulter',1,null)) curr,
count(iif(year(End_of_Month)=2022 and months=@n-1 and Monthly_Defaulters='Defaulter',1,null))
-count(iif(year(End_of_Month)=2022 and months=@n and Monthly_Defaulters='Defaulter',1,null)) mom
from Fact_Monthly_Defaulter


--top 5 defaulters--
select top 5 name,avg(cast(replace(Monthly_Percentage,'%','') as float))a from Fact_Monthly_Defaulter t1
join Dim_student t3
on t1.stud_Skey=t3.STUD_id
where Monthly_Defaulters='Defaulter'
group by name
order by a desc

--stream wise defaulters-
select stream,cast(count(iif(Monthly_Defaulters='Defaulter',1,null)) as float)/
count(iif(Monthly_Defaulters='Defaulter',1,1))*100
from Fact_Monthly_Defaulter t1
join Dim_student t3
on t1.stud_Skey=t3.STUD_id
group by stream;

select stream,cast(count(distinct stud_Skey) as float)/978*100
from Fact_Monthly_Defaulter t1
join Dim_student t3
on t1.stud_Skey=t3.STUD_id
where Monthly_Defaulters='Defaulter'
group by stream

--subj def--
select Subject,count(distinct stud_Skey) a  from FACT_SUBJECTWISE_DEFAULTERS t1
join Dim_student t3
on t1.stud_Skey=t3.STUD_id
where Subjectwise_Defaulters_NON_D='Defaulter'
group by Subject
order by a desc

declare @n int = 3;
select class,--count(iif( Quarter=@n-1 and Monthly_Defaulters='Defaulter',1,null)) prev,
count(iif(Quarter=@n and Monthly_Defaulters='Defaulter',1,null)) curr,
count(iif( Quarter=@n-1 and Monthly_Defaulters='Defaulter',1,null))
-count(iif(Quarter=@n and Monthly_Defaulters='Defaulter',1,null)) mom
from Fact_Monthly_Defaulter t1
join DIMDATE t2
on t1.DateKey=t2.DateKey
join Dim_student t3
on t1.stud_Skey=t3.STUD_id
group by class

------top 5-----
select top 5 * from (
select distinct name,OVERALL_PERCENTAGE from [Fact_Result] t1
join Dim_student t3
on t1.stud_Skey=t3.STUD_id)a
order by OVERALL_PERCENTAGE 

-----------------bottom 5-------------------
select top 5 * from (
select distinct name,OVERALL_PERCENTAGE from [Fact_Result] t1
join Dim_student t3
on t1.stud_Skey=t3.STUD_id)a
order by OVERALL_PERCENTAGE 




select SUBJECT,cast(count(iif(replace(SUBJECT_WISE_PERCENTAGE,'%','')>=75,1,null)) as float)/
count(iif(replace(SUBJECT_WISE_PERCENTAGE,'%','')>=75,1,1))*100
from [Fact_Result] t1
join Dim_Subject t2
on t1.Subject_key=t2.Sub_id
group by SUBJECT


select cast(count(distinct t1.Fact_Result_skey) as float) from [Fact_Result] t1
join Fact_Monthly_Defaulter t2
on t1.Stud_Skey=t2.stud_Skey
where Result_status='pass' and Monthly_Defaulters = 'Defaulter';

----------------------defaulters pass fail-----------------------
select cast(count(iif(flg='D' and Result_status='Pass',1,null)) as float)/count(iif(flg='D' ,1,null))*100 as [DFPass%],
cast(count(iif(flg='D' and Result_status='Fail',1,null)) as float)/count(iif(flg='D' ,1,null))*100 as [DFFail%],
count(iif(flg='D' and Result_status='Pass',1,null)) DfPass,
count(iif(flg='D' and Result_status='Fail',1,null)) DfFail,
count(iif(flg='D' ,1,null))TtlDefaulters from(
select Stud_Skey,avg(cast(replace(Monthly_Percentage,'%','') as float)) per,
iif(avg(cast(replace(Monthly_Percentage,'%','') as float))>=75,'ND','D') flg
from Fact_Monthly_Defaulter 
group by stud_Skey)a
join (select distinct Stud_Skey,Result_status from [Fact_Result])b
on a.stud_Skey=b.Stud_Skey




