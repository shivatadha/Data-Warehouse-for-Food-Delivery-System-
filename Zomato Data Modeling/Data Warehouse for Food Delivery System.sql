-- Create datetime_dim_tb table
CREATE TABLE datetime_dim_tb (
    datetime_id INT PRIMARY KEY,
    date DATE,
    day_of_week VARCHAR(20),
    week_number INT,
    month INT,
    quarter INT,
    year INT
);

-- Create customer_dim_tbl table
CREATE TABLE customer_dim_tbl (
    customer_id INT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100),
    phone VARCHAR(20),
    address VARCHAR(255)
);

-- Create menu_dim_tbl table
CREATE TABLE menu_dim_tbl (
    item_id INT PRIMARY KEY,
    restaurant_id INT,
    item_name VARCHAR(100),
    price DECIMAL(10, 2),
    available BOOLEAN,
    availability_status VARCHAR(50),
    FOREIGN KEY (restaurant_id) REFERENCES restaurant_dim_tbl(restaurant_id)
);

-- Create restaurant_dim_tbl table
CREATE TABLE restaurant_dim_tbl (
    restaurant_id INT PRIMARY KEY,
    geo_id INT,
    restaurant_name VARCHAR(100),
    address VARCHAR(255),
    opened_on DATE,
    open_time TIME,
    close_time TIME,
    FOREIGN KEY (geo_id) REFERENCES geography_dim_tbl(geo_id)
);

-- Create geography_dim_tbl table
CREATE TABLE geography_dim_tbl (
    geo_id INT PRIMARY KEY,
    city VARCHAR(100),
    state VARCHAR(100),
    country VARCHAR(100),
    region VARCHAR(100),
    latitude DECIMAL(9, 6),
    longitude DECIMAL(9, 6)
);

-- Create delivery table
CREATE TABLE delivery (
    delivery_id INT PRIMARY KEY,
    order_id INT,
    delivery_person_id INT,
    delivery_status VARCHAR(50),
    estimated_delivery_time TIMESTAMP,
    actual_delivery_time TIMESTAMP,
    delivery_delay INT,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (delivery_person_id) REFERENCES delivery_person_dim_tbl(delivery_person_id)
);

-- Create delivery_person_dim_tbl table
CREATE TABLE delivery_person_dim_tbl (
    delivery_person_id INT PRIMARY KEY,
    time_id INT,
    name VARCHAR(100),
    age INT,
    sex VARCHAR(10),
    salary DECIMAL(10, 2),
    home_address VARCHAR(255),
    vehicle_registered_number VARCHAR(20),
    available BOOLEAN,
    availability_status VARCHAR(50),
    FOREIGN KEY (time_id) REFERENCES datetime_dim_tb(datetime_id)
);

-- Create promotion_dim_tbl table
CREATE TABLE promotion_dim_tbl (
    promotion_id INT PRIMARY KEY,
    restaurant_id INT,
    discount_value DECIMAL(10, 2),
    validity_period INT,
    FOREIGN KEY (restaurant_id) REFERENCES restaurant_dim_tbl(restaurant_id)
);

-- Create review_dim_tbl table
CREATE TABLE review_dim_tbl (
    review_id INT PRIMARY KEY,
    order_id INT,
    customer_id INT,
    review_text TEXT,
    rating_category VARCHAR(50),
    star INT,
    review_source VARCHAR(50),
    created_at TIMESTAMP,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (customer_id) REFERENCES customer_dim_tbl(customer_id)
);

-- Create Orders table
CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    promotion_id INT,
    review_id INT,
    restaurant_id INT,
    time_id INT,
    geo_id INT,
    order_date_time TIMESTAMP,
    delivery_address VARCHAR(255),
    total_amount DECIMAL(10, 2),
    discount_amount DECIMAL(10, 2),
    net_amount DECIMAL(10, 2),
    order_status VARCHAR(50),
    payment_method VARCHAR(50),
    delivery_id INT,
    FOREIGN KEY (customer_id) REFERENCES customer_dim_tbl(customer_id),
    FOREIGN KEY (promotion_id) REFERENCES promotion_dim_tbl(promotion_id),
    FOREIGN KEY (review_id) REFERENCES review_dim_tbl(review_id),
    FOREIGN KEY (restaurant_id) REFERENCES restaurant_dim_tbl(restaurant_id),
    FOREIGN KEY (time_id) REFERENCES datetime_dim_tb(datetime_id),
    FOREIGN KEY (geo_id) REFERENCES geography_dim_tbl(geo_id),
    FOREIGN KEY (delivery_id) REFERENCES delivery(delivery_id)
);

-- Create menu_audit table
CREATE TABLE menu_audit (
    audit_id INT PRIMARY KEY,
    item_id INT,
    old_price DECIMAL(10, 2),
    new_price DECIMAL(10, 2),
    change_date TIMESTAMP,
    FOREIGN KEY (item_id) REFERENCES menu_dim_tbl(item_id)
);

-- Create promotion_audit table
CREATE TABLE promotion_audit (
    audit_id INT PRIMARY KEY,
    promotion_id INT,
    old_discount DECIMAL(10, 2),
    new_discount DECIMAL(10, 2),
    change_date TIMESTAMP,
    FOREIGN KEY (promotion_id) REFERENCES promotion_dim_tbl(promotion_id)
);

-- Create delivery_person_audit table
CREATE TABLE delivery_person_audit (
    audit_id INT PRIMARY KEY,
    delivery_person_id INT,
    old_salary DECIMAL(10, 2),
    new_salary DECIMAL(10, 2),
    change_date TIMESTAMP,
    FOREIGN KEY (delivery_person_id) REFERENCES delivery_person_dim_tbl(delivery_person_id)
);