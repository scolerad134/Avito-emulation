--liquibase changeset your_name:1

-- Create users table
CREATE TABLE users (
    id BIGSERIAL PRIMARY KEY,
    email VARCHAR(255) UNIQUE NOT NULL,
    phone_number VARCHAR(255),
    name VARCHAR(255) NOT NULL,
    active BOOLEAN NOT NULL,
    image_id BIGINT,
    password VARCHAR(1000) NOT NULL,
    local_date_time TIMESTAMP NOT NULL
);

-- Create products table
CREATE TABLE products (
    id BIGSERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    price INT NOT NULL,
    city VARCHAR(255),
    preview_image_id BIGINT,
    user_id BIGINT REFERENCES users(id) ON DELETE CASCADE,
    date_of_created TIMESTAMP NOT NULL
);

-- Create images table
CREATE TABLE images (
    id BIGSERIAL PRIMARY KEY,
    name VARCHAR(255),
    original_file_name VARCHAR(255),
    size BIGINT,
    content_type VARCHAR(255),
    is_preview_image BOOLEAN NOT NULL,
    bytes BYTEA,
    product_id BIGINT REFERENCES products(id) ON DELETE CASCADE
);

-- Add foreign key constraint for avatar in users table
ALTER TABLE users
ADD CONSTRAINT fk_user_avatar
FOREIGN KEY (image_id) REFERENCES images(id) ON DELETE SET NULL;

-- Create user_role table
CREATE TABLE user_role (
    user_id BIGINT REFERENCES users(id) ON DELETE CASCADE,
    roles VARCHAR(255) NOT NULL,
    PRIMARY KEY (user_id, roles)
);

-- Insert admin user (password 'admin' encrypted with BCryptPasswordEncoder for demonstration)
INSERT INTO users (email, phone_number, name, active, password, local_date_time) VALUES
('admin@example.com', '1234567890', 'Admin', TRUE, '$2a$10$fI.jX6.zG8oG5rQ1.d0ZJ.O0.q.p.Q1.z.Z.z', NOW());

-- Assign ADMIN role to admin user
INSERT INTO user_role (user_id, roles) VALUES
((SELECT id FROM users WHERE email = 'admin@example.com'), 'ROLE_ADMIN');
