//%attributes = {"invisible":true}
//Method: LSS_ResequenceInspPhotos
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): CJ
	//User (4D) : Designer
	//Date and time: 01/28/20, 12:47:28
	// ----------------------------------------------------
	//Created : 
	Mods_2020_01_bug
End if 
//
SHORT_MESSAGE("Re-Sequencing Images. Please wait...")
FIRST RECORD:C50([LSS_Photos:166])
C_LONGINT:C283($startSeq_L)
C_TEXT:C284($StartType_txt)
$startSeq_L:=1
$StartType_txt:=[LSS_Photos:166]LSS_PhotoType_s:3

OBJECT SET ENABLED:C1123(*; "SequenceNumberUpdate_1"; False:C215)
While (Not:C34(End selection:C36([LSS_Photos:166])))
	If (ut_LoadRecordInteractive(->[LSS_Photos:166]))
		
		If ([LSS_Photos:166]LSS_PhotoSequence_L:6#$startSeq_L)
			[LSS_Photos:166]LSS_PhotoSequence_L:6:=$startSeq_L
			LogChanges(->[LSS_Photos:166]LSS_PhotoSequence_L:6; ->[LSS_Photos:166]LSS_PhotoId_s:1; ->[LSS_Photos:166]LSS_PhotoId_s:1; ->[LSS_Photos:166]LSS_PhotoId_s:1; 0)
			SAVE RECORD:C53([LSS_Photos:166])
			LSS_PhotoUpdateSeq_b:=True:C214
		End if 
		NEXT RECORD:C51([LSS_Photos:166])
		If ([LSS_Photos:166]LSS_PhotoType_s:3=$StartType_txt)
			//still same type
			$startSeq_L:=$startSeq_L+1
		Else 
			//new type
			$startSeq_L:=1
			$StartType_txt:=[LSS_Photos:166]LSS_PhotoType_s:3
		End if 
		
		
	Else 
		ALERT:C41("Could not complete Re-Sequnecing of Images due to a locked Record!")
		LAST RECORD:C200([LSS_Photos:166])
		OBJECT SET ENABLED:C1123(*; "SequenceNumberUpdate_1"; True:C214)
		
	End if 
End while 

CLOSE WINDOW:C154
//End ut_ResequenceInspPhotos