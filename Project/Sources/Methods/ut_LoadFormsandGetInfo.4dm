//%attributes = {"invisible":true}
//Method: ut_LoadFormsandGetInfo
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 06/19/18, 16:18:02
	// ----------------------------------------------------
	//Created : 
	
End if 
//
C_BOOLEAN:C305($ReportonMissingOnly_B)

CONFIRM:C162("report on all or just missing fonts and or style sheets"; "Missing"; "All")
$ReportonMissingOnly_B:=OK=1

C_TEXT:C284($Path_txt)
C_POINTER:C301($Table_ptr)

C_BLOB:C604($Report_blb)
SET BLOB SIZE:C606($Report_blb; 0)

C_TEXT:C284($FormName_txt)
C_LONGINT:C283($Loop_l; $FormLoop_L)

ARRAY TEXT:C222($TableForms_atxt; 0)
ARRAY TEXT:C222($VariableOrFieldName_atxt; 0)
C_TIME:C306($Doc_tm)
$Path_txt:=Select folder:C670("Select folder to place form info in")
C_BLOB:C604($ReportPart_blb)
C_TEXT:C284($Detail_txt)
TEXT TO BLOB:C554("Table/Form Name"+Char:C90(Tab:K15:37)+\
"Variable Name"+Char:C90(Tab:K15:37)+\
"Object Name"+Char:C90(Tab:K15:37)+\
"Object Type"+Char:C90(Tab:K15:37)+\
"Style Sheet"+Char:C90(Tab:K15:37)+\
"Font"+Char:C90(Tab:K15:37)+\
"Font Size"+Char:C90(Tab:K15:37)+\
"Form Page"+Char:C90(Carriage return:K15:38); $Report_blb; UTF8 text without length:K22:17; *)




FORM GET NAMES:C1167($TableForms_atxt)
For ($FormLoop_L; 1; Size of array:C274($TableForms_atxt))
	$FormName_txt:=$TableForms_atxt{$FormLoop_L}
	
	FORM LOAD:C1103($TableForms_atxt{$FormLoop_L})
	SET BLOB SIZE:C606($ReportPart_blb; 0)
	ut_FormGetObjects($TableForms_atxt{$FormLoop_L}; ->$ReportPart_blb; $ReportonMissingOnly_B)
	If (BLOB size:C605($ReportPart_blb)>0)
		//TEXT TO BLOB("Start Form :"+$FormName_txt+Char(Carriage return);$Report_blb;UTF8 text without length;*)
		$Detail_txt:=BLOB to text:C555($ReportPart_blb; UTF8 text without length:K22:17)
		TEXT TO BLOB:C554($Detail_txt; $Report_blb; UTF8 text without length:K22:17; *)
		
		//TEXT TO BLOB("End Form :"+$FormName_txt+Char(Carriage return);$Report_blb;UTF8 text without length;*)
	End if 
	FORM UNLOAD:C1299
	
End for 
C_BOOLEAN:C305($SentStart_B; $SentEnd_B)

For ($Loop_l; 1; Get last table number:C254)
	
	If (Is table number valid:C999($Loop_l))
		$SentStart_B:=False:C215
		$SentEnd_B:=False:C215
		ARRAY TEXT:C222($TableForms_atxt; 0)
		$Table_ptr:=Table:C252($Loop_l)
		FORM GET NAMES:C1167($Table_ptr->; $TableForms_atxt)
		For ($FormLoop_L; 1; Size of array:C274($TableForms_atxt))
			$FormName_txt:="["+Table name:C256($Loop_l)+"];"+$TableForms_atxt{$FormLoop_L}
			SET BLOB SIZE:C606($ReportPart_blb; 0)
			FORM LOAD:C1103($Table_ptr->; $TableForms_atxt{$FormLoop_L})
			ut_FormGetObjects($TableForms_atxt{$FormLoop_L}; ->$ReportPart_blb; $ReportonMissingOnly_B)
			If (BLOB size:C605($ReportPart_blb)>0)
				If (Not:C34($SentStart_B))
					TEXT TO BLOB:C554("Start Table: "+Table name:C256($Loop_l)+Char:C90(Carriage return:K15:38); $Report_blb; UTF8 text without length:K22:17; *)
					$SentStart_B:=True:C214
				End if 
				//TEXT TO BLOB("Start Form :"+$FormName_txt+Char(Carriage return);$Report_blb;UTF8 text without length;*)
				$Detail_txt:=BLOB to text:C555($ReportPart_blb; UTF8 text without length:K22:17)
				TEXT TO BLOB:C554($Detail_txt; $Report_blb; UTF8 text without length:K22:17; *)
				
				//TEXT TO BLOB("End Form :"+$FormName_txt+Char(Carriage return);$Report_blb;UTF8 text without length;*)
			End if 
			FORM UNLOAD:C1299
		End for 
		If ($SentStart_B)
			TEXT TO BLOB:C554("End Table: "+Table name:C256($Loop_l)+Char:C90(Carriage return:K15:38); $Report_blb; UTF8 text without length:K22:17; *)
		End if 
	End if 
End for 
If ($ReportonMissingOnly_B)
	$Path_txt:=$Path_txt+"v15_FormInfo_Missing_"+ut_ReturnTimeStampFromDate(Current date:C33; Current time:C178)+".txt"
Else 
	$Path_txt:=$Path_txt+"v15_FormInfo_ALL_"+ut_ReturnTimeStampFromDate(Current date:C33; Current time:C178)+".txt"
	
End if 

BLOB TO DOCUMENT:C526($Path_txt; $Report_blb)
ALERT:C41("Done")
//End ut_LoadFormsandGetInfo