-- Очистка таблиц (для повторного запуска)
TRUNCATE TABLE
    post,
    discount_level,
    product_category,
    supplier,
    warehouse,
    employee,
    discount_card,
    client,
    product,
    product_category_prod,
    warehouse_product,
    purchase,
    purchase_product,
    transaction,
    purchase_employee,
    review
RESTART IDENTITY CASCADE;

--====================================================================================
-- Заполнение независимых таблиц
-- 5 Должностей
INSERT INTO post (type) VALUES
('Продавец-консультант'), ('Старший продавец'), ('Кассир'), ('Менеджер склада'), ('Директор магазина');

-- 4 Уровня дисконтной карты
INSERT INTO discount_level (name, discount_amount) VALUES
('Бронзовый', 5.00), ('Серебряный', 10.00), ('Золотой', 15.00), ('Платиновый', 20.00);

-- 8 Категорий
INSERT INTO product_category (name, description) VALUES
('Бег', 'Товары для бега на короткие и длинные дистанции'),
('Футбол', 'Экипировка и инвентарь для игры в футбол'),
('Плавание', 'Товары для бассейна и открытой воды'),
('Йога и Фитнес', 'Одежда и аксессуары для занятий йогой и фитнесом'),
('Велоспорт', 'Велосипеды, запчасти и аксессуары'),
('Туризм', 'Снаряжение для походов и кемпинга'),
('Тяжелая атлетика', 'Инвентарь для силовых тренировок'),
('Зимние виды спорта', 'Лыжи, сноуборды и экипировка');

-- 10 Поставщиков
INSERT INTO supplier (name, contact, phone, email) VALUES
('SportOpt', 'Григорьев П.А.', '+79161112233', 'sales@sportopt.ru'),
('AtletSnab', 'Федорова В.И.', '+79264445566', 'manager@atletsnab.com'),
('FitnessImport', 'Михайлов С.С.', '+79037778899', 'info@fitnessimport.org'),
('VeloMir', 'Алексеев Д.В.', '+79112223344', 'zakaz@velomir.net'),
('TourGear', 'Сидорова А.М.', '+79215556677', 'partner@tourgear.pro'),
('IronPower', 'Козлов М.Е.', '+79058889900', 'iron@powerlifting.com'),
('SnowPeaks', 'Наумова О.К.', '+79251112233', 'snow@peaks.ru'),
('AquaStyle', 'Петров И.И.', '+79013334455', 'aqua@style.com'),
('RunnersChoice', 'Васильева Е.А.', '+79105556677', 'run@choice.org'),
('UniversalSport', 'Захаров В.П.', '+79208889900', 'contact@universalsport.co');

-- 3 Склада
INSERT INTO warehouse (address, capacity) VALUES
('г. Москва, ул. Центральная, д. 1 (Главный)', 10000),
('г. Москва, ул. Складская, д. 25 (Дополнительный)', 5000),
('г. Санкт-Петербург, ул. Северная, д. 10', 7500);


--====================================================================================
-- Заполнение зависимых таблиц
-- 15 сотрудников
INSERT INTO employee (post_id, phone, email, hire_date, fio, passport) VALUES
(1, '+79151234567', 'a.smirnov@sportshop.ru', '2023-05-15', 'Смирнов Алексей Петрович', '4505 111111'),
(2, '+79167654321', 'e.ivanova@sportshop.ru', '2022-11-20', 'Иванова Елена Сергеевна', '4506 222222'),
(3, '+79178889900', 'v.kuznetsov@sportshop.ru', '2024-01-10', 'Кузнецов Виктор Игоревич', '4507 333333'),
(1, '+79011112233', 'd.volkov@sportshop.ru', '2023-08-01', 'Волков Дмитрий Андреевич', '4508 444444'),
(1, '+79022223344', 'm.pavlova@sportshop.ru', '2023-09-01', 'Павлова Мария Кирилловна', '4509 555555'),
(4, '+79033334455', 's.orlov@sportshop.ru', '2022-03-10', 'Орлов Степан Евгеньевич', '4510 666666'),
(1, '+79114445566', 'a.belova@sportshop.ru', '2024-02-20', 'Белова Анна Максимовна', '4511 777777'),
(3, '+79215556677', 'n.fedorov@sportshop.ru', '2024-03-01', 'Федоров Николай Романович', '4512 888888'),
(1, '+79256667788', 'o.gromova@sportshop.ru', '2023-06-12', 'Громова Ольга Владимировна', '4513 999999'),
(1, '+79267778899', 'i.makarov@sportshop.ru', '2023-07-22', 'Макаров Игорь Станиславович', '4514 101010'),
(5, '+79001234567', 'director@sportshop.ru', '2020-01-15', 'Рогов Павел Аркадьевич', '4500 000001'),
(4, '+79002345678', ' sklad@sportshop.ru', '2021-02-18', 'Тихонов Сергей Львович', '4501 000002'),
(2, '+79003456789', 'senior.seller@sportshop.ru', '2021-05-20', 'Лазарева Ирина Викторовна', '4502 000003'),
(1, '+79004567890', 'a.zaytsev@sportshop.ru', '2024-04-01', 'Зайцев Артем Денисович', '4515 121212'),
(1, '+79005678901', 'v.novikova@sportshop.ru', '2024-04-05', 'Новикова Вероника Павловна', '4516 131313');

