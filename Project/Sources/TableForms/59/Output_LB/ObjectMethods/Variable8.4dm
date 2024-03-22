If (False:C215)
	//Script: bzOmit
	//Object Method: [Activity Log].Output.bzOmit 
	//ACI University Programming Classes
	//Generic ACI Shell Programming
	//Created By: Kent Wilbur
	//Date:  10/1/95
	
	//Purpose: 
	
	<>fGeneric:=False:C215
	<>f_Ver1x10:=False:C215
	Mods_2015_11
	//  `sort by RefID when reloading
	
End if 

M_OmitSubset
ORDER BY:C49([Activity Log:59]; [Activity Log:59]RefID:28; >)
//End of script