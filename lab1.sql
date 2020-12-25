/*
�1
�������� ������, ��������� ��� ���������� � �������������. ����������� �� ����
������������.
�����: 27 �����.
*/
select d.*
  from departments d
  order by d.department_id
;

/*
�2
�������� ������, ���������� ID, ���+������� (� ���� ������ ������� ����� ������)
� ����� ����������� ����� ���� ��������. (������������ ������������ ����� �
�������������� ������� � ������ � �������� �� �NAME�). ����������� �� ����
�������.
�����: 319 �����.
*/
select c.customer_id,
       (c.cust_first_name||' '||c.cust_last_name) as name,
       c.cust_email
  from customers c
  order by c.customer_id
;

/*
�3
�������� ������, ��������� �����������, �������� ������� �� ��� ����� � ���������
�� 100 �� 200 ���. ���., ���������� �� �� ���������� ���������, �������� (�� �������
� �������) � �������. ��������� ������ ������ �������� �������, ���, ���������
(��� ���������), email, �������, �������� �� ����� �� ������� �������. ����� �������,
��� � ��� ������������� ����� ���������������: � �������� �� ��� �� 100 �� 150 ���.
���. ����� ���������� 30%, ���� � 35%. ��������� ��������� �� ������ ���.
����������� ������������ between � case.
�����: 27 �����.
*/
select  e.last_name,
        e.first_name,
        e.job_id,
        e.email,
        e.phone_number,
        case
          when e.salary*12  between 100000 and 150000 then
            round(e.salary*0.7,0)
          else 
            round(e.salary*0.65,0)
        end as salary
  from  employees e
  where e.salary*12 between 100000 and 200000
  order by e.job_id, e.salary, e.last_name
;

/*
�4
������� ������ � ���������������� DE, IT ��� RU. ������������� ������� �� ����
�������, ��������� �������. ����������� �� �������� ������.
�����: 2 ������.
*/
select  c.country_id as "��� ������",
        c.country_name as "�������� ������"
  from  countries c
  where c.country_id = 'DE' or c.country_id = 'IT' or c.country_id = 'RU'
  order by  c.country_name
;
/*
�5
������� ���+������� �����������, � ������� � ������� ������ ����� �a� (���������),
� � ����� ������������ ����� �d� (�� �����, � ����� ��������). ����������� �� �����.
������������ �������� like � ������� ���������� � ������� ��������.
�����: 5 �����.
*/
select  e.first_name || ' ' || e.last_name as name
  from  employees e
  where (upper(e.first_name) like '%D%') and (e.last_name like '_a%')
  order by e.first_name
;

/*
�6
������� ����������� � ������� ������� ��� ��� ������ 5 ��������. �����������
������ �� ��������� ����� ������� � �����, ����� �� ����� �������, ����� ������ ��
�������, ����� ������ �� �����.
�����: 27 �����.
*/
select  *
  from  employees e
  where (length(e.first_name) < 5) or (length(e.last_name) < 5)
  order by (length(e.first_name) + length(e.last_name)),
            length(e.last_name),
            e.last_name,
            e.first_name
;

/*
�7
������� ��������� � ������� �� ����������� (������� ��������, �� ������� �����
�������-�������������� ����������� � ������������ �������). ����� ���������
��������� ������ ���� �������, � ������ ���������� �������� ����������� �� ����
���������. ������� ������� ��� ���������, �������� ���������, ������� ��������
����� �������, ����������� �� �����. ������� ����� ��������������� ������� � 18%.
�����: 19 �����.
*/
select  j.job_id as id,
        j.job_title as title,
        round(((j.max_salary + j.min_salary) / 2) * 0.82, 2) as avg_salary
  from  jobs j
  order by ((j.max_salary + j.min_salary) / 2) desc,
            j.job_id
;

/*
�8
����� �������, ��� ��� ������� ������� �� ��������� A, B, C. ��������� A � ������� �
��������� ������� >= 3500, B >= 1000, C � ��� ���������. ������� ���� ��������,
���������� �� �� ��������� � �������� ������� (������� ������� ��������� A), �����
�� �������. ������� ������� �������, ���, ���������, �����������. � �����������
��� �������� ��������� A ������ ���� ������ ���������, VIP-��������, ���
��������� �������� ����������� ������ �������� ������ (NULL).
�����: 319 �����.
*/
select  c.*,
        case
          when c.category = 'A' then
            '��������, VIP-�������'
        end as "�����������"
  from  (
          select  c.cust_last_name,
                  c.cust_first_name,
                  case
                    when c.credit_limit >= 3500  then 
                      'A'
                    when (c.credit_limit >= 1000) and (c.credit_limit < 3500) then 
                      'B'
                    else 
                      'C'
                  end as category
            from customers c
        ) c
  order by  category,
            c.cust_last_name
;
/*
�9
������� ������ (�� �������� �� �������), � ������� ���� ������ � 1998 ����. ������
�� ������ ����������� � ������ ���� �����������. ������������ ����������� ��
������� extract �� ���� ��� ���������� ������������ ������� � decode ��� ������
�������� ������ �� ��� ������. ���������� �� ������������.
�����: 5 �����.
*/
select  decode(
          extract(month from o.order_date),
            1,'������',
            2,'�������',
            3,'����',
            4,'������',
            5,'���',
            6,'����',
            7,'����',
            8,'������',
            9,'��������',
            10,'�������',
            11,'������',
            12,'�������'
          ) as month
  from  orders o
  where date'1998-01-01' <= o.order_date and o.order_date < date'1999-01-01'
  group by extract(month from o.order_date)
  order by extract(month from o.order_date)
;

