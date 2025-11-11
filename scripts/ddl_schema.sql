-- 1. Создаём таблицы
CREATE TABLE discount_level (
  level_id bigserial PRIMARY KEY,
  name varchar(100) NOT NULL,
  discount_amount decimal NOT NULL
);
-- Комментарии к таблице "Уровень скидки"
COMMENT ON TABLE discount_level IS 'Таблица-справочник уровней скидки';
COMMENT ON COLUMN discount_level.level_id IS 'PRIMARY KEY. ID уровня скидки';
COMMENT ON COLUMN discount_level.name IS 'Название уровня скидки';
COMMENT ON COLUMN discount_level.discount_amount IS 'Величина скидки (%)';


CREATE TABLE discount_card (
  discount_card_id bigserial PRIMARY KEY,
  level_id bigint,
  date_issue timestamp
);
-- Комментарии к таблице "Дисконтная карта"
COMMENT ON TABLE discount_card IS 'Таблица для учёта дисконтных карт';
COMMENT ON COLUMN discount_card.discount_card_id IS 'PRIMARY KEY. ID дисконтной карты';
COMMENT ON COLUMN discount_card.level_id IS 'FOREIGN KEY. ID уровня скидки';
COMMENT ON COLUMN discount_card.date_issue IS 'Дата выдачи карты';


CREATE TABLE client (
  client_id bigserial PRIMARY KEY,
  fio varchar(255) NOT NULL,
  email varchar(255) NOT NULL,
  discount_card_id bigint NOT NULL,
  passport varchar(50) NOT NULL
);
-- Комментарии к таблице "Клиент"
COMMENT ON TABLE client IS 'Таблица-справочник клиентов';
COMMENT ON COLUMN client.client_id IS 'PRIMARY KEY. ID клиента';
COMMENT ON COLUMN client.fio IS 'ФИО клиента';
COMMENT ON COLUMN client.email IS 'Email клиента';
COMMENT ON COLUMN client.discount_card_id IS 'FOREIGN KEY. ID дисконтной карты';
COMMENT ON COLUMN client.passport IS 'Паспортные данные клиента';


CREATE TABLE purchase (
  purchase_id bigserial PRIMARY KEY,
  type varchar(50) NOT NULL,
  date_time timestamp NOT NULL,
  client_id bigint NOT NULL
);
-- Комментарии к таблице "Покупка"
COMMENT ON TABLE purchase IS 'Таблица фактов о совершённых покупках (чеках)';
COMMENT ON COLUMN purchase.purchase_id IS 'PRIMARY KEY. ID покупки';
COMMENT ON COLUMN purchase.type IS 'Тип покупки (онлайн / в магазине)';
COMMENT ON COLUMN purchase.date_time IS 'Дата и время покупки';
COMMENT ON COLUMN purchase.client_id IS 'FOREIGN KEY. ID клиента';


CREATE TABLE transaction (
  id bigserial PRIMARY KEY,
  purchase_id bigint NOT NULL,
  summ decimal NOT NULL,
  data timestamp NOT NULL,
  type varchar(50) NOT NULL
);
-- Комментарии к таблице "Транзакция"
COMMENT ON TABLE transaction IS 'Таблица для хранения финансовых операций по покупкам';
COMMENT ON COLUMN transaction.id IS 'PRIMARY KEY. ID транзакции';
COMMENT ON COLUMN transaction.purchase_id IS 'FOREIGN KEY. ID покупки';
COMMENT ON COLUMN transaction.summ IS 'Сумма транзакции';
COMMENT ON COLUMN transaction.data IS 'Дата транзакции';
COMMENT ON COLUMN transaction.type IS 'Тип транзакции (карта, наличные и т.д.)';


