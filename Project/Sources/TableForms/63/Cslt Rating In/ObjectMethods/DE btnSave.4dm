If (False:C215)
	//[Conslt Rating];"Cslt Rating In".DE btnSave
	// Modified by: Costas Manousakis-(Designer)-(2024-01-16 12:47:34)
	Mods_2024_01
	//  `make sure all changes are in the change stack
End if 

If (Form event code:C388=On Clicked:K2:4)
	If (Is new record:C668([Conslt Rating:63]))
		LogNewRecord(->[Bridge MHD NBIS:1]BIN:3; ->[Conslt Rating:63]BIN:1; ->[Conslt Rating:63]ConsltRatingID:42; 1; "ConsRtg")
	End if 
	//start of mods_2024_01
	ARRAY TEXT:C222($fldstoSkip_atxt; 0)
	APPEND TO ARRAY:C911($fldstoSkip_atxt; "BIN")
	APPEND TO ARRAY:C911($fldstoSkip_atxt; "ConsltRatingID")
	ACT_PushGroupChanges(Table:C252(->[Conslt Rating:63]); 1; ->$fldstoSkip_atxt; True:C214)
	//end of mods_2024_01
	
	SAVE RECORD:C53([Conslt Rating Cost:74])
End if 