CREATE TABLE products (
    product_id NUMBER PRIMARY KEY,
    product_name VARCHAR2(100),
    category VARCHAR2(50),
    price NUMBER(10,2),
    cost_price NUMBER(10,2)
);

CREATE TABLE sales (
    sale_id NUMBER PRIMARY KEY,
    product_id NUMBER REFERENCES products(product_id),
    quantity NUMBER,
    sale_date DATE
);



INSERT INTO sales VALUES
(1, 101, 2, DATE '2026-10-01');

INSERT INTO sales VALUES
(2, 102, 3, DATE '2026-10-01');

INSERT INTO sales VALUES
(3, 103, 5, DATE '2026-10-02');

INSERT INTO sales VALUES
(4, 104, 4, DATE '2026-10-02');

INSERT INTO sales VALUES
(5, 105, 2, DATE '2026-10-03');

INSERT INTO sales VALUES
(6, 101, 1, DATE '2026-10-03');

INSERT INTO sales VALUES
(7, 102, 2, DATE '2026-10-04');

INSERT INTO sales VALUES
(8, 103, 3, DATE '2026-10-04');

INSERT INTO sales VALUES
(9, 104, 6, DATE '2026-10-05');

INSERT INTO sales VALUES
(10, 105, 4, DATE '2026-10-05');

COMMIT;


-- Verify the data
SELECT * FROM products;
SELECT * FROM sales;



CREATE OR REPLACE FUNCTION get_product_price(
    p_product_id IN NUMBER
)
RETURN NUMBER
IS
    v_price NUMBER;
BEGIN
    SELECT price
    INTO v_price
    FROM products
    WHERE product_id = p_product_id;

    RETURN v_price;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN NULL;
END;
/

SELECT get_product_price(102) AS price FROM dual;


CREATE OR REPLACE FUNCTION get_product_category(
    p_product_id IN NUMBER
)
RETURN VARCHAR2
IS
    v_category VARCHAR2(50);
BEGIN
    SELECT category
    INTO v_category
    FROM products
    WHERE product_id = p_product_id;

    RETURN v_category;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN 'Not Found';
END;
/

SELECT get_product_category(103) AS category FROM dual;



CREATE OR REPLACE FUNCTION get_product_profit(
    p_product_id IN NUMBER
)
RETURN NUMBER
IS
    v_profit NUMBER;
BEGIN
    SELECT price - cost_price
    INTO v_profit
    FROM products
    WHERE product_id = p_product_id;

    RETURN v_profit;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN NULL;
END;
/

SELECT get_product_profit(101) AS profit FROM dual;


CREATE OR REPLACE FUNCTION get_total_products
RETURN NUMBER
IS
    v_count NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO v_count
    FROM products;

    RETURN v_count;
END;
/

SELECT get_total_products() AS total_products FROM dual;



CREATE OR REPLACE FUNCTION get_total_quantity
RETURN NUMBER
IS
    v_quantity NUMBER;
BEGIN
    SELECT NVL(SUM(quantity), 0)
    INTO v_quantity
    FROM sales;

    RETURN v_quantity;
END;
/

SELECT get_total_quantity() AS total_quantity FROM dual;


CREATE OR REPLACE FUNCTION get_product_quantity(
    p_product_id IN NUMBER
)
RETURN NUMBER
IS
    v_quantity NUMBER;
BEGIN
    SELECT NVL(SUM(quantity), 0)
    INTO v_quantity
    FROM sales
    WHERE product_id = p_product_id;

    RETURN v_quantity;
END;
/

SELECT get_product_quantity(101) AS total_quantity
FROM dual;


CREATE OR REPLACE FUNCTION get_product_revenue(
    p_product_id IN NUMBER
)
RETURN NUMBER
IS
    v_revenue NUMBER;
BEGIN
    SELECT NVL(SUM(s.quantity * p.price), 0)
    INTO v_revenue
    FROM sales s
    JOIN products p
      ON s.product_id = p.product_id
    WHERE s.product_id = p_product_id;

    RETURN v_revenue;
END;
/

SELECT get_product_revenue(101) AS revenue FROM dual;



CREATE OR REPLACE FUNCTION get_total_revenue
RETURN NUMBER
IS
    v_revenue NUMBER;
BEGIN
    SELECT NVL(SUM(s.quantity * p.price), 0)
    INTO v_revenue
    FROM sales s
    JOIN products p
      ON s.product_id = p.product_id;

    RETURN v_revenue;
END;
/

SELECT get_total_revenue() AS total_revenue FROM dual;



CREATE OR REPLACE FUNCTION get_total_profit
RETURN NUMBER
IS
    v_profit NUMBER;
BEGIN
    SELECT NVL(
        SUM(s.quantity * (p.price - p.cost_price)), 0
    )
    INTO v_profit
    FROM sales s
    JOIN products p
      ON s.product_id = p.product_id;

    RETURN v_profit;
END;
/
SELECT get_total_profit() AS gross_profit FROM dual;



CREATE OR REPLACE FUNCTION get_average_price
RETURN NUMBER
IS
    v_avg NUMBER;
BEGIN
    SELECT ROUND(AVG(price), 2)
    INTO v_avg
    FROM products;

    RETURN v_avg;
END;
/

SELECT get_average_price() AS average_price FROM dual;


CREATE OR REPLACE FUNCTION get_max_price
RETURN NUMBER
IS
    v_max NUMBER;
BEGIN
    SELECT MAX(price)
    INTO v_max
    FROM products;

    RETURN v_max;
END;
/

SELECT get_max_price() AS maximum_price FROM dual;


CREATE OR REPLACE FUNCTION get_min_price
RETURN NUMBER
IS
    v_min NUMBER;
BEGIN
    SELECT MIN(price)
    INTO v_min
    FROM products;

    RETURN v_min;
END;
/

SELECT get_min_price() AS minimum_price FROM dual;



CREATE OR REPLACE FUNCTION get_daily_revenue(
    p_date IN DATE
)
RETURN NUMBER
IS
    v_revenue NUMBER;
BEGIN
    SELECT NVL(SUM(s.quantity * p.price), 0)
    INTO v_revenue
    FROM sales s
    JOIN products p
      ON s.product_id = p.product_id
    WHERE s.sale_date >= TRUNC(p_date)
      AND s.sale_date < TRUNC(p_date) + 1;

    RETURN v_revenue;
END;
/

SELECT get_daily_revenue(
    DATE '2026-10-01'
) AS daily_revenue
FROM dual;


CREATE OR REPLACE FUNCTION check_price_category(
    p_product_id IN NUMBER
)
RETURN VARCHAR2
IS
    v_price NUMBER;
BEGIN
    SELECT price
    INTO v_price
    FROM products
    WHERE product_id = p_product_id;

    IF v_price >= 20000 THEN
        RETURN 'EXPENSIVE';
    ELSIF v_price >= 5000 THEN
        RETURN 'MEDIUM';
    ELSE
        RETURN 'LOW COST';
    END IF;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN 'PRODUCT NOT FOUND';
END;
/

SELECT check_price_category(101) AS price_category
FROM dual;


SELECT
    product_id,
    product_name,
    price,
    get_product_profit(product_id) AS unit_profit,
    get_product_quantity(product_id) AS units_sold,
    get_product_revenue(product_id) AS revenue,
    check_price_category(product_id) AS price_category
FROM products
ORDER BY product_id;


SELECT
    get_total_products() AS total_products,
    get_total_quantity() AS total_units,
    get_total_revenue() AS total_revenue,
    get_total_profit() AS gross_profit,
    get_average_price() AS average_price
FROM dual;
