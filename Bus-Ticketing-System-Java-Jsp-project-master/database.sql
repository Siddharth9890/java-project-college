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
    "flightId" INTEGER NOT NULL,
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
        "totalSeat" INTEGER NOT NULL,
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
ALTER TABLE
    "flight" ADD CONSTRAINT "flight_code_unique" UNIQUE("code");
CREATE TABLE "users"(
    "id" SERIAL PRIMARY KEY,
    "name" VARCHAR(255) NOT NULL,
    "email" VARCHAR(255) NOT NULL,
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
    "booking" ADD CONSTRAINT "booking_flightid_foreign" FOREIGN KEY("flightId") REFERENCES "flight"("id");
ALTER TABLE
    "booking" ADD CONSTRAINT "booking_userid_foreign" FOREIGN KEY("userId") REFERENCES "users"("id");

insert into users (id, name, email, phone, password, role) values (1, 'Estella', 'ekabsch0@51.la', '11352224', 'hwBMi6Mz', 'USER');
insert into users (id, name, email, phone, password, role) values (2, 'Fedora', 'fdronsfield1@list-manage.com', '67276215', 'NJ29ll', 'USER');
insert into users (id, name, email, phone, password, role) values (3, 'Jarib', 'jpoone2@redcross.org', '61537383', 'lvyQHDJ8j57', 'USER');
insert into users (id, name, email, phone, password, role) values (4, 'Kenny', 'kvarah3@lulu.com', '28057271', 'c97iN5jY', 'USER');
insert into users (id, name, email, phone, password, role) values (5, 'Dan', 'deskrick4@buzzfeed.com', '32765017', 'BVLbKN13q7n', 'ADMIN');
insert into users (id, name, email, phone, password, role) values (6, 'Carl', 'cfirbank5@paginegialle.it', '78616936', 'qMGoiQVr', 'USER');
insert into users (id, name, email, phone, password, role) values (7, 'Alidia', 'amccarter6@forbes.com', '19950511', 'WSPMWT', 'USER');
insert into users (id, name, email, phone, password, role) values (8, 'Xerxes', 'xcrasswell7@lulu.com', '11029432', 'FcaMdBODCeqO', 'USER');
insert into users (id, name, email, phone, password, role) values (9, 'Burtie', 'blarenson8@google.com.hk', '96911892', 'eGvxXkEDHx9I', 'ADMIN');
insert into users (id, name, email, phone, password, role) values (10, 'Jermaine', 'jmartins9@google.co.uk', '31468255', 'j8ISrOR0df', 'USER');

insert into airports (id, name, address, contact) values (1, 'Carregado', '511 Charing Cross Street', '52350862');
insert into airports (id, name, address, contact) values (2, 'Funaishikawa', '78031 Hooker Junction', '49758859');
insert into airports (id, name, address, contact) values (3, 'Egbe', '9 Grayhawk Terrace', '99237935');
insert into airports (id, name, address, contact) values (4, 'Zhabagly', '28987 Petterle Way', '70697118');
insert into airports (id, name, address, contact) values (5, 'Presidente Dutra', '031 Sullivan Terrace', '47770865');
insert into airports (id, name, address, contact) values (6, 'Campo Quijano', '482 Rockefeller Circle', '84912140');
insert into airports (id, name, address, contact) values (7, 'Sukakarya', '3 Sunnyside Place', '89419310');
insert into airports (id, name, address, contact) values (8, 'Mocoa', '7861 Glacier Hill Junction', '96119936');
insert into airports (id, name, address, contact) values (9, 'Whittlesea', '5 Shopko Park', '99461222');
insert into airports (id, name, address, contact) values (10, 'Hargeysa', '23399 Maryland Terrace', '45413813');

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

insert into journeys (id, "fromLocation", "toLocation","flightId" ,"departureTime", status, price, "totalSeat", "seatRange") values (1, 'Le Havre', 'Mladá Boleslav','2Qe-43', '2022/7/20', 'BOOKING', 83.22, 84, 3);
insert into journeys (id, "fromLocation", "toLocation","flightId" ,"departureTime", status, price, "totalSeat", "seatRange") values (2, 'Novyy Svit', 'Langqi', 'E5p-75','2022/9/18', 'PRE-BOOKING', 91.95, 64, 4);
insert into journeys (id, "fromLocation", "toLocation","flightId" ,"departureTime", status, price, "totalSeat", "seatRange") values (3, 'Apeldoorn', 'Yanhu', 'aYU-63','2022/3/8', 'PRE-BOOKING', 29.97, 4, 2);
insert into journeys (id, "fromLocation", "toLocation","flightId" ,"departureTime", status, price, "totalSeat", "seatRange") values (4, 'Haoxin', 'Ogod', 'G2w-90','2022/5/1', 'PRE-BOOKING', 61.21, 13, 1);
insert into journeys (id, "fromLocation", "toLocation","flightId" ,"departureTime", status, price, "totalSeat", "seatRange") values (5, 'Danxi', 'Kuala Terengganu','w6o-65', '2022/9/30', 'BOOKING', 7.26, 64, 3);
insert into journeys (id, "fromLocation", "toLocation","flightId" ,"departureTime", status, price, "totalSeat", "seatRange") values (6, 'Xiaochuan', 'Ferme-Neuve', 'cir-92','2022/6/16', 'PRE-BOOKING', 17.22, 87, 1);
insert into journeys (id, "fromLocation", "toLocation","flightId" ,"departureTime", status, price, "totalSeat", "seatRange") values (7, 'Alingsås', 'Xingguo', 'Pp2-33','2022/7/18', 'PRE-BOOKING', 57.42, 88, 2);
insert into journeys (id, "fromLocation", "toLocation","flightId" ,"departureTime", status, price, "totalSeat", "seatRange") values (8, 'Wujing', 'Tarrafal de São Nicolau', 'mTF-85','2022/4/14', 'BOOKING', 19.11, 99, 1);
insert into journeys (id, "fromLocation", "toLocation","flightId" ,"departureTime", status, price, "totalSeat", "seatRange") values (9, 'Kendayakan', 'Xingpinglu', 'VjR-64','2022/7/21', 'BOOKING', 22.43, 52, 2);
insert into journeys (id, "fromLocation", "toLocation","flightId" ,"departureTime", status, price, "totalSeat", "seatRange") values (10, 'Presidencia Roque Sáenz Peña', 'utr-47','Tourcoing', '2022/10/12', 'BOOKING', 25.5, 41, 4);
