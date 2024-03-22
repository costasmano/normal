If (False:C215)
	// Modified by: costasmanousakis-(Designer)-(2/14/2006 14:58:15)
	Mods_2006_CM03
	// Modified by: costasmanousakis-(Designer)-(2/24/2006 12:51:30)
	Mods_2006_CM03
End if 
FORM SET INPUT:C55([Contract_Assignment_Maintenance:101]; "Assignment Maintenance In")
ADD RECORD:C56([Contract_Assignment_Maintenance:101])

RELATE MANY:C262([Contract_Maintenance:97])
CM_SetupRelated(FORM Get current page:C276)
CM_BuildArrays(False:C215)  //don't reload
