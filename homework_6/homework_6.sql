use northwind;

# Task_1
-- Выведите одним запросом с использованием UNION столбцы id, employee_id из таблицы orders и
-- соответствующие им столбцы из таблицы purchase_orders. В таблице purchase_orders created_by
-- соответствует employee_id.

select o.id, o.employee_id
from orders as o
union
select p.id, p.created_by
from purchase_orders as p;

# Task_2
-- Из предыдущего запроса удалите записи там где employee_id не имеет значения. Добавьте
-- дополнительный столбец со сведениями из какой таблицы была взята запись.

select o.id, o.employee_id, "orders" as source_table
from orders as o
where o.employee_id is not null
union
select p.id, p.created_by, "purchase_orders" as source_table
from purchase_orders as p
where p.created_by is not null;

# Task_3
-- Выведите все столбцы таблицы order_details а также дополнительный столбец payment_method из
-- таблицы purchase_orders. Оставьте только заказы для которых известен payment_method.

select o.*, p.payment_method
from order_details as o
inner join purchase_orders as p on o.purchase_order_id = p.id
where p.payment_method is not null;

# Task_4
-- Выведите заказы orders и фамилии клиентов customers для тех заказов по которым были инвойсы
-- таблица invoices.

select o.id, c.last_name
from orders as o
join invoices as i on i.order_id = o.id
join customers as c on o.customer_id = c.id;

# Task_5
-- Подсчитайте количество инвойсов для каждого клиента из предыдущего запроса.

select c.id, c.last_name, count(i.id) as invoices_amount
from customers as c
join orders as o on o.customer_id = c.id
join invoices as i on i.order_id = o.id
group by c.id, c.last_name;