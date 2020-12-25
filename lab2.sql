/*
�1
������� ��������, � ������� ���� ������ � ���� 1999 ����. ����������� �� ����
�������. ������������ ���������� ���������� (inner join) � distinct.
�����: 47 �����.
*/
select  distinct c.*
  from  customers c
  inner join orders o on
    c.customer_id = o.customer_id and
    date'1999-07-01' <= o.order_date and o.order_date < date'1999-08-01'
  order by c.customer_id
;
/*
�2
������� ���� �������� � ����� �� ������� �� 2000 ���, ���������� �� �� ����� �������
(�������, � ������� ������ �� ���� ������� �� 2000 ���, ������� � �����), ����� �� ID
���������. ������� ����: ��� ���������, ��� ��������� (������� + ��� ����� ������),
����� ������� �� 2000 ���. ������������ ������� ���������� (left join) �������
���������� � ����������� ��� ������ ����� ������� (�� ������� �������) �� ��������
�� 2000 ��� (��������� � ������������).
�����: 319 �����.
*/
select  c.customer_id,
        c.cust_first_name || ' ' || c.cust_last_name as cust_name,
        o.sum as order_total
  from  customers c
    left join (
      select  o.customer_id,
              sum(o.order_total) as sum
        from  orders o
        where date'2000-01-01' <= o.order_date and o.order_date < date'2001-01-01'
        group by o.customer_id
    ) o on
    c.customer_id = o.customer_id
  order by  o.sum desc nulls last,
            c.customer_id
;
/*
�3
������� �����������, ������� �������� �� ������ ����� ��������� (��� ������� �
�������). ������������ ������� ���������� (����� ���������?) � �������� �������, �
����� ����� ������� �� ������� ����������� �����, ��� ������� �� �������������
����� �� ������� �������. ����������� ���������� ����������� �� ���� ������ ��
������ (� �������� �������, ����� �� ���� ���������� (� ������� �������).
�����: 100 �����.
*/
select  e.*
  from  employees e
    left join job_history jh on
      e.employee_id = jh.employee_id
  where jh.start_date is null
  order by  e.hire_date desc,
            e.employee_id
;
/*
�4
������� ��� ������, ���������� �� �� ���������� ������������ �������,
�������������� � ���. ������� ����: ��� ������, �������� ������, ����������
��������� ������� �� ������. ����������� �� ���������� ������������ ������� ��
������ (�� �������� ���������� � ��������), ����� �� ���� ������ (� �������
�������). ������, ��� ������� ��� ���������� � ������� �� ������, ������� � �����.
���������� �� ������������.
�����: 9 �����.
*/
select  w.warehouse_id,
        w.warehouse_name,
        count(i.product_id) as products_count
  from  warehouses w
    left join inventories i on
      w.warehouse_id = i.warehouse_id
  group by  w.warehouse_id,
            w.warehouse_name
  order by  products_count desc nulls last,
            w.warehouse_id
;

/*
�5
������� �����������, ������� �������� � ���. ����������� �� ���� ����������.
�����: 68 �����.
*/
select  e.*
  from  employees e
        inner join departments d on
          d.department_id = e.department_id
        inner join locations l on
          d.location_id = l.location_id
  where l.country_id = 'US'
  order by  e.employee_id
;
/*
�6
������� ��� ������ � �� �������� �� ������� �����. ������� ����: ��� ������,
�������� ������, ���� ������ � �������� (LIST_PRICE), �������� ������ �� �������
�����. ���� �������� ������ �� ������� ����� ���, � ���� �������� ������� ����
���������, ���������������� �������� nvl ��� ���������� case (� ������� ����
������ ��� ���� ������� ���� �������� �� ������� �����, ������ ������ ������ ����
������� � �������������, ��� �������� �� ������� ����� ����� � �� ����; ���
�������� ������� ����� ������� ��� ��������������� ����� � ���������, ��������� ��
� ���� �������� ��������������� �����������). ����������� �� ���� ���������
������, ����� �� ���� ������.
�����: 288 �����.
*/
select  pi.product_id,
        pi.product_name,
        pi.list_price,
        nvl(pd.translated_description, '��� ��������') as pr
  from  product_information pi
        left join product_descriptions pd on
          pd.product_id = pi.product_id and
          pd.language_id = 'RU'
  order by  pi.category_id,
            pi.product_id
