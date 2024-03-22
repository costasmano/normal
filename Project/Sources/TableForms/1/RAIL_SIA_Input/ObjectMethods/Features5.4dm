If (False:C215)
	//SC a7FDescr_ on layout [Bridge MHD NBIS];"SI & A Input".
	
	//Pop up menu for Item6a 
	// Added on 1\11\2000
	// Modified by: costasmanousakis-(Designer)-(4/16/08 22:10:02)
	Mods_2008_CM_5403  //ise SIA_Feature_OM
End if 

C_TEXT:C284(v7FDescr)  // Command Replaced was o_C_STRING length was 30

SIA_Feature_OM(->[Bridge MHD NBIS:1]Item7:65; ->a7FDescr_; ->v7FDescr; ->a7FCodes_; ->v7RteNum; ->v7Suffix; ->v7Descr)