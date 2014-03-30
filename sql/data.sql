#operations
DELETE FROM hospital_main.operations;

INSERT INTO `hospital_main`.`operations` (`Name`, `Description`, `EstTime`, `ReqJobTitle`) VALUES ('Heart Transplant', 'Replace heart', '4:00', 'Surgeon');
INSERT INTO `hospital_main`.`operations` (`Name`, `Description`, `EstTime`, `ReqJobTitle`) VALUES ('Kidney Transplant', 'Replace kidney', '3:00', 'Surgeon');
INSERT INTO `hospital_main`.`operations` (`Name`, `Description`, `EstTime`, `ReqJobTitle`) VALUES ('Vasectomy', 'Male sterilization', '0:30', 'Surgeon');
INSERT INTO `hospital_main`.`operations` (`Name`, `Description`, `EstTime`, `ReqJobTitle`) VALUES ('Arm Amputation', 'Removal of the arm', '2:00', 'Surgeon');
INSERT INTO `hospital_main`.`operations` (`Name`, `Description`, `EstTime`, `ReqJobTitle`) VALUES ('CT Scan', 'Take images of the brain', '1:00', 'Surgeon');
INSERT INTO `hospital_main`.`operations` (`Name`, `Description`, `EstTime`, `ReqJobTitle`) VALUES ('C-Section', 'Remove baby via incision', '1:00', 'Surgeon');
INSERT INTO `hospital_main`.`operations` (`Name`, `Description`, `EstTime`, `ReqJobTitle`) VALUES ('Plastic Surgury', 'Rebuild the body', '2:00', 'Surgeon');


#drugs
DELETE FROM hospital_main.drugs;

INSERT INTO `hospital_main`.`drugs` (`DIN`, `TradeName`, `Description`) VALUES ('02276054', 'Extra Strength Tylenol Allergy', 'Allergy medicine');
INSERT INTO `hospital_main`.`drugs` (`DIN`, `TradeName`, `Description`) VALUES ('02362643', 'Advil Cold & Flu', 'Cold medicine');
INSERT INTO `hospital_main`.`drugs` (`DIN`, `TradeName`, `Description`) VALUES ('02239766', 'Viagra', 'Erectile dysfunction');
INSERT INTO `hospital_main`.`drugs` (`DIN`, `TradeName`, `Description`) VALUES ('02248809', 'Adderall', 'ADHD treatment');
INSERT INTO `hospital_main`.`drugs` (`DIN`, `TradeName`, `Description`) VALUES ('02237726', 'Aspirin', 'Aches and pain');
INSERT INTO `hospital_main`.`drugs` (`DIN`, `TradeName`, `Description`) VALUES ('02248503', 'Paxil', 'Antidepressant');
INSERT INTO `hospital_main`.`drugs` (`DIN`, `TradeName`, `Description`) VALUES ('02132702', 'Zoloft', 'Antidepressant');
INSERT INTO `hospital_main`.`drugs` (`DIN`, `TradeName`, `Description`) VALUES ('02018985', 'Prozac', 'Antidepressant');
INSERT INTO `hospital_main`.`drugs` (`DIN`, `TradeName`, `Description`) VALUES ('00548359', 'Xanax', 'Antidepressant');
INSERT INTO `hospital_main`.`drugs` (`DIN`, `TradeName`, `Description`) VALUES ('00013285', 'Valium', 'Anxiety, panic attacks, insomnia, and seizures');


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


#users
DELETE FROM hospital_main.users;

