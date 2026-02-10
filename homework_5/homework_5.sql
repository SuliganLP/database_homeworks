use northwind;


-- 1 Посчитайте основные статистики - среднее, сумму, минимум, максимум столбца unit_cost.


select 
	avg(unit_cost) as average, 
	min(unit_cost) as minimun_cost,
    max(unit_cost) as maximum_cost,
    sum(unit_cost) as sum_cost
from purchase_order_details;


-- 2 Посчитайте количество уникальных заказов purchase_order_id


select distinct(purchase_order_id)
from purchase_order_details;


-- 3 Посчитайте количество продуктов product_id в каждом заказе purchase_order_id 
-- Отсортируйте полученные данные по убыванию количества


select purchase_order_id, count(product_id) as product_count
from purchase_order_details
group by purchase_order_id
order by product_count desc;


-- 4 Посчитайте заказы по дате доставки date_received Считаем только те продукты, 
-- количество quantity которых больше 30

select date_received, count(distinct(purchase_order_id)) as order_count
from purchase_order_details
where quantity > 30
group by date_received
order by date_received;

-- 5 Посчитайте суммарную стоимость заказов в каждую из дат Стоимость заказа - произведение quantity на unit_cost


select 
	date_received, 
	count(distinct(purchase_order_id)) as order_count,
    sum(quantity * unit_cost) as sum_orders_cost
from purchase_order_details
group by date_received
order by date_received;


-- 6 Сгруппируйте товары по unit_cost и вычислите среднее и максимальное значение quantity 
-- только для товаров где purchase_order_id не больше 100


select
	unit_cost,
    avg(quantity) as average_quantity,
    max(quantity) as maximum_quantity
from 
where purchase_order_id < 100
group by unit_cost;


-- 7 Выберите только строки где есть значения в столбце inventory_id 
-- Создайте столбец category - если unit_cost > 20 то 'Expensive' в остальных случаях 'others' 
-- Посчитайте количество продуктов в каждой категории


select 
	case
		when unit_cost > 20 then "Expensive"
        else "others"
	end as category,
    count(*) as product_count
from purchase_order_details
where inventory_id is not null
group by category;



