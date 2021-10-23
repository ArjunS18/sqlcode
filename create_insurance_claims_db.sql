
CREATE TABLE address
(
	street_address       CHAR(18) NOT NULL,
	city                 CHAR(18) NOT NULL,
	state                CHAR(18) NOT NULL,
	postal_code          CHAR(18) NULL
);

ALTER TABLE address
ADD PRIMARY KEY (street_address,city,state);

CREATE TABLE car_type
(
	car_type_id          INTEGER NOT NULL,
	car_make             CHAR(255) NOT NULL,
	car_model            CHAR(255) NOT NULL
);

ALTER TABLE car_type
ADD PRIMARY KEY (car_type_id);

CREATE UNIQUE INDEX car_type_unique_key ON car_type
(
	car_make,	car_model
);

CREATE TABLE claim
(
	claim_number         CHAR(11) NOT NULL,
	amount               FLOAT NOT NULL,
	claim_date           DATE NOT NULL,
	policy_number        CHAR(16) NOT NULL,
	status_id            INTEGER NOT NULL
);

ALTER TABLE claim
ADD PRIMARY KEY (claim_number);

CREATE TABLE customer
(
	customer_number      CHAR(7) NOT NULL,
	first_name           CHAR(255) NOT NULL,
	last_name            CHAR(255) NOT NULL,
	street_address       CHAR(18) NULL,
	city                 CHAR(18) NULL,
	state                CHAR(18) NULL
);

ALTER TABLE customer
ADD PRIMARY KEY (customer_number);

CREATE UNIQUE INDEX customer_unique_key ON customer
(
	first_name,	last_name
);

CREATE TABLE policy
(
	policy_number        CHAR(16) NOT NULL,
	policy_limit         INTEGER NOT NULL,
	deductible           INTEGER NOT NULL,
	expiration_date      DATE NOT NULL,
	customer_number      CHAR(7) NOT NULL,
	vin                  CHAR(17) NOT NULL
);

ALTER TABLE policy
ADD PRIMARY KEY (policy_number);

CREATE TABLE status
(
	status_id            INTEGER NOT NULL,
	status               CHAR(15) NOT NULL
);

ALTER TABLE status
ADD PRIMARY KEY (status_id);

CREATE UNIQUE INDEX status_unique_key ON status
(
	status
);

CREATE TABLE vehicle
(
	vin                  CHAR(17) NOT NULL,
	model_year           INTEGER NULL,
	car_type_id          INTEGER NULL
);

ALTER TABLE vehicle
ADD PRIMARY KEY (vin);

ALTER TABLE claim
ADD CONSTRAINT claim_policy_num_fk FOREIGN KEY (policy_number) REFERENCES policy (policy_number)
		ON DELETE CASCADE;

ALTER TABLE claim
ADD CONSTRAINT claim_status_id_fk FOREIGN KEY (status_id) REFERENCES status (status_id)
		ON DELETE CASCADE;

ALTER TABLE customer
ADD CONSTRAINT R_12 FOREIGN KEY (street_address, city, state) REFERENCES address (street_address, city, state);

ALTER TABLE policy
ADD CONSTRAINT policy_customer_num_fk FOREIGN KEY (customer_number) REFERENCES customer (customer_number)
		ON DELETE CASCADE;

ALTER TABLE policy
ADD CONSTRAINT policy_vehicle_id_fk FOREIGN KEY (vin) REFERENCES vehicle (vin)
		ON DELETE CASCADE;

ALTER TABLE vehicle
ADD CONSTRAINT vehicle_car_type_id_fk FOREIGN KEY (car_type_id) REFERENCES car_type (car_type_id)
		ON DELETE CASCADE;