CREATE TABLE product_category (
  product_category_id bigserial PRIMARY KEY,
  name varchar(255) NOT NULL,
  description text
);
-- Комментарии к таблице "Категория товара"
COMMENT ON TABLE product_category IS 'Таблица-справочник категорий товаров';
COMMENT ON COLUMN product_category.product_category_id IS 'PRIMARY KEY. ID категории товара';
COMMENT ON COLUMN product_category.name IS 'Название категории товара';
COMMENT ON COLUMN product_category.description IS 'Описание категории';


CREATE TABLE product (
  product_id bigserial PRIMARY KEY,
  name varchar(255) NOT NULL,
  price decimal NOT NULL,
  supplier_id bigint NOT NULL
);
-- Комментарии к таблице "Товар" (product)
COMMENT ON TABLE product IS 'Таблица-справочник товаров';
COMMENT ON COLUMN product.product_id IS 'PRIMARY KEY. ID товара';
COMMENT ON COLUMN product.name IS 'Название товара';
COMMENT ON COLUMN product.price IS 'Цена товара';
COMMENT ON COLUMN product.supplier_id IS 'FOREIGN KEY. ID поставщика';


CREATE TABLE supplier (
  supplier_id bigserial PRIMARY KEY,
  name varchar(255) NOT NULL,
  contact varchar(255) NOT NULL,
  phone varchar(50) NOT NULL,
  email varchar(255) NOT NULL
);
-- Комментарии к таблице "Поставщик"
COMMENT ON TABLE supplier IS 'Таблица-справочник поставщиков';
COMMENT ON COLUMN supplier.supplier_id IS 'PRIMARY KEY. ID поставщика';
COMMENT ON COLUMN supplier.name IS 'Название/ФИО поставщика';
COMMENT ON COLUMN supplier.contact IS 'Контактное лицо';
COMMENT ON COLUMN supplier.phone IS 'Телефон поставщика';
COMMENT ON COLUMN supplier.email IS 'Email поставщика';


CREATE TABLE warehouse (
  warehouse_id bigserial PRIMARY KEY,
  address varchar(255) NOT NULL,
  capacity int NOT NULL
);
-- Комментарии к таблице "Склад"
COMMENT ON TABLE warehouse IS 'Таблица-справочник складов';
COMMENT ON COLUMN warehouse.warehouse_id IS 'PRIMARY KEY. ID склада';
COMMENT ON COLUMN warehouse.address IS 'Адрес склада';
COMMENT ON COLUMN warehouse.capacity IS 'Вместимость склада';


CREATE TABLE warehouse_product (
  warehouse_product_id bigserial PRIMARY KEY,
  warehouse_id bigint NOT NULL,
  product_id bigint NOT NULL,
  quantity int NOT NULL
);
-- Комментарии к таблице "Связь Склад-Товар"
COMMENT ON TABLE warehouse_product IS 'Таблица для связи "многие-ко-многим" между складами и товарами, хранит остатки.';
COMMENT ON COLUMN warehouse_product.warehouse_product_id IS 'PRIMARY KEY. ID записи связи склад-товар';
COMMENT ON COLUMN warehouse_product.warehouse_id IS 'FOREIGN KEY. ID склада';
COMMENT ON COLUMN warehouse_product.product_id IS 'FOREIGN KEY. ID товара';
COMMENT ON COLUMN warehouse_product.quantity IS 'Количество единиц данного товара на данном складе';


CREATE TABLE product_category_prod (
  product_category_prod_id bigserial PRIMARY KEY,
  product_category_id bigint NOT NULL,
  product_id bigint NOT NULL
);
-- Комментарии к таблице "Связь Товар-Категория"
COMMENT ON TABLE product_category_prod IS 'Таблица для связи "многие-ко-многим" между товарами и их категориями';
COMMENT ON COLUMN product_category_prod.product_category_prod_id IS 'PRIMARY KEY. ID записи связи товар-категория';
COMMENT ON COLUMN product_category_prod.product_category_id IS 'FOREIGN KEY. ID категории товара';
COMMENT ON COLUMN product_category_prod.product_id IS 'FOREIGN KEY. ID товара';


