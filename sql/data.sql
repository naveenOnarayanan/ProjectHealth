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

INSERT INTO `hospital_main`.`patients` (`UserID`, `FirstName`, `LastName`, `Address`, `City`, `Province`, `Country`, `PostalCode`, `PhoneNumber`, `Email`, `HealthCardNumber`, `SIN`, `Visits`, `DefaultDoctorID`, `HealthStatus`, `PrimaryContactNo`, `Transfered`) VALUES ('dtargaryen', 'Daenerys', 'Targaryen', '4124 Yonge St', 'Toronto', 'ON', 'CAN', 'M4M 1Y3', '416-874-2538', 'dtargaryen@gmail.com', '3317-961-031-XJ', '841-181-978', '0', 'jhalmo', 'Good', '416-298-3704', '0');
INSERT INTO `hospital_main`.`patients` (`UserID`, `FirstName`, `LastName`, `Address`, `City`, `Province`, `Country`, `PostalCode`, `PhoneNumber`, `Email`, `HealthCardNumber`, `SIN`, `Visits`, `DefaultDoctorID`, `HealthStatus`, `PrimaryContactNo`, `Transfered`) VALUES ('jmormont', 'Jorah', 'Mormont', '9376 Eglinton Ave', 'Toronto', 'ON', 'CAN', 'M4M 1Y3', '416-357-6653', 'jmormont@gmail.com', '3018-326-563-OI', '443-840-202', '0', 'jhalmo', 'Good', '416-163-6567', '0');
INSERT INTO `hospital_main`.`patients` (`UserID`, `FirstName`, `LastName`, `Address`, `City`, `Province`, `Country`, `PostalCode`, `PhoneNumber`, `Email`, `HealthCardNumber`, `SIN`, `Visits`, `DefaultDoctorID`, `HealthStatus`, `PrimaryContactNo`, `Transfered`) VALUES ('pbaelish', 'Petyr', 'Baelish', '984 Leslie St', 'Toronto', 'ON', 'CAN', 'M6G 2X3', '416-163-6567', 'pbaelish@gmail.com', '6925-777-885-AV', '341-111-054', '0', 'gzhou', 'Good', '416-702-3752', '0');
INSERT INTO `hospital_main`.`patients` (`UserID`, `FirstName`, `LastName`, `Address`, `City`, `Province`, `Country`, `PostalCode`, `PhoneNumber`, `Email`, `HealthCardNumber`, `SIN`, `Visits`, `DefaultDoctorID`, `HealthStatus`, `PrimaryContactNo`, `Transfered`) VALUES ('dseaworth', 'Davos', 'Seaworth', '30 Warden Ave', 'Toronto', 'ON', 'CAN', 'M4Y 1Z9', '416-702-3752', 'dseaworth@gmail.com', '5047-015-169-PK', '159-798-612', '0', 'nnarayanan', 'Burnt', '416-766-8805', '0');
INSERT INTO `hospital_main`.`patients` (`UserID`, `FirstName`, `LastName`, `Address`, `City`, `Province`, `Country`, `PostalCode`, `PhoneNumber`, `Email`, `HealthCardNumber`, `SIN`, `Visits`, `DefaultDoctorID`, `HealthStatus`, `PrimaryContactNo`, `Transfered`) VALUES ('sbaratheon', 'Stannis', 'Baratheon', '3732 Dundas St', 'Toronto', 'ON', 'CAN', 'M6P 9F2', '416-279-7176', 'sbaratheon@gmail.com', '9410-497-572-MF', '942-177-343', '0', 'gzhou', 'Good', '416-432-6843', '0');
INSERT INTO `hospital_main`.`patients` (`UserID`, `FirstName`, `LastName`, `Address`, `City`, `Province`, `Country`, `PostalCode`, `PhoneNumber`, `Email`, `HealthCardNumber`, `SIN`, `Visits`, `DefaultDoctorID`, `HealthStatus`, `PrimaryContactNo`, `Transfered`) VALUES ('mtyrell', 'Margaery', 'Tyrell', '529 Bloor St', 'Toronto', 'ON', 'CAN', 'M5R 1V9', '416-932-9406', 'mtyrell@gmail.com', '7837-858-802-PV', '658-548-204', '0', 'nnarayanan', 'Good', '416-950-3445', '0');
INSERT INTO `hospital_main`.`patients` (`UserID`, `FirstName`, `LastName`, `Address`, `City`, `Province`, `Country`, `PostalCode`, `PhoneNumber`, `Email`, `HealthCardNumber`, `SIN`, `Visits`, `DefaultDoctorID`, `HealthStatus`, `PrimaryContactNo`, `Transfered`) VALUES ('bstark', 'Bran', 'Stark', '767 Church St', 'Toronto', 'ON', 'CAN', 'M4K 3V3', '416-031-2515', 'bstark@gmail.com', '3283-759-877-ED', '615-545-716', '0', 'nnarayanan', 'Crippled', '416-281-5142', '0');
INSERT INTO `hospital_main`.`patients` (`UserID`, `FirstName`, `LastName`, `Address`, `City`, `Province`, `Country`, `PostalCode`, `PhoneNumber`, `Email`, `HealthCardNumber`, `SIN`, `Visits`, `DefaultDoctorID`, `HealthStatus`, `PrimaryContactNo`, `Transfered`) VALUES ('sstark', 'Sansa', 'Stark', '733 Queen St', 'Toronto', 'ON', 'CAN', 'M5V 3W2', '416-205-0015', 'sstark@gmail.com', '7866-722-684-HW', '640-056-784', '0', 'gzhou', 'Good', '416-592-3948', '0');
INSERT INTO `hospital_main`.`patients` (`UserID`, `FirstName`, `LastName`, `Address`, `City`, `Province`, `Country`, `PostalCode`, `PhoneNumber`, `Email`, `HealthCardNumber`, `SIN`, `Visits`, `DefaultDoctorID`, `HealthStatus`, `PrimaryContactNo`, `Transfered`) VALUES ('jbaratheon', 'Joffrey', 'Baratheon', '938 King St', 'Toronto', 'ON', 'CAN', 'M6G 3H2', '416-775-8334', 'jbaratheon@gmail.com', '8552-687-430-RF', '505-045-266', '0', 'nnarayanan', 'Good', '416-638-7639', '0');
INSERT INTO `hospital_main`.`patients` (`UserID`, `FirstName`, `LastName`, `Address`, `City`, `Province`, `Country`, `PostalCode`, `PhoneNumber`, `Email`, `HealthCardNumber`, `SIN`, `Visits`, `DefaultDoctorID`, `HealthStatus`, `PrimaryContactNo`, `Transfered`) VALUES ('cstark', 'Catelyn', 'Stark', '858 Sherbourne St', 'Toronto', 'ON', 'CAN', 'M5T 1L1', '416-064-0927', 'cstark@gmail.com', '5750-205-136-ME', '805-687-237', '0', 'gzhou', 'Dead', '416-189-6588', '0');
INSERT INTO `hospital_main`.`patients` (`UserID`, `FirstName`, `LastName`, `Address`, `City`, `Province`, `Country`, `PostalCode`, `PhoneNumber`, `Email`, `HealthCardNumber`, `SIN`, `Visits`, `DefaultDoctorID`, `HealthStatus`, `PrimaryContactNo`, `Transfered`) VALUES ('rstark', 'Robb', 'Stark', '858 Sherbourne St', 'Toronto', 'ON', 'CAN', 'M5T 1L1', '416-777-0643', 'rstark@gmail.com', '8306-661-412-CM', '402-410-545', '0', 'gzhou', 'Dead', '416-999-3251', '0');
INSERT INTO `hospital_main`.`patients` (`UserID`, `FirstName`, `LastName`, `Address`, `City`, `Province`, `Country`, `PostalCode`, `PhoneNumber`, `Email`, `HealthCardNumber`, `SIN`, `Visits`, `DefaultDoctorID`, `HealthStatus`, `PrimaryContactNo`, `Transfered`) VALUES ('estark', 'Eddard', 'Stark', '858 Sherbourne St', 'Toronto', 'ON', 'CAN', 'M5T 1L1', '416-9599-215', 'estark@gmail.com', '4944-975-776-LK', '483-423-569', '0', 'jhalmo', 'Dead', '416-474-9158', '0');


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


