//%attributes = {"invisible":true}
//27-Jan-2005
//Following Comments Copied from Structure Submitted by Charles Miller.

//new table
//This table will be used as a history report all bridges whose status is true at 
//the start of each month will have a record created in this table.
// Currently, there are about 600 records / month
//The [SD_History]SD_Year and [SD_History]SD_Month will be caluclated as follows
//Using current date from server
//extract year
//extract month
//if month = 1
//substract 1 from year and make 
//otherwise, substract 1 from month

//[SD_History]
//[SD_History]Bin
//[SD_History]SD_Year
//[SD_History]SD_Month
//[SD_History]BDEPT
//[SD_History]Town Name
//[SD_History]Item8
//[SD_History]Item7
//[SD_History]Item6A
//[SD_History]Item58
//[SD_History]Item59
//[SD_History]Item60
//[SD_History]Item2
//[SD_History]AASHTO
//[SD_History]Item21
//[SD_History]Item41
//SD_CreateMonthlyRecords

//10/12/04, 09:50
//Add two fileds to [SD_History] table
//[SD_History]SD_AddRemoveStatus_s
//This field can be set  as follows:
//A = added this month
//R= removed next month
//B= added this month and removed next month
//"" carry over from previous momnth

//[SD_History]SD_Owner_s
//Substring([SD_History]Item8;10;3) set when saving new records. It is used for qu

//add code to set new fields
//SD_SetAddRemoveStatus `This method will add status of A, R, or B as needed
// Trigger: SD_History this sets up the owner field
//New forms and queries

//begin writing report and queries
//
