--Step1 create catalog/Database
CREATE CATALOG IF NOT EXISTS exercise4;

--Step2 create schema 
CREATE SCHEMA IF NOT EXISTS exercise4.joins;

--Step3  create the table TABLE1 USERS
CREATE TABLE IF NOT EXISTS exercise4.joins.users_table(user_id INT,user_name STRING,country STRING);

--Step 4 Insert the information into the table 
INSERT INTO exercise4.joins.users_table VALUES(1,'Nomvula','Johannesburg'),
(2,'David','Cape Town'),
(3,'Anele','Durban'),
(4,'Kabelo','Pretoria'),
(5,'Lerato','Port Elizabeth');

--Step5 check if you put the correct information
SELECT*
FROM exercise4.joins.users_table;


--Create schema for TABLE2 PLANS
CREATE SCHEMA IF NOT EXISTS exercise4.joins;

CREATE TABLE IF NOT EXISTS exercise4.joins.plans_table(plan_id INT,plan_name STRING,monthly_price INT);

INSERT INTO exercise4.joins.plans_table VALUES
(10,'Basic',79),
(11,'Standard',129),
(12,'Premium',199),
(13,'Family',249),
(14,'Mobile',59);

SELECT*
FROM exercise4.joins.plans_table


--TABLE3 SUBSCRIPTIONS
CREATE TABLE IF NOT EXISTS exercise4.joins.subscriptions_table(subscription_id INT,user_id INT,plan_id INT,start_date DATE);

INSERT INTO exercise4.joins.subscriptions_table VALUES
(501,1,10,'2026-01-15'),
(502,2,11,'2026-02-01'),
(503,1,12,'2026-03-10'),
(504,6,11,'2026-03-20'),
(505,3,13,'2026-04-05');

SELECT*
FROM exercise4.joins.subscriptions_table;

TABLE4 SHOWS

CREATE TABLE IF NOT EXISTS exercise4.joins.shows_table(show_id INT,show_title STRING,genre STRING);

INSERT INTO exercise4.joins.shows_table VALUES
(701,'Comedy Hour','Comedy'),
(702,'Crime Time','Drama'),
(703,'Tech Tales','Documentary'),
(704,'Cooking Lab','Lifestyle'),
(706,'Wild Earth','Documentary');

SELECT*
FROM exercise4.joins.shows_table;


--TABLE5 VIEWING_SESSIONS
CREATE TABLE IF NOT EXISTS exercise4.joins.viewing_sessions_table(session_id INT,user_id INT,show_id INT,watch_minutes INT);
INSERT INTO exercise4.joins.viewing_sessions_table VALUES
(901,1,701,45),
(902,2,703,30),
(903,1,702,60),
(904,7,701,20),
(905,3,705,90);

SELECT*
FROM exercise4.joins.viewing_sessions_table;

--QUESTION1:Show every user who has a subscriptions.Match users to subscriptions

SELECT A.user_id,
user_name,
B.subscription_id,
start_date
FROM exercise4.joins.users_table AS A 
INNER JOIN exercise4.joins.subscriptions_table AS B
ON A.user_id=B.user_id;

--QUESTION2:Show every subscription with it matching plan name and monthly price.

SELECT A.subscription_id,
A.user_id,
plan_name,
monthly_price
FROM exercise4.joins.subscriptions_table AS A
INNER JOIN exercise4.joins.plans_table AS B
ON A.plan_id=B.plan_id;

--QUESTION3:Show every viewing session that has a matching show.Include the show title and genre

SELECT A.session_id,
A.user_id,
B.show_title,
B.genre,
watch_minutes
FROM exercise4.joins.viewing_sessions_table AS A
INNER JOIN exercise4.joins.shows_table AS B
ON A.show_id=B.show_id;

--QUESTION4:Show every viewing session with the user who watched it.Only show session with matching user

SELECT B.user_name,
country,
A.session_id,
A.show_id,
watch_minutes
FROM exercise4.joins.viewing_sessions_table AS A
INNER JOIN exercise4.joins.users_table AS B 
ON A.user_id=B.user_id;

--QUESTION5:Show users alongwith their subscriptions ,the plan name, and the price.
SELECT A.user_name,
country,
C.plan_name,
monthly_price,
start_date
FROM exercise4.joins.users_table AS A
INNER JOIN exercise4.joins.subscriptions_table AS B 
ON A.user_id=B.user_id 
INNER JOIN exercise4.joins.plans_table AS C
ON B.plan_id=C.plan_id;

