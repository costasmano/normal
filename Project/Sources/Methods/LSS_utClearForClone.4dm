//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): administrator
//Date and time: 07/07/15, 13:11:27
//----------------------------------------------------
//Method: LSS_utClearForClone
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2015_07  // 
	//Modified by: administrator (7/7/15 13:11:30)
	
End if 
ut_SetReadWrite("Write"; ->[LSS_Inspection:164]; ->[LSS_ElementInspection:163]; ->[LSS_Photos:166]; ->[LSS_Accessibility:159]; ->[LSS_DMeter:161]; ->[LSS_UT:175]; ->[LSS_UtResult:176]; ->[LSS_TeamMembers:173])


ut_SetReadWrite("Write"; ->[LSS_SignPanel:172]; ->[LSS_TowerDistance:174]; ->[LSS_VerticalClearance:177])
C_BOOLEAN:C305($Complete_B)
C_LONGINT:C283($RecordCount_L)

Repeat 
	Repeat 
		CONFIRM:C162("Truncate [LSS_Inventory] with "+String:C10(Records in table:C83([LSS_Inventory:165]))+" records in table")
		If (OK=1)
			TRUNCATE TABLE:C1051([LSS_Inventory:165])
			If (OK=0)
				DELAY PROCESS:C323(Current process:C322; 10)
			End if 
		Else 
			OK:=1
		End if 
	Until (OK=1)
	$RecordCount_L:=Records in table:C83([LSS_Inventory:165])
	
	Repeat 
		CONFIRM:C162("Truncate [LSS_Inspection] with "+String:C10(Records in table:C83([LSS_Inspection:164]))+" records in table")
		If (OK=1)
			TRUNCATE TABLE:C1051([LSS_Inspection:164])
			If (OK=0)
				DELAY PROCESS:C323(Current process:C322; 10)
			End if 
		Else 
			OK:=1
		End if 
	Until (OK=1)
	$RecordCount_L:=$RecordCount_L+Records in table:C83([LSS_Inspection:164])
	Repeat 
		CONFIRM:C162("Truncate [LSS_ElementInspection] with "+String:C10(Records in table:C83([LSS_ElementInspection:163]))+" records in table")
		If (OK=1)
			TRUNCATE TABLE:C1051([LSS_ElementInspection:163])
			If (OK=0)
				DELAY PROCESS:C323(Current process:C322; 10)
			End if 
		Else 
			OK:=1
		End if 
	Until (OK=1)
	$RecordCount_L:=$RecordCount_L+Records in table:C83([LSS_ElementInspection:163])
	Repeat 
		CONFIRM:C162("Truncate [LSS_Photos] with "+String:C10(Records in table:C83([LSS_Photos:166]))+" records in table")
		If (OK=1)
			TRUNCATE TABLE:C1051([LSS_Photos:166])
			If (OK=0)
				DELAY PROCESS:C323(Current process:C322; 10)
			End if 
		Else 
			OK:=1
		End if 
	Until (OK=1)
	$RecordCount_L:=$RecordCount_L+Records in table:C83([LSS_Photos:166])
	Repeat 
		CONFIRM:C162("Truncate [LSS_Accessibility] with "+String:C10(Records in table:C83([LSS_Accessibility:159]))+" records in table")
		If (OK=1)
			TRUNCATE TABLE:C1051([LSS_Accessibility:159])
			If (OK=0)
				DELAY PROCESS:C323(Current process:C322; 10)
			End if 
		Else 
			OK:=1
		End if 
	Until (OK=1)
	$RecordCount_L:=$RecordCount_L+Records in table:C83([LSS_Accessibility:159])
	Repeat 
		CONFIRM:C162("Truncate [LSS_DMeter] with "+String:C10(Records in table:C83([LSS_DMeter:161]))+" records in table")
		If (OK=1)
			TRUNCATE TABLE:C1051([LSS_DMeter:161])
			If (OK=0)
				
				DELAY PROCESS:C323(Current process:C322; 10)
			End if 
		Else 
			OK:=1
		End if 
	Until (OK=1)
	$RecordCount_L:=$RecordCount_L+Records in table:C83([LSS_DMeter:161])
	Repeat 
		CONFIRM:C162("Truncate [LSS_UT] with "+String:C10(Records in table:C83([LSS_UT:175]))+" records in table")
		If (OK=1)
			TRUNCATE TABLE:C1051([LSS_UT:175])
			If (OK=0)
				DELAY PROCESS:C323(Current process:C322; 10)
			End if 
		Else 
			OK:=1
		End if 
	Until (OK=1)
	$RecordCount_L:=$RecordCount_L+Records in table:C83([LSS_UT:175])
	Repeat 
		CONFIRM:C162("Truncate [LSS_UtResult] with "+String:C10(Records in table:C83([LSS_UtResult:176]))+" records in table")
		If (OK=1)
			TRUNCATE TABLE:C1051([LSS_UtResult:176])
			If (OK=0)
				DELAY PROCESS:C323(Current process:C322; 10)
			End if 
		Else 
			OK:=1
		End if 
	Until (OK=1)
	$RecordCount_L:=$RecordCount_L+Records in table:C83([LSS_UtResult:176])
	Repeat 
		CONFIRM:C162("Truncate [LSS_TeamMembers] with "+String:C10(Records in table:C83([LSS_TeamMembers:173]))+" records in table")
		If (OK=1)
			TRUNCATE TABLE:C1051([LSS_TeamMembers:173])
			If (OK=0)
				DELAY PROCESS:C323(Current process:C322; 10)
			End if 
		Else 
			OK:=1
		End if 
	Until (OK=1)
	$RecordCount_L:=$RecordCount_L+Records in table:C83([LSS_TeamMembers:173])
	Repeat 
		CONFIRM:C162("Truncate [LSS_SignPanel] with "+String:C10(Records in table:C83([LSS_SignPanel:172]))+" records in table")
		If (OK=1)
			TRUNCATE TABLE:C1051([LSS_SignPanel:172])
			If (OK=0)
				DELAY PROCESS:C323(Current process:C322; 10)
			End if 
		Else 
			OK:=1
		End if 
	Until (OK=1)
	$RecordCount_L:=$RecordCount_L+Records in table:C83([LSS_SignPanel:172])
	Repeat 
		CONFIRM:C162("Truncate [LSS_TowerDistance] with "+String:C10(Records in table:C83([LSS_TowerDistance:174]))+" records in table")
		If (OK=1)
			TRUNCATE TABLE:C1051([LSS_TowerDistance:174])
			If (OK=0)
				DELAY PROCESS:C323(Current process:C322; 10)
			End if 
		Else 
			OK:=1
		End if 
	Until (OK=1)
	$RecordCount_L:=$RecordCount_L+Records in table:C83([LSS_TowerDistance:174])
	Repeat 
		CONFIRM:C162("Truncate [LSS_VerticalClearance] with "+String:C10(Records in table:C83([LSS_VerticalClearance:177]))+" records in table")
		If (OK=1)
			TRUNCATE TABLE:C1051([LSS_VerticalClearance:177])
			If (OK=0)
				DELAY PROCESS:C323(Current process:C322; 10)
			End if 
		Else 
			OK:=1
		End if 
	Until (OK=1)
	$RecordCount_L:=$RecordCount_L+Records in table:C83([LSS_VerticalClearance:177])
	If ($RecordCount_L=0)
		$Complete_B:=True:C214
	Else 
		CONFIRM:C162("There are still "+String:C10($RecordCount_L)+" record(s)"; "Try again"; "Skip")
		If (OK=0)
			$Complete_B:=True:C214
		End if 
	End if 
Until ($Complete_B)
If ($RecordCount_L=0)
	SET TEXT TO PASTEBOARD:C523("146.243.135.131:26902")
	
	clone_ControlClone
End if 


//End LSS_utClearFortClone

