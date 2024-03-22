//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 11/02/07, 09:53:30
	// ----------------------------------------------------
	// Method: ARCH_SearchforField
	// Description
	// 
	// 
	// Parameters
	// $1 : $FieldNumber_L
	// ----------------------------------------------------
	
	Mods_2007_CM12_5302
End if 
C_LONGINT:C283($1; $FieldNumber_L)
$FieldNumber_L:=$1
C_TEXT:C284($FieldNumber_txt)
$FieldNumber_txt:="["+String:C10($FieldNumber_L)+"]"
CREATE EMPTY SET:C140([Activity Log:59]; "ARCHFoundSet")
USE SET:C118("ARCHSourceSet")
READ ONLY:C145([Activity Log:59])
FIRST RECORD:C50([Activity Log:59])
C_LONGINT:C283($NumRecs; $i)
C_TEXT:C284($Data_txt)
$NumRecs:=Records in selection:C76([Activity Log:59])
For ($i; 1; $NumRecs)
	Case of 
		: ([Activity Log:59]Activity Type:3="GRP")
			$Data_txt:=fGrpBlob2Text([Activity Log:59]Data:10)
			If (Position:C15($FieldNumber_txt; $Data_txt)>0)
				ADD TO SET:C119([Activity Log:59]; "ARCHFoundSet")
			End if 
			
	End case 
	
	NEXT RECORD:C51([Activity Log:59])
End for 
$Data_txt:=""
READ WRITE:C146([Activity Log:59])