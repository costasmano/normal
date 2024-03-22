If (False:C215)
	//SC aFeatDescr_ on layout [Bridge MHD NBIS];"SI & A Input".
	
	//Pop up menu for Item6a 
	
	// Modified by: costasmanousakis-(Designer)-(4/16/08 22:10:43)
	Mods_2008_CM_5403  //use SIA_Feature_OM
End if 

C_TEXT:C284(vFeatDescr)  // Command Replaced was o_C_STRING length was 30

SIA_Feature_OM(->[Bridge MHD NBIS:1]Item6A:63; ->aFeatDescr_; ->vFeatDescr; ->aFeatCodes_; ->vRteNum; ->vsuffix; ->v6Descr)