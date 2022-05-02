DROP TABLE IF EXISTS "booking";
DROP TABLE IF EXISTS "airports";
DROP TABLE IF EXISTS "destinations";
DROP TABLE IF EXISTS "flight";
DROP TABLE IF EXISTS "users";
DROP TABLE IF EXISTS "trains";
DROP TABLE IF EXISTS "journeys";


CREATE TABLE "booking"(
    "id" SERIAL PRIMARY KEY,
    "destinationId" INTEGER NOT NULL,
    "bookingDate" DATE NOT NULL,
    "journeyDate" DATE NOT NULL,
    "flightId" VARCHAR(255) NOT NULL,
    "seatNumbers" VARCHAR(255) NOT NULL,
    "userId" INTEGER NOT NULL,
    "numberOfSeat" INTEGER NOT NULL,
    "paymentStatus" VARCHAR(255) CHECK
        ("paymentStatus" IN('INCOMPLETE','COMPLETED')) NOT NULL,
        "status" VARCHAR(255) NOT NULL,
        "type" VARCHAR(255)
    CHECK
        ("type" IN('BUSINESS','NORMAL')) NOT NULL
);

CREATE TABLE "journeys"(
    "id" SERIAL PRIMARY KEY,
    "fromLocation" VARCHAR(255) NOT NULL,
    "toLocation" VARCHAR(255) NOT NULL,
    "flightId" VARCHAR(255) NOT NULL,
    "departureTime" TIMESTAMP(0) WITHOUT TIME ZONE NOT NULL,
    "status" VARCHAR(255) CHECK
        ("status" IN('PRE-BOOKING','BOOKING')) NOT NULL,
        "price" DOUBLE PRECISION NOT NULL,
        "seatRange" VARCHAR(255) NOT NULL,
        "type" VARCHAR(255)
    CHECK
        ("type" IN('BUSINESS','NORMAL')) NOT NULL
);


ALTER TABLE journeys
DROP COLUMN type;


CREATE TABLE "airports"(
    "id" SERIAL PRIMARY KEY,
    "name" VARCHAR(255) NOT NULL,
    "address" VARCHAR(255) NOT NULL,
    "contact" INTEGER NOT NULL
);
ALTER TABLE
    "airports" ADD CONSTRAINT "airports_name_unique" UNIQUE("name");
CREATE TABLE "flight"(
    "id" SERIAL PRIMARY KEY,
    "code" VARCHAR(255) NOT NULL,
    "name" VARCHAR(255) NOT NULL,
    "totalSeats" INTEGER NOT NULL,
    "type" VARCHAR(255) CHECK
        ("type" IN('BUSINESS','NORMAL')) NOT NULL
);
-- add name as unique
ALTER TABLE
    "flight" ADD CONSTRAINT "flight_code_unique" UNIQUE("code");
CREATE TABLE "users"(
    "id" SERIAL PRIMARY KEY,
    "name" VARCHAR(255) NOT NULL,
    "email" VARCHAR(255) NOT NULL,
    "address" VARCHAR(255) ,
    "phone" INTEGER NOT NULL,
    "password" VARCHAR(255) NOT NULL,
    "role" VARCHAR(255) CHECK
        ("role" IN('ADMIN','USER')) NOT NULL,
        "regestirationDate" DATE DEFAULT CURRENT_DATE 
);

ALTER TABLE
    "users" ADD CONSTRAINT "users_email_unique" UNIQUE("email");
ALTER TABLE
    "users" ADD CONSTRAINT "users_phone_unique" UNIQUE("phone");
ALTER TABLE
    "booking" ADD CONSTRAINT "booking_destinationid_foreign" FOREIGN KEY("destinationId") REFERENCES "journeys"("id");
ALTER TABLE
    "booking" ADD CONSTRAINT "booking_flightid_foreign" FOREIGN KEY("flightId") REFERENCES "flight"("code");
ALTER TABLE
    "booking" ADD CONSTRAINT "booking_userid_foreign" FOREIGN KEY("userId") REFERENCES "users"("id");



