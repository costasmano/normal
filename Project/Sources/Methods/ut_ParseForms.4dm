//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): Chuck Miller
//Date and time: 08/09/16, 14:58:48
//----------------------------------------------------
//Method: ut_ParseForms
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// 
	//Modified by: Chuck Miller (8/9/16 14:58:50)
	
End if 

C_BLOB:C604($Report_blb)
SET BLOB SIZE:C606($Report_blb; 0)
C_LONGINT:C283($FormLoop_L; $ObjectLoop_L; $FontSize_L; $FontStyle_L)
ARRAY TEXT:C222($FormNames_atxt; 0)
C_TEXT:C284($VariableName_txt)
C_LONGINT:C283($Table_L; $Field_L)
//Append project forms
FORM GET NAMES:C1167($FormNames_atxt; *)
TEXT TO BLOB:C554("Form Type/Table"+Char:C90(Tab:K15:37)+"Form Name"+Char:C90(Tab:K15:37)+"Variable Name"+Char:C90(Tab:K15:37)+"Object Name"+Char:C90(Tab:K15:37)+"Style Sheet"+Char:C90(Tab:K15:37)+"Font"+Char:C90(Tab:K15:37)+"Size"+Char:C90(Tab:K15:37)+"Style"+Char:C90(Carriage return:K15:38); $Report_blb; Mac text without length:K22:10; *)

For ($FormLoop_L; 1; Size of array:C274($FormNames_atxt))
	FORM LOAD:C1103($FormNames_atxt{$FormLoop_L})
	ARRAY POINTER:C280($Variables_aptr; 0)
	ARRAY TEXT:C222($Objects_atxt; 0)
	
	FORM GET OBJECTS:C898($Objects_atxt; $Variables_aptr; $Pages_al)
	
	For ($ObjectLoop_L; 1; Size of array:C274($Objects_atxt))
		RESOLVE POINTER:C394($Variables_aptr{$ObjectLoop_L}; $VariableName_txt; $Table_L; $Field_L)
		Case of 
			: (Position:C15("Line"; $Objects_atxt{$ObjectLoop_L})>0) & (Is nil pointer:C315($Variables_aptr{$ObjectLoop_L}))
				
				
			: (Position:C15("Rectangle"; $Objects_atxt{$ObjectLoop_L})>0) & (Is nil pointer:C315($Variables_aptr{$ObjectLoop_L}))
				
				
			Else 
				TEXT TO BLOB:C554("Project Form"+Char:C90(Tab:K15:37); $Report_blb; Mac text without length:K22:10; *)
				TEXT TO BLOB:C554($FormNames_atxt{$FormLoop_L}+Char:C90(Tab:K15:37); $Report_blb; Mac text without length:K22:10; *)
				
				If ($Table_L>0)
					TEXT TO BLOB:C554(Field name:C257($Table_L; $Field_L)+Char:C90(Tab:K15:37); $Report_blb; Mac text without length:K22:10; *)
				Else 
					TEXT TO BLOB:C554($VariableName_txt+Char:C90(Tab:K15:37); $Report_blb; Mac text without length:K22:10; *)
				End if 
				TEXT TO BLOB:C554($Objects_atxt{$ObjectLoop_L}+Char:C90(Tab:K15:37); $Report_blb; Mac text without length:K22:10; *)
				TEXT TO BLOB:C554(OBJECT Get style sheet:C1258(*; $Objects_atxt{$ObjectLoop_L})+Char:C90(Tab:K15:37); $Report_blb; Mac text without length:K22:10; *)
				TEXT TO BLOB:C554(OBJECT Get font:C1069(*; $Objects_atxt{$ObjectLoop_L})+Char:C90(Tab:K15:37); $Report_blb; Mac text without length:K22:10; *)
				$FontSize_L:=OBJECT Get font size:C1070(*; $Objects_atxt{$ObjectLoop_L})
				
				$FontStyle_L:=OBJECT Get font style:C1071($Objects_atxt{$ObjectLoop_L})
				
				TEXT TO BLOB:C554(String:C10($FontSize_L)+Char:C90(Tab:K15:37); $Report_blb; Mac text without length:K22:10; *)
				TEXT TO BLOB:C554(String:C10($FontStyle_L)+Char:C90(Carriage return:K15:38); $Report_blb; Mac text without length:K22:10; *)
				
				
				
		End case 
	End for 
	
