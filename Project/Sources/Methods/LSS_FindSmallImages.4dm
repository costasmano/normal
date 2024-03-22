//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): administrator
//Date and time: 05/21/15, 10:58:33
//----------------------------------------------------
//Method: LSS_FindSmallImages
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2014_Lighting  // 
	//Modified by: administrator (5/21/15 10:58:34)
	
End if 
QUERY:C277([LSS_Photos:166]; [LSS_Photos:166]LSS_Photo_txt:4="")
ARRAY LONGINT:C221($Records_AL; 0)

LONGINT ARRAY FROM SELECTION:C647([LSS_Photos:166]; $Records_AL)

C_LONGINT:C283($Loop)
For ($LOop; Size of array:C274($Records_AL); 1; -1)
	GOTO RECORD:C242([LSS_Photos:166]; $Records_AL{$Loop})
	If (BLOB size:C605([LSS_Photos:166]LSS_Photo_blb:5)>14828)
		DELETE FROM ARRAY:C228($Records_AL; $Loop; 1)
	End if 
End for 
CREATE SELECTION FROM ARRAY:C640([LSS_Photos:166]; $Records_AL)

//End LSS_FindSmallImages

