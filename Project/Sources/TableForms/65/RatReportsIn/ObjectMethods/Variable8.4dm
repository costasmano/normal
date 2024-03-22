If ([RatingReports:65]ReportDate:4=!00-00-00!)
	ALERT:C41("Please enter a valid date or delete this record when you are done!")
End if 
If (False:C215)
	// Modified by: Costas Manousakis-(Designer)-(11/15/19 17:26:52)
	Mods_2019_11
	//  `make sure to go to validate part
End if 

//Force it to go through a Validate part of the Form method  
[RatingReports:65]Consultant:5:=[RatingReports:65]Consultant:5
//ACCEPT
