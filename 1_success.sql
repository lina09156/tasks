-- ЗАДАНИЕ 1
DROP TABLE IF EXISTS access_cards CASCADE;
DROP TABLE IF EXISTS employees CASCADE;

CREATE TABLE employees (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY, 
    full_name TEXT NOT NULL CHECK (full_name <> '')
);

CREATE TABLE access_cards (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY, 
    employee_id INT UNIQUE NOT NULL, 
    card_number TEXT NOT NULL CHECK (card_number <> ''), 
    FOREIGN KEY (employee_id) REFERENCES employees(id)
);

INSERT INTO employees(full_name) VALUES ('Алина Рымарева'), ('Эвелина Хасанова');
INSERT INTO access_cards(employee_id, card_number) VALUES (1, 'A-001'), (2, 'A-002');

SELECT e.full_name, a.card_number 
FROM employees e 
JOIN access_cards a ON e.id = a.employee_id;

CREATE VIEW employee_access_cards AS 
SELECT employees.full_name AS name, access_cards.card_number AS card 
FROM employees 
JOIN access_cards ON employees.id = access_cards.employee_id;

SELECT * FROM employee_access_cards;


-- ЗАДАНИЕ 2
DROP TABLE IF EXISTS employees CASCADE;
DROP TABLE IF EXISTS departments CASCADE;

CREATE TABLE departments (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY, 
    name TEXT NOT NULL CHECK (name <> '')
);

CREATE TABLE employees (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY, 
    full_name TEXT NOT NULL CHECK (full_name <> ''), 
    department_id INT NOT NULL, 
    FOREIGN KEY (department_id) REFERENCES departments(id) ON DELETE RESTRICT
);

INSERT INTO departments(name) VALUES ('IT'), ('HR');
INSERT INTO employees(full_name, department_id) VALUES ('Алина Рымарева', 1), ('Эвелина Хасанова', 2);

SELECT e.full_name, d.name AS department 
FROM employees e 
JOIN departments d ON e.department_id = d.id;

CREATE VIEW department_employees AS 
SELECT employees.full_name AS name, departments.name AS department 
FROM employees 
JOIN departments ON employees.department_id = departments.id;

SELECT * FROM department_employees;

SELECT e.full_name, d.name AS department 
FROM employees e 
JOIN departments d ON e.department_id = d.id 
WHERE d.name = 'IT';

UPDATE employees SET department_id = 2 WHERE id = 1;

SELECT e.full_name, d.name AS department 
FROM employees e 
JOIN departments d ON e.department_id = d.id;


-- ЗАДАНИЕ 3
DROP TABLE IF EXISTS enrollments CASCADE;
DROP TABLE IF EXISTS courses CASCADE;
DROP TABLE IF EXISTS students CASCADE;

CREATE TABLE students (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY, 
    full_name TEXT NOT NULL CHECK (full_name <> '')
);

CREATE TABLE courses (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY, 
    title TEXT NOT NULL CHECK (title <> '')
);

CREATE TABLE enrollments (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY, 
    student_id INT NOT NULL, 
    course_id INT NOT NULL, 
    enrollment_date DATE NOT NULL, 
    status TEXT NOT NULL CHECK (status IN ('active', 'completed', 'dropped')), 
    UNIQUE (student_id, course_id), 
    FOREIGN KEY (student_id) REFERENCES students(id), 
    FOREIGN KEY (course_id) REFERENCES courses(id)
);

INSERT INTO students(full_name) VALUES ('Амир Алимгулов'), ('Павел Егоров');
INSERT INTO courses(title) VALUES ('Математика'), ('Физика');
INSERT INTO enrollments(student_id, course_id, enrollment_date, status) 
VALUES (1, 1, '2026-09-01', 'active'), 
       (1, 2, '2026-09-01', 'active'), 
       (2, 1, '2026-09-02', 'active');

SELECT s.full_name, c.title 
FROM students s 
JOIN enrollments e ON s.id = e.student_id 
JOIN courses c ON e.course_id = c.id;

