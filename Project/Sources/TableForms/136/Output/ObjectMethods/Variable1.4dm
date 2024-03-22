If (False:C215)
	
	Mods_2010_05
End if 

//M_AddRecords

//GP M_AddRecords hen disabled;
//the following lines duplicate its original function.
//Repeat 
CREATE SET:C116(pfile->; "DCM_CONTRACTS_ORIG")
ADD RECORD:C56(pFile->)
ADD TO SET:C119(pFile->; "DCM_CONTRACTS_ORIG")
USE SET:C118("DCM_CONTRACTS_ORIG")
CLEAR SET:C117("DCM_CONTRACTS_ORIG")
//Until (OK=0)  `Until the user clicks a Cancel button
DCM_SortOutputList("SORT")
WindowTitle
//End of script
