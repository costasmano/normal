C_TEXT:C284($msg)
If ([ScourPOA_Images:134]ImgDescr_txt:4#"")
	$Msg:="Delete photo "+<>sQU+[ScourPOA_Images:134]ImgDescr_txt:4+<>sQU+" ?"
Else 
	$Msg:="Delete this "+[ScourPOA_Images:134]ImageType:5+" ?"
End if 

CONFIRM:C162($Msg; "Delete")
If (OK=1)
	If (Not:C34(Is new record:C668([ScourPOA_Images:134])))
		If (SCPOA_LogChanges_b)
			LogDeletion(->[ScourPOA:132]ScourPOAID:1; ->[ScourPOA_Images:134]ScourPOAID:2; ->[ScourPOA_Images:134]ScourPOAImgID:1; 2)
		End if 
		DELETE RECORD:C58([ScourPOA_Images:134])
	End if 
	CANCEL:C270
End if 
