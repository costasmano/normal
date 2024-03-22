If (False:C215)
	// Modified by: Costas Manousakis-(Designer)-(6/14/18 17:12:50)
	Mods_2018_06
	//  `added order by and copy named selection
	
End if 

ALL RECORDS:C47(Current form table:C627->)
WIN_SetWindowTitle(->[NTI_TunnelInfo:181])

ORDER BY FORMULA:C300([NTI_TunnelInfo:181]; NTI_SortByFormula(1); >)
COPY NAMED SELECTION:C331([NTI_TunnelInfo:181]; "NTI_TunnelInfoSet")

