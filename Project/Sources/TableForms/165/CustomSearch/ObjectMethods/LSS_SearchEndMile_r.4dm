If ((LSS_SearchEndMile_r>0) & (LSS_SearchStartMile_r>0))
	If (LSS_SearchEndMile_r<LSS_SearchStartMile_r)
		ALERT:C41("End Mile Marker :"+String:C10(LSS_SearchEndMile_r)+" is less than Start Mile Marker :"+String:C10(LSS_SearchStartMile_r))
	End if 
End if 

//End Object Method: [LSS_Inventory].CustomSearch.LSS_SearchEndMile_r