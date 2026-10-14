CREATE OR REPLACE FUNCTION add_numbers(
    a IN NUMBER,
    b IN NUMBER
)
RETURN NUMBER
IS
BEGIN
    RETURN a + b;
END;
/

SELECT add_numbers(10, 20) AS result FROM dual;
  


CREATE OR REPLACE FUNCTION subtract_numbers(
    a IN NUMBER,
    b IN NUMBER
)
RETURN NUMBER
IS
BEGIN
    RETURN a - b;
END;
/

SELECT subtract_numbers(50, 20) AS result FROM dual;


CREATE OR REPLACE FUNCTION multiply_numbers(
    a IN NUMBER,
    b IN NUMBER
)
RETURN NUMBER
IS
BEGIN
    RETURN a * b;
END;
/

SELECT multiply_numbers(10, 5) AS result FROM dual;


CREATE OR REPLACE FUNCTION divide_numbers(
    a IN NUMBER,
    b IN NUMBER
)
RETURN NUMBER
IS
BEGIN
    IF b = 0 THEN
        RETURN NULL;
    END IF;

    RETURN a / b;
END;
/

SELECT divide_numbers(100, 5) AS result FROM dual;



CREATE OR REPLACE FUNCTION square_number(
    n IN NUMBER
)
RETURN NUMBER
IS
BEGIN
    RETURN n * n;
END;
/

SELECT square_number(6) AS result FROM dual;


CREATE OR REPLACE FUNCTION check_even_odd(
    n IN NUMBER
)
RETURN VARCHAR2
IS
BEGIN
    IF MOD(n, 2) = 0 THEN
        RETURN 'EVEN';
    ELSE
        RETURN 'ODD';
    END IF;
END;
/

SELECT check_even_odd(10) AS result FROM dual;



CREATE OR REPLACE FUNCTION biggest_number(
    a IN NUMBER,
    b IN NUMBER
)
RETURN NUMBER
IS
BEGIN
    IF a > b THEN
        RETURN a;
    ELSE
        RETURN b;
    END IF;
END;
/

SELECT biggest_number(50, 80) AS result FROM dual;



CREATE OR REPLACE FUNCTION calculate_bonus(
    salary IN NUMBER
)
RETURN NUMBER
IS
    v_bonus NUMBER;
BEGIN
    v_bonus := salary * 0.10;

    RETURN v_bonus;
END;
/

SELECT calculate_bonus(50000) AS bonus FROM dual;



CREATE OR REPLACE FUNCTION calculate_gst(
    amount IN NUMBER
)
RETURN NUMBER
IS
BEGIN
    RETURN amount * 0.18;
END;
/

SELECT calculate_gst(1000) AS gst FROM dual;


CREATE OR REPLACE FUNCTION calculate_discount(
    price IN NUMBER,
    discount_percentage IN NUMBER
)
RETURN NUMBER
IS
BEGIN
    RETURN price * discount_percentage / 100;
END;
/

SELECT calculate_discount(2000, 10) AS discount
FROM dual;


CREATE OR REPLACE FUNCTION convert_upper(
    p_text IN VARCHAR2
)
RETURN VARCHAR2
IS
BEGIN
    RETURN UPPER(p_text);
END;
/

SELECT convert_upper('oracle sql') AS result
FROM dual;


CREATE OR REPLACE FUNCTION string_length(
    p_text IN VARCHAR2
)
RETURN NUMBER
IS
BEGIN
    RETURN LENGTH(p_text);
END;
/

SELECT string_length('ORACLE') AS result
FROM dual;


CREATE OR REPLACE FUNCTION combine_names(
    first_name IN VARCHAR2,
    last_name IN VARCHAR2
)
RETURN VARCHAR2
IS
BEGIN
    RETURN first_name || ' ' || last_name;
END;
/

SELECT combine_names('Ravi', 'Kumar') AS full_name
FROM dual;


CREATE OR REPLACE FUNCTION simple_interest(
    principal IN NUMBER,
    rate IN NUMBER,
    years IN NUMBER
)
RETURN NUMBER
IS
BEGIN
    RETURN (principal * rate * years) / 100;
END;
/

SELECT simple_interest(10000, 5, 2) AS interest
FROM dual;


CREATE OR REPLACE FUNCTION check_result(
    marks IN NUMBER
)
RETURN VARCHAR2
IS
BEGIN
    IF marks >= 35 THEN
        RETURN 'PASS';
    ELSE
        RETURN 'FAIL';
    END IF;
END;
/

SELECT check_result(75) AS result FROM dual;



SELECT square_number(add_numbers(10, 20)) AS result
FROM dual;


SELECT
    add_numbers(10, 20) AS addition,
    subtract_numbers(50, 20) AS subtraction,
    multiply_numbers(5, 6) AS multiplication,
    square_number(8) AS square_value,
    calculate_bonus(50000) AS bonus,
    calculate_gst(1000) AS gst
FROM dual;