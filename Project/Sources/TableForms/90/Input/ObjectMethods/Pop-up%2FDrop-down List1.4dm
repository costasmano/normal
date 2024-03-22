If (False:C215)
	Mods_2005_CM06
	Mods_2011_06  // CJ Miller`06/20/11, 11:32:31      ` Type all local variables for v11
End if 
Case of 
	: (Form event code:C388=On Clicked:K2:4)
		If (aNBI_Descr#Size of array:C274(aNBI_Descr))
			C_LONGINT:C283($NewID)
			$NewID:=aNBI_IDs{aNBI_Descr}
			If ([Combined Inspections:90]NBISInspID:2#$NewID)
				[Combined Inspections:90]NBISInspID:2:=$NewID
				LogLink(->[Combined Inspections:90]NBISInspID:2; ->[Bridge MHD NBIS:1]BIN:3; ->[Combined Inspections:90]BIN:1; ->[Combined Inspections:90]ID:6; 1)
			End if 
		End if 
End case 