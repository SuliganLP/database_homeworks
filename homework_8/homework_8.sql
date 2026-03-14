-- 1 Найдите все записи таблицы Printer для цветных принтеров.

select *
from printer
where color = 'y';

-- 2 Найдите номера моделей и цены всех имеющихся в продаже продуктов (любого типа) производителя B (латинская буква).

select p.model, pc.price
from product p
join pc on p.model = pc.model
where p.maker = 'B'

union

select p.model, l.price
from product p
join laptop l on p.model = l.model
where p.maker = 'B'

union

select p.model, pr.price
from product p
join printer pr on p.model = pr.model
where p.maker = 'B';

-- 3 Найдите производителя, выпускающего ПК, но не ПК-блокноты.

select distinct maker
from product
where type = 'PC'
  and maker not in (
    select maker
    from product
    where type = 'Laptop'
);

-- 4 Найдите производителей ПК с процессором не менее 450 Мгц. Вывести: Maker

select distinct p.maker
from product p
join pc on p.model = pc.model
where pc.speed >= 450;

-- 5 Найдите среднюю скорость ПК.

select avg(speed) as avg_speed
from pc;

-- 6 Для каждого производителя, имеющего модели в таблице Laptop, найдите средний размер экрана 
-- выпускаемых им ПК-блокнотов.
-- Вывести: maker, средний размер экрана.

select p.maker, avg(l.screen) as avg_screen
from product p
join laptop l on p.model = l.model
group by p.maker;