SELECT s.full_name, c.title 
FROM students s 
JOIN enrollments e ON s.id = e.student_id 
JOIN courses c ON e.course_id = c.id 
WHERE c.title = 'Математика';

CREATE VIEW student_courses AS 
SELECT students.full_name AS name, courses.title AS course 
FROM students 
JOIN enrollments ON students.id = enrollments.student_id 
JOIN courses ON enrollments.course_id = courses.id;

SELECT * FROM student_courses;

DELETE FROM enrollments WHERE student_id = 1 AND course_id = 2;

SELECT s.full_name, c.title 
FROM students s 
JOIN enrollments e ON s.id = e.student_id 
JOIN courses c ON e.course_id = c.id;

UPDATE enrollments SET status = 'completed' WHERE student_id = 2 AND course_id = 1;
SELECT * FROM enrollments WHERE status = 'completed';


-- ЗАДАНИЕ 4
DROP TABLE IF EXISTS rentals CASCADE;
DROP TABLE IF EXISTS rental_points CASCADE;
DROP TABLE IF EXISTS bikes CASCADE;
DROP TABLE IF EXISTS clients CASCADE;

CREATE TABLE clients (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY, 
    full_name TEXT NOT NULL CHECK (full_name <> '')
);

CREATE TABLE bikes (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY, 
    model TEXT NOT NULL CHECK (model <> '')
);

CREATE TABLE rental_points (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY, 
    name TEXT NOT NULL CHECK (name <> '')
);

CREATE TABLE rentals (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY, 
    client_id INT NOT NULL, 
    bike_id INT NOT NULL, 
    point_id INT NOT NULL, 
    start_date DATE NOT NULL, 
    end_date DATE, 
    FOREIGN KEY (client_id) REFERENCES clients(id), 
    FOREIGN KEY (bike_id) REFERENCES bikes(id), 
    FOREIGN KEY (point_id) REFERENCES rental_points(id)
);

INSERT INTO clients(full_name) VALUES ('Елизавета Петрухан'), ('Сайфуллин Тимур');
INSERT INTO bikes(model) VALUES ('Stels Navigator'), ('Merida Matts');
INSERT INTO rental_points(name) VALUES ('Пункт А'), ('Пункт Б');
INSERT INTO rentals(client_id, bike_id, point_id, start_date, end_date) 
VALUES (1, 1, 1, '2026-01-01', '2026-01-05'), 
       (2, 2, 2, '2026-01-02', NULL);

SELECT c.full_name, b.model, r.start_date, r.end_date 
FROM rentals r 
JOIN clients c ON r.client_id = c.id 
JOIN bikes b ON r.bike_id = b.id;

SELECT c.full_name, b.model, r.start_date, r.end_date 
FROM rentals r 
JOIN clients c ON r.client_id = c.id 
JOIN bikes b ON r.bike_id = b.id 
WHERE c.full_name = 'Елизавета Петрухан';

CREATE VIEW rental_details AS 
SELECT clients.full_name AS client, bikes.model AS bike, rentals.start_date AS start_date, rentals.end_date AS end_date 
FROM rentals 
JOIN clients ON rentals.client_id = clients.id 
JOIN bikes ON rentals.bike_id = bikes.id;

SELECT * FROM rental_details;


CREATE VIEW employee_access_cards AS 
SELECT employees.full_name AS name, access_cards.card_number AS card 
FROM employees 
JOIN access_cards ON employees.id = access_cards.employee_id;


SELECT 'Задание 1: Пропуска' AS info, name::text AS col1, card::text AS col2 FROM employee_access_cards
UNION ALL
SELECT 'Задание 2: Отделы', name::text, department::text FROM department_employees
UNION ALL
SELECT 'Задание 3: Курсы', name::text, course::text FROM student_courses
UNION ALL
SELECT 'Задание 4: Аренда', client::text, bike::text FROM rental_details;
