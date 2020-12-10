-- a) Decrease interest rate to 10% for all saving accounts whose opening date is from 01/09/2020.
CREATE OR REPLACE PROCEDURE PROB_A()
    LANGUAGE plpgsql
    AS $$
    BEGIN
        UPDATE Saving_account
        SET insrate = 10
        WHERE (date >= '01/09/2020'::DATE) AND (insrate > 10)
        ;
    END;
    $$;

CALL PROB_A();

-- b)
SELECT r.code customer_code, r.fname customer_first_name, r.lname customer_last_name, r.number account_number, 
	   sa.date saving_account_date, sa.balance saving_account_balance, sa.date saving_account_insrate, 
	   ca.date check_account_date, ca.balance check_account_balance, 
	   l.date loan_account_date, l.balance loan_account_balance, l.date loan_account_insrate
FROM (SELECT code, fname, lname, number
	  FROM Customer c
	  JOIN Account a
	  ON c.code = a.cust_code
	  WHERE c.fname = 'Nguyen Van' and c.lname = 'A'
	  ) r
LEFT JOIN CHECKING_ACCOUNT ca
ON r.number = ca.number
LEFT JOIN SAVING_ACCOUNT sa
ON r.number = sa.number
LEFT JOIN LOAN l
on r.number = l.number
;

-- c)
CREATE OR REPLACE FUNCTION PROB_C
    (
        p_cust_code CUSTOMER.code%TYPE
    )
    RETURNS TABLE 
    (
        saving_account_balance NUMERIC, 
        check_account_balance NUMERIC, 
        loan_account_balance NUMERIC
    )
    LANGUAGE plpgsql
    AS $$
    BEGIN 
        RETURN QUERY
            SELECT SUM(sa.balance), SUM(ca.balance), SUM(l.balance)
            FROM (SELECT code, fname, lname, number, acc_type_code
                    FROM Customer c
                    JOIN Account a
                    ON c.code = a.cust_code
                    WHERE c.code = p_cust_code
                    ) r
            LEFT JOIN CHECKING_ACCOUNT ca
            ON r.number = ca.number
            LEFT JOIN SAVING_ACCOUNT sa
            ON r.number = sa.number
            LEFT JOIN LOAN l
            on r.number = l.number
            GROUP BY acc_type_code
            ;
    END; 
    $$;

SELECT TOTAL_BALANCE_FOR_EACH_ACCOUNT_TYPE('cus0009');

-- d)
CREATE OR REPLACE FUNCTION PROB_D
    (
        p_start_date    DATE,
        p_end_date      DATE
    )
    RETURNS TABLE
    (
        code            Employee.code%TYPE,
        fname           Employee.fname%TYPE,
        lname           Employee.lname%TYPE,
        email           Employee.email%TYPE,
        addressno       Employee.addressno%TYPE,
        street          Employee.street%TYPE,
        district        Employee.district%TYPE,
	    city            Employee.city%TYPE,
	    dob             Employee.dob%TYPE,
	    branch_name     Employee.branch_name%TYPE,
        num_cust_serve  BIGINT
    )
    LANGUAGE plpgsql
    AS $$
    BEGIN
        RETURN QUERY
            SELECT e.code, e.fname, e.lname, e.email,
                   e.addressno, e.street, e.district,
                   e.city, e.dob, e.branch_name, COUNT(c.code)
            FROM Employee e LEFT JOIN Customer c
            ON e.code = c.emp_code AND (c.serve_date BETWEEN p_start_date AND p_end_date)
            GROUP BY e.code
            ORDER BY COUNT(c.code) DESC
            ;
    END;
    $$;

SELECT * FROM PROB_D('10/10/2016'::DATE, NOW()::DATE);