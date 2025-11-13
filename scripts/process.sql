-- Процедура возврата товара. С проверкой на факта покупки и созданием транзакции с отрицательной суммой. 
-- Запускает транзакцию и если любой из шагов завершится с ошибкой, все изменения будут отменены.

CREATE OR REPLACE PROCEDURE sp_process_product_return(
    p_purchase_id INT,
    p_product_id INT,
    p_return_quantity INT
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_price_per_item    NUMERIC;
    v_refund_amount     NUMERIC;
    v_main_warehouse_id INT := 1; -- Все возвраты на склад 1
BEGIN
    SELECT
        price_per_item
    INTO
        v_price_per_item
    FROM
        purchase_product
    WHERE
        purchase_id = p_purchase_id AND product_id = p_product_id;

    -- Проверка на факт покупки
    IF NOT FOUND THEN
        RAISE EXCEPTION 'Товар с ID % не найден в покупке с ID %.', p_product_id, p_purchase_id;
    END IF;

    v_refund_amount := v_price_per_item * p_return_quantity;

    -- Отрицательная транзакция
    INSERT INTO transaction (purchase_id, summ, data, type)
    VALUES (p_purchase_id, -v_refund_amount, NOW(), 'возврат');

    UPDATE warehouse_product
    SET quantity = quantity + p_return_quantity
    WHERE product_id = p_product_id AND warehouse_id = v_main_warehouse_id;

    IF NOT FOUND THEN
        INSERT INTO warehouse_product (warehouse_id, product_id, quantity)
        VALUES (v_main_warehouse_id, p_product_id, p_return_quantity);
    END IF;

    RAISE NOTICE 'Возврат товара ID % в количестве % на сумму % успешно оформлен.', p_product_id, p_return_quantity, v_refund_amount;
END;
$$;

COMMENT ON PROCEDURE sp_process_product_return IS 'Оформление возврата товара';