-- 30 дисконтных карт
INSERT INTO discount_card (level_id, date_issue) SELECT
CASE WHEN n <= 3 THEN 3 WHEN n <= 10 THEN 2 ELSE 1 END,
CURRENT_DATE - (n * 15 || ' days')::interval
FROM generate_series(1, 30) as n;

-- 30 клиентов
INSERT INTO client (fio, email, discount_card_id, passport) VALUES
('Иванов Иван Иванович', 'ivanov.ii@email.com', 1, '4601 123456'),
('Петрова Мария Андреевна', 'petrova.ma@email.com', 2, '4602 654321'),
('Сидоров Николай Викторович', 'sidorov.nv@email.com', 3, '4603 789012'),
('Васильева Ольга Дмитриевна', 'vasilieva.od@email.com', 4, '4604 210987'),
('Кузнецова Анна Петровна', 'kuznetsova.ap@email.com', 5, '4605 321456'),
('Михайлов Артем Сергеевич', 'mikhailov.as@email.com', 6, '4606 432567'),
('Попова Елена Владимировна', 'popova.ev@email.com', 7, '4607 543678'),
('Лебедев Дмитрий Игоревич', 'lebedev.di@email.com', 8, '4608 654789'),
('Козлова Екатерина Романовна', 'kozlova.er@email.com', 9, '4609 765890'),
('Новиков Максим Евгеньевич', 'novikov.me@email.com', 10, '4610 876901'),
('Соколова Татьяна Алексеевна', 'sokolova.ta@email.com', 11, '4611 987012'),
('Морозов Илья Андреевич', 'morozov.ia@email.com', 12, '4612 098123'),
('Волкова Анастасия Викторовна', 'volkova.av@email.com', 13, '4613 109234'),
('Алексеев Сергей Дмитриевич', 'alekseev.sd@email.com', 14, '4614 210345'),
('Павлова Ольга Николаевна', 'pavlova.on@email.com', 15, '4615 321456'),
('Степанов Владимир Борисович', 'stepanov.vb@email.com', 16, '4616 432567'),
('Николаева Ирина Игоревна', 'nikolaeva.ii@email.com', 17, '4617 543678'),
('Орлов Георгий Максимович', 'orlov.gm@email.com', 18, '4618 654789'),
('Белова Вероника Денисовна', 'belova.vd@email.com', 19, '4619 765890'),
('Давыдов Григорий Павлович', 'davydov.gp@email.com', 20, '4620 876901'),
('Захарова Маргарита Антоновна', 'zakharova.ma@email.com', 21, '4621 987012'),
('Борисов Кирилл Александрович', 'borisov.ka@email.com', 22, '4622 098123'),
('Романова Светлана Юрьевна', 'romanova.sy@email.com', 23, '4623 109234'),
('Филиппов Денис Олегович', 'filippov.do@email.com', 24, '4624 210345'),
('Комарова Алиса Романовна', 'komarova.ar@email.com', 25, '4625 321456'),
('Григорьев Арсений Вадимович', 'grigoriev.av@email.com', 26, '4626 432567'),
('Фролова Полина Сергеевна', 'frolova.ps@email.com', 27, '4627 543678'),
('Богданов Матвей Артёмович', 'bogdanov.ma@email.com', 28, '4628 654789'),
('Воробьева Ксения Алексеевна', 'vorobieva.ka@email.com', 29, '4629 765890'),
('Архипов Игнат Петрович', 'arkhipov.ip@email.com', 30, '4630 876901');