INSERT INTO hospital_main.users (UserID, Password, Role) VALUES ('jhalmo', '386a85d8c88778b00b1355608363c7e3078857f3e9633cfd0802d3bf1c0b5b83', 'doctor');
INSERT INTO hospital_main.users (UserID, Password, Role) VALUES ('tlannister', '94c792191e17d3ee525a2e534b8fbdced0e12523b0bc6b70d75f2aaabace48db', 'staff');
INSERT INTO hospital_main.users (UserID, Password, Role) VALUES ('dtargaryen', 'db27c449e5d5067b9419fd1cf7c47edd00523d657e046dd2f83d0cd90af4eaa2', 'patient');
INSERT INTO hospital_main.users (UserID, Password, Role) VALUES ('jsnow', 'bb472edb86809a761936d90c70aeb4346618aa71da7a00c16e334863499108fd', 'doctor');
INSERT INTO hospital_main.users (UserID, Password, Role) VALUES ('gzhou', '9fe93417853739c1c18c2e8b051860d1a317824f1aa91304d16f3fe832486f7a', 'doctor');
INSERT INTO hospital_main.users (UserID, Password, Role) VALUES ('jmormont', 'deac5824a9da4679fd1a0a60b57f6a7a0cb4d986b7c9a1c495a3649319eb7594', 'patient');
INSERT INTO hospital_main.users (UserID, Password, Role) VALUES ('pbaelish', 'f6dfbac1595f62cc8dae6154e22243d0d7d454669316da5df80154b3bf15136f', 'patient');
INSERT INTO hospital_main.users (UserID, Password, Role) VALUES ('jlannister', '2a097b21dfbe7d9b3356a0a4979c5d8f5d4bb47111a9a39656f00dab3d0ddd09', 'staff');
INSERT INTO hospital_main.users (UserID, Password, Role) VALUES ('dseaworth', '32117daa13e13a660a73cd4ae0cb0345b19eb73b343d7bb32e04006bda2f8edf', 'patient');
INSERT INTO hospital_main.users (UserID, Password, Role) VALUES ('sbaratheon', 'a7cb19c2e3b997210acd1eb6a12658e22be7c61944aec8288a31fa450c652432', 'patient');
INSERT INTO hospital_main.users (UserID, Password, Role) VALUES ('mtyrell', '5b6998d988223a2452abab62a7483e04d8e143bbcc660918eaae8ed33f57aff7', 'patient');
INSERT INTO hospital_main.users (UserID, Password, Role) VALUES ('ecameracci', '6f9edcd3408cbda14a837e6a44fc5b7f64ccc9a2477c1498fcb13c777ffb9605', 'staff');
INSERT INTO hospital_main.users (UserID, Password, Role) VALUES ('bstark', '051945a27551270c442208045a38bf38bf4c5b819f1db0f0511ceafa74a2af59', 'patient');
INSERT INTO hospital_main.users (UserID, Password, Role) VALUES ('sstark', 'e8a5ecf39c3d5e2976d8acbf0e990fc9b8e1482128d1c2144c3f41693852c33f', 'patient');
INSERT INTO hospital_main.users (UserID, Password, Role) VALUES ('nnarayanan', 'a5bb9829c699828fa7abf756356dfbbac04cea5a90346435286036c953f7c65f', 'doctor');
INSERT INTO hospital_main.users (UserID, Password, Role) VALUES ('astark', 'b02e06485c54bb8d503d44ab75693665ccfb580a0d5cbd12c488d8c4aab51f37', 'staff');
INSERT INTO hospital_main.users (UserID, Password, Role) VALUES ('tgreyjoy', '4865e43e019d52d21125c9e440c647a3bd412c66ff19272b9d128281d2404ba2', 'staff');
INSERT INTO hospital_main.users (UserID, Password, Role) VALUES ('jbaratheon', 'd2f272763efca04d0705fbb03ca84ab10329dc0419390a681ad07c6a1c3009f3', 'patient');
INSERT INTO hospital_main.users (UserID, Password, Role) VALUES ('starly', 'd6cf30c7139dc46f779bc4151c0466cbce66b6c1b8246d213bb7fdc5432aa2b5', 'finance');
INSERT INTO hospital_main.users (UserID, Password, Role) VALUES ('sclegane', '8d6216813e05489cc3eadbdb74f597b8946824ad82f75177d9399f7980a5d037', 'staff');
INSERT INTO hospital_main.users (UserID, Password, Role) VALUES ('cstark', '5334f1d47daa445295cd3e7ec7a0928f3c925333c06b614f3d35695d28c2bad8', 'patient');
INSERT INTO hospital_main.users (UserID, Password, Role) VALUES ('rstark', 'bbe632c0baeeae82cf72865c745de20ae725faf418f8bfcd174f944a3f12acac', 'patient');
INSERT INTO hospital_main.users (UserID, Password, Role) VALUES ('estark', '3c04b49bd6d1a58956db3c96bf4ca5617b2cc89994d1c7951733d440ad1b888c', 'patient');
INSERT INTO hospital_main.users (UserID, Password, Role) VALUES ('rbolton', 'b493ae6a41c97e073feb610651eb95bfd5ea644a41043ab551a086b1c23ba017', 'legal');
INSERT INTO hospital_main.users (UserID, Password, Role) VALUES ('rsnow', '1b08b1a8b43967edc0f6825cb46c8178e172d5bd191477bfc625adf8cf9e1105', 'it');


