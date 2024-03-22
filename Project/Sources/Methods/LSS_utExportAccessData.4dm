//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): administrator
//Date and time: 07/14/15, 10:23:51
//----------------------------------------------------
//Method: LSS_utExportAccessData
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2014_Lighting  // 
	//Modified by: administrator (7/14/15 10:23:53)
	
End if 
READ ONLY:C145(*)
ARRAY POINTER:C280($AuxTables_ptr; 0)
//APPEND TO ARRAY($AuxTables_ptr;->[LSS_Photos])

APPEND TO ARRAY:C911($AuxTables_ptr; ->[LSS_Accessibility:159])
APPEND TO ARRAY:C911($AuxTables_ptr; ->[LSS_DMeter:161])
APPEND TO ARRAY:C911($AuxTables_ptr; ->[LSS_ElementInspection:163])
APPEND TO ARRAY:C911($AuxTables_ptr; ->[LSS_Inspection:164])
APPEND TO ARRAY:C911($AuxTables_ptr; ->[LSS_Inventory:165])
APPEND TO ARRAY:C911($AuxTables_ptr; ->[LSS_SignPanel:172])
APPEND TO ARRAY:C911($AuxTables_ptr; ->[LSS_TeamMembers:173])
APPEND TO ARRAY:C911($AuxTables_ptr; ->[LSS_TowerDistance:174])
APPEND TO ARRAY:C911($AuxTables_ptr; ->[LSS_UT:175])
APPEND TO ARRAY:C911($AuxTables_ptr; ->[LSS_UtResult:176])
APPEND TO ARRAY:C911($AuxTables_ptr; ->[LSS_VerticalClearance:177])
C_LONGINT:C283($TableLoop_L; $InnerLoop_L; $NumTables_L; $TableNum_L; $NumTableRecs_L)
C_TEXT:C284($FolderPath_txt)
C_TIME:C306($doc_tm)
$NumTables_L:=Size of array:C274($AuxTables_ptr)
$FolderPath_txt:=Select folder:C670("Select folder to export Access Data for "+Data file:C490; "")
If (OK=1)
	For ($TableLoop_L; 1; Size of array:C274($AuxTables_ptr))
		$TableNum_L:=Table:C252($AuxTables_ptr{$TableLoop_L})
		ALL RECORDS:C47($AuxTables_ptr{$TableLoop_L}->)
		$NumTableRecs_L:=Records in table:C83($AuxTables_ptr{$TableLoop_L}->)
		
		MESSAGE:C88(<>sCR+"Table "+String:C10($TableLoop_L)+"/"+String:C10($NumTables_L)+" :"+Table name:C256($AuxTables_ptr{$TableLoop_L})+"["+String:C10($NumTableRecs_L)+"]")
		C_LONGINT:C283($Count_L; $StartLocation_L)
		$StartLocation_L:=1
		$Count_L:=500
		If (Table name:C256($AuxTables_ptr{$TableLoop_L})="LSS_Photos")
			C_BOOLEAN:C305($Complete_B)
			$Complete_B:=False:C215
			ARRAY LONGINT:C221($RecordNumbers_aL; 0)
			LONGINT ARRAY FROM SELECTION:C647($AuxTables_ptr{$TableLoop_L}->; $RecordNumbers_aL)
			C_LONGINT:C283($EndLocation_L)
			$EndLocation_L:=500
			Repeat 
				If ($StartLocation_L=1)
					GOTO XY:C161(10; 0)
					MESSAGE:C88(<>sCR+"Photo from "+String:C10($StartLocation_L)+" to "+String:C10($EndLocation_L)+" of "+String:C10(Size of array:C274($RecordNumbers_aL)))
				Else 
					GOTO XY:C161(10; 0)
					MESSAGE:C88(<>sCR+"Photo from "+String:C10($StartLocation_L)+" to "+String:C10($EndLocation_L)+" of "+String:C10(Size of array:C274($RecordNumbers_aL)))
				End if 
				SET CHANNEL:C77(12; $FolderPath_txt+Table name:C256($AuxTables_ptr{$TableLoop_L})+"_"+String:C10($StartLocation_L; "000000")+".txt")
				SEND VARIABLE:C80($TableNum_L)
				SEND VARIABLE:C80($Count_L)
				
				
				For ($InnerLoop_L; $StartLocation_L; $EndLocation_L)
					GOTO RECORD:C242([LSS_Photos:166]; $RecordNumbers_aL{$InnerLoop_L})
					SEND RECORD:C78([LSS_Photos:166])
					
				End for 
				$EndLocation_L:=$EndLocation_L+500
				SET CHANNEL:C77(11)
				
				If ($InnerLoop_L>=Size of array:C274($RecordNumbers_aL))
					$Complete_B:=True:C214
					
				Else 
					$StartLocation_L:=$InnerLoop_L
				End if 
				If (($StartLocation_L+500)>Size of array:C274($RecordNumbers_aL))
					$EndLocation_L:=Size of array:C274($RecordNumbers_aL)
				End if 
			Until ($Complete_B)
			
		Else 
			SET CHANNEL:C77(12; $FolderPath_txt+Table name:C256($AuxTables_ptr{$TableLoop_L})+".txt")
			
			SEND VARIABLE:C80($TableNum_L)
			SEND VARIABLE:C80($NumTableRecs_L)
			
			For ($InnerLoop_L; 1; $NumTableRecs_L)
				GOTO SELECTED RECORD:C245($AuxTables_ptr{$TableLoop_L}->; $InnerLoop_L)
				SEND RECORD:C78($AuxTables_ptr{$InnerLoop_L}->)
				
			End for 
			SET CHANNEL:C77(11)
		End if 
		
	End for 
End if 
//End LSS_utExportAccessData