-- 15 товаров
INSERT INTO product (name, price, supplier_id) VALUES
('Кроссовки для бега "Скорость"', 8500.00, 9),
('Мяч футбольный "Чемпион"', 3200.00, 1),
('Очки для плавания "Дельфин"', 1500.00, 8),
('Коврик для йоги "Гармония"', 4500.00, 3),
('Футболка компрессионная "Атлет"', 3800.00, 2),
('Бутылка для воды "Оазис" 1л', 950.00, 10),
('Велосипед горный "Summit"', 45000.00, 4),
('Палатка 3-местная "Explorer"', 12500.00, 5),
('Набор гантелей 2x10кг', 6200.00, 6),
('Лыжи беговые "Nordic"', 15500.00, 7),
('Термос "Арктика" 1.5л', 2800.00, 5),
('Велошлем "Защита"', 3100.00, 4),
('Шапочка для плавания силикон', 700.00, 8),
('Рюкзак туристический 80л', 9900.00, 5),
('Гейнер "MassBuilder" 3кг', 4100.00, 6);


--====================================================================================
-- Заполнение связующих таблиц (распределение товаров по категориям)
INSERT INTO product_category_prod (product_id, product_category_id) VALUES
(1, 1), (2, 2), (3, 3), (4, 4), (5, 1), (5, 4), (6, 1), (6, 4), (6, 5), (6, 6),
(7, 5), (8, 6), (9, 7), (10, 8), (11, 6), (12, 5), (13, 3), (14, 6), (15, 7);
-- Распределяем товары по складам (остатки)
INSERT INTO warehouse_product (warehouse_id, product_id, quantity) SELECT
(1 + n % 3), n, 20 + (n * 3) % 50
FROM generate_series(1, 15) n;


--====================================================================================
-- Заполнение 50 покупок