#staff
DELETE FROM hospital_main.staff;

INSERT INTO hospital_main.staff (UserID, FirstName, LastName, ManagingDoctorID, JobTitle, CurrentlyEmployed) VALUES ('jhalmo', 'Josh', 'Halmo', NULL, 'Doctor', 1);
INSERT INTO hospital_main.staff (UserID, FirstName, LastName, ManagingDoctorID, JobTitle, CurrentlyEmployed) VALUES ('tlannister', 'Tyrion', 'Lannister', 'jhalmo', 'Nurse', 1);
INSERT INTO hospital_main.staff (UserID, FirstName, LastName, ManagingDoctorID, JobTitle, CurrentlyEmployed) VALUES ('jsnow', 'Jon', 'Snow', NULL, 'Surgeon', 1);
INSERT INTO hospital_main.staff (UserID, FirstName, LastName, ManagingDoctorID, JobTitle, CurrentlyEmployed) VALUES ('gzhou', 'Gordon', 'Zhou', NULL, 'Doctor', 1);
INSERT INTO hospital_main.staff (UserID, FirstName, LastName, ManagingDoctorID, JobTitle, CurrentlyEmployed) VALUES ('jlannister', 'Jaime', 'Lannister', 'gzhou', 'Receptionist', 1);
INSERT INTO hospital_main.staff (UserID, FirstName, LastName, ManagingDoctorID, JobTitle, CurrentlyEmployed) VALUES ('ecameracci', 'Eric', 'Cameracci', 'nnarayanan', 'Assistant', 1);
INSERT INTO hospital_main.staff (UserID, FirstName, LastName, ManagingDoctorID, JobTitle, CurrentlyEmployed) VALUES ('nnarayanan', 'Naveen', 'Narayanan', NULL, 'Doctor', 1);
INSERT INTO hospital_main.staff (UserID, FirstName, LastName, ManagingDoctorID, JobTitle, CurrentlyEmployed) VALUES ('astark', 'Arya', 'Stark', 'nnarayanan', 'Nurse', 1);
INSERT INTO hospital_main.staff (UserID, FirstName, LastName, ManagingDoctorID, JobTitle, CurrentlyEmployed) VALUES ('tgreyjoy', 'Theon', 'Greyjoy', 'nnarayanan', 'Nurse', 0);
INSERT INTO hospital_main.staff (UserID, FirstName, LastName, ManagingDoctorID, JobTitle, CurrentlyEmployed) VALUES ('starly', 'Samwell', 'Tarly', NULL, 'Accountant', 1);
INSERT INTO hospital_main.staff (UserID, FirstName, LastName, ManagingDoctorID, JobTitle, CurrentlyEmployed) VALUES ('sclegane', 'Sandor', 'Clegane', 'gzhou', 'Nurse', 1);
INSERT INTO hospital_main.staff (UserID, FirstName, LastName, ManagingDoctorID, JobTitle, CurrentlyEmployed) VALUES ('rbolton', 'Roose', 'Bolton', NULL, 'Lawyer', 1);
INSERT INTO hospital_main.staff (UserID, FirstName, LastName, ManagingDoctorID, JobTitle, CurrentlyEmployed) VALUES ('rsnow', 'Ramsay', 'Snow', NULL, 'IT', 1);


#patients
DELETE FROM hospital_main.patients;