#visitation
DELETE FROM hospital_main.visitation;

INSERT INTO hospital_main.visitation (VisitID, PatientID, DoctorID, Symptoms, Diagnosis, Type, Length, Comments, DateTime, Timestamp, ApptComplete, Cancelled) VALUES ('0', 'dtargaryen', 'jhalmo', 'Always hot', 'Albinism', 'Checkup', '00:10:00', 'I am not a doctor', '2012-01-12 01:02:03', '2012-01-12 01:02:03', '1', '0');
INSERT INTO hospital_main.visitation (VisitID, PatientID, DoctorID, Symptoms, Diagnosis, Type, Length, Comments, DateTime, Timestamp, ApptComplete, Cancelled) VALUES ('1', 'jmormont', 'jhalmo', 'Balding', 'Anthrax', 'Checkup', '01:20:00', 'I am not a doctor', '2012-02-13 02:03:04', '2012-02-13 02:03:04', '1', '0');
INSERT INTO hospital_main.visitation (VisitID, PatientID, DoctorID, Symptoms, Diagnosis, Type, Length, Comments, DateTime, Timestamp, ApptComplete, Cancelled) VALUES ('2', 'pbaelish', 'gzhou', 'Smaller than normal fingers', 'Arthritis', 'Checkup', '00:20:00', 'I am not a doctor', '2012-03-14 03:04:05', '2012-03-14 03:04:05', '1', '0');
INSERT INTO hospital_main.visitation (VisitID, PatientID, DoctorID, Symptoms, Diagnosis, Type, Length, Comments, DateTime, Timestamp, ApptComplete, Cancelled) VALUES ('3', 'dseaworth', 'nnarayanan', 'First joints of the fingers of his left hand are missing', 'Arthritis', 'Surgury', '02:00:00', 'I am not a doctor', '2013-04-15 04:05:06', '2013-04-15 04:05:06', '1', '0');
INSERT INTO hospital_main.visitation (VisitID, PatientID, DoctorID, Symptoms, Diagnosis, Type, Length, Comments, DateTime, Timestamp, ApptComplete, Cancelled) VALUES ('4', 'sbaratheon', 'gzhou', 'Dyslexia', 'Dyslexia', 'Checkup', '01:40:00', 'I am not a doctor', '2013-05-16 05:06:07', '2013-05-16 05:06:07', '1', '0');
INSERT INTO hospital_main.visitation (VisitID, PatientID, DoctorID, Symptoms, Diagnosis, Type, Length, Comments, DateTime, Timestamp, ApptComplete, Cancelled) VALUES ('5', 'mtyrell', 'nnarayanan', 'Crooked mouth', 'Tooth decay', 'Checkup', '00:45:00', 'I am not a doctor', '2013-06-17 06:07:08', '2013-06-17 06:07:08', '1', '0');
INSERT INTO hospital_main.visitation (VisitID, PatientID, DoctorID, Symptoms, Diagnosis, Type, Length, Comments, DateTime, Timestamp, ApptComplete, Cancelled) VALUES ('6', 'bstark', 'nnarayanan', 'Paralyzed from the waist down', 'Paralysis', 'Surgury', '06:15:00', 'I am not a doctor', '2013-07-18 07:08:09', '2013-07-18 07:08:09', '1', '0');
INSERT INTO hospital_main.visitation (VisitID, PatientID, DoctorID, Symptoms, Diagnosis, Type, Length, Comments, DateTime, Timestamp, ApptComplete, Cancelled) VALUES ('7', 'sstark', 'gzhou', 'Emotional roalercoaster', 'Puberty', 'Checkup', '00:20:00', 'I am not a doctor', '2014-03-18 11:59:59', '2014-03-18 11:59:59', '1', '0');
INSERT INTO hospital_main.visitation (VisitID, PatientID, DoctorID, Symptoms, Diagnosis, Type, Length, Comments, DateTime, Timestamp, ApptComplete, Cancelled) VALUES ('8', 'jbaratheon', 'nnarayanan', 'Full of hot air', 'Anthrax', 'Checkup', '00:55:00', 'I am not a doctor', '2014-03-18 11:59:59', '2014-03-18 11:59:59', '1', '0');
INSERT INTO hospital_main.visitation (VisitID, PatientID, DoctorID, Symptoms, Diagnosis, Type, Length, Comments, DateTime, Timestamp, ApptComplete, Cancelled) VALUES ('9', 'cstark', 'gzhou', 'Old', 'Arthritis', 'Surgury', '01:25:00', 'I am not a doctor', '2014-03-18 11:59:59', '2014-03-18 11:59:59', '1', '0');
INSERT INTO hospital_main.visitation (VisitID, PatientID, DoctorID, Symptoms, Diagnosis, Type, Length, Comments, DateTime, Timestamp, ApptComplete, Cancelled) VALUES ('10', 'rstark', 'gzhou', 'Pain in his chest', 'Asthma', 'Checkup', '00:45:00', 'I am not a doctor', '2014-03-18 11:59:59', '2014-03-18 11:59:59', '1', '0');
INSERT INTO hospital_main.visitation (VisitID, PatientID, DoctorID, Symptoms, Diagnosis, Type, Length, Comments, DateTime, Timestamp, ApptComplete, Cancelled) VALUES ('11', 'estark', 'jhalmo', 'Neck pain', 'Pulled muscle', 'Surgury', '03:20:00', 'I am not a doctor', '2014-03-18 11:59:59', '2014-03-18 11:59:59', '1', '0');
INSERT INTO hospital_main.visitation (VisitID, PatientID, DoctorID, Symptoms, Diagnosis, Type, Length, Comments, DateTime, Timestamp, ApptComplete, Cancelled) VALUES ('12', 'mtyrell', 'nnarayanan', 'Dizzy', 'Migrane', 'Followup', '00:15:00', 'I am not a doctor', '2014-03-18 11:59:59', '2014-03-18 11:59:59', '0', '0');
INSERT INTO hospital_main.visitation (VisitID, PatientID, DoctorID, Symptoms, Diagnosis, Type, Length, Comments, DateTime, Timestamp, ApptComplete, Cancelled) VALUES ('13', 'rstark', 'gzhou', 'Coughing up blood', 'Asthma', 'Followup', '00:35:00', 'I am not a doctor', '2014-03-18 11:59:59', '2014-03-18 11:59:59', '0', '1');
INSERT INTO hospital_main.visitation (VisitID, PatientID, DoctorID, Symptoms, Diagnosis, Type, Length, Comments, DateTime, Timestamp, ApptComplete, Cancelled) VALUES ('14', 'jbaratheon', 'nnarayanan', 'Uncontrollable temper', 'Puberty', 'Checkup', '00:10:00', 'I am not a doctor', '2014-03-18 11:59:59', '2014-03-18 11:59:59', '0', '0');
INSERT INTO hospital_main.visitation (VisitID, PatientID, DoctorID, Symptoms, Diagnosis, Type, Length, Comments, DateTime, Timestamp, ApptComplete, Cancelled) VALUES ('15', 'mtyrell', 'nnarayanan', 'Unblemished skin', 'Acne', 'Checkup', '00:20:00', 'I am not a doctor', '2014-03-18 11:59:59', '2014-03-18 11:59:59', '0', '1');
INSERT INTO hospital_main.visitation (VisitID, PatientID, DoctorID, Symptoms, Diagnosis, Type, Length, Comments, DateTime, Timestamp, ApptComplete, Cancelled) VALUES ('16', 'jmormont', 'jhalmo', 'Mid-life crisis', 'Arthritis', 'Surgury', '00:40:00', 'I am not a doctor', '2014-03-18 11:59:59', '2014-03-18 11:59:59', '1', '0');
INSERT INTO hospital_main.visitation (VisitID, PatientID, DoctorID, Symptoms, Diagnosis, Type, Length, Comments, DateTime, Timestamp, ApptComplete, Cancelled) VALUES ('17', 'estark', 'jhalmo', 'Neck pain has spread', 'Pulled muscle', 'Surgury', '05:15:00', 'I am not a doctor', '2014-03-18 11:59:59', '2014-03-18 11:59:59', '0', '0');
INSERT INTO hospital_main.visitation (VisitID, PatientID, DoctorID, Symptoms, Diagnosis, Type, Length, Comments, DateTime, Timestamp, ApptComplete, Cancelled) VALUES ('18', 'cstark', 'gzhou', 'Long fingers', 'Arthritis', 'Surgury', '00:25:00', 'I am not a doctor', '2014-03-18 11:59:59', '2014-03-18 11:59:59', '0', '1');
INSERT INTO hospital_main.visitation (VisitID, PatientID, DoctorID, Symptoms, Diagnosis, Type, Length, Comments, DateTime, Timestamp, ApptComplete, Cancelled) VALUES ('19', 'sstark', 'gzhou', 'Pain in stomach', 'Puberty', 'Checkup', '00:20:00', 'I am not a doctor', '2014-03-18 11:59:59', '2014-03-18 11:59:59', '0', '0');
INSERT INTO hospital_main.visitation (VisitID, PatientID, DoctorID, Symptoms, Diagnosis, Type, Length, Comments, DateTime, Timestamp, ApptComplete, Cancelled) VALUES ('20', 'estark', 'jhalmo', 'Burning sensation in his neck', 'Pulled muscle', 'Followup', '00:05:00', 'I am not a doctor', '2014-03-18 11:59:59', '2014-03-18 11:59:59', '1', '0');
INSERT INTO hospital_main.visitation (VisitID, PatientID, DoctorID, Symptoms, Diagnosis, Type, Length, Comments, DateTime, Timestamp, ApptComplete, Cancelled) VALUES ('21', 'pbaelish', 'gzhou', 'Pain in fingers', 'Anthrax', 'Checkup', '00:50:00', 'I am not a doctor', '2014-03-18 11:59:59', '2014-03-18 11:59:59', '0', '0');
INSERT INTO hospital_main.visitation (VisitID, PatientID, DoctorID, Symptoms, Diagnosis, Type, Length, Comments, DateTime, Timestamp, ApptComplete, Cancelled) VALUES ('22', 'estark', 'jhalmo', 'Feels very light headed', 'Pulled muscle', 'Surgury', '00:30:00', 'I am not a doctor', '2014-03-18 11:59:59', '2014-03-18 11:59:59', '1', '0');


