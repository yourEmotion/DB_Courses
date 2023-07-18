SELECT
    'member' AS "table",
    count(*) AS amount
FROM
    edu.member

UNION ALL

SELECT
    'field' AS "table",
    count(*) AS amount
FROM
    edu.field
    
UNION ALL

SELECT
    'course' AS "table",
    count(*) AS amount
FROM
    edu.course
    
UNION ALL

SELECT
    'author' AS "table",
    count(*) AS amount
FROM
    edu.author

UNION ALL

SELECT
    'authority' AS "table",
    count(*) AS amount
FROM
    edu.authority
    
UNION ALL

SELECT
    'payment' AS "table",
    count(*) AS amount
FROM
    edu.payment
    
UNION ALL

SELECT
    'registration' AS "table",
    count(*) AS amount
FROM
    edu.registration
    
UNION ALL

SELECT
    'feedback' AS "table",
    count(*) AS amount
FROM
    edu.feedback;
