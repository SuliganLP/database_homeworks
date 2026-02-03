use 121225ptm_Suligan;

CREATE TABLE weather_last5 (
    id int auto_increment primary key,
    weather_date date not null,

    day_temp int not null,
    night_temp int not null,

    wind_speed decimal(4,1) not null,

    check (day_temp between -30 and 30),
    check (night_temp between -30 and 30),
    check (wind_speed between 0 and 60),

    unique (weather_date)
);

insert into weather_last5 (weather_date, day_temp, night_temp, wind_speed)
VALUES
    (curdate() - INTERVAL 4 DAY,  2, -3,  1.8),
    (curdate() - INTERVAL 3 DAY,  4, -1,  3.0),
    (curdate() - INTERVAL 2 DAY,  6,  0,  5.4),
    (curdate() - INTERVAL 1 DAY,  5, -2,  2.4),
    (curdate(),                   3, -4,  0.9);

update weather_last5
set night_temp = night_temp + 1
WHERE wind_speed <= 3;

create or replace view v_weather_last5 AS
SELECT
    id,
    weather_date,
    day_temp,
    night_temp,
    wind_speed,

    (day_temp + night_temp) / 2.0 AS avg_daily_temp,

    CASE
        WHEN wind_speed < 2 THEN 'штиль'
        WHEN wind_speed >= 2 AND wind_speed < 5 THEN 'умеренный ветер'
        ELSE 'сильный ветер'
    END AS wind_level
FROM weather_last5;

SELECT * FROM v_weather_last5 ORDER BY weather_date;