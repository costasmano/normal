//Method: From Method SelectResources
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 11/20/18, 16:38:07
	// ----------------------------------------------------
	//Created : 
	Mods_2018_11
	Mods_2020_05  //Add in progress bar
End if 
//
Case of 
	: (Form event code:C388=On Load:K2:1)
		C_BLOB:C604($Blob_blb)
		SET BLOB SIZE:C606($Blob_blb; 0)
		$Blob_blb:=Server_ReturnResourceStructure
		ARRAY TEXT:C222(LBGeneric_atxt; 0)
		ARRAY TEXT:C222(v_1_150_atxt; 0)
		C_LONGINT:C283($Offset_L)
		CLEAR VARIABLE:C89(v_1_150_atxt)
		BLOB TO VARIABLE:C533($Blob_blb; LBGeneric_atxt; $Offset_L)
		CLEAR VARIABLE:C89(v_1_004_ab)
		C_TEXT:C284(v_1_150_txt)
		$Size_L:=Size of array:C274(LBGeneric_atxt)
		ARRAY BOOLEAN:C223(v_1_004_ab; $Size_L)
		ARRAY TEXT:C222(v_1_150_atxt; $Size_L)
		C_LONGINT:C283($Pos_L; $loop_L; $Size_L)
		C_OBJECT:C1216($progressObj_o)
		$progressObj_o:=ProgressNew("Parsing Server Resource Structure"; $Size_L; True:C214; ""; 3)
		
		For ($loop_L; Size of array:C274(LBGeneric_atxt); 1; -1)
			UpdateProgressNew($progressObj_o; $loop_L)
			If (Position:C15(Folder separator:K24:12+"CACHE"; Uppercase:C13(LBGeneric_atxt{$loop_L}))=1)
				DELETE FROM ARRAY:C228(LBGeneric_atxt; $loop_L; 1)
				DELETE FROM ARRAY:C228(v_1_150_atxt; $loop_L; 1)
				DELETE FROM ARRAY:C228(v_1_004_ab; $loop_L; 1)
			Else 
				$Pos_L:=Position:C15("."; LBGeneric_atxt{$loop_L})
				v_1_150_atxt{$loop_L}:=Substring:C12(Uppercase:C13(LBGeneric_atxt{$loop_L}); $Pos_L+1)
			End if 
		End for 
		Progress QUIT(OB Get:C1224($progressObj_o; "progress"))
		
		SORT ARRAY:C229(v_1_150_atxt; LBGeneric_atxt; v_1_004_ab; >)
		CLEAR VARIABLE:C89(v_1_150_txt)
		
End case 
//End SelectResources