INSERT INTO `hospital_main`.`patients` (`UserID`, `FirstName`, `LastName`, `Address`, `City`, `Province`, `Country`, `PostalCode`, `PhoneNumber`, `Email`, `HealthCardNumber`, `SIN`, `DefaultDoctorID`, `HealthStatus`, `PrimaryContactNo`, `Transfered`) VALUES ('dtargaryen', 'Daenerys', 'Targaryen', '4124 Yonge St', 'Toronto', 'ON', 'CAN', 'M4M 1Y3', '416-874-2538', 'dtargaryen@gmail.com', '3317-961-031-XJ', '841-181-978', 'jhalmo', 'Good', '416-298-3704', '0');
INSERT INTO `hospital_main`.`patients` (`UserID`, `FirstName`, `LastName`, `Address`, `City`, `Province`, `Country`, `PostalCode`, `PhoneNumber`, `Email`, `HealthCardNumber`, `SIN`, `DefaultDoctorID`, `HealthStatus`, `PrimaryContactNo`, `Transfered`) VALUES ('jmormont', 'Jorah', 'Mormont', '9376 Eglinton Ave', 'Toronto', 'ON', 'CAN', 'M4M 1Y3', '416-357-6653', 'jmormont@gmail.com', '3018-326-563-OI', '443-840-202', 'jhalmo', 'Good', '416-163-6567', '0');
INSERT INTO `hospital_main`.`patients` (`UserID`, `FirstName`, `LastName`, `Address`, `City`, `Province`, `Country`, `PostalCode`, `PhoneNumber`, `Email`, `HealthCardNumber`, `SIN`, `DefaultDoctorID`, `HealthStatus`, `PrimaryContactNo`, `Transfered`) VALUES ('pbaelish', 'Petyr', 'Baelish', '984 Leslie St', 'Toronto', 'ON', 'CAN', 'M6G 2X3', '416-163-6567', 'pbaelish@gmail.com', '6925-777-885-AV', '341-111-054', 'gzhou', 'Good', '416-702-3752', '0');
INSERT INTO `hospital_main`.`patients` (`UserID`, `FirstName`, `LastName`, `Address`, `City`, `Province`, `Country`, `PostalCode`, `PhoneNumber`, `Email`, `HealthCardNumber`, `SIN`, `DefaultDoctorID`, `HealthStatus`, `PrimaryContactNo`, `Transfered`) VALUES ('dseaworth', 'Davos', 'Seaworth', '30 Warden Ave', 'Toronto', 'ON', 'CAN', 'M4Y 1Z9', '416-702-3752', 'dseaworth@gmail.com', '5047-015-169-PK', '159-798-612', 'nnarayanan', 'Burnt', '416-766-8805', '0');
INSERT INTO `hospital_main`.`patients` (`UserID`, `FirstName`, `LastName`, `Address`, `City`, `Province`, `Country`, `PostalCode`, `PhoneNumber`, `Email`, `HealthCardNumber`, `SIN`, `DefaultDoctorID`, `HealthStatus`, `PrimaryContactNo`, `Transfered`) VALUES ('sbaratheon', 'Stannis', 'Baratheon', '3732 Dundas St', 'Toronto', 'ON', 'CAN', 'M6P 9F2', '416-279-7176', 'sbaratheon@gmail.com', '9410-497-572-MF', '942-177-343', 'gzhou', 'Good', '416-432-6843', '0');
INSERT INTO `hospital_main`.`patients` (`UserID`, `FirstName`, `LastName`, `Address`, `City`, `Province`, `Country`, `PostalCode`, `PhoneNumber`, `Email`, `HealthCardNumber`, `SIN`, `DefaultDoctorID`, `HealthStatus`, `PrimaryContactNo`, `Transfered`) VALUES ('mtyrell', 'Margaery', 'Tyrell', '529 Bloor St', 'Toronto', 'ON', 'CAN', 'M5R 1V9', '416-932-9406', 'mtyrell@gmail.com', '7837-858-802-PV', '658-548-204', 'nnarayanan', 'Good', '416-950-3445', '0');
INSERT INTO `hospital_main`.`patients` (`UserID`, `FirstName`, `LastName`, `Address`, `City`, `Province`, `Country`, `PostalCode`, `PhoneNumber`, `Email`, `HealthCardNumber`, `SIN`, `DefaultDoctorID`, `HealthStatus`, `PrimaryContactNo`, `Transfered`) VALUES ('bstark', 'Bran', 'Stark', '767 Church St', 'Toronto', 'ON', 'CAN', 'M4K 3V3', '416-031-2515', 'bstark@gmail.com', '3283-759-877-ED', '615-545-716', 'nnarayanan', 'Crippled', '416-281-5142', '0');
INSERT INTO `hospital_main`.`patients` (`UserID`, `FirstName`, `LastName`, `Address`, `City`, `Province`, `Country`, `PostalCode`, `PhoneNumber`, `Email`, `HealthCardNumber`, `SIN`, `DefaultDoctorID`, `HealthStatus`, `PrimaryContactNo`, `Transfered`) VALUES ('sstark', 'Sansa', 'Stark', '733 Queen St', 'Toronto', 'ON', 'CAN', 'M5V 3W2', '416-205-0015', 'sstark@gmail.com', '7866-722-684-HW', '640-056-784', 'gzhou', 'Good', '416-592-3948', '0');
INSERT INTO `hospital_main`.`patients` (`UserID`, `FirstName`, `LastName`, `Address`, `City`, `Province`, `Country`, `PostalCode`, `PhoneNumber`, `Email`, `HealthCardNumber`, `SIN`, `DefaultDoctorID`, `HealthStatus`, `PrimaryContactNo`, `Transfered`) VALUES ('jbaratheon', 'Joffrey', 'Baratheon', '938 King St', 'Toronto', 'ON', 'CAN', 'M6G 3H2', '416-775-8334', 'jbaratheon@gmail.com', '8552-687-430-RF', '505-045-266', 'nnarayanan', 'Good', '416-638-7639', '0');
INSERT INTO `hospital_main`.`patients` (`UserID`, `FirstName`, `LastName`, `Address`, `City`, `Province`, `Country`, `PostalCode`, `PhoneNumber`, `Email`, `HealthCardNumber`, `SIN`, `DefaultDoctorID`, `HealthStatus`, `PrimaryContactNo`, `Transfered`) VALUES ('cstark', 'Catelyn', 'Stark', '858 Sherbourne St', 'Toronto', 'ON', 'CAN', 'M5T 1L1', '416-064-0927', 'cstark@gmail.com', '5750-205-136-ME', '805-687-237', 'gzhou', 'Dead', '416-189-6588', '0');
INSERT INTO `hospital_main`.`patients` (`UserID`, `FirstName`, `LastName`, `Address`, `City`, `Province`, `Country`, `PostalCode`, `PhoneNumber`, `Email`, `HealthCardNumber`, `SIN`, `DefaultDoctorID`, `HealthStatus`, `PrimaryContactNo`, `Transfered`) VALUES ('rstark', 'Robb', 'Stark', '858 Sherbourne St', 'Toronto', 'ON', 'CAN', 'M5T 1L1', '416-777-0643', 'rstark@gmail.com', '8306-661-412-CM', '402-410-545', 'gzhou', 'Dead', '416-999-3251', '0');
INSERT INTO `hospital_main`.`patients` (`UserID`, `FirstName`, `LastName`, `Address`, `City`, `Province`, `Country`, `PostalCode`, `PhoneNumber`, `Email`, `HealthCardNumber`, `SIN`, `DefaultDoctorID`, `HealthStatus`, `PrimaryContactNo`, `Transfered`) VALUES ('estark', 'Eddard', 'Stark', '858 Sherbourne St', 'Toronto', 'ON', 'CAN', 'M5T 1L1', '416-999-2125', 'estark@gmail.com', '4944-975-776-LK', '483-423-569', 'jhalmo', 'Dead', '416-474-9158', '0');