-- ЯНВАРЬ 2025
-- Покупка 1
INSERT INTO purchase (type, date_time, client_id) VALUES ('в магазине', '2025-01-15 14:30:00', 1);
INSERT INTO purchase_product (purchase_id, product_id, quantity, price_per_item) VALUES (1, 1, 1, 8500.00), (1, 6, 1, 950.00);
INSERT INTO transaction (purchase_id, summ, data, type) VALUES (1, 9450.00, '2025-01-15 14:32:00', 'карта');
INSERT INTO purchase_employee (purchase_id, employee_id) VALUES (1, 1);
INSERT INTO review (client_id, product_id, grade, text, data) VALUES (1, 1, 5, 'Отличные кроссовки!', '2025-01-25');
-- Покупка 2
INSERT INTO purchase (type, date_time, client_id) VALUES ('онлайн', '2025-01-16 10:00:00', 20);
INSERT INTO purchase_product (purchase_id, product_id, quantity, price_per_item) VALUES (2, 13, 1, 700.00);
INSERT INTO transaction (purchase_id, summ, data, type) VALUES (2, 700.00, '2025-01-16 10:01:00', 'карта');
-- Покупка 3
INSERT INTO purchase (type, date_time, client_id) VALUES ('в магазине', '2025-01-17 19:15:00', 10);
INSERT INTO purchase_product (purchase_id, product_id, quantity, price_per_item) VALUES (3, 5, 1, 3800.00);
INSERT INTO transaction (purchase_id, summ, data, type) VALUES (3, 3800.00, '2025-01-17 19:16:00', 'карта');
INSERT INTO purchase_employee (purchase_id, employee_id) VALUES (3, 1);
-- Покупка 4
INSERT INTO purchase (type, date_time, client_id) VALUES ('в магазине', '2025-01-18 12:00:00', 21);
INSERT INTO purchase_product (purchase_id, product_id, quantity, price_per_item) VALUES (4, 10, 1, 15500.00), (4, 6, 2, 950.00);
INSERT INTO transaction (purchase_id, summ, data, type) VALUES (4, 17400.00, '2025-01-18 12:05:00', 'карта');
INSERT INTO purchase_employee (purchase_id, employee_id) VALUES (4, 2);
-- Покупка 5
INSERT INTO purchase (type, date_time, client_id) VALUES ('онлайн', '2025-01-20 18:00:00', 2);
INSERT INTO purchase_product (purchase_id, product_id, quantity, price_per_item) VALUES (5, 4, 1, 4500.00);
INSERT INTO transaction (purchase_id, summ, data, type) VALUES (5, 4500.00, '2025-01-20 18:01:00', 'карта');
-- Покупка 6
INSERT INTO purchase (type, date_time, client_id) VALUES ('онлайн', '2025-01-21 22:30:00', 1);
INSERT INTO purchase_product (purchase_id, product_id, quantity, price_per_item) VALUES (6, 6, 5, 950.00);
INSERT INTO transaction (purchase_id, summ, data, type) VALUES (6, 4750.00, '2025-01-21 22:31:00', 'карта');
-- Покупка 7
INSERT INTO purchase (type, date_time, client_id) VALUES ('в магазине', '2025-01-22 11:00:00', 3);
INSERT INTO purchase_product (purchase_id, product_id, quantity, price_per_item) VALUES (7, 7, 1, 45000.00);
INSERT INTO transaction (purchase_id, summ, data, type) VALUES (7, 45000.00, '2025-01-22 11:05:00', 'карта');
INSERT INTO purchase_employee (purchase_id, employee_id) VALUES (7, 2);
-- Покупка 8
INSERT INTO purchase (type, date_time, client_id) VALUES ('в магазине', '2025-01-24 16:45:00', 12);
INSERT INTO purchase_product (purchase_id, product_id, quantity, price_per_item) VALUES (8, 9, 1, 6200.00);
INSERT INTO transaction (purchase_id, summ, data, type) VALUES (8, 6200.00, '2025-01-24 16:46:00', 'наличные');
INSERT INTO purchase_employee (purchase_id, employee_id) VALUES (8, 5);
-- Покупка 9
INSERT INTO purchase (type, date_time, client_id) VALUES ('в магазине', '2025-01-25 15:00:00', 16);
INSERT INTO purchase_product (purchase_id, product_id, quantity, price_per_item) VALUES (9, 6, 3, 950.00);
INSERT INTO transaction (purchase_id, summ, data, type) VALUES (9, 2850.00, '2025-01-25 15:02:00', 'наличные');
INSERT INTO purchase_employee (purchase_id, employee_id) VALUES (9, 1);
-- Покупка 10
INSERT INTO purchase (type, date_time, client_id) VALUES ('онлайн', '2025-01-26 08:00:00', 22);
INSERT INTO purchase_product (purchase_id, product_id, quantity, price_per_item) VALUES (10, 4, 1, 4500.00);
INSERT INTO transaction (purchase_id, summ, data, type) VALUES (10, 4500.00, '2025-01-26 08:01:00', 'карта');
-- Покупка 11
INSERT INTO purchase (type, date_time, client_id) VALUES ('в магазине', '2025-01-28 13:20:00', 8);
INSERT INTO purchase_product (purchase_id, product_id, quantity, price_per_item) VALUES (11, 11, 1, 2800.00), (11, 14, 1, 9900.00);
INSERT INTO transaction (purchase_id, summ, data, type) VALUES (11, 12700.00, '2025-01-28 13:23:00', 'карта');
INSERT INTO purchase_employee (purchase_id, employee_id) VALUES (11, 4);
-- Покупка 12
INSERT INTO purchase (type, date_time, client_id) VALUES ('в магазине', '2025-01-28 18:00:00', 7);
INSERT INTO purchase_product (purchase_id, product_id, quantity, price_per_item) VALUES (12, 2, 1, 3200.00);
INSERT INTO transaction (purchase_id, summ, data, type) VALUES (12, 3200.00, '2025-01-28 18:02:00', 'карта');
INSERT INTO purchase_employee (purchase_id, employee_id) VALUES (12, 1);
-- Покупка 13
INSERT INTO purchase (type, date_time, client_id) VALUES ('в магазине', '2025-01-29 11:30:00', 23);
INSERT INTO purchase_product (purchase_id, product_id, quantity, price_per_item) VALUES (13, 1, 1, 8500.00);
INSERT INTO transaction (purchase_id, summ, data, type) VALUES (13, 8500.00, '2025-01-29 11:33:00', 'карта');
INSERT INTO purchase_employee (purchase_id, employee_id) VALUES (13, 2);
-- Покупка 14
INSERT INTO purchase (type, date_time, client_id) VALUES ('онлайн', '2025-01-30 19:00:00', 14);
INSERT INTO purchase_product (purchase_id, product_id, quantity, price_per_item) VALUES (14, 11, 1, 2800.00);
INSERT INTO transaction (purchase_id, summ, data, type) VALUES (14, 2800.00, '2025-01-30 19:01:00', 'карта');
-- Покупка 15
INSERT INTO purchase (type, date_time, client_id) VALUES ('в магазине', '2025-01-31 20:00:00', 24);
INSERT INTO purchase_product (purchase_id, product_id, quantity, price_per_item) VALUES (15, 15, 1, 4100.00);
INSERT INTO transaction (purchase_id, summ, data, type) VALUES (15, 4100.00, '2025-01-31 20:01:00', 'наличные');
INSERT INTO purchase_employee (purchase_id, employee_id) VALUES (15, 1);

