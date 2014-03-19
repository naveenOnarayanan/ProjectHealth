#users
DELETE FROM hospital_main.users;

INSERT INTO hospital_main.users (UserID, Password, Role) VALUES ('jhalmo', 'josh', 'doctor');
INSERT INTO hospital_main.users (UserID, Password, Role) VALUES ('tlannister', 'tyrion', 'staff');
INSERT INTO hospital_main.users (UserID, Password, Role) VALUES ('dtargaryen', 'daenerys', 'patient');
INSERT INTO hospital_main.users (UserID, Password, Role) VALUES ('jsnow', 'jon', 'staff');
INSERT INTO hospital_main.users (UserID, Password, Role) VALUES ('gzhou', 'gordon', 'doctor');
INSERT INTO hospital_main.users (UserID, Password, Role) VALUES ('jmormont', 'jorah', 'patient');
INSERT INTO hospital_main.users (UserID, Password, Role) VALUES ('pbaelish', 'petyr', 'patient');
INSERT INTO hospital_main.users (UserID, Password, Role) VALUES ('jlannister', 'jaime', 'staff');
INSERT INTO hospital_main.users (UserID, Password, Role) VALUES ('dseaworth', 'davos', 'patient');
INSERT INTO hospital_main.users (UserID, Password, Role) VALUES ('sbaratheon', 'stannis', 'patient');
INSERT INTO hospital_main.users (UserID, Password, Role) VALUES ('mtyrell', 'margaery', 'patient');
INSERT INTO hospital_main.users (UserID, Password, Role) VALUES ('ecameracci', 'eric', 'staff');
INSERT INTO hospital_main.users (UserID, Password, Role) VALUES ('bstark', 'bran', 'patient');
INSERT INTO hospital_main.users (UserID, Password, Role) VALUES ('sstark', 'sansa', 'patient');
INSERT INTO hospital_main.users (UserID, Password, Role) VALUES ('nnarayanan', 'naveen', 'doctor');
INSERT INTO hospital_main.users (UserID, Password, Role) VALUES ('astark', 'arya', 'staff');
INSERT INTO hospital_main.users (UserID, Password, Role) VALUES ('tgreyjoy', 'theon', 'staff');
INSERT INTO hospital_main.users (UserID, Password, Role) VALUES ('jbaratheon', 'joffrey', 'patient');
INSERT INTO hospital_main.users (UserID, Password, Role) VALUES ('starly', 'samwell', 'finance');
INSERT INTO hospital_main.users (UserID, Password, Role) VALUES ('sclegane', 'sandor', 'staff');
INSERT INTO hospital_main.users (UserID, Password, Role) VALUES ('cstark', 'catelyn', 'patient');
INSERT INTO hospital_main.users (UserID, Password, Role) VALUES ('rstark', 'robb', 'patient');
INSERT INTO hospital_main.users (UserID, Password, Role) VALUES ('estark', 'eddard', 'patient');


#staff
DELETE FROM hospital_main.staff;