#visitation
DELETE FROM hospital_main.visitation;

INSERT INTO hospital_main.visitation (PatientID, DoctorID, Symptoms, Diagnosis, Type, Length, Comments, DateTime, Timestamp, ApptComplete, Cancelled) VALUES ('dtargaryen', 'jhalmo', 'Always hot', 'Albinism', 'Checkup', '00:30:00', 'I am not a doctor', '2014-03-25 01:02:03', '2014-03-12 01:02:03', '1', '0');
INSERT INTO hospital_main.visitation (PatientID, DoctorID, Symptoms, Diagnosis, Type, Length, Comments, DateTime, Timestamp, ApptComplete, Cancelled) VALUES ('jmormont', 'jhalmo', 'Balding', 'Anthrax', 'Checkup', '01:20:00', 'I am not a doctor', '2014-03-25 02:03:04', '2014-03-13 02:03:04', '1', '0');
INSERT INTO hospital_main.visitation (PatientID, DoctorID, Symptoms, Diagnosis, Type, Length, Comments, DateTime, Timestamp, ApptComplete, Cancelled) VALUES ('pbaelish', 'gzhou', 'Smaller than normal fingers', 'Arthritis', 'Checkup', '00:30:00', 'I am not a doctor', '2014-03-25 03:04:05', '2014-03-14 03:04:05', '1', '0');
INSERT INTO hospital_main.visitation (PatientID, DoctorID, Symptoms, Diagnosis, Type, Length, Comments, DateTime, Timestamp, ApptComplete, Cancelled) VALUES ('dseaworth', 'nnarayanan', 'First joints of the fingers of his left hand are missing', 'Arthritis', 'Surgury', '02:00:00', 'I am not a doctor', '2014-03-25 04:05:06', '2014-03-15 04:05:06', '1', '0');
INSERT INTO hospital_main.visitation (PatientID, DoctorID, Symptoms, Diagnosis, Type, Length, Comments, DateTime, Timestamp, ApptComplete, Cancelled) VALUES ('sbaratheon', 'gzhou', 'Dyslexia', 'Dyslexia', 'Checkup', '01:40:00', 'I am not a doctor', '2014-03-25 05:06:07', '2014-03-16 05:06:07', '1', '0');
INSERT INTO hospital_main.visitation (PatientID, DoctorID, Symptoms, Diagnosis, Type, Length, Comments, DateTime, Timestamp, ApptComplete, Cancelled) VALUES ('mtyrell', 'nnarayanan', 'Crooked mouth', 'Tooth decay', 'Checkup', '00:45:00', 'I am not a doctor', '2014-03-25 06:07:08', '2014-03-17 06:07:08', '1', '0');
INSERT INTO hospital_main.visitation (PatientID, DoctorID, Symptoms, Diagnosis, Type, Length, Comments, DateTime, Timestamp, ApptComplete, Cancelled) VALUES ('bstark', 'nnarayanan', 'Paralyzed from the waist down', 'Paralysis', 'Surgury', '06:15:00', 'I am not a doctor', '2014-03-25 07:08:09', '2014-03-18 07:08:09', '1', '0');
INSERT INTO hospital_main.visitation (PatientID, DoctorID, Symptoms, Diagnosis, Type, Length, Comments, DateTime, Timestamp, ApptComplete, Cancelled) VALUES ('sstark', 'gzhou', 'Emotional roalercoaster', 'Puberty', 'Checkup', '00:30:00', 'I am not a doctor', '2014-03-25 11:00:00', '2014-03-18 11:00:00', '1', '0');
INSERT INTO hospital_main.visitation (PatientID, DoctorID, Symptoms, Diagnosis, Type, Length, Comments, DateTime, Timestamp, ApptComplete, Cancelled) VALUES ('jbaratheon', 'nnarayanan', 'Full of hot air', 'Anthrax', 'Checkup', '00:55:00', 'I am not a doctor', '2014-03-30 11:00:00', '2014-03-18 11:00:00', '1', '0');
INSERT INTO hospital_main.visitation (PatientID, DoctorID, Symptoms, Diagnosis, Type, Length, Comments, DateTime, Timestamp, ApptComplete, Cancelled) VALUES ('cstark', 'gzhou', 'Old', 'Arthritis', 'Surgury', '01:00:00', 'I am not a doctor', '2014-03-30 13:00:00', '2014-03-18 13:00:00', '1', '0');
INSERT INTO hospital_main.visitation (PatientID, DoctorID, Symptoms, Diagnosis, Type, Length, Comments, DateTime, Timestamp, ApptComplete, Cancelled) VALUES ('rstark', 'gzhou', 'Pain in his chest', 'Asthma', 'Checkup', '00:45:00', 'I am not a doctor', '2014-03-30 14:00:00', '2014-03-18 14:00:00', '1', '0');
INSERT INTO hospital_main.visitation (PatientID, DoctorID, Symptoms, Diagnosis, Type, Length, Comments, DateTime, Timestamp, ApptComplete, Cancelled) VALUES ('estark', 'jhalmo', 'Neck pain', 'Pulled muscle', 'Surgury', '03:20:00', 'I am not a doctor', '2014-03-30 14:00:00', '2014-03-18 14:00:01', '1', '0');
INSERT INTO hospital_main.visitation (PatientID, DoctorID, Symptoms, Diagnosis, Type, Length, Comments, DateTime, Timestamp, ApptComplete, Cancelled) VALUES ('mtyrell', 'nnarayanan', 'Dizzy', 'Migrane', 'Followup', '00:30:00', 'I am not a doctor', '2014-03-30 15:00:00', '2014-03-18 15:00:00', '1', '0');
INSERT INTO hospital_main.visitation (PatientID, DoctorID, Symptoms, Diagnosis, Type, Length, Comments, DateTime, Timestamp, ApptComplete, Cancelled) VALUES ('rstark', 'gzhou', 'Coughing up blood', 'Asthma', 'Followup', '00:35:00', 'I am not a doctor', '2014-03-30 15:00:00', '2014-03-18 15:00:01', '0', '1');
INSERT INTO hospital_main.visitation (PatientID, DoctorID, Symptoms, Diagnosis, Type, Length, Comments, DateTime, Timestamp, ApptComplete, Cancelled) VALUES ('jbaratheon', 'nnarayanan', 'Uncontrollable temper', 'Puberty', 'Checkup', '00:30:00', 'I am not a doctor', '2014-03-31 16:00:00', '2014-03-18 16:00:00', '0', '0');
INSERT INTO hospital_main.visitation (PatientID, DoctorID, Symptoms, Diagnosis, Type, Length, Comments, DateTime, Timestamp, ApptComplete, Cancelled) VALUES ('mtyrell', 'nnarayanan', 'Unblemished skin', 'Acne', 'Checkup', '00:30:00', 'I am not a doctor', '2014-03-31 16:30:00', '2014-03-18 16:30:00', '0', '1');
INSERT INTO hospital_main.visitation (PatientID, DoctorID, Symptoms, Diagnosis, Type, Length, Comments, DateTime, Timestamp, ApptComplete, Cancelled) VALUES ('jmormont', 'jhalmo', 'Mid-life crisis', 'Arthritis', 'Surgury', '00:40:00', 'I am not a doctor', '2014-03-31 16:00:00', '2014-03-18 16:00:00', '0', '0');
INSERT INTO hospital_main.visitation (PatientID, DoctorID, Symptoms, Diagnosis, Type, Length, Comments, DateTime, Timestamp, ApptComplete, Cancelled) VALUES ('estark', 'jhalmo', 'Neck pain has spread', 'Pulled muscle', 'Surgury', '05:15:00', 'I am not a doctor', '2014-04-01 09:00:00', '2014-03-19 09:00:00', '0', '0');
INSERT INTO hospital_main.visitation (PatientID, DoctorID, Symptoms, Diagnosis, Type, Length, Comments, DateTime, Timestamp, ApptComplete, Cancelled) VALUES ('cstark', 'gzhou', 'Long fingers', 'Arthritis', 'Surgury', '00:30:00', 'I am not a doctor', '2014-04-01 09:30:00', '2014-03-19 09:30:00', '0', '1');
INSERT INTO hospital_main.visitation (PatientID, DoctorID, Symptoms, Diagnosis, Type, Length, Comments, DateTime, Timestamp, ApptComplete, Cancelled) VALUES ('sstark', 'gzhou', 'Pain in stomach', 'Puberty', 'Checkup', '00:30:00', 'I am not a doctor', '2014-04-01 10:00:00', '2014-03-19 10:00:00', '0', '0');
INSERT INTO hospital_main.visitation (PatientID, DoctorID, Symptoms, Diagnosis, Type, Length, Comments, DateTime, Timestamp, ApptComplete, Cancelled) VALUES ('estark', 'jhalmo', 'Burning sensation in his neck', 'Pulled muscle', 'Followup', '00:35:00', 'I am not a doctor', '2014-04-01 11:00:00', '2014-03-19 11:00:00', '0', '0');
INSERT INTO hospital_main.visitation (PatientID, DoctorID, Symptoms, Diagnosis, Type, Length, Comments, DateTime, Timestamp, ApptComplete, Cancelled) VALUES ('pbaelish', 'gzhou', 'Pain in fingers', 'Anthrax', 'Checkup', '00:50:00', 'I am not a doctor', '2014-04-02 13:00:00', '2014-03-19 13:00:00', '0', '0');
INSERT INTO hospital_main.visitation (PatientID, DoctorID, Symptoms, Diagnosis, Type, Length, Comments, DateTime, Timestamp, ApptComplete, Cancelled) VALUES ('estark', 'jhalmo', 'Feels very light headed', 'Pulled muscle', 'Surgury', '00:30:00', 'I am not a doctor', '2014-04-02 14:00:00', '2014-03-19 14:00:00', '0', '0');
INSERT INTO hospital_main.visitation (VisitID, PatientID, DoctorID, Symptoms, Diagnosis, Type, Length, Comments, DateTime, Timestamp, ApptComplete, Cancelled) VALUES (20, 'sstark', 'gzhou', 'Pain in stomach', 'Puberty', 'Checkup', '00:30:00', 'I am not a doctor', '2014-04-02 10:00:00', '2014-03-18 10:00:00', '0', '0');


