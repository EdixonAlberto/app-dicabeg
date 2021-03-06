-- USERS
CREATE TABLE "users" (
  "user_id" VARCHAR(36) NOT NULL,
  "activated" BOOLEAN NOT NULL DEFAULT FALSE,
  "username" VARCHAR(20) NOT NULL,
  "email" VARCHAR(40) NOT NULL,
  "balance" NUMERIC(10, 5) DEFAULT 0,
  "names" VARCHAR(20) NULL DEFAULT NULL,
  "lastnames" VARCHAR(20) NULL DEFAULT NULL,
  "age" INTEGER NULL DEFAULT NULL,
  "avatar" VARCHAR NULL DEFAULT NULL,
  "phone" VARCHAR(20) NULL DEFAULT NULL,
  "player_id" VARCHAR(36) NULL DEFAULT NULL,
  "invite_code" VARCHAR(6) NOT NULL,
  "password" VARCHAR(255) NOT NULL,
  "create_date" TIMESTAMP NULL,
  "update_date" TIMESTAMP NULL,
  "rol_id" INTEGER NOT NULL,
  CONSTRAINT "users_user_id_PK" PRIMARY KEY ("user_id"),
  CONSTRAINT "users_username_UQ" UNIQUE ("username"),
  CONSTRAINT "users_email_UQ" UNIQUE ("email"),
  CONSTRAINT "users_invite_code_UQ" UNIQUE ("invite_code"),
  CONSTRAINT "users_rol_id_FK" FOREIGN KEY ("rol_id") REFERENCES roles("rol_id")
);

-- ROLES
CREATE TABLE "roles" (
  "rol_id" SMALLSERIAL NOT NULL,
  "name" VARCHAR(20) NOT NULL,
  CONSTRAINT "roles_rol_id_PK" PRIMARY KEY ("rol_id")
);

-- ACCOUNTS
CREATE TABLE "accounts" (
  "email" VARCHAR(36) NOT NULL,
  "temporal_code" VARCHAR(6) NULL DEFAULT NULL,
  "last_email_sended" VARCHAR(20) NULL DEFAULT NULL,
  "time_zone" VARCHAR NOT NULL,
  "code_create_date" TIMESTAMP NULL,
  CONSTRAINT "accounts_email_PK" PRIMARY KEY ("email")
);

-- TRANSFERS
CREATE TABLE "transfers" (
  "user_id" VARCHAR(36) NOT NULL,
  "transfer_code" VARCHAR(6) NOT NULL,
  "concept" VARCHAR(40) NULL DEFAULT NULL,
  "responsible" VARCHAR(36) NOT NULL,
  "amount" NUMERIC(10, 5) DEFAULT 0,
  "previous_balance" NUMERIC(10, 5) DEFAULT 0,
  "current_balance" NUMERIC(10, 5) DEFAULT 0,
  "create_date" TIMESTAMP NULL,
  CONSTRAINT "transfers_user_id_FK" FOREIGN KEY("user_id") REFERENCES users("user_id")
);

-- COMMISSIONS
CREATE TABLE "commissions" (
  "user_id" VARCHAR(36) NOT NULL,
  "amount" NUMERIC(10, 5) DEFAULT 0,
  "commission" NUMERIC(10, 5) DEFAULT 0,
  "create_date" TIMESTAMP NULL,
  CONSTRAINT "commissions_user_id_UQ" UNIQUE ("user_id")
);

-- REFERREDS
CREATE TABLE "referreds" (
  "user_id" VARCHAR(36) NOT NULL,
  "referred_id" VARCHAR(36) NOT NULL,
  "create_date" TIMESTAMP NULL,
  CONSTRAINT "referreds_user_id_FK" FOREIGN KEY("user_id") REFERENCES users("user_id"),
  CONSTRAINT "referreds_referred_id_FK" FOREIGN KEY("referred_id") REFERENCES users("user_id")
);

-- VIDEOS
CREATE TABLE "videos" (
  "video_id" VARCHAR(36) NOT NULL,
  "name" VARCHAR(40) NULL DEFAULT NULL,
  "link" VARCHAR NULL DEFAULT NULL,
  "size" INTEGER DEFAULT 0,
  "provider_logo" VARCHAR NULL DEFAULT NULL,
  "question" VARCHAR(255) NULL DEFAULT NULL,
  "correct" INTEGER DEFAULT 0,
  "responses" JSON NULL DEFAULT NULL,
  "total_views" INTEGER DEFAULT 0,
  "create_date" TIMESTAMP NULL,
  "update_date" TIMESTAMP NULL,
  CONSTRAINT "videos_video_id_PK" PRIMARY KEY ("video_id")
);

-- HISTORY
CREATE TABLE "history" (
  "user_id" VARCHAR(36) NOT NULL,
  "video" VARCHAR(36) NOT NULL,
  "total_views" INTEGER DEFAULT 0,
  "create_date" TIMESTAMP NULL,
  CONSTRAINT "history_user_id_FK" FOREIGN KEY ("user_id") REFERENCES users("user_id"),
  CONSTRAINT "history_video_FK" FOREIGN KEY ("video") REFERENCES videos("video_id")
);

-- OPTIONS
CREATE TABLE "options" (
  "expiration_time" VARCHAR NOT NULL,
  "pay_bonus" NUMERIC(6, 5) DEFAULT 0,
  "pay_enterprise" NUMERIC(6, 5) DEFAULT 0,
  "commission_amount" NUMERIC(6, 5) DEFAULT 0,
  "commission_percetage" INTEGER DEFAULT 0
);

-- CATEGORIES
CREATE TABLE "categories" (
  "category_id" SMALLSERIAL NOT NULL,
  "name" VARCHAR(20) NOT NULL,
  CONSTRAINT "categories_category_id_PK" PRIMARY KEY ("category_id")
);

-- PRODUCTS
CREATE TABLE "products" (
  "product_id" VARCHAR(36) NOT NULL,
  "user_id" VARCHAR(36) NOT NULL,
  "category_id" INTEGER NOT NULL,
  "name" VARCHAR(20) NOT NULL,
  "price" NUMERIC(10, 5) NOT NULL,
  "description" VARCHAR NULL DEFAULT NULL,
  "quantity" INTEGER DEFAULT 0,
  "photo" VARCHAR NULL DEFAULT NULL,
  "create_date" TIMESTAMP NULL,
  "update_date" TIMESTAMP NULL,
  CONSTRAINT "products_product_id_PK" PRIMARY KEY ("product_id"),
  CONSTRAINT "products_user_id_FK" FOREIGN KEY ("user_id") REFERENCES users("user_id"),
  CONSTRAINT "products_category_id_FK" FOREIGN KEY ("category_id") REFERENCES categories("category_id")
);
/* Type
    NUMERIC: hasta 131072 dígitos antes del punto decimal;
    hasta 16383 dígitos después del punto decimal
*/