insert into airports (id, name, address, contact) values (1, 'Pune', '511 Charing Cross Street', '52350862');
insert into airports (id, name, address, contact) values (2, 'Mumbai', '78031 Hooker Junction', '49758859');
insert into airports (id, name, address, contact) values (3, 'Delhi', '9 Grayhawk Terrace', '99237935');
insert into airports (id, name, address, contact) values (4, 'Nagpur', '28987 Petterle Way', '70697118');
insert into airports (id, name, address, contact) values (5, 'Manipur', '031 Sullivan Terrace', '47770865');
insert into airports (id, name, address, contact) values (6, 'Banglore', '482 Rockefeller Circle', '84912140');
insert into airports (id, name, address, contact) values (7, 'Chennai', '3 Sunnyside Place', '89419310');
insert into airports (id, name, address, contact) values (8, 'Amarvati', '7861 Glacier Hill Junction', '96119936');
insert into airports (id, name, address, contact) values (9, 'Nashik', '5 Shopko Park', '99461222');
insert into airports (id, name, address, contact) values (10, 'Gubtur', '23399 Maryland Terrace', '45413813');

insert into flight (code, name, "totalSeats", type) values ('2Qe-43', 'Kathrine', 3, 'BUSINESS');
insert into flight (code, name, "totalSeats", type) values ('E5p-75', 'Constantine', 55, 'NORMAL');
insert into flight (code, name, "totalSeats", type) values ('aYU-63', 'Melony', 47, 'NORMAL');
insert into flight (code, name, "totalSeats", type) values ('G2w-90', 'Laverne', 20, 'BUSINESS');
insert into flight (code, name, "totalSeats", type) values ('w6o-65', 'Huntley', 4, 'NORMAL');
insert into flight (code, name, "totalSeats", type) values ('cir-92', 'Ardelle', 59, 'BUSINESS');
insert into flight (code, name, "totalSeats", type) values ('Pp2-33', 'Taffy', 76, 'BUSINESS');
insert into flight (code, name, "totalSeats", type) values ('mTF-85', 'Carlotta', 8, 'NORMAL');
insert into flight (code, name, "totalSeats", type) values ('VjR-64', 'Arabele', 53, 'NORMAL');
insert into flight (code, name, "totalSeats", type) values ('utr-47', 'Vida', 22, 'NORMAL');

insert into journeys (id, "fromLocation", "toLocation","flightId" ,"departureTime", status, price, "seatRange") values (1, 'Pune', 'Mumbai','2Qe-43', '2022/7/20', 'BOOKING', 83.22, 3);
insert into journeys (id, "fromLocation", "toLocation","flightId" ,"departureTime", status, price, "seatRange") values (2, 'Mumbai', 'Pune', 'E5p-75','2022/9/18', 'PRE-BOOKING', 91.95, 4);
insert into journeys (id, "fromLocation", "toLocation","flightId" ,"departureTime", status, price, "seatRange") values (3, 'Pune', 'Delhi', 'aYU-63','2022/3/8', 'PRE-BOOKING', 29.97, 2);
insert into journeys (id, "fromLocation", "toLocation","flightId" ,"departureTime", status, price, "seatRange") values (4, 'Mumbau', 'Delhi', 'G2w-90','2022/5/1', 'PRE-BOOKING', 61.21, 1);
insert into journeys (id, "fromLocation", "toLocation","flightId" ,"departureTime", status, price, "seatRange") values (5, 'Punjab', 'Delhi','w6o-65', '2022/9/30', 'BOOKING', 7.26, 3);
insert into journeys (id, "fromLocation", "toLocation","flightId" ,"departureTime", status, price, "seatRange") values (6, 'Delhi', 'Punjab', 'cir-92','2022/6/16', 'PRE-BOOKING', 17.22, 1);
insert into journeys (id, "fromLocation", "toLocation","flightId" ,"departureTime", status, price, "seatRange") values (7, 'Pune', 'Punjab', 'Pp2-33','2022/7/18', 'PRE-BOOKING', 57.42, 2);
insert into journeys (id, "fromLocation", "toLocation","flightId" ,"departureTime", status, price, "seatRange") values (8, 'Pune', 'Banglore', 'mTF-85','2022/4/14', 'BOOKING', 19.11, 1);
insert into journeys (id, "fromLocation", "toLocation","flightId" ,"departureTime", status, price, "seatRange") values (9, 'Banglore', 'Pune', 'VjR-64','2022/7/21', 'BOOKING', 22.43, 2);
insert into journeys (id, "fromLocation", "toLocation","flightId" ,"departureTime", status, price, "seatRange") values (10, 'Banglore', 'Delhi','utr-47', '2022/10/12', 'BOOKING', 25.5, 4);