End for 

C_LONGINT:C283($TableLoop_L)
C_TEXT:C284($TableName_txt)
C_POINTER:C301($Table_ptr)

For ($TableLoop_L; 1; Get last table number:C254)
	If (Is table number valid:C999($TableLoop_L))
		$TableName_txt:=Table name:C256($TableLoop_L)
		$Table_ptr:=Table:C252($TableLoop_L)
		ARRAY TEXT:C222($FormNames_atxt; 0)
		FORM GET NAMES:C1167($Table_ptr->; $FormNames_atxt; *)
		For ($FormLoop_L; 1; Size of array:C274($FormNames_atxt))
			
			FORM LOAD:C1103($Table_ptr->; $FormNames_atxt{$FormLoop_L})
			ARRAY POINTER:C280($Variables_aptr; 0)
			ARRAY TEXT:C222($Objects_atxt; 0)
			
			FORM GET OBJECTS:C898($Objects_atxt; $Variables_aptr; $Pages_al)
			
			For ($ObjectLoop_L; 1; Size of array:C274($Objects_atxt))
				RESOLVE POINTER:C394($Variables_aptr{$ObjectLoop_L}; $VariableName_txt; $Table_L; $Field_L)
				Case of 
					: (Position:C15("Line"; $Objects_atxt{$ObjectLoop_L})>0) & (Is nil pointer:C315($Variables_aptr{$ObjectLoop_L}))
						
					: (Position:C15("Rectangle"; $Objects_atxt{$ObjectLoop_L})>0) & (Is nil pointer:C315($Variables_aptr{$ObjectLoop_L}))
						
						
					Else 
						TEXT TO BLOB:C554($TableName_txt+Char:C90(Tab:K15:37); $Report_blb; Mac text without length:K22:10; *)
						TEXT TO BLOB:C554($FormNames_atxt{$FormLoop_L}+Char:C90(Tab:K15:37); $Report_blb; Mac text without length:K22:10; *)
						
						
						Case of 
							: ($Table_L>0) & ($Field_L>0)
								TEXT TO BLOB:C554(Field name:C257($Table_L; $Field_L)+Char:C90(Tab:K15:37); $Report_blb; Mac text without length:K22:10; *)
							: ($Table_L>0)
								TEXT TO BLOB:C554(Table name:C256($Table_L)+Char:C90(Tab:K15:37); $Report_blb; Mac text without length:K22:10; *)
								
							: ($Field_L>0)
								TEXT TO BLOB:C554("OH OH"+Char:C90(Tab:K15:37); $Report_blb; Mac text without length:K22:10; *)
							Else 
								TEXT TO BLOB:C554($VariableName_txt+Char:C90(Tab:K15:37); $Report_blb; Mac text without length:K22:10; *)
						End case 
						
						TEXT TO BLOB:C554($Objects_atxt{$ObjectLoop_L}+Char:C90(Tab:K15:37); $Report_blb; Mac text without length:K22:10; *)
						TEXT TO BLOB:C554(OBJECT Get style sheet:C1258(*; $Objects_atxt{$ObjectLoop_L})+Char:C90(Tab:K15:37); $Report_blb; Mac text without length:K22:10; *)
						TEXT TO BLOB:C554(OBJECT Get font:C1069(*; $Objects_atxt{$ObjectLoop_L})+Char:C90(Tab:K15:37); $Report_blb; Mac text without length:K22:10; *)
						$FontSize_L:=OBJECT Get font size:C1070(*; $Objects_atxt{$ObjectLoop_L})
						$FontStyle_L:=OBJECT Get font style:C1071(*; $Objects_atxt{$ObjectLoop_L})
						
						TEXT TO BLOB:C554(String:C10($FontSize_L)+Char:C90(Tab:K15:37); $Report_blb; Mac text without length:K22:10; *)
						TEXT TO BLOB:C554(String:C10($FontStyle_L)+Char:C90(Carriage return:K15:38); $Report_blb; Mac text without length:K22:10; *)
						
						
				End case 
			End for 
		End for 
		
		
		
	End if 
End for 
C_TIME:C306($Doc_tm)
$Doc_tm:=Create document:C266("")

CLOSE DOCUMENT:C267($Doc_tm)
BLOB TO DOCUMENT:C526(Document; $Report_blb)
//End ut_ParseForms

