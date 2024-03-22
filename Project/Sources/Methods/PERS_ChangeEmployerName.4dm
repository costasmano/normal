//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 08/22/08, 09:34:57
	// ----------------------------------------------------
	// Method: PERS_ChangeEmployerName
	// Description
	// Change the current employer name
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2008_CM_5404
End if 
C_TEXT:C284($OldName_txt; $NewName_txt)
ARRAY TEXT:C222(ListofEmpl_atxt; 0)
COPY NAMED SELECTION:C331([Personnel:42]; "CHGNAMESELECTION")
ALL RECORDS:C47([Personnel:42])
DISTINCT VALUES:C339([Personnel:42]Employer:9; ListofEmpl_atxt)
SORT ARRAY:C229(ListofEmpl_atxt)
C_LONGINT:C283($FldType; $FldLen; $Employer_pick_L)
GET FIELD PROPERTIES:C258(->[Personnel:42]Employer:9; $FldType; $FldLen)

$Employer_pick_L:=G_PickFromList(->ListofEmpl_atxt)
If ($Employer_pick_L>0)
	QUERY:C277([Personnel:42]; [Personnel:42]Employer:9=ListofEmpl_atxt{$Employer_pick_L})
	C_BOOLEAN:C305($GotNewName_b; $Done_b)
	$GotNewName_b:=False:C215
	$Done_b:=False:C215
	Repeat 
		$NewName_txt:=Request:C163("Enter New Consultant Name - max "+String:C10($FldLen)+" chars")
		If (OK=1)
			Case of 
				: (Length:C16($NewName_txt)>$FldLen)
					ALERT:C41("Name entered <"+$NewName_txt+"> is greater than "+String:C10($FldLen)+" characters! Please try again!")
				Else 
					$NewName_txt:=Request:C163("Verify New Consultant Name"; $NewName_txt)
					If (OK=1)
						If (Length:C16($NewName_txt)>$FldLen)
							ALERT:C41("Name entered <"+$NewName_txt+"> is greater than "+String:C10($FldLen)+" characters! Please try again!")
						Else 
							$Done_b:=True:C214
							$GotNewName_b:=True:C214
						End if 
					Else 
						CONFIRM:C162("Try to enter New Employer again or Cancel?"; "TryAgain"; "Cancel")
						If (Ok=1)
						Else 
							$Done_b:=True:C214
						End if 
					End if 
			End case 
			
		Else 
			$Done_b:=True:C214
		End if 
		
	Until ($Done_b)
	
	If ($GotNewName_b)
		C_LONGINT:C283($i; $NumPers_L)
		C_BOOLEAN:C305($Done_b; $ApplyChange_b)
		$Done_b:=False:C215
		$ApplyChange_b:=False:C215
		Repeat 
			$NumPers_L:=Records in selection:C76([Personnel:42])
			CONFIRM:C162("Number of selected records are :"+String:C10($NumPers_L)+". Change their employer or do a new query?"; "Apply"; "NewQuery")
			If (OK=1)
				$Done_b:=True:C214
				$ApplyChange_b:=True:C214
			Else 
				QUERY:C277([Personnel:42])
				If (OK=1)
				Else 
					$Done_b:=True:C214
				End if 
				
			End if 
			
		Until ($Done_b)
		
		If ($ApplyChange_b)
			For ($i; 1; $NumPers_L)
				GOTO SELECTED RECORD:C245([Personnel:42]; $i)
				If (ut_LoadRecordInteractive(->[Personnel:42]))
					InitChangeStack(1)
					[Personnel:42]Employer:9:=$NewName_txt
					PushChange(1; ->[Personnel:42]Employer:9)
					SAVE RECORD:C53([Personnel:42])
					FlushGrpChgs(1; ->[Personnel:42]Person ID:1; ->[Personnel:42]Person ID:1; ->[Personnel:42]Person ID:1; 1)
				End if 
			End for 
			ORDER BY:C49([Personnel:42]; [Personnel:42]Last Name:5; >; [Personnel:42]First Name:3; >)
			COPY NAMED SELECTION:C331([Personnel:42]; "CHGNAMESELECTION")
			//now update the lists
			ARRAY TEXT:C222($ListItems_atxt; 0)
			LIST TO ARRAY:C288("Bridge Designers"; $ListItems_atxt)
			If (Find in array:C230($ListItems_atxt; $NewName_txt)<0)
				INSERT IN ARRAY:C227($ListItems_atxt; 1; 1)
				$ListItems_atxt{1}:=$NewName_txt
				SORT ARRAY:C229($ListItems_atxt)
				ARRAY TO LIST:C287($ListItems_atxt; "Bridge Designers")
			End if 
			ARRAY TEXT:C222($ListItems_atxt; 0)
			LIST TO ARRAY:C288("Employers"; $ListItems_atxt)
			If (Find in array:C230($ListItems_atxt; $NewName_txt)<0)
				INSERT IN ARRAY:C227($ListItems_atxt; 1; 1)
				$ListItems_atxt{1}:=$NewName_txt
				SORT ARRAY:C229($ListItems_atxt)
				ARRAY TO LIST:C287($ListItems_atxt; "Employers")
			End if 
			ARRAY TEXT:C222($ListItems_atxt; 0)
			LIST TO ARRAY:C288("Rating Cnslts"; $ListItems_atxt)
			If (Find in array:C230($ListItems_atxt; $NewName_txt)<0)
				INSERT IN ARRAY:C227($ListItems_atxt; 1; 1)
				$ListItems_atxt{1}:=$NewName_txt
				SORT ARRAY:C229($ListItems_atxt)
				ARRAY TO LIST:C287($ListItems_atxt; "Rating Cnslts")
			End if 
			ARRAY TEXT:C222($ListItems_atxt; 0)
			
		End if 
	End if 
	
End if 
USE NAMED SELECTION:C332("CHGNAMESELECTION")
CLEAR NAMED SELECTION:C333("CHGNAMESELECTION")