/*
�10
�������� ���������� ������, ��������� ��� ��������� �������� ������ �������
to_char (������� ��� ������� nls_date_language 3-� ����������). ������ �����������
������������ distinct, ���������� �� ������������.
�����: 5 �����.
*/
select  distinct to_char(o.order_date,'Month','nls_date_language = RUSSIAN') as month
  from  orders o
  where date'1998-01-01' <= o.order_date and o.order_date < date'1999-01-01'
  order by to_date(month,'Month','nls_date_language = RUSSIAN')
;

/*
�11
�������� ������, ��������� ��� ���� �������� ������. ������� ����� ������ �������
�� sysdate. ������ ������� ������ ��������� ����������� � ���� ������ ���������
��� ������ � �����������. ��� ����������� ��� ������ ��������������� �������
to_char. ��� ������ ����� �� 1 �� 31 ����� ��������������� �������������� rownum,
������� ������ �� ����� �������, ��� ���������� ����� ����� 30.
�����: 30 ��� 31 ������ (�� ���� ������ ������� ������� �� � �������).
*/
select  trunc(sysdate, 'MM') + rownum - 1,
        case
          when to_char(trunc(sysdate, 'MM') + rownum - 1, 'DY', 'nls_date_language = ENGLISH') in ('SAT','SUN')  then
            '��������'
        end as qwe
    from  employees e
    where rownum <= 31
;

/*
�12
������� ���� ����������� (��� ����������, �������+��� ����� ������, ��� ���������,
��������, �������� - %), ������� �������� �������� �� �������. ���������������
������������ is not null.����������� ����������� �� �������� �������� (�� �������� �
��������), ����� �� ���� ����������.
�����: 35 �����.
*/
select  e.employee_id,
        (e.last_name || ' ' || e.first_name) as name,
        e.job_id,
        e.salary,
        e.commission_pct
  from employees e
  where e.commission_pct is not null
  order by  e.commission_pct DESC,
            e.employee_id
;

/*
�13
�������� ���������� �� ����� ������ �� 1995-2000 ���� � ������� ��������� (1 �������
� ������-���� � �.�.). � ������� ������ ���� 6 �������� � ���, ����� ������ �� 1-��, 2-
��, 3-�� � 4-�� ��������, � ����� ����� ����� ������ �� ���. ����������� �� ����.
��������������� ������������ �� ����, � ����� ������������� �� ��������� � case
��� decode, ������� ����� �������� ������� �� ������ �������.
�����: 5 �����.
*/
select  extract(year from o.order_date) as year, 
        sum(
          case
            when extract(month from o.order_date) <= 3  then o.order_total
          end
        ) as quart1_sum,
        sum(
          case
            when (3 < extract(month from o.order_date)) and (extract(month from o.order_date) <= 6) then o.order_total
          end
        ) as quart2_sum,
        sum(
          case
            when (6 < extract(month from o.order_date)) and (extract(month from o.order_date) <= 9) then o.order_total
           end
        ) as quart3_sum,
        sum(
          case
            when (9 < extract(month from o.order_date)) and (extract(month from o.order_date) <= 12) then o.order_total
          end
        ) as quart4_sum,
        sum(o.order_total) as year_sum
    from orders o
    group by extract(year from o.order_date)
    having (1995 <= extract(year from o.order_date)) and (extract(year from o.order_date) <= 2000)
    order by year
;

/*
�14
������� �� ������� ������� ��� ����������� ������. ������� ������� ����� �����
��� �������� � �������� ������ ������ � MB ��� GB (� ����� ��������), ��������
������ �� ���������� � HD, � ����� � ������ 30 �������� �������� ������ ��
����������� ����� disk, drive � hard. ������� �������: ��� ������, �������� ������,
��������, ���� (�� ������ � LIST_PRICE), url � ��������. � ���� �������� ������ ����
�������� ����� ����� � ���������� ������� �������� (������, ��� �������� ����� ����
��� � �����). ����������� �� ������� ������ (�� �������� � ��������), ����� �� ����
(�� ������� � �������). ������ ��� �������������� ������� �� �������� ������ ��
������� NN MB/GB (�� ������ ��� ���� ��������������� GB � ���������) c �������
regexp_replace. Like �� ������������, ������ ���� ������������ regexp_like � �����
���������, ��� ������� ���� ������� ������������.
�����: 24 ������.
*/
select  pi.product_id,
        pi.product_name,
        extract(year from pi.warranty_period)*12 + extract(month from pi.warranty_period) as warranty_months,
        pi.list_price,
        pi.catalog_url
  from product_information pi
  where regexp_like(pi.product_name,'(\d+\s*)(GB|MB)(\s|$)','i') and
        not regexp_like(pi.product_name,'^HD','i') and
        not regexp_like(substr(pi.product_name,1,30),'disk|drive|hard','i')
  order by  case regexp_substr(pi.product_name,'(\d+\s*)(GB|MB)(\s|$)', 1, 1, 'i', 2)
              when  'GB' then
                to_number(regexp_substr(pi.product_name,'(\d+)(\s*)(GB|MB)(\s|$)',1,1,'i',1)) * 1024
              when 'MB' then
                to_number(regexp_substr(pi.product_name,'(\d+)(\s*)(GB|MB)(\s|$)',1,1,'i',1))
            end desc,
            pi.list_price
;

/*
�15
������� ����� ���������� �����, ���������� �� ��������� �������. ����� ���������
������� � ������� ������ ���� ������ � ���� ������, �������� �21:30�. ������ ��������
������� ���� � ������� ���� �� ������. ����� ��������������� ����������� �������
to_char/to_date.
�����: 1 ������ (1 �����).
*/
select  (to_date('21:30','HH24:MI') - to_date(to_char(sysdate,'HH24:MI'),'HH24:MI'))*24*60 as minutes
  from dual
;