INSERT INTO hospital_main.staff (UserID, FirstName, LastName, ManagingDoctorID, JobTitle, CurrentlyEmployed) VALUES ('jhalmo', 'Josh', 'Halmo', NULL, 'Doctor', 1);
INSERT INTO hospital_main.staff (UserID, FirstName, LastName, ManagingDoctorID, JobTitle, CurrentlyEmployed) VALUES ('tlannister', 'Tyrion', 'Lannister', 'jhalmo', 'Nurse', 1);
INSERT INTO hospital_main.staff (UserID, FirstName, LastName, ManagingDoctorID, JobTitle, CurrentlyEmployed) VALUES ('jsnow', 'Jon', 'Snow', 'jhalmo', 'Doctor', 1);
INSERT INTO hospital_main.staff (UserID, FirstName, LastName, ManagingDoctorID, JobTitle, CurrentlyEmployed) VALUES ('gzhou', 'Gordon', 'Zhou', NULL, 'Doctor', 1);
INSERT INTO hospital_main.staff (UserID, FirstName, LastName, ManagingDoctorID, JobTitle, CurrentlyEmployed) VALUES ('jlannister', 'Jaime', 'Lannister', 'gzhou', 'Receptionist', 1);
INSERT INTO hospital_main.staff (UserID, FirstName, LastName, ManagingDoctorID, JobTitle, CurrentlyEmployed) VALUES ('ecameracci', 'Eric', 'Cameracci', 'nnarayanan', 'Assistant', 1);
INSERT INTO hospital_main.staff (UserID, FirstName, LastName, ManagingDoctorID, JobTitle, CurrentlyEmployed) VALUES ('nnarayanan', 'Naveen', 'Narayanan', NULL, 'Doctor', 1);
INSERT INTO hospital_main.staff (UserID, FirstName, LastName, ManagingDoctorID, JobTitle, CurrentlyEmployed) VALUES ('astark', 'Arya', 'Stark', 'nnarayanan', 'Nurse', 1);
INSERT INTO hospital_main.staff (UserID, FirstName, LastName, ManagingDoctorID, JobTitle, CurrentlyEmployed) VALUES ('tgreyjoy', 'Theon', 'Greyjoy', 'nnarayanan', 'Nurse', 0);
INSERT INTO hospital_main.staff (UserID, FirstName, LastName, ManagingDoctorID, JobTitle, CurrentlyEmployed) VALUES ('starly', 'Samwell', 'Tarly', NULL, 'Accountant', 1);
INSERT INTO hospital_main.staff (UserID, FirstName, LastName, ManagingDoctorID, JobTitle, CurrentlyEmployed) VALUES ('sclegane', 'Sandor', 'Clegane', 'gzhou', 'Nurse', 1);


#patients
DELETE FROM hospital_main.patients;

