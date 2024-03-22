//%attributes = {"invisible":true}
//Method: INSP_AssignConsPrjMgr
//Description
// assign a consultant proj manager to the records selected in the
// inspection review screen
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 03/19/21, 20:22:35
	// ----------------------------------------------------
	//Created : 
	Mods_2021_03
End if 
//
If (Records in set:C195("UserSet")=0)
	ALERT:C41("You must select Inspection reports first!")
Else 
	C_LONGINT:C283($mouseX; $mouseY; $mouseBtn)
	GET MOUSE:C468($mouseX; $mouseY; $mouseBtn)
	COPY NAMED SELECTION:C331([Inspections:27]; "PREModInspections")
	// check that all inspections are same agency
	USE SET:C118("UserSet")
	ARRAY TEXT:C222($Agencies_atxt; 0)
	DISTINCT VALUES:C339([Inspections:27]Agency:156; $Agencies_atxt)
	
	If (Size of array:C274($Agencies_atxt)>1)
		ALERT:C41("There are multiple consultants selected! All inspection should be by the same consultant!")
		
	Else 
		//get a proje manager for the company
		C_TEXT:C284($agency_txt)
		$agency_txt:=$Agencies_atxt{1}
		ARRAY TEXT:C222($names_atxt; 0)
		ARRAY LONGINT:C221($IDs_aL; 0)
		Begin SQL
			Select Concat(concat([Personnel].[First Name],' '), [Personnel].[Last Name]), [Personnel].[Person ID]
			from [Personnel]
			where [Personnel].[Employer] = :$agency_txt
			AND [Personnel].[Person ID] IN ( Select [PERS_GroupMembers].[PersonID_I] from [PERS_GroupMembers], [PERS_Groups]
			where [PERS_GroupMembers].[GroupID_I] = [PERS_Groups].PERS_GroupID_I and
			([PERS_Groups].[PERS_GroupName_s]='ConsInspProjMgrs'
			or [PERS_Groups].[PERS_GroupName_s]='BIN_InspProjMgrs' 
			) )
			order by [Personnel].[Last Name] ASC
			into :$names_atxt,  :$IDs_aL ;
		End SQL
		
		If (Size of array:C274($names_atxt)=0)
			ALERT:C41("There were no project managers found for "+$agency_txt)
		Else 
			ARRAY TEXT:C222($IDS_atxt; Size of array:C274($IDs_aL))
			C_LONGINT:C283($loop_L)
			For ($loop_L; 1; Size of array:C274($IDs_aL))
				$IDS_atxt{$loop_L}:=String:C10($IDs_aL{$loop_L})
			End for 
			
			C_TEXT:C284($menu_txt; $mgrID_txt; $manager_txt)
			$menu_txt:=MENU_BuildMenuFromArrays(->$names_atxt; ->$IDS_atxt; "")
			$mgrID_txt:=Dynamic pop up menu:C1006($menu_txt; ""; $mouseX; $mousey)
			RELEASE MENU:C978($menu_txt)
			
			If (Num:C11($mgrID_txt)#0)
				C_LONGINT:C283($mgrID_L; $rec_L; $Records_L; $Scanned_L; $Updated_L)
				$manager_txt:=$names_atxt{Find in array:C230($IDS_atxt; $mgrID_txt)}
				$mgrID_L:=Num:C11($mgrID_txt)
				//loop throu
				$Records_L:=Records in selection:C76([Inspections:27])
				
				//start the bar
				C_OBJECT:C1216($progress_o)
				$progress_o:=ProgressNew("Seting Cons Mgr to "+$manager_txt; $Records_L; True:C214; " Inspections"; 3)
				$Scanned_L:=0
				$Updated_L:=0
				For ($rec_L; 1; $Records_L)
					
					GOTO SELECTED RECORD:C245([Inspections:27]; $rec_L)
					If (Is in set:C273("Userset"))
						//update progress
						UpdateProgressNew($progress_o; $rec_L)
						$Scanned_L:=$Scanned_L+1
						If (ut_LoadRecord(->[Inspections:27]))
							[Inspections:27]ConsQCEngrID:205:=$mgrID_L
							LogLink(->[Inspections:27]ConsQCEngrID:205; ->[Bridge MHD NBIS:1]BIN:3; ->[Inspections:27]BIN:1; ->[Inspections:27]InspID:2; 1; ->[Personnel:42]Person ID:1)
							SAVE RECORD:C53([Inspections:27])
							$Updated_L:=$Updated_L+1
						End if 
					End if 
					
					//check if progress stopped
					If (Progress Stopped(OB Get:C1224($progress_o; "progress"; Is longint:K8:6)))
						//abort loop
						$rec_L:=$Records_L+1
					End if 
					
				End for 
				
				//quit progress
				Progress QUIT(OB Get:C1224($progress_o; "progress"; Is longint:K8:6))
				
				ALERT:C41("Scanned "+String:C10($Scanned_L)+" Inspection reports.\r"+\
					"Set project manager to "+$manager_txt+" (ID="+$mgrID_txt+") for "+String:C10($Updated_L))
			End if 
			
		End if 
		
	End if 
	
	USE NAMED SELECTION:C332("PREModInspections")
	CLEAR NAMED SELECTION:C333("PREModInspections")
	HIGHLIGHT RECORDS:C656([Inspections:27])
	
End if 

//End INSP_AssignConsPrjMgr