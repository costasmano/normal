// ----------------------------------------------------
// Object Method: ◊SD_IncludeALL_l
// User name (OS): cjmiller
// Date and time: 04/19/05, 13:47:48
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2005_CJM03
End if 
If (<>SD_IncludeALL_l=1)
	If (Size of array:C274(aIt8OwnerDesIncludedCode)>0)
		CONFIRM:C162("Are you sure you want to change from selected to all owners?"; "All Owners"; "Selected Owners")
		If (OK=1)
			ARRAY TEXT:C222(aIt8OwnerDesIncludedCode; 0)  //Command Replaced was o_ARRAY string length was 3
			ARRAY TEXT:C222(aIt8OwnerDesIncluded; 0)  //Command Replaced was o_ARRAY string length was 50
			COPY ARRAY:C226(<>aIt8OwnerDes; aIt8OwnerDes)
			COPY ARRAY:C226(<>aIt8OwnerCode; aIt8OwnerCode)
		Else 
			<>SD_IncludeALL_l:=0
		End if 
	End if 
End if 
//End Object Method: ◊SD_IncludeALL_l