CREATE TABLE post (
  post_id bigserial PRIMARY KEY,
  type varchar(100) NOT NULL
);
-- Комментарии к таблице "Должность"
COMMENT ON TABLE post IS 'Таблица-справочник должностей сотрудников';
COMMENT ON COLUMN post.post_id IS 'PRIMARY KEY. ID должности';
COMMENT ON COLUMN post.type IS 'Название должности';


CREATE TABLE employee (
  employee_id bigserial PRIMARY KEY,
  post_id bigint NOT NULL,
  phone varchar(50) NOT NULL,
  email varchar(255) NOT NULL,
  hire_date timestamp NOT NULL,
  fio varchar(255) NOT NULL,
  passport varchar(50) NOT NULL
);
-- Комментарии к таблице "Сотрудник"
COMMENT ON TABLE employee IS 'Таблица-справочник сотрудников';
COMMENT ON COLUMN employee.employee_id IS 'PRIMARY KEY. ID сотрудника';
COMMENT ON COLUMN employee.post_id IS 'FOREIGN KEY. ID должности';
COMMENT ON COLUMN employee.phone IS 'Телефон сотрудника';
COMMENT ON COLUMN employee.email IS 'Email сотрудника';
COMMENT ON COLUMN employee.hire_date IS 'Дата найма сотрудника';
COMMENT ON COLUMN employee.fio IS 'ФИО сотрудника';
COMMENT ON COLUMN employee.passport IS 'Паспортные данные сотрудника';


CREATE TABLE purchase_employee (
  purchase_employee_id bigserial PRIMARY KEY,
  purchase_id bigint NOT NULL,
  employee_id bigint NOT NULL
);
-- Комментарии к таблице "Связь Покупка-Сотрудник"
COMMENT ON TABLE purchase_employee IS 'Таблица для связи "многие-ко-многим" между покупками и сотрудниками';
COMMENT ON COLUMN purchase_employee.purchase_employee_id IS 'PRIMARY KEY. ID записи связи покупка-сотрудник';
COMMENT ON COLUMN purchase_employee.purchase_id IS 'FOREIGN KEY. ID покупки';
COMMENT ON COLUMN purchase_employee.employee_id IS 'FOREIGN KEY. ID сотрудника';


CREATE TABLE purchase_product (
  purchase_product_id bigserial PRIMARY KEY,
  purchase_id bigint NOT NULL,
  product_id bigint NOT NULL,
  quantity int NOT NULL,
  price_per_item decimal NOT NULL
);
-- Комментарии к таблице "Связь Покупка-Товар"
COMMENT ON TABLE purchase_product IS 'Таблица для связи "многие-ко-многим" между покупками и товарами (состав чека)';
COMMENT ON COLUMN purchase_product.purchase_product_id IS 'PRIMARY KEY. ID записи связи покупка-товар';
COMMENT ON COLUMN purchase_product.purchase_id IS 'FOREIGN KEY. ID покупки';
COMMENT ON COLUMN purchase_product.product_id IS 'FOREIGN KEY. ID товара';
COMMENT ON COLUMN purchase_product.quantity IS 'Количество единиц товара в данной покупке';
COMMENT ON COLUMN purchase_product.price_per_item IS 'Цена за единицу товара на момент покупки (для фиксации цены)';


CREATE TABLE review (
  id bigserial PRIMARY KEY,
  client_id bigint NOT NULL,
  product_id bigint NOT NULL,
  grade int NOT NULL,
  text text,
  data date NOT NULL
);
-- Комментарии к таблице "Отзыв"
COMMENT ON TABLE review IS 'Таблица для хранения отзывов клиентов о товарах';
COMMENT ON COLUMN review.id IS 'PRIMARY KEY. ID отзыва';
COMMENT ON COLUMN review.client_id IS 'FOREIGN KEY. ID клиента';
COMMENT ON COLUMN review.product_id IS 'FOREIGN KEY. ID товара';
COMMENT ON COLUMN review.grade IS 'Оценка товара (1-5)';
COMMENT ON COLUMN review.text IS 'Текст отзыва';
COMMENT ON COLUMN review.data IS 'Дата отзыва';