-- ФЕВРАЛЬ 2025
-- Покупка 16
INSERT INTO purchase (type, date_time, client_id) VALUES ('в магазине', '2025-02-01 13:00:00', 1);
INSERT INTO purchase_product (purchase_id, product_id, quantity, price_per_item) VALUES (16, 8, 1, 12500.00);
INSERT INTO transaction (purchase_id, summ, data, type) VALUES (16, 12500.00, '2025-02-01 13:02:00', 'карта');
INSERT INTO purchase_employee (purchase_id, employee_id) VALUES (16, 2);
-- Покупка 17
INSERT INTO purchase (type, date_time, client_id) VALUES ('онлайн', '2025-02-03 15:45:00', 15);
INSERT INTO purchase_product (purchase_id, product_id, quantity, price_per_item) VALUES (17, 6, 2, 950.00);
INSERT INTO transaction (purchase_id, summ, data, type) VALUES (17, 1900.00, '2025-02-03 15:46:00', 'карта');
-- Покупка 18
INSERT INTO purchase (type, date_time, client_id) VALUES ('в магазине', '2025-02-05 17:00:00', 25);
INSERT INTO purchase_product (purchase_id, product_id, quantity, price_per_item) VALUES (18, 3, 1, 1500.00);
INSERT INTO transaction (purchase_id, summ, data, type) VALUES (18, 1500.00, '2025-02-05 17:01:00', 'наличные');
INSERT INTO purchase_employee (purchase_id, employee_id) VALUES (18, 7);
-- Покупка 19
INSERT INTO purchase (type, date_time, client_id) VALUES ('в магазине', '2025-02-07 18:30:00', 18);
INSERT INTO purchase_product (purchase_id, product_id, quantity, price_per_item) VALUES (19, 1, 1, 8500.00);
INSERT INTO transaction (purchase_id, summ, data, type) VALUES (19, 8500.00, '2025-02-07 18:32:00', 'карта');
INSERT INTO purchase_employee (purchase_id, employee_id) VALUES (19, 1);
-- Покупка 20
INSERT INTO purchase (type, date_time, client_id) VALUES ('в магазине', '2025-02-10 12:10:00', 1);
INSERT INTO purchase_product (purchase_id, product_id, quantity, price_per_item) VALUES (20, 2, 1, 3200.00), (20, 5, 2, 3800.00), (20, 3, 1, 1500.00);
INSERT INTO transaction (purchase_id, summ, data, type) VALUES (20, 12300.00, '2025-02-10 12:15:00', 'карта');
INSERT INTO purchase_employee (purchase_id, employee_id) VALUES (20, 2);
INSERT INTO review (client_id, product_id, grade, text, data) VALUES (1, 2, 4, 'Хороший мяч.', '2025-02-15');
-- Покупка 21
INSERT INTO purchase (type, date_time, client_id) VALUES ('онлайн', '2025-02-11 09:00:00', 26);
INSERT INTO purchase_product (purchase_id, product_id, quantity, price_per_item) VALUES (21, 1, 1, 8500.00);
INSERT INTO transaction (purchase_id, summ, data, type) VALUES (21, 8500.00, '2025-02-11 09:01:00', 'карта');
-- Покупка 22
INSERT INTO purchase (type, date_time, client_id) VALUES ('в магазине', '2025-02-14 14:20:00', 19);
INSERT INTO purchase_product (purchase_id, product_id, quantity, price_per_item) VALUES (22, 7, 1, 45000.00), (22, 12, 2, 3100.00);
INSERT INTO transaction (purchase_id, summ, data, type) VALUES (22, 51200.00, '2025-02-14 14:25:00', 'карта');
INSERT INTO purchase_employee (purchase_id, employee_id) VALUES (22, 2);
-- Покупка 23
INSERT INTO purchase (type, date_time, client_id) VALUES ('онлайн', '2025-02-16 23:50:00', 1);
INSERT INTO purchase_product (purchase_id, product_id, quantity, price_per_item) VALUES (23, 13, 3, 700.00);
INSERT INTO transaction (purchase_id, summ, data, type) VALUES (23, 2100.00, '2025-02-16 23:51:00', 'карта');
-- Покупка 24
INSERT INTO purchase (type, date_time, client_id) VALUES ('в магазине', '2025-02-18 19:45:00', 4);
INSERT INTO purchase_product (purchase_id, product_id, quantity, price_per_item) VALUES (24, 1, 1, 8500.00);
INSERT INTO transaction (purchase_id, summ, data, type) VALUES (24, 8500.00, '2025-02-18 19:46:00', 'наличные');
INSERT INTO purchase_employee (purchase_id, employee_id) VALUES (24, 1);
-- Покупка 25
INSERT INTO purchase (type, date_time, client_id) VALUES ('в магазине', '2025-02-20 10:10:00', 27);
INSERT INTO purchase_product (purchase_id, product_id, quantity, price_per_item) VALUES (25, 14, 1, 9900.00);
INSERT INTO transaction (purchase_id, summ, data, type) VALUES (25, 9900.00, '2025-02-20 10:11:00', 'карта');
INSERT INTO purchase_employee (purchase_id, employee_id) VALUES (25, 1);
-- Покупка 26
INSERT INTO purchase (type, date_time, client_id) VALUES ('в магазине', '2025-02-22 16:00:00', 1);
INSERT INTO purchase_product (purchase_id, product_id, quantity, price_per_item) VALUES (26, 5, 1, 3800.00);
INSERT INTO transaction (purchase_id, summ, data, type) VALUES (26, 3800.00, '2025-02-22 16:03:00', 'карта');
INSERT INTO purchase_employee (purchase_id, employee_id) VALUES (26, 2);
-- Покупка 27
INSERT INTO purchase (type, date_time, client_id) VALUES ('в магазине', '2025-02-24 12:00:00', 20);
INSERT INTO purchase_product (purchase_id, product_id, quantity, price_per_item) VALUES (27, 10, 1, 15500.00);
INSERT INTO transaction (purchase_id, summ, data, type) VALUES (27, 15500.00, '2025-02-24 12:03:00', 'наличные');
INSERT INTO purchase_employee (purchase_id, employee_id) VALUES (27, 9);
-- Покупка 28
INSERT INTO purchase (type, date_time, client_id) VALUES ('онлайн', '2025-02-25 10:00:00', 5);
INSERT INTO purchase_product (purchase_id, product_id, quantity, price_per_item) VALUES (28, 13, 2, 700.00), (28, 3, 1, 1500.00);
INSERT INTO transaction (purchase_id, summ, data, type) VALUES (28, 2900.00, '2025-02-25 10:02:00', 'карта');
-- Покупка 29
INSERT INTO purchase (type, date_time, client_id) VALUES ('онлайн', '2025-02-26 18:00:00', 28);
INSERT INTO purchase_product (purchase_id, product_id, quantity, price_per_item) VALUES (29, 5, 1, 3800.00);
INSERT INTO transaction (purchase_id, summ, data, type) VALUES (29, 3800.00, '2025-02-26 18:01:00', 'карта');
-- Покупка 30
INSERT INTO purchase (type, date_time, client_id) VALUES ('онлайн', '2025-02-27 23:00:00', 17);
INSERT INTO purchase_product (purchase_id, product_id, quantity, price_per_item) VALUES (30, 9, 1, 6200.00);
INSERT INTO transaction (purchase_id, summ, data, type) VALUES (30, 6200.00, '2025-02-27 23:01:00', 'карта');
-- Покупка 31
INSERT INTO purchase (type, date_time, client_id) VALUES ('в магазине', '2025-02-28 14:00:00', 9);
INSERT INTO purchase_product (purchase_id, product_id, quantity, price_per_item) VALUES (31, 15, 1, 4100.00);
INSERT INTO transaction (purchase_id, summ, data, type) VALUES (31, 4100.00, '2025-02-28 14:01:00', 'наличные');
INSERT INTO purchase_employee (purchase_id, employee_id) VALUES (31, 5);