#doctor patient permission
DELETE FROM hospital_main.doctorpatientperm;

INSERT INTO `hospital_main`.`doctorpatientperm` (`PatientID`, `DoctorID`, `SecDoctorID`, `Expiry`) VALUES ('pbaelish', 'gzhou', 'nnarayanan', '2015-04-20');
INSERT INTO `hospital_main`.`doctorpatientperm` (`PatientID`, `DoctorID`, `SecDoctorID`, `Expiry`) VALUES ('mtyrell', 'nnarayanan', 'gzhou', '2015-03-14');
INSERT INTO `hospital_main`.`doctorpatientperm` (`PatientID`, `DoctorID`, `SecDoctorID`, `Expiry`) VALUES ('dtargaryen', 'jhalmo', 'gzhou', '2015-04-14');

#prescriptions
DELETE FROM hospital_main.prescriptions;

INSERT INTO hospital_main.prescriptions (VisitID, DIN, Quantity, Refills, Dosage, Expiry) VALUES ('1', '00013285', '250', '1', 'Once in before breakfast', '2015-04-15 11:59:59');
INSERT INTO hospital_main.prescriptions (VisitID, DIN, Quantity, Refills, Dosage, Expiry) VALUES ('2', '02237726', '500', '5', 'Maximum 3 times per day', '2016-09-05 11:59:59');
INSERT INTO hospital_main.prescriptions (VisitID, DIN, Quantity, Refills, Dosage, Expiry) VALUES ('2', '02248809', '123', '2', 'Maximum 2 times per week', '2015-09-05 11:59:59');
INSERT INTO hospital_main.prescriptions (VisitID, DIN, Quantity, Refills, Dosage, Expiry) VALUES ('4', '02248809', '100', '8', 'Once before bed', '2020-01-02 11:59:59');
INSERT INTO hospital_main.prescriptions (VisitID, DIN, Quantity, Refills, Dosage, Expiry) VALUES ('6', '02237726', '300', '3', 'Whenever there is pain', '2015-01-09 11:59:59');
INSERT INTO hospital_main.prescriptions (VisitID, DIN, Quantity, Refills, Dosage, Expiry) VALUES ('8', '02132702', '1000', '2', 'Taken twice a day, once after waking up, once before going to bed', '2018-08-08 11:59:59');
INSERT INTO hospital_main.prescriptions (VisitID, DIN, Quantity, Refills, Dosage, Expiry) VALUES ('10', '02276054', '800', '5', 'Take before performing strenuous activity', '2017-06-06 11:59:59');
INSERT INTO hospital_main.prescriptions (VisitID, DIN, Quantity, Refills, Dosage, Expiry) VALUES ('12', '00013285', '400', '10', 'Once before each meal', '2014-12-12 11:59:59');
INSERT INTO hospital_main.prescriptions (VisitID, DIN, Quantity, Refills, Dosage, Expiry) VALUES ('22', '00013285', '300', '10', 'Once before each meal', '2014-12-12 11:59:59');