#operations
DELETE FROM hospital_main.operations;

INSERT INTO `hospital_main`.`operations` (`Name`, `Description`, `EstTime`, `ReqJobTitle`) VALUES ('Heart Transplant', 'Replace heart', '4:00', 'Surgeon');
INSERT INTO `hospital_main`.`operations` (`Name`, `Description`, `EstTime`, `ReqJobTitle`) VALUES ('Kidney Transplant', 'Replace kidney', '3:00', 'Surgeon');
INSERT INTO `hospital_main`.`operations` (`Name`, `Description`, `EstTime`, `ReqJobTitle`) VALUES ('Vasectomy', 'Male sterilization', '0:30', 'Physician');
INSERT INTO `hospital_main`.`operations` (`Name`, `Description`, `EstTime`, `ReqJobTitle`) VALUES ('Arm Amputation', 'Removal of the arm', '2:00', 'Surgeon');
INSERT INTO `hospital_main`.`operations` (`Name`, `Description`, `EstTime`, `ReqJobTitle`) VALUES ('CT Scan', 'Take images of the brain', '1:00', 'Physician');
INSERT INTO `hospital_main`.`operations` (`Name`, `Description`, `EstTime`, `ReqJobTitle`) VALUES ('C-Section', 'Remove baby via incision', '1:00', 'Physician');
INSERT INTO `hospital_main`.`operations` (`Name`, `Description`, `EstTime`, `ReqJobTitle`) VALUES ('Plastic Surgury', 'Rebuild the body', '2:00', 'Surgeon');