INSERT INTO `hospital_main`.`patients` (`UserID`, `FirstName`, `LastName`, `Address`, `City`, `Province`, `Country`, `PostalCode`, `PhoneNumber`, `Email`, `HealthCardNumber`, `SIN`, `Visits`, `DefaultDoctorID`, `HealthStatus`, `PrimaryContactNo`, `Transfered`) VALUES ('dtargaryen', 'Daenerys', 'Targaryen', '4124 Yonge St', 'Toronto', 'ON', 'CAN', 'M4M 1Y3', '4168742538', 'dtargaryen@gmail.com', '331719615031034', '84131811978', '0', 'jhalmo', 'Good', '4162983704', '0');
INSERT INTO `hospital_main`.`patients` (`UserID`, `FirstName`, `LastName`, `Address`, `City`, `Province`, `Country`, `PostalCode`, `PhoneNumber`, `Email`, `HealthCardNumber`, `SIN`, `Visits`, `DefaultDoctorID`, `HealthStatus`, `PrimaryContactNo`, `Transfered`) VALUES ('jmormont', 'Jorah', 'Mormont', '9376 Eglinton Ave', 'Toronto', 'ON', 'CAN', 'M4M 1Y3', '4163576653', 'jmormont@gmail.com', '301843268563971', '44308401202', '0', 'jhalmo', 'Good', '4161636567', '0');
INSERT INTO `hospital_main`.`patients` (`UserID`, `FirstName`, `LastName`, `Address`, `City`, `Province`, `Country`, `PostalCode`, `PhoneNumber`, `Email`, `HealthCardNumber`, `SIN`, `Visits`, `DefaultDoctorID`, `HealthStatus`, `PrimaryContactNo`, `Transfered`) VALUES ('pbaelish', 'Petyr', 'Baelish', '984 Leslie St', 'Toronto', 'ON', 'CAN', 'M6G 2X3', '4161636567', 'pbaelish@gmail.com', '692527775885537', '34101112054', '0', 'gzhou', 'Good', '4167023752', '0');
INSERT INTO `hospital_main`.`patients` (`UserID`, `FirstName`, `LastName`, `Address`, `City`, `Province`, `Country`, `PostalCode`, `PhoneNumber`, `Email`, `HealthCardNumber`, `SIN`, `Visits`, `DefaultDoctorID`, `HealthStatus`, `PrimaryContactNo`, `Transfered`) VALUES ('dseaworth', 'Davos', 'Seaworth', '30 Warden Ave', 'Toronto', 'ON', 'CAN', 'M4Y 1Z9', '4167023752', 'dseaworth@gmail.com', '504710157169029', '15957984612', '0', 'nnarayanan', 'Burnt', '4167668805', '0');
INSERT INTO `hospital_main`.`patients` (`UserID`, `FirstName`, `LastName`, `Address`, `City`, `Province`, `Country`, `PostalCode`, `PhoneNumber`, `Email`, `HealthCardNumber`, `SIN`, `Visits`, `DefaultDoctorID`, `HealthStatus`, `PrimaryContactNo`, `Transfered`) VALUES ('sbaratheon', 'Stannis', 'Baratheon', '3732 Dundas St', 'Toronto', 'ON', 'CAN', 'M6P 9F2', '4162797176', 'sbaratheon@gmail.com', '941054979572072', '94281778343', '0', 'gzhou', 'Good', '4164326843', '0');
INSERT INTO `hospital_main`.`patients` (`UserID`, `FirstName`, `LastName`, `Address`, `City`, `Province`, `Country`, `PostalCode`, `PhoneNumber`, `Email`, `HealthCardNumber`, `SIN`, `Visits`, `DefaultDoctorID`, `HealthStatus`, `PrimaryContactNo`, `Transfered`) VALUES ('mtyrell', 'Margaery', 'Tyrell', '529 Bloor St', 'Toronto', 'ON', 'CAN', 'M5R 1V9', '4169329406', 'mtyrell@gmail.com', '783788585802540', '65865481204', '0', 'nnarayanan', 'Good', '4169503445', '0');
INSERT INTO `hospital_main`.`patients` (`UserID`, `FirstName`, `LastName`, `Address`, `City`, `Province`, `Country`, `PostalCode`, `PhoneNumber`, `Email`, `HealthCardNumber`, `SIN`, `Visits`, `DefaultDoctorID`, `HealthStatus`, `PrimaryContactNo`, `Transfered`) VALUES ('bstark', 'Bran', 'Stark', '767 Church St', 'Toronto', 'ON', 'CAN', 'M4K 3V3', '4160312515', 'bstark@gmail.com', '328387596877292', '61525458716', '0', 'nnarayanan', 'Crippled', '4162815142', '0');
INSERT INTO `hospital_main`.`patients` (`UserID`, `FirstName`, `LastName`, `Address`, `City`, `Province`, `Country`, `PostalCode`, `PhoneNumber`, `Email`, `HealthCardNumber`, `SIN`, `Visits`, `DefaultDoctorID`, `HealthStatus`, `PrimaryContactNo`, `Transfered`) VALUES ('sstark', 'Sansa', 'Stark', '733 Queen St', 'Toronto', 'ON', 'CAN', 'M5V 3W2', '4162050015', 'sstark@gmail.com', '786667223684104', '64020568784', '0', 'gzhou', 'Good', '4165923948', '0');
INSERT INTO `hospital_main`.`patients` (`UserID`, `FirstName`, `LastName`, `Address`, `City`, `Province`, `Country`, `PostalCode`, `PhoneNumber`, `Email`, `HealthCardNumber`, `SIN`, `Visits`, `DefaultDoctorID`, `HealthStatus`, `PrimaryContactNo`, `Transfered`) VALUES ('jbaratheon', 'Joffrey', 'Baratheon', '938 King St', 'Toronto', 'ON', 'CAN', 'M6G 3H2', '4167758334', 'jbaratheon@gmail.com', '855276875430718', '50510450266', '0', 'nnarayanan', 'Good', '4166387639', '0');
INSERT INTO `hospital_main`.`patients` (`UserID`, `FirstName`, `LastName`, `Address`, `City`, `Province`, `Country`, `PostalCode`, `PhoneNumber`, `Email`, `HealthCardNumber`, `SIN`, `Visits`, `DefaultDoctorID`, `HealthStatus`, `PrimaryContactNo`, `Transfered`) VALUES ('cstark', 'Catelyn', 'Stark', '858 Sherbourne St', 'Toronto', 'ON', 'CAN', 'M5T 1L1', '4160640927', 'cstark@gmail.com', '575092055136338', '80566872237', '0', 'gzhou', 'Dead', '4161896588', '0');
INSERT INTO `hospital_main`.`patients` (`UserID`, `FirstName`, `LastName`, `Address`, `City`, `Province`, `Country`, `PostalCode`, `PhoneNumber`, `Email`, `HealthCardNumber`, `SIN`, `Visits`, `DefaultDoctorID`, `HealthStatus`, `PrimaryContactNo`, `Transfered`) VALUES ('rstark', 'Robb', 'Stark', '858 Sherbourne St', 'Toronto', 'ON', 'CAN', 'M5T 1L1', '4167770643', 'rstark@gmail.com', '830636612412214', '4024107545', '0', 'gzhou', 'Dead', '4169993251', '0');
INSERT INTO `hospital_main`.`patients` (`UserID`, `FirstName`, `LastName`, `Address`, `City`, `Province`, `Country`, `PostalCode`, `PhoneNumber`, `Email`, `HealthCardNumber`, `SIN`, `Visits`, `DefaultDoctorID`, `HealthStatus`, `PrimaryContactNo`, `Transfered`) VALUES ('estark', 'Eddard', 'Stark', '858 Sherbourne St', 'Toronto', 'ON', 'CAN', 'M5T 1L1', '4169599215', 'estark@gmail.com', '494409752776846', '48314235569', '0', 'jhalmo', 'Dead', '4164749158', '0');


