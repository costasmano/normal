If (False:C215)
	// ----------------------------------------------------
	// User name (OS): Costas Manousakis
	// User name (4D): 
	// Date and time: 01/04/12, 16:35:21
	// ----------------------------------------------------
	// Method: Object Method: [SD_History].QryForm.SDDistrSelect
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	
	
	Mods_2012_01
End if 

C_TEXT:C284(<>SD_DistrictSelect_txt)

Case of 
	: (Form event code:C388=On Load:K2:1)
		<>SD_DistrictSelect_txt:=""
	: (Form event code:C388=On Data Change:K2:15)
		
	: (Form event code:C388=On Clicked:K2:4)
		C_LONGINT:C283($Selected_L)
		$Selected_L:=Self:C308->
		If (Self:C308->{$Selected_L}="ALL")
			<>SD_DistrictSelect_txt:=""
		Else 
			<>SD_DistrictSelect_txt:="0"+Substring:C12(Self:C308->{$Selected_L}; Length:C16(Self:C308->{$Selected_L}); 1)
		End if 
		
End case 