#doctor patient permission
DELETE FROM hospital_main.doctorpatientperm;

INSERT INTO `hospital_main`.`doctorpatientperm` (`PatientID`, `DoctorID`, `SecDoctorID`, `Expiry`) VALUES ('pbaelish', 'gzhou', 'nnarayanan', '2012-04-20 17:00:00');
INSERT INTO `hospital_main`.`doctorpatientperm` (`PatientID`, `DoctorID`, `SecDoctorID`, `Expiry`) VALUES ('mtyrell', 'nnarayanan', 'gzhou', '2012-03-14 20:00:00');
INSERT INTO `hospital_main`.`doctorpatientperm` (`PatientID`, `DoctorID`, `SecDoctorID`, `Expiry`) VALUES ('dtargaryen', 'jhalmo', 'gzhou', '2012-04-14 17:00:00');

#prescriptions
DELETE FROM hospital_main.prescriptions;

INSERT INTO hospital_main.prescriptions (VisitID, DIN, Quantity, Refills, Dosage, Expiry) VALUES ('0', '00013285', '250', '1', 'Once in before breakfast', '2015-04-15 11:59:59');
INSERT INTO hospital_main.prescriptions (VisitID, DIN, Quantity, Refills, Dosage, Expiry) VALUES ('2', '02237726', '500', '5', 'Maximum 3 times per day', '2016-09-05 11:59:59');
INSERT INTO hospital_main.prescriptions (VisitID, DIN, Quantity, Refills, Dosage, Expiry) VALUES ('4', '02248809', '100', '8', 'Once before bed', '2020-01-02 11:59:59');
INSERT INTO hospital_main.prescriptions (VisitID, DIN, Quantity, Refills, Dosage, Expiry) VALUES ('6', '02237726', '300', '3', 'Whenever there is pain', '2015-01-09 11:59:59');
INSERT INTO hospital_main.prescriptions (VisitID, DIN, Quantity, Refills, Dosage, Expiry) VALUES ('8', '02132702', '1000', '2', 'Taken twice a day, once after waking up, once before going to bed', '2018-08-08 11:59:59');
INSERT INTO hospital_main.prescriptions (VisitID, DIN, Quantity, Refills, Dosage, Expiry) VALUES ('10', '02276054', '800', '5', 'Take before performing strenuous activity', '2017-06-06 11:59:59');
INSERT INTO hospital_main.prescriptions (VisitID, DIN, Quantity, Refills, Dosage, Expiry) VALUES ('12', '00013285', '400', '10', 'Once before each meal', '2014-12-12 11:59:59');

