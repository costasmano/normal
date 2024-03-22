If (False:C215)
	// Object Method: [NTI_TunnelInfo];"ListBoxOutput".bQuery
	// Modified by: Costas Manousakis-(Designer)-(1/30/17 12:54:26)
	Mods_2017_01
	//  `changed QUERY to QUERY SELECTION
	// Modified by: Costas Manousakis-(Designer)-(6/14/18 17:12:50)
	Mods_2018_06
	//  `added order by and copy named selection
End if 

QUERY SELECTION:C341(Current form table:C627->)
WIN_SetWindowTitle(->[NTI_TunnelInfo:181])


ORDER BY FORMULA:C300([NTI_TunnelInfo:181]; NTI_SortByFormula(1); >)

COPY NAMED SELECTION:C331([NTI_TunnelInfo:181]; "NTI_TunnelInfoSet")
