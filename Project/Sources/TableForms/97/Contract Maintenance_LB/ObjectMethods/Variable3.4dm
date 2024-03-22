If \
(False:C215)
	
	
End if 
SRC_SearchByBridge(->[Contract_Project_Maintenance:100]; \
->[Contract_Project_Maintenance:100]BIN:5; \
->[Contract_Project_Maintenance:100]BridgeNo:4; \
->[Bridge MHD NBIS:1]Bridge Key:2; \
True:C214)
If (OK=1)
	RELATE ONE SELECTION:C349([Contract_Project_Maintenance:100]; \
		[Contract_Assignment_Maintenance:101])
	RELATE ONE SELECTION:C349([Contract_Assignment_Maintenance:101]; \
		[Contract_Maintenance:97])
	CM_SortOutputList
	RegionTitle
	
End if 
//End of script