-- 2. Добавляем связи (FOREIGN KEYS) и проверки
ALTER TABLE discount_card
  ADD CONSTRAINT fk_discount_card_level FOREIGN KEY (level_id) REFERENCES discount_level(level_id);

ALTER TABLE client
  ADD CONSTRAINT fk_client_discount_card FOREIGN KEY (discount_card_id) REFERENCES discount_card(discount_card_id),
  ADD CONSTRAINT uq_client_email UNIQUE (email), -- email должен быть уникальны
  ADD CONSTRAINT uq_client_passport UNIQUE (passport); -- Пасспорт должен быть уникальным

ALTER TABLE purchase
  ADD CONSTRAINT fk_purchase_client FOREIGN KEY (client_id) REFERENCES client(client_id);

ALTER TABLE transaction
  ADD CONSTRAINT fk_transaction_purchase FOREIGN KEY (purchase_id) REFERENCES purchase(purchase_id);

ALTER TABLE product
  ADD CONSTRAINT fk_product_supplier FOREIGN KEY (supplier_id) REFERENCES supplier(supplier_id),
  ADD CONSTRAINT chk_product_price CHECK (price >= 0); -- Цена не может быть отрицательной

ALTER TABLE warehouse_product
  ADD CONSTRAINT fk_warehouse_product_warehouse FOREIGN KEY (warehouse_id) REFERENCES warehouse(warehouse_id),
  ADD CONSTRAINT fk_warehouse_product_product FOREIGN KEY (product_id) REFERENCES product(product_id),
  ADD CONSTRAINT chk_warehouse_quantity CHECK (quantity >= 0); -- Количество товара на складе, не может быть отрицательным

ALTER TABLE product_category_prod
  ADD CONSTRAINT fk_prod_cat_prod_category FOREIGN KEY (product_category_id) REFERENCES product_category(product_category_id),
  ADD CONSTRAINT fk_prod_cat_prod_product FOREIGN KEY (product_id) REFERENCES product(product_id);

ALTER TABLE employee
  ADD CONSTRAINT fk_employee_post FOREIGN KEY (post_id) REFERENCES post(post_id),
  ADD CONSTRAINT chk_employee_hire_date CHECK (hire_date <= CURRENT_DATE), -- Дата устройства не может быть в будущем
  ADD CONSTRAINT uq_employee_email UNIQUE (email), -- email должен быть уникальным
  ADD CONSTRAINT uq_employee_passport  UNIQUE (passport); -- Пасспорт должен быть уникальным

ALTER TABLE purchase_employee
  ADD CONSTRAINT fk_purchase_employee_purchase FOREIGN KEY (purchase_id) REFERENCES purchase(purchase_id),
  ADD CONSTRAINT fk_purchase_employee_employee FOREIGN KEY (employee_id) REFERENCES employee(employee_id);

ALTER TABLE purchase_product
  ADD CONSTRAINT fk_purchase_product_purchase FOREIGN KEY (purchase_id) REFERENCES purchase(purchase_id),
  ADD CONSTRAINT fk_purchase_product_product FOREIGN KEY (product_id) REFERENCES product(product_id);
  ADD CONSTRAINT chk_purchase_product_quantity CHECK (quantity > 0), -- В чеке не может быть 0 товаров
  ADD CONSTRAINT chk_purchase_product_price CHECK (price_per_item >= 0); -- Цена не может быть отрицательной

ALTER TABLE review
  ADD CONSTRAINT fk_review_client FOREIGN KEY (client_id) REFERENCES client(client_id),
  ADD CONSTRAINT fk_review_product FOREIGN KEY (product_id) REFERENCES product(product_id),
  ADD CONSTRAINT chk_review_grade CHECK (grade BETWEEN 1 AND 5); -- Оценка отзыва может быть только от 1 до 5 звезд
