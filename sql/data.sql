#users
DELETE FROM hospital_main.users;

INSERT INTO hospital_main.users (UserID, Password, Role) VALUES ('jhalmo', 'josh', 'doctor');
INSERT INTO hospital_main.users (UserID, Password, Role) VALUES ('ckent', 'clark', 'staff');
INSERT INTO hospital_main.users (UserID, Password, Role) VALUES ('bwayne', 'bruce', 'patient');
INSERT INTO hospital_main.users (UserID, Password, Role) VALUES ('pparker', 'peter', 'staff');
INSERT INTO hospital_main.users (UserID, Password, Role) VALUES ('gzhou', 'gordon', 'doctor');
INSERT INTO hospital_main.users (UserID, Password, Role) VALUES ('acurry', 'arthur', 'patient');
INSERT INTO hospital_main.users (UserID, Password, Role) VALUES ('ballen', 'bary', 'patient');
INSERT INTO hospital_main.users (UserID, Password, Role) VALUES ('hjordan', 'hal', 'staff');
INSERT INTO hospital_main.users (UserID, Password, Role) VALUES ('dprince', 'diana', 'patient');
INSERT INTO hospital_main.users (UserID, Password, Role) VALUES ('oqueen', 'oliver', 'patient');
INSERT INTO hospital_main.users (UserID, Password, Role) VALUES ('tstark', 'tony', 'patient');
INSERT INTO hospital_main.users (UserID, Password, Role) VALUES ('ecameracii', 'eric', 'staff');
INSERT INTO hospital_main.users (UserID, Password, Role) VALUES ('todinson', 'thor', 'patient');
INSERT INTO hospital_main.users (UserID, Password, Role) VALUES ('hpyrn', 'henry', 'patient');
INSERT INTO hospital_main.users (UserID, Password, Role) VALUES ('rbanner', 'robert', 'staff');
INSERT INTO hospital_main.users (UserID, Password, Role) VALUES ('nnarayanan', 'naveen', 'doctor');
INSERT INTO hospital_main.users (UserID, Password, Role) VALUES ('srogers', 'steve', 'staff');
INSERT INTO hospital_main.users (UserID, Password, Role) VALUES ('cbarton', 'clinton', 'patient');
INSERT INTO hospital_main.users (UserID, Password, Role) VALUES ('ssummers', 'scott', 'finance');
INSERT INTO hospital_main.users (UserID, Password, Role) VALUES ('nalianovna', 'natalia', 'staff');
INSERT INTO hospital_main.users (UserID, Password, Role) VALUES ('cxavier', 'charles', 'patient');
INSERT INTO hospital_main.users (UserID, Password, Role) VALUES ('jgrey', 'jean', 'patient');
INSERT INTO hospital_main.users (UserID, Password, Role) VALUES ('apaquin', 'anna', 'patient');


#staff
DELETE FROM hospital_main.staff;

INSERT INTO hospital_main.staff (UserID, FirstName, LastName, ManagingDoctorID, JobTitle, CurrentlyEmployed) VALUES ('jhalmo', 'Josh', 'Halmo', NULL, 'Doctor', 1);
INSERT INTO hospital_main.staff (UserID, FirstName, LastName, ManagingDoctorID, JobTitle, CurrentlyEmployed) VALUES ('ckent', 'Clark', 'Kent', 'jhalmo', 'Nurse', 1);
INSERT INTO hospital_main.staff (UserID, FirstName, LastName, ManagingDoctorID, JobTitle, CurrentlyEmployed) VALUES ('pparker', 'Peter', 'Parker', 'jhalmo', 'Nurse', 1);
INSERT INTO hospital_main.staff (UserID, FirstName, LastName, ManagingDoctorID, JobTitle, CurrentlyEmployed) VALUES ('gzhou', 'Gordon', 'Zhou', NULL, 'Doctor', 1);
INSERT INTO hospital_main.staff (UserID, FirstName, LastName, ManagingDoctorID, JobTitle, CurrentlyEmployed) VALUES ('hjordan', 'Hal', 'Jordan', 'gzhou', 'Doctor', 1);
INSERT INTO hospital_main.staff (UserID, FirstName, LastName, ManagingDoctorID, JobTitle, CurrentlyEmployed) VALUES ('ecameracii', 'Eric', 'Cameracii', 'nnarayanan', 'Assistant', 1);
INSERT INTO hospital_main.staff (UserID, FirstName, LastName, ManagingDoctorID, JobTitle, CurrentlyEmployed) VALUES ('rbanner', 'Robert', 'Banner', 'gzhou', 'Receptionist', 1);
INSERT INTO hospital_main.staff (UserID, FirstName, LastName, ManagingDoctorID, JobTitle, CurrentlyEmployed) VALUES ('nnarayanan', 'Naveen', 'Narayanan', NULL, 'Doctor', 1);
INSERT INTO hospital_main.staff (UserID, FirstName, LastName, ManagingDoctorID, JobTitle, CurrentlyEmployed) VALUES ('srogers', 'Steve', 'Rogers', 'gzhou', 'Nurse', 0);
INSERT INTO hospital_main.staff (UserID, FirstName, LastName, ManagingDoctorID, JobTitle, CurrentlyEmployed) VALUES ('cbarton', 'Clinton', 'Barton', 'nnarayanan', 'Nurse', 1);
INSERT INTO hospital_main.staff (UserID, FirstName, LastName, ManagingDoctorID, JobTitle, CurrentlyEmployed) VALUES ('ssummers', 'Scott', 'Summers', NULL, 'Accountant', 1);
INSERT INTO hospital_main.staff (UserID, FirstName, LastName, ManagingDoctorID, JobTitle, CurrentlyEmployed) VALUES ('nalianovna', 'Natalia', 'Alianovna', 'gzhou', 'Nurse', 1);