;
/*
�7
������� ������, ������� ������� �� �����������. ������� ����: ��� ������, ��������
������, ���� ������ � �������� (LIST_PRICE), �������� ������ �� ������� ����� (������
������ ���� ������� � �������������, ��� �������� ������ �� ������� ����� ����� �
�� ����). ����������� �� ���� ������ � �������� ������� (������, ��� ������� ��
������� ����, ������� � �����), ����� �� ���� ������.
�����: 103 ������.
*/
select  pi.product_id,
        pi.product_name,
        pi.list_price,
        nvl(pd.translated_name, '��� �������� ������ �� ������� �����') as ru_name
  from  product_information pi
        left join order_items oi on
          oi.product_id = pi.product_id
        left join product_descriptions pd on
          pd.product_id = pi.product_id and
          pd.language_id = 'RU'
  where  oi.order_id is null
  order by  pi.list_price desc nulls last,
            pi.product_id
;

/*
�8
������� ��������, � ������� ���� ������ �� ����� ������, ��� � 2 ���� �����������
������� ���� ������. ������� ����: ��� �������, �������� ������� (������� + ���
����� ������), ���������� ����� �������, ������������ ����� ������. ����������� ��
���������� ����� ������� � �������� �������, ����� �� ���� �������.
�����: 13 �����.
*/
select  c.customer_id,
        c.cust_first_name || ' ' || c.cust_last_name as cust_name,
        o.large_sum_orders_count,
        o.max_order_sum
  from  customers c
        inner join (
          select  o.customer_id,
                  count(o.order_id) as large_sum_orders_count,
                  max(o.order_total) as max_order_sum
            from  orders o
            where o.order_total > (
                    select  avg(o.order_total)
                      from  orders o
                  ) * 2
            group by  o.customer_id
        ) o on
          c.customer_id = o.customer_id
  order by  large_sum_orders_count desc,
            c.customer_id
;

/*
�9
����������� �������� �� ����� ������� �� 2000 ���. ������� ����: ��� �������, ���
������� (������� + ��� ����� ������), ����� ������� �� 2000 ���. ����������� ������
�� ����� ������� �� 2000 ��� � �������� �������, ����� �� ���� �������. �������, �
������� �� ���� ������� � 2000, ������� � �����.
�����: 319 �����.
*/
select  c.customer_id,
        c.cust_first_name || ' ' || c.cust_last_name as cust_name,
        o.sum_orders_total
  from  customers c
        left join (
          select  o.customer_id,
                  sum(o.order_total) as sum_orders_total
            from  orders o
            where date'2000-01-01' <= o.order_date and o.order_date < date'2001-01-01'
            group by o.customer_id
        ) o on
          c.customer_id = o.customer_id
  order by  o.sum_orders_total desc nulls last,
            c.customer_id
;

/*
�10
���������� ���������� ������ ���, ����� �� �������� ��������, � ������� ������ ��
���� �������.
�����: 16 �����.
*/
select  c.customer_id,
        c.cust_first_name || ' ' || c.cust_last_name as cust_name,
        o.sum_orders_total
  from  customers c
        inner join (
          select  o.customer_id,
                  sum(o.order_total) as sum_orders_total
            from  orders o
            where date'2000-01-01' <= o.order_date and o.order_date < date'2001-01-01'
            group by o.customer_id
        ) o on
          c.customer_id = o.customer_id
  order by  o.sum_orders_total desc nulls last,
            c.customer_id
;

/*
�11
������� ��������� �� �������� ����������� ��������� ��� �����. ��������� ��
�������� ������� �����������, ��� ��������� �������: �SA_MAN� � �SA_REP�.
������� ����: ��� ���������, ��� ��������� (������� + ��� ����� ������), ���
�������, ��� ������� (������� + ��� ����� ������), ���� ������, ����� ������,
���������� ��������� ������� � ������. ����������� ������ �� ���� ������ � ��������
�������, ����� �� ����� ������ � �������� �������, ����� �� ���� ����������. ���
����������, � ������� ��� �������, ������� � �����.
�����: 35 �����.
*/
select  e.employee_id,
        e.last_name || ' ' || e.last_name as emp_name,
        c.customer_id,
        c.cust_last_name || ' ' || c.cust_first_name as cust_name,
        o.order_date,
        o.order_total,
        oi.items_count
  from  employees e
        left join (
            select  o.sales_rep_id,
                    o.order_date,
                    o.order_total,
                    o.order_id,
                    o.customer_id
              from orders o
              where o.order_date = (
                select  max(o1.order_date)
                  from orders o1
                  where o1.sales_rep_id = o.sales_rep_id
                  )
         ) o on
          e.employee_id = o.sales_rep_id
        left join(
          select  oi.order_id,
                  count(oi.product_id) as items_count
            from order_items oi
            group by oi.order_id
        ) oi on
          oi.order_id = o.order_id
        left join customers c on 
          c.customer_id = o.customer_id
  where e.job_id in ('SA_MAN','SA_REP')
  order by  o.order_date desc nulls last,
            o.order_total desc,
            e.employee_id
