//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): Chuck Miller
//Date and time: 06/29/17, 14:27:17
//----------------------------------------------------
//Method: ut_GetDepreactedAgain
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2017_06_bug  //
	
	
	//Modified by: Chuck Miller (6/29/17 14:27:21)
	
End if 
C_TEXT:C284($DOCUMENT_TXT; $Name_txt)
ARRAY TEXT:C222($files_atxt; 0)

$Name_txt:=Select document:C905(""; ""; "Select Doc containing missing picture ids"; Multiple files:K24:7; $files_atxt)
If (OK=1)
	$Name_txt:=$files_atxt{1}
	$DOCUMENT_TXT:=Document to text:C1236($Name_txt; UTF8 text without length:K22:17; Document unchanged:K24:18)
	
	
	
	Compiler_SQL
	Compiler_clone
	
	clone_ControlConnect
	
	
	ARRAY TEXT:C222($Lines_atxt; 0)
	C_TEXT:C284($PhotoID_txt)
	
	ut_NewTextToArray($DOCUMENT_TXT; ->$Lines_atxt; Char:C90(Carriage return:K15:38))
	READ WRITE:C146([Standard Photos:36])
	C_PICTURE:C286($Picture_pct)
	C_LONGINT:C283($PhotoID_L; $Loop_L)
	
	For ($Loop_L; 2; Size of array:C274($Lines_atxt))
		ARRAY TEXT:C222($Parts_atxt; 0)
		ut_NewTextToArray($Lines_atxt{$Loop_L}; ->$Parts_atxt; Char:C90(Tab:K15:37))
		$PhotoID_txt:=$Parts_atxt{1}
		$PhotoID_L:=Num:C11($PhotoID_txt)
		QUERY:C277([Standard Photos:36]; [Standard Photos:36]StdPhotoID:7=$PhotoID_L)
		
		Begin SQL
			
			select
			[Standard Photos].[Std Photo]
			from
			[Standard Photos]
			where
			[Standard Photos].[StdPhotoID] =:$PhotoID_L
			into 
			:$Picture_pct
			
			
		End SQL
		[Standard Photos:36]Std Photo:3:=$Picture_pct
		SAVE RECORD:C53([Standard Photos:36])
		
		
		
		
		
	End for 
	
	
	
	SQL LOGOUT:C872
End if 
//End ut_GetDepreactedAgain

