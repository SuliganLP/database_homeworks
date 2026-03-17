use northwind;


-- Для каждого заказа order_id выведите минимальный, максимальный и средний unit_cost.

select purchase_order_id,
       unit_cost,
	   min(unit_cost) over (partition by purchase_order_id) as min_cost,
	   max(unit_cost) over (partition by purchase_order_id) as max_cost,
       avg(unit_cost) over (partition by purchase_order_id) as avg_cost
from purchase_order_details;

-- Оставьте только уникальные строки из предыдущего запроса.

select distinct
       purchase_order_id,
	   min(unit_cost) over (partition by purchase_order_id) as min_cost,
	   max(unit_cost) over (partition by purchase_order_id) as max_cost,
       avg(unit_cost) over (partition by purchase_order_id) as avg_cost
from purchase_order_details
group by purchase_order_id;

-- Посчитайте стоимость продукта в заказе как quantity*unit_cost.
-- ● Выведите суммарную стоимость продуктов с помощью оконной функции.
-- ● Сделайте то же самое с помощью GROUP BY.

select purchase_order_id,
       product_id,
       quantity,
       unit_cost,
       quantity * unit_cost as product_total,
       sum(quantity * unit_cost) over (partition by purchase_order_id) as order_total
from purchase_order_details;

select purchase_order_id,
	   sum(quantity * unit_cost) as order_cost
from purchase_order_details
group by purchase_order_id;

-- Посчитайте количество заказов по дате получения и posted_to_inventory.
-- Если оно превышает 1 то выведите '>1' в противном случае '=1'.

select date_received,
	   posted_to_inventory,
       count(*) as orders_count,
       case
	       when count(*) > 1 then ">1"
           else "=1"
       end as result
from purchase_order_details
group by date_received, posted_to_inventory;

-- Выведите purchase_order_id, date_received и вычисленный столбец.

select
    purchase_order_id,
    date_received,
    case
        when count(*) over (partition by date_received, posted_to_inventory) > 1 then '>1'
        else '=1'
    end as  calculated_quantity
FROM purchase_order_details;