#scheduled operations
DELETE FROM hospital_main.scheduledoperations;

INSERT INTO hospital_main.scheduledoperations (VisitID, OperationDateTime, OperationName, DoctorID) VALUES ('3', '2014-03-28 13:00:00', 'Arm Amputation', 'nnarayanan');
INSERT INTO hospital_main.scheduledoperations (VisitID, OperationDateTime, OperationName, DoctorID) VALUES ('9', '2014-04-15 9:00:00', 'Plastic Surgury', 'jhalmo');
INSERT INTO hospital_main.scheduledoperations (VisitID, OperationDateTime, OperationName, DoctorID) VALUES ('11', '2014-04-03 10:30:00', 'CT Scan', 'gzhou');
INSERT INTO hospital_main.scheduledoperations (VisitID, OperationDateTime, OperationName, DoctorID) VALUES ('16', '2014-05-09 04:15:00', 'Vasectomy', 'jhalmo');
INSERT INTO hospital_main.scheduledoperations (VisitID, OperationDateTime, OperationName, DoctorID) VALUES ('17', '2014-07-17 19:45:00', 'Heart Transplant', 'nnarayanan');
INSERT INTO hospital_main.scheduledoperations (VisitID, OperationDateTime, OperationName, DoctorID) VALUES ('18', '2014-12-01 12:05:00', 'Kidney Transplant', 'gzhou');
INSERT INTO hospital_main.scheduledoperations (VisitID, OperationDateTime, OperationName, DoctorID) VALUES ('22', '2015-01-22 11:35:00', 'C-Section', 'nnarayanan');