;

/*
�12
���������, ���� �� ������, � ������� ������ ������������ �� �������. �������, ���
������ ����, ���� ����� ������ ������ ����� ��������� ���� ������� � ������, ����
���� ������� �������� � �������� (������). ���� ����� ������ ����, �� �������
������������ ������� ������ ����� ���� ����� �������, ����������� �� 2 ������ �����
�������.
�����: 1 ������ (1 �����).
*/
select  round(max(1 - o.order_total / oi.order_price) * 100,2) as max_discont_percent
  from  orders o
        inner join (
          select  oi.order_id,
                  sum(pi.list_price * oi.quantity) as order_price
            from  order_items oi
                  inner join product_information pi on
                    oi.product_id = pi.product_id
            group by oi.order_id
        ) oi on
          o.order_id = oi.order_id
  where not o.order_total = oi.order_price
;

/*
�13
������� ������, ������� ���� ������ �� ����� ������. ������� ����: ��� ������,
�������� ������, ���� ������ �� �������� (LIST_PRICE), ��� � �������� ������, ��
������� ���� ������ �����, ������, � ������� ��������� ������ �����. �����������
������ �� �������� ������, ����� �� ���� ������, ����� �� �������� ������.
�����: 12 �����.
*/
select  pi.product_id,
        pi.product_name,
        pi.list_price,
        w.warehouse_id,
        w.warehouse_name,
        c.country_name
  from  product_information pi
        inner join(
          select  i.product_id,
                  i.warehouse_id
            from inventories i
            where (select  count(i.warehouse_id)
                    from  inventories i1
                    where i1.product_id = i.product_id
                  ) = 1
        ) i on 
          pi.product_id = i.product_id
        inner join warehouses w on
          i.warehouse_id = w.warehouse_id
        left join locations l on 
          l.location_id = w.location_id
        left join countries c on
          c.country_id = l.country_id
  order by  c.country_name,
            w.warehouse_id,
            pi.product_name
;

/*
�14
��� ���� ����� ������� ���������� ��������, ������� ��������� � ������ ������.
������� ����: ��� ������, �������� ������, ���������� ��������. ��� �����, � �������
��� ��������, � �������� ���������� �������� ������� 0. ����������� �� ����������
�������� � �������� �������, ����� �� �������� ������.
�����: 25 �����.
*/
select  c.country_id,
        c.country_name,
        count(cust.customer_id) as customers_count
  from  countries c
        left join customers cust on
          cust.cust_address_country_id = c.country_id
  group by  c.country_id,
            c.country_name
  order by  customers_count desc
;

/*
�15
��� ������� ������� ������� ����������� �������� (���������� ����) ����� ���
��������. �������� ����� �������� ������� ��� ������� � ���� ����� ������ 2-�
������� ��� ����� ������� ������. ������� ����: ��� �������, ��� �������
(������� + ��� ����� ������), ���� ������� � ����������� ���������� (����� ��
�����������), �������� � ���� ����� ����� ��������. ���� � ������� ������� ��� ���
����� ���� �� ��� �������, �� ����� �������� �� ��������. ����������� �� ����
�������.
�����: 18 �����.
*/
select  c.customer_id,
        c.cust_last_name || ' ' || c.cust_first_name as cust_name,
        o1.order_date,
        o2.order_date,
        abs(trunc(o1.order_date,'DD') - trunc(o2.order_date,'DD')) as min_order_interval
  from  customers c
        inner join orders o1 on 
          c.customer_id = o1.customer_id
        inner join orders o2 on
          o1.customer_id = o2.customer_id and
          o1.order_date < o2.order_date
  where abs(trunc(o1.order_date,'DD')-trunc(o2.order_date,'DD')) = (
          select  min(abs(trunc(o1.order_date,'DD') - trunc(o2.order_date,'DD'))) as min_order_interval
            from  customers c1
                  inner join orders o1 on
                    c1.customer_id = o1.customer_id
                  inner join orders o2 on
                    o1.customer_id = o2.customer_id and
                    o1.order_date < o2.order_date
            where c.customer_id = c1.customer_id
        )
  order by c.customer_id
;