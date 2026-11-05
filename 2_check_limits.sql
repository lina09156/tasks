-- ПРОВЕРКА ОГРАНИЧЕНИЙ

-- ЗАДАНИЕ 1
DO $$ 
BEGIN 
    INSERT INTO access_cards(employee_id, card_number) VALUES (1, 'A-003'); 
EXCEPTION WHEN unique_violation THEN 
    RAISE NOTICE 'Ожидаемая ошибка (Задание 1): Алине нельзя выдать второй пропуск'; 
END $$;

-- ЗАДАНИЕ 2
DO $$ 
BEGIN 
    INSERT INTO employees(full_name, department_id) VALUES ('Амир Алимгулов', 99); 
EXCEPTION WHEN foreign_key_violation THEN 
    RAISE NOTICE 'Ожидаемая ошибка (Задание 2): отдел 99 не существует'; 
END $$;

DO $$ 
BEGIN 
    DELETE FROM departments WHERE id = 2; 
EXCEPTION WHEN foreign_key_violation THEN 
    RAISE NOTICE 'Ожидаемая ошибка (Задание 2): нельзя удалить отдел с сотрудниками'; 
END $$;

-- ЗАДАНИЕ 3
DO $$ 
BEGIN 
    INSERT INTO enrollments(student_id, course_id, enrollment_date, status) VALUES (1, 1, '2026-09-01', 'active'); 
EXCEPTION WHEN unique_violation THEN 
    RAISE NOTICE 'Ожидаемая ошибка (Задание 3): Амир уже записан на этот курс'; 
END $$;

DO $$ 
BEGIN 
    INSERT INTO enrollments(student_id, course_id, enrollment_date, status) VALUES (99, 1, '2026-09-01', 'active'); 
EXCEPTION WHEN foreign_key_violation THEN 
    RAISE NOTICE 'Ожидаемая ошибка (Задание 3): студент 99 не существует'; 
END $$;

-- ЗАДАНИЕ 4
DO $$ 
BEGIN 
    INSERT INTO rentals(client_id, bike_id, point_id, start_date, end_date) VALUES (99, 1, 1, '2026-01-10', NULL); 
EXCEPTION WHEN foreign_key_violation THEN 
    RAISE NOTICE 'Ожидаемая ошибка (Задание 4): клиент 99 не существует'; 
END $$;

DO $$ 
BEGIN 
    DELETE FROM clients WHERE id = 1; 
EXCEPTION WHEN foreign_key_violation THEN 
    RAISE NOTICE 'Ожидаемая ошибка (Задание 4): нельзя удалить Елизавету с арендой'; 
END $$;

DO $$ 
BEGIN 
    DELETE FROM bikes WHERE id = 1; 
EXCEPTION WHEN foreign_key_violation THEN 
    RAISE NOTICE 'Ожидаемая ошибка (Задание 4): нельзя удалить велосипед, который в аренде'; 
END $$;