--QUESTION6:Show every user and any subscriptions they have.Users without subscription must still appear

SELECT A.user_id,
user_name,
B.subscription_id,
start_date
FROM exercise4.joins.users_table AS A
LEFT JOIN exercise4.joins.subscriptions_table AS B
ON A.user_id=B.user_id;

--QUESTION7:Show every plan and the subscriptions on it.Plans with no subscribers must still appear.

SELECT A.plan_id,
plan_name,
subscription_id,
user_id
FROM exercise4.joins.plans_table AS A
LEFT JOIN exercise4.joins.subscriptions_table AS B
ON A.plan_id=B.plan_id;


--QUESTIONS8:Show every show and any viewing sessions on it.Shows that were never watched must still appear
SELECT A.show_id,
show_title,
B.session_id,
watch_minutes
FROM exercise4.joins.shows_table AS A 
LEFT JOIN exercise4.joins.viewing_sessions_table AS B 
ON A.show_id =B.show_id; 

--QUESTION9:Show every viewing session and the user who watched it.
--Sessions referencing users that do not exists must still appear (with NULL user details)

SELECT A.session_id,
show_id,
watch_minutes,
B.user_id,
user_name
FROM exercise4.joins.viewing_sessions_table AS A
LEFT JOIN exercise4.joins.users_table AS B 
ON A.user_id=B.user_id;


--QUESTION10:Show every user the plan they are on(if any),and the monthly price .
--Users without a subcription must still appear
SELECT A.user_name,
country,
C.plan_name, 
C.monthly_price
FROM exercise4.joins.users_table AS A 
LEFT JOIN exercise4.joins.subscriptions_table AS B
ON A.user_id=B.user_id
LEFT JOIN exercise4.joins.plans_table AS C 
ON B.plan_id=C.plan_id;

--QUESTION11:Show every user and every subscription ,
--including users without subscriptions AND subscription referencing users that do not exists

SELECT A.user_id, 
A.user_name,
subscription_id,
start_date
FROM exercise4.joins.users_table AS A 
FULL JOIN exercise4.joins.subscriptions_table AS B 
ON A.user_id=B.user_id;

--QUESTION12:Subscription referencing a plan that does not exists 

SELECT plans_table.plan_id,
plan_name,
subscription_id,
user_id
FROM exercise4.joins.subscriptions_table 
FULL JOIN exercise4.joins.plans_table
ON subscriptions_table.plan_id=plans_table.plan_id;

--QUESTION13:Show every show and evry viewing session,
--including shows that were never watched AND sessions referencing shows that do not exist

SELECT shows_table.show_id,
show_title,
session_id,
watch_minutes
FROM exercise4.joins.shows_table 
FULL JOIN exercise4.joins.viewing_sessions_table 
ON shows_table.show_id =viewing_sessions_table.show_id;

--QUESTION14:Show every user and every viewing_session,
-- including users with no session AND sessions referencing users who do not exists
SELECT users_table.user_id,
user_name ,
session_id,
show_id,
watch_minutes
FROM exercise4.joins.users_table 
FULL JOIN exercise4.joins.viewing_sessions_table 
ON users_table.user_id=viewing_sessions_table.user_id;

--QUESTION15:Show every user,every subscription,and every plan in one query-using
--FULL OUTER JOIN throughout.This is the hardest question-get all gaps visible at once.
SELECT users_table.user_id,
user_name,
subscription_id,
plans_table.plan_id,
plan_name
FROM exercise4.joins.users_table 
FULL JOIN exercise4.joins.subscriptions_table 
ON users_table.user_id=subscriptions_table.user_id
FULL JOIN exercise4.joins.plans_table 
ON subscriptions_table.plan_id=plans_table.plan_id;

--BONUS QUESTIONS:
--BONUS 01:Which users have not subscribed to any plan?
--ANSWER:Kabelo and Lerato have not subscribed to any plans.

--BONUS 02:Which subscriptions reference that do not exist in the users table?
--ANSWER:SUbscription ID:504/User ID:6.

--BONUS 03:Which shows have never been watched ?
--ANSWER:The Cooking Lab show and Wild Earth have never been watched.

--BONUS 04:Which viewing sessions reference shows that do not exist?
--ANSWER:Show ID:705/ Session ID:905

--BONUS 05:Which plans have no subscribers?
--ANSWER:The mobile plan has no subscribers.
