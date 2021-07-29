
CREATE TABLE backer_levels (
  level_id INT(9) NOT NULL,
  name VARCHAR(40) NOT NULL,
  minimum_pledge DECIMAL (6,2) NOT NULL,
  reward_details VARCHAR(2000) NOT NULL,
  PRIMARY KEY (level_id)
);

CREATE TABLE customer_backer_levels (
  level_id INT(9) NOT NULL,
  customer_id INT(9) NOT NULL,
  backing_date DATE NOT NULL,
  pledge_amount DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (level_id,customer_id),
  CONSTRAINT fk_has_level FOREIGN KEY (level_id)
  REFERENCES backer_levels(level_id),
  CONSTRAINT fk_has_customer FOREIGN KEY (customer_id)
  REFERENCES customers(customer_id)
);

CREATE TABLE customers (
  customer_id INT(9) AUTO_INCREMENT NOT NULL,
  first_name VARCHAR(40) NOT NULL,
  last_name VARCHAR(40) NOT NULL,
  email_address VARCHAR(40) NOT NULL,
  date_of_birth DATE NOT NULL,
  `password` VARCHAR(40) NOT NULL,
  PRIMARY KEY (customer_id),
  CONSTRAINT cus_pass_min6 CHECK (`password` LIKE "%______")
);

CREATE TABLE orders (
  order_id INT(9) AUTO_INCREMENT NOT NULL,
  customer_id INT(9) NOT NULL,
  order_date DATE NOT NULL,
  PRIMARY KEY (order_id),
  CONSTRAINT fk_placed_by FOREIGN KEY (customer_id)
  REFERENCES customers(customer_id)
);

CREATE TABLE order_versions (
  order_id INT(9) NOT NULL,
  version_id INT(9) NOT NULL,
  PRIMARY KEY (order_id,version_id),
  CONSTRAINT fk_has_order FOREIGN KEY (order_id)
  REFERENCES orders(order_id),
  CONSTRAINT fk_has_version FOREIGN KEY (version_id)
  REFERENCES versions(version_id)
);

CREATE TABLE versions (
  version_id INT(9) NOT NULL,
  version_name VARCHAR(40) NOT NULL,
  release_date DATE NOT NULL,
  price DECIMAL(6,2) NOT NULL,
  PRIMARY KEY (version_id)
);

CREATE TABLE employee_versions (
  version_id INT(9) NOT NULL,
  employee_id INT(9) NOT NULL,
  PRIMARY KEY (version_id,employee_id),
  CONSTRAINT fk_assigned_version FOREIGN KEY (version_id)
  REFERENCES versions(version_id),
  CONSTRAINT fk_assigned_employee FOREIGN KEY (employee_id)
  REFERENCES employees(employee_id)
);

CREATE TABLE employees (
  employee_id INT(9) AUTO_INCREMENT NOT NULL,
  first_name VARCHAR(40) NOT NULL,
  last_name VARCHAR(40) NOT NULL,
  date_of_birth DATE NOT NULL,
  phone_number VARCHAR(15) NOT NULL,
  email_address VARCHAR(40) NOT NULL,
  `password` VARCHAR(40) NOT NULL,
  boss_id INT(9) DEFAULT NULL,
  role_id INT(9) NOT NULL,
  PRIMARY KEY (employee_id),
  CONSTRAINT fk_has_boss FOREIGN KEY (boss_id)
  REFERENCES employees(employee_id),
  CONSTRAINT fk_has_role FOREIGN KEY (role_id)
  REFERENCES roles(role_id),
  CONSTRAINT emp_pass_min6 CHECK (`password` like "%______")
);

CREATE TABLE roles (
  role_id INT(9) NOT NULL,
  title VARCHAR(40) NOT NULL,
  salary DECIMAL (10,2) NOT NULL,
  PRIMARY KEY (role_id)
);

CREATE TABLE invoices (
  invoice_id INT(9) AUTO_INCREMENT NOT NULL,
  issue_date DATE NOT NULL,
  order_id INT NOT NULL,
  PRIMARY KEY (invoice_id),
  CONSTRAINT fk_invoice_order FOREIGN KEY(order_id)
  REFERENCES orders(order_id),
  CONSTRAINT unique_order UNIQUE KEY (order_id)
);
