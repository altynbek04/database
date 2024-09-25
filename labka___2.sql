-- Create `airport` table
CREATE TABLE airport (
    airport_id SERIAL PRIMARY KEY,
    airport_name VARCHAR(50),
    country VARCHAR(50),
    "city" VARCHAR(50),
    state VARCHAR(50),
    created_at TIMESTAMP,
    updated_at TIMESTAMP
);

--  Create `airline` table
CREATE TABLE airline (
    airline_id SERIAL PRIMARY KEY,
    airline_code VARCHAR(50),
    airline_name VARCHAR(50),
    airline_country VARCHAR(50),
    created_at TIMESTAMP,
    updated_at TIMESTAMP
);

--  Create `flights` table
CREATE TABLE flights (
    flight_id SERIAL PRIMARY KEY,
    flight_no VARCHAR(50),
    scheduled_departure TIMESTAMP,
    scheduled_arrival TIMESTAMP,
    departure_airport_id INTEGER,
    arrival_airport_id INTEGER,
    airline_id INTEGER,
    status VARCHAR(50),
    actual_departure TIMESTAMP,
    actual_arrival TIMESTAMP,
    created_at TIMESTAMP,
    updated_at TIMESTAMP,
    FOREIGN KEY (departure_airport_id) REFERENCES airport(airport_id),
    FOREIGN KEY (arrival_airport_id) REFERENCES airport(airport_id),
    FOREIGN KEY (airline_id) REFERENCES airline(airline_id)
);

--  Create `passengers` table
CREATE TABLE passengers (
    passenger_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    date_of_birth DATE,
    gender VARCHAR(50),
    country_of_citizenship VARCHAR(50),
    country_of_residence VARCHAR(50),
    passport_number VARCHAR(50),
    created_at TIMESTAMP,
    updated_at TIMESTAMP
);

--  Create `booking` table
CREATE TABLE booking (
    booking_id SERIAL PRIMARY KEY,
    passenger_id INTEGER,
    booking_platform VARCHAR(50),
    created_at TIMESTAMP,
    updated_at TIMESTAMP,
    status VARCHAR(50),
    price NUMERIC(7,2),
    FOREIGN KEY (passenger_id) REFERENCES passengers(passenger_id)
);

--  Create `baggage` table
CREATE TABLE baggage (
    baggage_id SERIAL PRIMARY KEY,
    weight_in_kg NUMERIC(4,2),
    created_at TIMESTAMP,
    updated_at TIMESTAMP,
    booking_id INTEGER,
    FOREIGN KEY (booking_id) REFERENCES booking(booking_id)
);

--  Create `baggage_check` table
CREATE TABLE baggage_check (
    baggage_check_id SERIAL PRIMARY KEY,
    check_result VARCHAR(50),
    created_at TIMESTAMP,
    updated_at TIMESTAMP,
    booking_id INTEGER,
    passenger_id INTEGER,
    FOREIGN KEY (booking_id) REFERENCES booking(booking_id),
    FOREIGN KEY (passenger_id) REFERENCES passengers(passenger_id)
);

--  Create `boarding_pass` table
CREATE TABLE boarding_pass (
    boarding_pass_id SERIAL PRIMARY KEY,
    booking_id INTEGER,
    seat VARCHAR(50),
    boarding_time TIMESTAMP,
    created_at TIMESTAMP,
    updated_at TIMESTAMP,
    FOREIGN KEY (booking_id) REFERENCES booking(booking_id)
);

--  Create `security_check` table
CREATE TABLE security_check (
    security_check_id SERIAL PRIMARY KEY,
    check_result VARCHAR(50),
    created_at TIMESTAMP,
    updated_at TIMESTAMP,
    passenger_id INTEGER,
    FOREIGN KEY (passenger_id) REFERENCES passengers(passenger_id)
);

--  Create `booking_flight` table
CREATE TABLE booking_flight (
    booking_flight_id SERIAL PRIMARY KEY,
    booking_id INTEGER,
    flight_id INTEGER,
    created_at TIMESTAMP,
    updated_at TIMESTAMP,
    FOREIGN KEY (booking_id) REFERENCES booking(booking_id),
    FOREIGN KEY (flight_id) REFERENCES flights(flight_id)
);


-- Create relationships

-- Passengers with Security_check, Booking, Baggage_check by passenger_id
ALTER TABLE security_check ADD CONSTRAINT fk_security_passenger FOREIGN KEY (passenger_id) REFERENCES passengers (passenger_id);
ALTER TABLE booking ADD CONSTRAINT fk_booking_passenger FOREIGN KEY (passenger_id) REFERENCES passengers (passenger_id);
ALTER TABLE baggage_check ADD CONSTRAINT fk_baggage_check_passenger FOREIGN KEY (passenger_id) REFERENCES passengers (passenger_id);

