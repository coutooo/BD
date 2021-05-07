CREATE TABLE airport (
	airport_code	INT,
	city			VARCHAR(30) NOT NULL,
	airport_state	VARCHAR(30) NOT NULL,
	airport_name	VARCHAR(30) NOT NULL,
	PRIMARY KEY(airport_code)
);

CREATE TABLE airplane_type (
	airplane_name	VARCHAR(30),
	max_seats		INT NOT NULL,
	company			VARCHAR(30) NOT NULL,
	PRIMARY KEY(airplane_name),
	CHECK(max_seats > 0)
);

CREATE TABLE can_land (
	airport		INT,
	airplane	VARCHAR(30),
	PRIMARY KEY(airport, airplane),
	FOREIGN KEY(airport) REFERENCES airport(airport_code),
	FOREIGN KEY(airplane) REFERENCES airplane_type(airplane_name)
);

CREATE TABLE airplane (
	airplane_id			INT,
	total_number_seats	INT NOT NULL,
	name_type			VARCHAR(30) NOT NULL,
	PRIMARY KEY(airplane_id),
	FOREIGN KEY(name_type) REFERENCES airplane_type(airplane_name),
	CHECK(total_number_seats > 0)
);

CREATE TABLE flight (
	flight_number	INT,
	airline			VARCHAR(30) NOT NULL,
	weekdays		VARCHAR(50) NOT NULL,
	PRIMARY KEY(flight_number)
);

CREATE TABLE flight_leg (
	flight_number		INT,
	flight_leg_number	INT,
	arrival_airport		INT NOT NULL,
	departure_airport	INT NOT NULL,
	weekdays			VARCHAR(50) NOT NULL,
	arrive_time			TIME NOT NULL,
	departure_time		TIME NOT NULL,
	PRIMARY KEY(flight_number, flight_leg_number),
	FOREIGN KEY(flight_number) REFERENCES flight(flight_number),
);

CREATE TABLE leg_instance (
	instance_number			INT,
	leg_number				INT,
	leg_date				DATE,
	airplane				INT NOT NULL,
	number_available_seats	INT NOT NULL,
	arrival_airport			INT NOT NULL,
	departure_airport		INT NOT NULL,
	PRIMARY KEY(instance_number, leg_number, leg_date),
	FOREIGN KEY(instance_number, leg_number) REFERENCES flight_leg(flight_number, flight_leg_number),
	FOREIGN KEY(airplane) REFERENCES airplane(airplane_id),
	FOREIGN KEY(arrival_airport) REFERENCES airport(airport_code),
	FOREIGN KEY(departure_airport) REFERENCES airport(airport_code),
	CHECK(number_available_seats > 0)
);

CREATE TABLE seat (
	seat_number				INT,
	seat_instance_number	INT,
	seat_leg_number			INT,
	seat_date				DATE,
	customer_name			VARCHAR(30) NOT NULL,
	customer_phone			CHAR(9) NOT NULL,
	PRIMARY KEY(seat_number, seat_instance_number, seat_leg_number, seat_date),
	FOREIGN KEY(seat_instance_number, seat_leg_number, seat_date) REFERENCES leg_instance(instance_number, leg_number, leg_date)
);

CREATE TABLE fare (
	fare_number		INT,
	fare_code		INT,
	amount			MONEY NOT NULL,
	restrictions	VARCHAR(30) NOT NULL,
	PRIMARY KEY(fare_number, fare_code),
	FOREIGN KEY(fare_number) REFERENCES flight(flight_number)
);