#province
DELETE FROM hospital_main.province;

INSERT INTO `hospital_main`.`province` (`Code`, `Name`) VALUES ('ON', 'Ontario');
INSERT INTO `hospital_main`.`province` (`Code`, `Name`) VALUES ('BC', 'British Columbia');
INSERT INTO `hospital_main`.`province` (`Code`, `Name`) VALUES ('AB', 'Alberta');
INSERT INTO `hospital_main`.`province` (`Code`, `Name`) VALUES ('SK', 'Saskatchewan');
INSERT INTO `hospital_main`.`province` (`Code`, `Name`) VALUES ('MB', 'Manitoba');
INSERT INTO `hospital_main`.`province` (`Code`, `Name`) VALUES ('QC', 'Quebec');
INSERT INTO `hospital_main`.`province` (`Code`, `Name`) VALUES ('NB', 'New Brunswick');
INSERT INTO `hospital_main`.`province` (`Code`, `Name`) VALUES ('NS', 'Nova Scotia');
INSERT INTO `hospital_main`.`province` (`Code`, `Name`) VALUES ('NL', 'Newfoundland and Labrador');
INSERT INTO `hospital_main`.`province` (`Code`, `Name`) VALUES ('PE', 'Prince Edward Island');
INSERT INTO `hospital_main`.`province` (`Code`, `Name`) VALUES ('YT', 'Yukon');
INSERT INTO `hospital_main`.`province` (`Code`, `Name`) VALUES ('NU', 'Nunavut');
INSERT INTO `hospital_main`.`province` (`Code`, `Name`) VALUES ('NT', 'Northwest Territories');


#country
DELETE FROM hospital_main.country;

INSERT INTO `hospital_main`.`country` (`Code`, `Name`) VALUES ('CAN', 'Canada');