-- МАРТ 2025
-- Покупка 32
INSERT INTO purchase (type, date_time, client_id) VALUES ('в магазине', '2025-03-01 10:00:00', 1);
INSERT INTO purchase_product (purchase_id, product_id, quantity, price_per_item) VALUES (32, 4, 1, 4500.00);
INSERT INTO transaction (purchase_id, summ, data, type) VALUES (32, 4500.00, '2025-03-01 10:02:00', 'карта');
INSERT INTO purchase_employee (purchase_id, employee_id) VALUES (32, 1);
-- Покупка 33
INSERT INTO purchase (type, date_time, client_id) VALUES ('онлайн', '2025-03-03 11:20:00', 21);
INSERT INTO purchase_product (purchase_id, product_id, quantity, price_per_item) VALUES (33, 6, 2, 950.00);
INSERT INTO transaction (purchase_id, summ, data, type) VALUES (33, 1900.00, '2025-03-03 11:21:00', 'карта');
-- Покупка 34
INSERT INTO purchase (type, date_time, client_id) VALUES ('в магазине', '2025-03-04 14:00:00', 29);
INSERT INTO purchase_product (purchase_id, product_id, quantity, price_per_item) VALUES (34, 2, 1, 3200.00);
INSERT INTO transaction (purchase_id, summ, data, type) VALUES (34, 3200.00, '2025-03-04 14:01:00', 'карта');
INSERT INTO purchase_employee (purchase_id, employee_id) VALUES (34, 2);
-- Покупка 35
INSERT INTO purchase (type, date_time, client_id) VALUES ('онлайн', '2025-03-05 21:00:00', 1);
INSERT INTO purchase_product (purchase_id, product_id, quantity, price_per_item) VALUES (35, 1, 1, 8500.00);
INSERT INTO transaction (purchase_id, summ, data, type) VALUES (35, 8500.00, '2025-03-05 21:01:00', 'карта');
-- Покупка 36
INSERT INTO purchase (type, date_time, client_id) VALUES ('в магазине', '2025-03-06 16:00:00', 22);
INSERT INTO purchase_product (purchase_id, product_id, quantity, price_per_item) VALUES (36, 1, 1, 8500.00);
INSERT INTO transaction (purchase_id, summ, data, type) VALUES (36, 8500.00, '2025-03-06 16:02:00', 'наличные');
INSERT INTO purchase_employee (purchase_id, employee_id) VALUES (36, 1);
-- Покупка 37
INSERT INTO purchase (type, date_time, client_id) VALUES ('в магазине', '2025-03-08 13:13:00', 30);
INSERT INTO purchase_product (purchase_id, product_id, quantity, price_per_item) VALUES (37, 10, 1, 15500.00), (37, 15, 2, 4100.00);
INSERT INTO transaction (purchase_id, summ, data, type) VALUES (37, 23700.00, '2025-03-08 13:15:00', 'карта');
INSERT INTO purchase_employee (purchase_id, employee_id) VALUES (37, 10);
-- Покупка 38
INSERT INTO purchase (type, date_time, client_id) VALUES ('в магазине', '2025-03-10 18:00:00', 18);
INSERT INTO purchase_product (purchase_id, product_id, quantity, price_per_item) VALUES (38, 7, 1, 45000.00), (38, 12, 1, 3100.00);
INSERT INTO transaction (purchase_id, summ, data, type) VALUES (38, 48100.00, '2025-03-10 18:05:00', 'карта');
INSERT INTO purchase_employee (purchase_id, employee_id) VALUES (38, 1);
-- Покупка 39
INSERT INTO purchase (type, date_time, client_id) VALUES ('онлайн', '2025-03-11 23:00:00', 1);
INSERT INTO purchase_product (purchase_id, product_id, quantity, price_per_item) VALUES (39, 1, 1, 8500.00), (39, 6, 1, 950.00);
INSERT INTO transaction (purchase_id, summ, data, type) VALUES (39, 9450.00, '2025-03-11 23:01:00', 'карта');
-- Покупка 40
INSERT INTO purchase (type, date_time, client_id) VALUES ('в магазине', '2025-03-12 11:00:00', 6);
INSERT INTO purchase_product (purchase_id, product_id, quantity, price_per_item) VALUES (40, 8, 1, 12500.00), (40, 14, 1, 9900.00);
INSERT INTO transaction (purchase_id, summ, data, type) VALUES (40, 22400.00, '2025-03-12 11:05:00', 'карта');
INSERT INTO purchase_employee (purchase_id, employee_id) VALUES (40, 1);
INSERT INTO review (client_id, product_id, grade, text, data) VALUES (6, 8, 5, 'Палатка просто супер, выдержала ливень!', '2025-03-20');
-- Покупка 41
INSERT INTO purchase (type, date_time, client_id) VALUES ('в магазине', '2025-03-14 12:45:00', 4);
INSERT INTO purchase_product (purchase_id, product_id, quantity, price_per_item) VALUES (41, 10, 1, 15500.00);
INSERT INTO transaction (purchase_id, summ, data, type) VALUES (41, 15500.00, '2025-03-14 12:48:00', 'карта');
INSERT INTO purchase_employee (purchase_id, employee_id) VALUES (41, 2);
-- Покупка 42
INSERT INTO purchase (type, date_time, client_id) VALUES ('в магазине', '2025-03-15 15:15:00', 23);
INSERT INTO purchase_product (purchase_id, product_id, quantity, price_per_item) VALUES (42, 5, 1, 3800.00);
INSERT INTO transaction (purchase_id, summ, data, type) VALUES (42, 3800.00, '2025-03-15 15:16:00', 'карта');
INSERT INTO purchase_employee (purchase_id, employee_id) VALUES (42, 2);
-- Покупка 43
INSERT INTO purchase (type, date_time, client_id) VALUES ('онлайн', '2025-03-18 09:30:00', 19);
INSERT INTO purchase_product (purchase_id, product_id, quantity, price_per_item) VALUES (43, 1, 1, 8500.00), (43, 6, 1, 950.00);
INSERT INTO transaction (purchase_id, summ, data, type) VALUES (43, 9450.00, '2025-03-18 09:31:00', 'карта');
-- Покупка 44
INSERT INTO purchase (type, date_time, client_id) VALUES ('в магазине', '2025-03-19 17:30:00', 24);
INSERT INTO purchase_product (purchase_id, product_id, quantity, price_per_item) VALUES (44, 12, 1, 3100.00);
INSERT INTO transaction (purchase_id, summ, data, type) VALUES (44, 3100.00, '2025-03-19 17:31:00', 'наличные');
INSERT INTO purchase_employee (purchase_id, employee_id) VALUES (44, 1);
-- Покупка 45
INSERT INTO purchase (type, date_time, client_id) VALUES ('в магазине', '2025-03-20 15:00:00', 2);
INSERT INTO purchase_product (purchase_id, product_id, quantity, price_per_item) VALUES (45, 6, 2, 950.00);
INSERT INTO transaction (purchase_id, summ, data, type) VALUES (45, 1900.00, '2025-03-20 15:01:00', 'наличные');
INSERT INTO purchase_employee (purchase_id, employee_id) VALUES (45, 4);
-- Покупка 46
INSERT INTO purchase (type, date_time, client_id) VALUES ('в магазине', '2025-03-22 19:00:00', 11);
INSERT INTO purchase_product (purchase_id, product_id, quantity, price_per_item) VALUES (46, 2, 2, 3200.00);
INSERT INTO transaction (purchase_id, summ, data, type) VALUES (46, 6400.00, '2025-03-22 19:02:00', 'наличные');
INSERT INTO purchase_employee (purchase_id, employee_id) VALUES (46, 1);
-- Покупка 47
INSERT INTO purchase (type, date_time, client_id) VALUES ('онлайн', '2025-03-25 00:10:00', 25);
INSERT INTO purchase_product (purchase_id, product_id, quantity, price_per_item) VALUES (47, 13, 5, 700.00);
INSERT INTO transaction (purchase_id, summ, data, type) VALUES (47, 3500.00, '2025-03-25 00:11:00', 'карта');
-- Покупка 48
INSERT INTO purchase (type, date_time, client_id) VALUES ('в магазине', '2025-03-28 17:00:00', 3);
INSERT INTO purchase_product (purchase_id, product_id, quantity, price_per_item) VALUES (48, 12, 1, 3100.00);
INSERT INTO transaction (purchase_id, summ, data, type) VALUES (48, 3100.00, '2025-03-28 17:02:00', 'карта');
INSERT INTO purchase_employee (purchase_id, employee_id) VALUES (48, 2);
-- Покупка 49
INSERT INTO purchase (type, date_time, client_id) VALUES ('в магазине', '2025-03-30 20:00:00', 1);
INSERT INTO purchase_product (purchase_id, product_id, quantity, price_per_item) VALUES (49, 11, 2, 2800.00);
INSERT INTO transaction (purchase_id, summ, data, type) VALUES (49, 5600.00, '2025-03-30 20:05:00', 'карта');
INSERT INTO purchase_employee (purchase_id, employee_id) VALUES (49, 2);
-- Покупка 50
INSERT INTO purchase (type, date_time, client_id) VALUES ('в магазине', '2025-03-31 19:55:00', 1);
INSERT INTO purchase_product (purchase_id, product_id, quantity, price_per_item) VALUES (50, 7, 1, 45000.00), (50, 12, 1, 3100.00), (50, 1, 1, 8500.00);
INSERT INTO transaction (purchase_id, summ, data, type) VALUES (50, 56600.00, '2025-03-31 20:00:00', 'карта');
INSERT INTO purchase_employee (purchase_id, employee_id) VALUES (50, 1);