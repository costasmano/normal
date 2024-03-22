//Method: MethodsList.FindByName1
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): CJ
	//User (4D) : Designer
	//Date and time: 03/05/20, 15:53:54
	// ----------------------------------------------------
	//Created : 
	Mods_2020_03  //ADD button to Methods List Form _ This is utility method
	
End if 
//
C_LONGINT:C283($Loop_L; $Size_L; $InnerLoop_L)
$Size_L:=Size of array:C274(LBGeneric_atxt)
C_BLOB:C604($Report_blb)
C_TEXT:C284($methodCode_txt; $FormName_txt; $Doc_txt)
ARRAY TEXT:C222($Selected_atxt; 0)

C_BOOLEAN:C305($Export_B)
For ($Loop_L; Size of array:C274(LBGeneric_atxt); 1; -1)
	ARRAY TEXT:C222($parts_atxt; 0)
	ut_NewTextToArray(LBGeneric_atxt{$Loop_L}; ->$parts_atxt; " - ")
	ARRAY TEXT:C222($Changes_atxt; 0)
	ut_NewTextToArray($parts_atxt{2}; ->$Changes_atxt; "/")
	$Export_B:=False:C215
	Case of 
		: (Size of array:C274($Changes_atxt)=1)
			$Export_B:=True:C214
			$FormName_txt:=$Changes_atxt{1}
		: ($Changes_atxt{1}="[databaseMethod]")
			$Export_B:=True:C214
			$FormName_txt:=$Changes_atxt{1}
	End case 
	If ($Export_B)
		TEXT TO BLOB:C554($FormName_txt+Char:C90(Carriage return:K15:38); $Report_blb; UTF8 text without length:K22:17; *)
		METHOD GET CODE:C1190($FormName_txt; $methodCode_txt)
		TEXT TO BLOB:C554($methodCode_txt+Char:C90(Carriage return:K15:38); $Report_blb; UTF8 text without length:K22:17; *)
		
	End if 
	
	
	
End for 
$Doc_txt:=Select document:C905(""; "txt"; "Crate text document of Methods in list"; File name entry:K24:17; $Selected_atxt)
If (OK=1)
	$Doc_txt:=$Selected_atxt{1}
	BLOB TO DOCUMENT:C526($Doc_txt; $Report_blb)
End if 
//End MethodsList.FindByName1