-- Booking with Baggage_check, Baggage, Boarding_pass, Booking_flight by booking_id
ALTER TABLE baggage_check ADD CONSTRAINT fk_baggage_check_booking FOREIGN KEY (booking_id) REFERENCES booking (booking_id);
ALTER TABLE baggage ADD CONSTRAINT fk_baggage_booking FOREIGN KEY (booking_id) REFERENCES booking (booking_id);
ALTER TABLE boarding_pass ADD CONSTRAINT fk_boarding_pass_booking FOREIGN KEY (booking_id) REFERENCES booking (booking_id);
ALTER TABLE booking_flight ADD CONSTRAINT fk_booking_flight_booking FOREIGN KEY (booking_id) REFERENCES booking (booking_id);

-- Flights with Booking_flight by flight_id
ALTER TABLE booking_flight ADD CONSTRAINT fk_booking_flight FOREIGN KEY (flight_id) REFERENCES flights (flight_id);

-- Airport with Flights by departing_airport_id and arriving_airport_id
ALTER TABLE flights ADD CONSTRAINT fk_flights_departing_airport FOREIGN KEY (departure_airport_id) REFERENCES airport (airport_id);
ALTER TABLE flights ADD CONSTRAINT fk_flights_arriving_airport FOREIGN KEY (arrival_airport_id) REFERENCES airport (airport_id);

-- Airline with Flights by airline_id
ALTER TABLE flights ADD CONSTRAINT fk_flights_airline FOREIGN KEY (airline_id) REFERENCES airline (airline_id);


