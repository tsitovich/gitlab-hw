-- 1. Справочник должностей
CREATE TABLE positions (
    position_id SERIAL PRIMARY KEY,
    position_name VARCHAR(100) UNIQUE NOT NULL
);

-- 2. Справочник типов подразделений
CREATE TABLE department_types (
    type_id SERIAL PRIMARY KEY,
    type_name VARCHAR(50) UNIQUE NOT NULL
);

-- 3. Филиалы компании (включая регион, город и адрес)
CREATE TABLE branches (
    branch_id SERIAL PRIMARY KEY,
    region_name VARCHAR(100) NOT NULL,
    city_name VARCHAR(100) NOT NULL,
    street_address VARCHAR(150) NOT NULL,
    UNIQUE (region_name, city_name, street_address)
);

-- 4. Структурные подразделения
CREATE TABLE departments (
    department_id SERIAL PRIMARY KEY,
    department_name VARCHAR(150) NOT NULL,
    type_id INTEGER NOT NULL REFERENCES department_types(type_id) ON DELETE RESTRICT,
    branch_id INTEGER NOT NULL REFERENCES branches(branch_id) ON DELETE RESTRICT
);

-- 5. Сотрудники
CREATE TABLE employees (
    employee_id SERIAL PRIMARY KEY,
    full_name VARCHAR(150) NOT NULL,
    salary NUMERIC(10, 2) NOT NULL CHECK (salary > 0),
    hire_date DATE NOT NULL,
    position_id INTEGER NOT NULL REFERENCES positions(position_id) ON DELETE RESTRICT,
    department_id INTEGER NOT NULL REFERENCES departments(department_id) ON DELETE RESTRICT
);

-- 6. Справочник проектов
CREATE TABLE projects (
    project_id SERIAL PRIMARY KEY,
    project_name VARCHAR(200) UNIQUE NOT NULL
);

-- 7. Связь сотрудников и проектов (многие ко многим)
CREATE TABLE employee_projects (
    employee_id INTEGER NOT NULL REFERENCES employees(employee_id) ON DELETE CASCADE,
    project_id INTEGER NOT NULL REFERENCES projects(project_id) ON DELETE CASCADE,
    PRIMARY KEY (employee_id, project_id)
);
