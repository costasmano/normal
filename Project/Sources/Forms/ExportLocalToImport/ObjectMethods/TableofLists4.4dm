
//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 05/23/13, 15:37:39
//----------------------------------------------------
//Method: Object Method: Testing.Button
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2013_05  //r003 ` 
	//Modified by: Charles Miller (5/23/13 15:37:40)
	
End if 
C_LONGINT:C283($Loop_L; $ArrayPosition_L)
C_BOOLEAN:C305($RemoveRowFromDisplay_b)
ARRAY LONGINT:C221($LocalKeys_al; 0)

For ($Loop_L; 1; Records in selection:C76([TableOfLists:125]))
	GOTO SELECTED RECORD:C245([TableOfLists:125]; $Loop_L)
	$ArrayPosition_L:=Find in array:C230(RemoteListKey_al; [TableOfLists:125]ListKeyID_L:4)
	$RemoveRowFromDisplay_b:=False:C215
	
	If ($ArrayPosition_L>0)
		
		Case of 
			: (Not:C34([TableOfLists:125]ListName_s:1=RemoteListName_atxt{$ArrayPosition_L}))
			: (Not:C34([TableOfLists:125]ListSequence_l:3=RemoteListSequence_al{$ArrayPosition_L}))
			: (Not:C34([TableOfLists:125]ListValue_s:2=RemoteListValue_atxt{$ArrayPosition_L}))
				
			Else 
				
				
				$RemoveRowFromDisplay_b:=True:C214
				
				
		End case 
		If ($RemoveRowFromDisplay_b)
			LISTBOX DELETE ROWS:C914(*; "TableofLists"; $ArrayPosition_L)
		Else 
			APPEND TO ARRAY:C911($LocalKeys_al; [TableOfLists:125]ListKeyID_L:4)
		End if 
	Else 
		APPEND TO ARRAY:C911($LocalKeys_al; [TableOfLists:125]ListKeyID_L:4)
	End if 
	
End for 

QUERY WITH ARRAY:C644([TableOfLists:125]ListKeyID_L:4; $LocalKeys_al)
CREATE SET:C116([TableOfLists:125]; "QuerySet")



//End Object Method: Testing.Button

