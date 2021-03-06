/******************** Irene Hsueh's BS 851 Homework 2 ********************/


/******************** Question 1 ********************/

/*Question 1A*/
proc plan seed=12345;
	factors blocks=334 ordered trt=6 random/noprint;
    output out=block_randomization trt cvals=("A" "A" "A" "B" "B" "B");
run;
quit;

title "Block Randomization";
proc print data=block_randomization (obs=20); 
run; 
title;



/*Question 1B*/
proc plan seed=12345;
	factors age_group=3 ordered DNA_level=2 ordered blocks=84 ordered trt=6 random/noprint;
	output out=stratified_randomization  trt cvals=("A" "A" "A" "B" "B" "B");
run;
quit;

title "1) Stratified Randomization for <23 years and hepB DNA level <8 log10 IU/mL";
proc print data=stratified_randomization (obs=10); 
where age_group=1 & DNA_level=1;
run; 

title "2) Stratified Randomization for <23 years and hepB DNA level >8 log10 IU/mL";
proc print data=stratified_randomization (obs=10); 
where age_group=1 & DNA_level=2;
run; 

title "3) Stratified Randomization for 23-28 years and hepB DNA level <8 log10 IU/mL";
proc print data=stratified_randomization (obs=10); 
where age_group=2 & DNA_level=1;
run; 

title "4) Stratified Randomization for 23-28 years and hepB DNA level >8 log10 IU/mL";
proc print data=stratified_randomization (obs=10); 
where age_group=2 & DNA_level=2;
run; 

title "5) Stratified Randomization for >30 years and hepB DNA level <8 log10 IU/mL";
proc print data=stratified_randomization (obs=10); 
where age_group=3 & DNA_level=1;
run; 

title "6) Stratified Randomization for >30 years and hepB DNA level >8 log10 IU/mL";
proc print data=stratified_randomization (obs=10); 
where age_group=3 & DNA_level=2;
run; 
title;



/*Question 1C*/
proc plan seed=12345;
	factors age_group=3 ordered DNA_level=2 ordered centers=10 ordered blocks=34 ordered trt=6 random/noprint;
	output out=further_stratified_randomization  trt cvals=("A" "A" "A" "B" "B" "B");
run;
quit;

title "Further Stratified Randomization";
proc print data=further_stratified_randomization (obs=500); 
run; 
title;




/******************** Question 2 ********************/
proc plan seed=12345;
	factors center=4 ordered blocks=10 ordered treatment=7 random;
    output out=randomized_schedule treatment cvals=("A" "A" "B" "B" "C" "C" "D");
run;
quit;

title "Stratified Block Randomization";
proc print data=randomized_schedule (obs=100); 
run; 
title;

/*Add patient ID*/
data final_randomized_schedule;
set randomized_schedule; 
	by center;
	if first.center then patient=0;
	patient+1;
	if center=1 then patientID=100+patient;
	else if center=2 then patientID=200+patient;
	else if center=3 then patientID=300+patient;
	else if center=4 then patientID=400+patient;
label patientID="Patient ID" center="Study Center" treatment="Treatment";
run;

/*Export Randomized Schedule to Excel file*/
ods excel file="C:/Irene Hsueh's Documents/MS Applied Biostatistics/BS 851 - Applied Statistics in Clinical Trials I/Class 2 - Randomization of Patients to Study Treatments/Homework 2/RandomizedSchedule.xlsx";
title "Randomized Schedule";
proc print data=final_randomized_schedule label;
id patientID;
var center treatment;
run;
title;
ods excel close;