#scheduled operations
DELETE FROM hospital_main.scheduledoperations;

INSERT INTO hospital_main.scheduledoperations (VisitID, OperationDateTime, OperationName, DoctorID) VALUES ('3', '2014-03-13 13:00:00', 'Arm Amputation', 'jsnow');
INSERT INTO hospital_main.scheduledoperations (VisitID, OperationDateTime, OperationName, DoctorID) VALUES ('9', '2014-03-15 9:00:00', 'Plastic Surgury', 'jsnow');
INSERT INTO hospital_main.scheduledoperations (VisitID, OperationDateTime, OperationName, DoctorID) VALUES ('11', '2014-03-24 10:30:00', 'CT Scan', 'jsnow');
INSERT INTO hospital_main.scheduledoperations (VisitID, OperationDateTime, OperationName, DoctorID) VALUES ('16', '2014-05-09 04:15:00', 'Vasectomy', 'jsnow');
INSERT INTO hospital_main.scheduledoperations (VisitID, OperationDateTime, OperationName, DoctorID) VALUES ('17', '2014-07-17 19:45:00', 'Heart Transplant', 'jsnow');
INSERT INTO hospital_main.scheduledoperations (VisitID, OperationDateTime, OperationName, DoctorID) VALUES ('18', '2014-12-01 12:05:00', 'Kidney Transplant', 'jsnow');
INSERT INTO hospital_main.scheduledoperations (VisitID, OperationDateTime, OperationName, DoctorID) VALUES ('22', '2015-01-22 11:35:00', 'C-Section', 'jsnow');
