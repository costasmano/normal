//Method: Object Method: [Contract_Assignment_Maintenance].PreservationInput.PRV_PreservationTypes_atxt
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 06/05/12, 16:07:44
	// ----------------------------------------------------
	//Created : 
	Mods_2012_06
End if 
//
Case of 
		
	: ((Form event code:C388=On Clicked:K2:4) | (Form event code:C388=On Data Change:K2:15))
		C_TEXT:C284($me_txt)
		C_LONGINT:C283($MeRow_L; $InType_L)
		$me_txt:=Self:C308->{0}
		$me_txt:=f_TrimStr($me_txt; True:C214; True:C214)
		If (($me_txt#"") & ($me_txt#"OTHER"))
			$InType_L:=Position:C15($me_txt; [Contract_Assignment_Maintenance:101]ProjectType:36)
			If ($InType_L<=0)
				ARRAY TEXT:C222($ProjTypes_atxt; 0)
				ut_TextToArray([Contract_Assignment_Maintenance:101]ProjectType:36; ->$ProjTypes_atxt; ";")
				C_LONGINT:C283($loop_L)
				For ($loop_L; 1; Size of array:C274($ProjTypes_atxt))
					$ProjTypes_atxt{$loop_L}:=f_TrimStr($ProjTypes_atxt{$loop_L}; True:C214; True:C214)
				End for 
				APPEND TO ARRAY:C911($ProjTypes_atxt; $me_txt)
				SORT ARRAY:C229($ProjTypes_atxt)
				[Contract_Assignment_Maintenance:101]ProjectType:36:=$ProjTypes_atxt{1}
				For ($loop_L; 2; Size of array:C274($ProjTypes_atxt))
					[Contract_Assignment_Maintenance:101]ProjectType:36:=[Contract_Assignment_Maintenance:101]ProjectType:36+"; "+$ProjTypes_atxt{$loop_L}
				End for 
				ARRAY TEXT:C222($ProjTypes_atxt; 0)
			End if 
			
		End if 
		
End case 

//End Object Method: [Contract_Assignment_Maintenance].PreservationInput.PRV_PreservationTypes_atxt