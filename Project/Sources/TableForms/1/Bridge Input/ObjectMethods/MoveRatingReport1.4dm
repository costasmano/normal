//Method: [Bridge MHD NBIS].Bridge Input.MoveRatingReport1
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 11/14/17, 11:38:11
	// ----------------------------------------------------
	//Created : 
	Mods_2017_11  //Add code to allow for moving/copying rating reports to directory structure
	//Modified by: Chuck Miller (11/14/17 16:39:12)
	Mods_2020_07  //Changed confirm by adding word local to make it clearer
	//Modified by: CJ (7/27/20 13:55:38)
	
End if 
//

OM_ControlOpenandMoveRatingPDF
If (Size of array:C274(v_65_035_atxt)>0)
	
	
	//APPEND TO ARRAY(v_65_035_atxt;$NewFileName_txt)
	//APPEND TO ARRAY(v_65_035_atxt;CopyFrom_txt)
	//APPEND TO ARRAY(v_65_035_atxt;$Copyto_txt)
	C_TEXT:C284($Copyto_txt; $NewFileName_txt)
	$NewFileName_txt:=v_65_035_atxt{1}
	CopyFrom_txt:=v_65_035_atxt{2}
	$Copyto_txt:=v_65_035_atxt{3}
	C_BOOLEAN:C305($replace_B)
	$replace_B:=True:C214
	If (Test path name:C476($Copyto_txt)=Is a document:K24:1)
		CONFIRM:C162("There is already a local document named "+$NewFileName_txt+" do you want to "; "Replace"; "Skip")
		$replace_B:=OK=1
		If ($replace_B)
			If (MR_CheckandResetDocumentLock(CopyFrom_txt; False:C215))
				ON ERR CALL:C155("4D_Errors")
				DELETE DOCUMENT:C159($Copyto_txt)
				If (4DError_b)
					4DError_b:=False:C215
					$replace_B:=False:C215
					ALERT:C41("Could not delete document "+$Copyto_txt+" you will have do move manually")
					ON ERR CALL:C155("")
				End if 
			End if 
		End if 
	End if 
	If ($replace_B)
		MOVE DOCUMENT:C540(CopyFrom_txt; $Copyto_txt)
		If (MR_CheckandResetDocumentLock($Copyto_txt; True:C214))
		End if 
	End if 
End if 
ARRAY TEXT:C222(v_65_035_atxt; 0)

//End [Bridge MHD NBIS].Bridge Input.MoveRatingReport1