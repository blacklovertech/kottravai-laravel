CREATE TABLE `users` (
  `id` integer PRIMARY KEY,
  `phone_number` varchar(255) UNIQUE,
  `full_name` varchar(255),
  `email` varchar(255),
  `password` varchar(255),
  `profile_pic` varchar(255),
  `device_token` varchar(255),
  `business_name` varchar(255),
  `role` varchar(255),
  `upi_id` varchar(255),
  `is_verified` boolean,
  `is_active` boolean,
  `created_at` timestamp,
  `updated_at` timestamp
);

CREATE TABLE `addresses` (
  `id` integer PRIMARY KEY,
  `user_id` integer,
  `label` varchar(255),
  `address_line` varchar(255),
  `city` varchar(255),
  `state` varchar(255),
  `postal_code` varchar(255),
  `country` varchar(255),
  `is_default` boolean,
  `created_at` timestamp,
  `updated_at` timestamp
);

CREATE TABLE `products` (
  `id` integer PRIMARY KEY,
  `user_id` integer,
  `name` varchar(255),
  `description` text,
  `price` decimal,
  `stock_quantity` integer,
  `is_active` boolean,
  `is_approved` boolean,
  `avg_rating` float,
  `review_count` integer,
  `category` varchar(255),
  `created_at` timestamp,
  `updated_at` timestamp
);

CREATE TABLE `product_images` (
  `id` integer PRIMARY KEY,
  `product_id` integer,
  `image_url` varchar(255),
  `is_primary` boolean,
  `display_order` integer,
  `created_at` timestamp,
  `updated_at` timestamp
);

CREATE TABLE `orders` (
  `id` integer PRIMARY KEY,
  `buyer_id` integer,
  `seller_id` integer,
  `order_number` varchar(255) UNIQUE,
  `total_amount` decimal,
  `status` varchar(255),
  `shipping_address` varchar(255),
  `billing_address` varchar(255),
  `buyer_phone` varchar(255),
  `seller_phone` varchar(255),
  `is_payment_verified` boolean,
  `is_shipped` boolean,
  `is_delivered` boolean,
  `created_at` timestamp,
  `updated_at` timestamp
);

CREATE TABLE `order_items` (
  `id` integer PRIMARY KEY,
  `order_id` integer,
  `product_id` integer,
  `quantity` integer,
  `unit_price` decimal,
  `total_price` decimal,
  `created_at` timestamp,
  `updated_at` timestamp
);

CREATE TABLE `payments` (
  `id` integer PRIMARY KEY,
  `order_id` integer,
  `transaction_id` varchar(255) UNIQUE,
  `payment_method` varchar(255),
  `razorpay_payment_id` varchar(255),
  `amount` decimal,
  `status` varchar(255),
  `signature_hash` varchar(255),
  `is_verified` boolean,
  `payment_date` timestamp,
  `created_at` timestamp,
  `updated_at` timestamp
);

CREATE TABLE `shipments` (
  `id` integer PRIMARY KEY,
  `order_id` integer,
  `courier_partner` varchar(255),
  `tracking_number` varchar(255),
  `status` varchar(255),
  `tracking_url` varchar(255),
  `shipped_at` timestamp,
  `expected_delivery` timestamp,
  `delivered_at` timestamp,
  `created_at` timestamp,
  `updated_at` timestamp
);

CREATE TABLE `reviews` (
  `id` integer PRIMARY KEY,
  `product_id` integer,
  `user_id` integer,
  `rating` integer,
  `comment` text,
  `is_approved` boolean,
  `is_verified_purchase` boolean,
  `created_at` timestamp,
  `updated_at` timestamp
);

CREATE TABLE `review_images` (
  `id` integer PRIMARY KEY,
  `review_id` integer,
  `image_url` varchar(255),
  `created_at` timestamp,
  `updated_at` timestamp
);

CREATE TABLE `notifications` (
  `id` integer PRIMARY KEY,
  `user_id` integer,
  `order_id` integer,
  `type` varchar(255),
  `message` varchar(255),
  `is_read` boolean,
  `delivery_channel` varchar(255),
  `created_at` timestamp,
  `updated_at` timestamp
);

CREATE TABLE `admins` (
  `id` integer PRIMARY KEY,
  `username` varchar(255) UNIQUE,
  `email` varchar(255) UNIQUE,
  `password` varchar(255),
  `name` varchar(255),
  `role` varchar(255),
  `is_active` boolean,
  `last_login` timestamp,
  `created_at` timestamp,
  `updated_at` timestamp
);

CREATE TABLE `wishlists` (
  `id` integer PRIMARY KEY,
  `user_id` integer,
  `product_id` integer,
  `created_at` timestamp
);

CREATE TABLE `returns` (
  `id` integer PRIMARY KEY,
  `order_id` integer,
  `user_id` integer,
  `reason` text,
  `status` varchar(255),
  `requested_at` timestamp,
  `resolved_at` timestamp,
  `created_at` timestamp,
  `updated_at` timestamp
);

CREATE TABLE `coupons` (
  `id` integer PRIMARY KEY,
  `code` varchar(255) UNIQUE,
  `description` varchar(255),
  `discount_amount` decimal,
  `discount_percentage` decimal,
  `min_purchase_amount` decimal,
  `usage_limit` integer,
  `used_count` integer,
  `is_active` boolean,
  `valid_from` timestamp,
  `valid_until` timestamp,
  `created_at` timestamp,
  `updated_at` timestamp
);

CREATE TABLE `coupons_used` (
  `id` integer PRIMARY KEY,
  `order_id` integer,
  `coupon_id` integer,
  `discount_applied` decimal,
  `created_at` timestamp
);

CREATE TABLE `login_logs` (
  `id` integer PRIMARY KEY,
  `user_id` integer,
  `login_time` timestamp,
  `ip_address` varchar(255),
  `device_info` varchar(255),
  `created_at` timestamp,
  `updated_at` timestamp
);

ALTER TABLE `addresses` ADD FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

ALTER TABLE `products` ADD FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

ALTER TABLE `product_images` ADD FOREIGN KEY (`product_id`) REFERENCES `products` (`id`);

ALTER TABLE `orders` ADD FOREIGN KEY (`buyer_id`) REFERENCES `users` (`id`);

ALTER TABLE `orders` ADD FOREIGN KEY (`seller_id`) REFERENCES `users` (`id`);

ALTER TABLE `order_items` ADD FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`);

ALTER TABLE `order_items` ADD FOREIGN KEY (`product_id`) REFERENCES `products` (`id`);

ALTER TABLE `payments` ADD FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`);

ALTER TABLE `shipments` ADD FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`);

ALTER TABLE `reviews` ADD FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

ALTER TABLE `reviews` ADD FOREIGN KEY (`product_id`) REFERENCES `products` (`id`);

ALTER TABLE `review_images` ADD FOREIGN KEY (`review_id`) REFERENCES `reviews` (`id`);

ALTER TABLE `notifications` ADD FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

ALTER TABLE `notifications` ADD FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`);

ALTER TABLE `wishlists` ADD FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

ALTER TABLE `wishlists` ADD FOREIGN KEY (`product_id`) REFERENCES `products` (`id`);

ALTER TABLE `returns` ADD FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`);

ALTER TABLE `returns` ADD FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

ALTER TABLE `coupons_used` ADD FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`);

ALTER TABLE `coupons_used` ADD FOREIGN KEY (`coupon_id`) REFERENCES `coupons` (`id`);

ALTER TABLE `orders` ADD FOREIGN KEY (`buyer_phone`) REFERENCES `review_images` (`image_url`);