--a. Generate and Insert 100 random rows (Use Mockaroo for generating data):
INSERT INTO airline (airline_code, airline_name, airline_country, created_at, updated_at) VALUES
('KA', 'KazAir', 'Kazakhstan', NOW(), NOW()),
('AE', 'AirEasy', 'France', NOW(), NOW()),
('FH', 'FlyHigh', 'Brazil', NOW(), NOW()),
('FF', 'FlyFly', 'Poland', NOW(), NOW()),
('AA', 'AirAsia', 'Malaysia', NOW(), NOW()),
('BA', 'British Airways', 'United Kingdom', NOW(), NOW()),
('CA', 'China Airlines', 'China', NOW(), NOW()),
('DA', 'Delta Air', 'USA', NOW(), NOW()),
('EA', 'EasyJet', 'United Kingdom', NOW(), NOW()),
('FA', 'FlyAway', 'Australia', NOW(), NOW()),
('GA', 'Gulf Air', 'Bahrain', NOW(), NOW()),
('HA', 'Hawaiian Airlines', 'USA', NOW(), NOW()),
('IA', 'Icelandair', 'Iceland', NOW(), NOW()),
('JA', 'Jet Airways', 'India', NOW(), NOW()),
('KA', 'KazAir', 'Kazakhstan', NOW(), NOW()),
('LA', 'LATAM Airlines', 'Chile', NOW(), NOW()),
('MA', 'Malaysia Airlines', 'Malaysia', NOW(), NOW()),
('NA', 'Nigerian Air', 'Nigeria', NOW(), NOW()),
('OA', 'Olympic Airlines', 'Greece', NOW(), NOW()),
('PA', 'Philippine Airlines', 'Philippines', NOW(), NOW()),
('QA', 'Qatar Airways', 'Qatar', NOW(), NOW()),
('RA', 'Royal Air Maroc', 'Morocco', NOW(), NOW()),
('SA', 'South African Airways', 'South Africa', NOW(), NOW()),
('TA', 'Turkish Airlines', 'Turkey', NOW(), NOW()),
('UA', 'United Airlines', 'USA', NOW(), NOW()),
('VA', 'Virgin Atlantic', 'United Kingdom', NOW(), NOW()),
('WA', 'Wizz Air', 'Hungary', NOW(), NOW()),
('XA', 'Xiamen Airlines', 'China', NOW(), NOW()),
('YA', 'Yemenia', 'Yemen', NOW(), NOW()),
('ZA', 'Zambia Airways', 'Zambia', NOW(), NOW()),
('AB', 'Air Berlin', 'Germany', NOW(), NOW()),
('AC', 'Air Canada', 'Canada', NOW(), NOW()),
('AD', 'Azul Brazilian Airlines', 'Brazil', NOW(), NOW()),
('AE', 'American Eagle', 'USA', NOW(), NOW()),
('AF', 'Air France', 'France', NOW(), NOW()),
('AG', 'Alaska Airlines', 'USA', NOW(), NOW()),
('AH', 'Air Algerie', 'Algeria', NOW(), NOW()),
('AI', 'Air India', 'India', NOW(), NOW()),
('AJ', 'Alitalia', 'Italy', NOW(), NOW()),
('AK', 'AirAsia X', 'Malaysia', NOW(), NOW()),
('AL', 'Allegiant Air', 'USA', NOW(), NOW()),
('AM', 'Aeromexico', 'Mexico', NOW(), NOW()),
('AN', 'AnadoluJet', 'Turkey', NOW(), NOW()),
('AO', 'Avianca', 'Colombia', NOW(), NOW()),
('AP', 'Air Poland', 'Poland', NOW(), NOW()),
('AQ', 'AeroMexico', 'Mexico', NOW(), NOW()),
('AR', 'Argentinian Airlines', 'Argentina', NOW(), NOW()),
('AS', 'Alaska Airlines', 'USA', NOW(), NOW()),
('AT', 'Air Tahiti', 'French Polynesia', NOW(), NOW()),
('AU', 'Air Austral', 'Reunion', NOW(), NOW()),
('AV', 'Avianca', 'Colombia', NOW(), NOW()),
('AW', 'Aero World', 'Global', NOW(), NOW()),
('AX', 'Alaska Air', 'USA', NOW(), NOW()),
('AY', 'Finnair', 'Finland', NOW(), NOW()),
('AZ', 'Alitalia', 'Italy', NOW(), NOW()),
('BA', 'Bangladesh Airlines', 'Bangladesh', NOW(), NOW()),
('BB', 'Bamboo Airways', 'Vietnam', NOW(), NOW()),
('BC', 'Jetstar Japan', 'Japan', NOW(), NOW()),
('BD', 'Biman Bangladesh Airlines', 'Bangladesh', NOW(), NOW()),
('BE', 'Flybe', 'United Kingdom', NOW(), NOW()),
('BF', 'Blue Air', 'Romania', NOW(), NOW()),
('BG', 'Bulgaria Air', 'Bulgaria', NOW(), NOW()),
('BH', 'Bahamasair', 'Bahamas', NOW(), NOW()),
('BI', 'Royal Brunei Airlines', 'Brunei', NOW(), NOW()),
('BJ', 'Belavia', 'Belarus', NOW(), NOW()),
('BK', 'Uni Air', 'Taiwan', NOW(), NOW()),
('BL', 'Bamboo Airways', 'Vietnam', NOW(), NOW()),
('BM', 'Bahamasair', 'Bahamas', NOW(), NOW()),
('BN', 'Brussels Airlines', 'Belgium', NOW(), NOW()),
('BO', 'Boliviana de Aviacion', 'Bolivia', NOW(), NOW()),
('BP', 'Air Botswana', 'Botswana', NOW(), NOW()),
('BQ', 'Air Guyane', 'French Guiana', NOW(), NOW()),
('BR', 'China Airlines', 'Taiwan', NOW(), NOW()),
('BS', 'Belavia', 'Belarus', NOW(), NOW()),
('BT', 'airBaltic', 'Latvia', NOW(), NOW()),
('BU', 'Buraq Air', 'Libya', NOW(), NOW()),
('BV', 'Blue Wings', 'Germany', NOW(), NOW()),
('BW', 'Caribbean Airlines', 'Trinidad and Tobago', NOW(), NOW()),
('BX', 'Air Busan', 'South Korea', NOW(), NOW()),
('BY', 'Belavia', 'Belarus', NOW(), NOW()),
('BZ', 'Binter Canarias', 'Spain', NOW(), NOW());


--b. Add a new airline named "KazAir" based in "Kazakhstan"
INSERT INTO airline (airline_code, airline_name, airline_country, created_at, updated_at)
VALUES ('KA', 'KazAir', 'Kazakhstan', NOW(), NOW());


--c. Update the airline country "KazAir" to "Turkey"
UPDATE airline SET airline_country = 'Turkey' WHERE airline_name = 'KazAir';


--d. Remove the airline named "SIT"
DELETE FROM airline WHERE airline_name = 'SIT';


--e. Add three airlines at once
INSERT INTO airline (airline_code, airline_name, airline_country, created_at, updated_at) VALUES
('AE', 'AirEasy', 'France', NOW(), NOW()),
('FH', 'FlyHigh', 'Brazil', NOW(), NOW()),
('FF', 'FlyFly', 'Poland', NOW(), NOW());


--f. Delete all flights whose arrival is in the year 2024
DELETE FROM flights WHERE EXTRACT(YEAR FROM scheduled_arrival) = 2024;


--g. Increase the price of all tickets in the booking table for flights by 10%
UPDATE booking SET price = price * 1.10;

--h. Delete all tickets whose price is less than 1000 units
DELETE FROM booking WHERE price < 1000;