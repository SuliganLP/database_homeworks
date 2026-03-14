use northwind;

-- Вывести названия продуктов таблица products, включая количество заказанных единиц quantity для 
-- каждого продукта таблица order_details.
-- Решить задачу с помощью cte и подзапроса

#Подзапрос
select p.product_name, t.amount
from products p
join (
	select product_id, sum(quantity) as amount
    from order_details
    group by product_id) t
on p.id = t.product_id;


#CTE
with my_cte as (
	select product_id, sum(quantity) as amount
    from order_details
    group by product_id)
select p.product_name, c.amount
from products p
join my_cte c
on p.id = c.product_id;


-- Найти все заказы таблица orders, сделанные после даты самого первого заказа клиента Lee таблица customers.

select *
from orders as o
where order_date > (
	select min(order_date)
	from orders o2
    join customers c on o2.customer_id = c.id
    where last_name = "Lee");

-- Найти все продукты таблицы  products c максимальным target_level

select product_name, target_level
from products
where target_level = (
	select max(target_level)
    from products);
