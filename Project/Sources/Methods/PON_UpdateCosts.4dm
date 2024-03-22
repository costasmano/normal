//%attributes = {"invisible":true}
//Method: PON_UpdateCosts
//Description
// Updates table [PON_ELEM_COSTS] 
// executed only on boston server or on dev servers for client connections (utf_ConnectedToBoston_b)
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 04/09/15, 11:39:07
	// ----------------------------------------------------
	//Created : 
	Mods_2015_04
End if 
//
//should only be done in Boston Server `IDs are only created here!
If (utf_ConnectedToBoston_b)
	//for now should be value from ELEM_REL_WEIGHT only 
	QUERY:C277([PON_ELEM_DEFS:178]; [PON_ELEM_DEFS:178]ELEM_SMART_FLAG:4#"Y")
	READ ONLY:C145([PON_ELEM_DEFS:178])
	READ WRITE:C146([PON_ELEM_COSTS:180])
	
	If (Type:C295(ptr_Changes)#Array 2D:K8:24)
		ARRAY POINTER:C280(ptr_Changes; 0; 0)
	End if 
	C_LONGINT:C283($changestack_L)
	If (Size of array:C274(ptr_Changes)=0)
		InitChangeStack(1)
		$changestack_L:=1
	Else 
		//find 1st stack not in use
		C_LONGINT:C283($loop_L)
		$changestack_L:=0
		For ($loop_L; 1; Size of array:C274(ptr_Changes))
			
			If (Size of array:C274(ptr_Changes{$loop_L})=0)
				$changestack_L:=$loop_L  //found empty one!
				$loop_L:=Size of array:C274(ptr_Changes)+1
			End if 
			
		End for 
		If ($changestack_L=0)
			//did not find any empty stack - add one
			$changestack_L:=Size of array:C274(ptr_Changes)+1
			InitChangeStack($changestack_L)
		End if 
		
	End if 
	C_TEXT:C284(vsForward)
	
	C_BOOLEAN:C305($one_b; $many_b)
	GET AUTOMATIC RELATIONS:C899($one_b; $many_b)
	SET AUTOMATIC RELATIONS:C310(False:C215; False:C215)
	//Action should still be HI when getting cost for HI
	SHORT_MESSAGE("Updating HI Cost Table....")
	FIRST RECORD:C50([PON_ELEM_DEFS:178])
	C_LONGINT:C283($totalCount_L; $Updates_L; $New_L)
	While (Not:C34(End selection:C36([PON_ELEM_DEFS:178])))
		
		C_LONGINT:C283($env_Loop_L)
		For ($env_Loop_L; 1; 4)
			QUERY:C277([PON_ELEM_COSTS:180]; [PON_ELEM_COSTS:180]ELEM_KEY:1=[PON_ELEM_DEFS:178]ELEM_KEY:1; *)
			QUERY:C277([PON_ELEM_COSTS:180]; [PON_ELEM_COSTS:180]ELEM_ACTION:3="HI"; *)
			QUERY:C277([PON_ELEM_COSTS:180]; [PON_ELEM_COSTS:180]ENVKEY:2=$env_Loop_L)
			MESSAGE:C88(String:C10([PON_ELEM_DEFS:178]ELEM_KEY:1)+"-"+String:C10($env_Loop_L)+"...")
			$totalCount_L:=$totalCount_L+1
			Case of 
				: (Records in selection:C76([PON_ELEM_COSTS:180])=1)
					If ([PON_ELEM_COSTS:180]ELEM_COST:4#[PON_ELEM_DEFS:178]ELEM_REL_WEIGHT:20)
						If (ut_LoadRecordInteractive(->[PON_ELEM_COSTS:180]))
							[PON_ELEM_COSTS:180]ELEM_COST:4:=[PON_ELEM_DEFS:178]ELEM_REL_WEIGHT:20
							LogChanges(->[PON_ELEM_COSTS:180]ELEM_COST:4; ->[PON_ELEM_COSTS:180]COSTID_L:5; ->[PON_ELEM_COSTS:180]COSTID_L:5; ->[PON_ELEM_COSTS:180]COSTID_L:5; 0)
							SAVE RECORD:C53([PON_ELEM_COSTS:180])
							$Updates_L:=$Updates_L+1
						Else 
							CONFIRM:C162("Not able to load HI cost record for elem key "+String:C10([PON_ELEM_DEFS:178]ELEM_KEY:1)+", env "+String:C10($env_Loop_L)+"!!"; "Continue the Update?"; "Abort")
							If (Ok=0)
								$env_Loop_L:=5
								LAST RECORD:C200([PON_ELEM_DEFS:178])
							End if 
						End if 
					End if 
				: (Records in selection:C76([PON_ELEM_COSTS:180])=0)
					//create record!
					CREATE RECORD:C68([PON_ELEM_COSTS:180])
					Inc_Sequence("PON_ELEM_COSTS"; ->[PON_ELEM_COSTS:180]COSTID_L:5)
					[PON_ELEM_COSTS:180]ELEM_KEY:1:=[PON_ELEM_DEFS:178]ELEM_KEY:1
					[PON_ELEM_COSTS:180]ELEM_ACTION:3:="HI"
					[PON_ELEM_COSTS:180]ENVKEY:2:=$env_Loop_L
					[PON_ELEM_COSTS:180]ELEM_COST:4:=[PON_ELEM_DEFS:178]ELEM_REL_WEIGHT:20
					LogNewRecordChanges(->[PON_ELEM_COSTS:180]COSTID_L:5; ->[PON_ELEM_COSTS:180]COSTID_L:5; ->[PON_ELEM_COSTS:180]COSTID_L:5; 0; "PON_ELEM_COSTS"; $changestack_L)
					SAVE RECORD:C53([PON_ELEM_COSTS:180])
					$New_L:=$New_L+1
				Else 
					//probably multiple records found!!
					CONFIRM:C162("Multiple HI Cost records found for Elem Key "+String:C10([PON_ELEM_DEFS:178]ELEM_KEY:1)+" Envirmoment "+String:C10($env_Loop_L); "Continue?"; "Abort Update")
					
					If (OK=1)
						
					Else 
						$env_Loop_L:=5
						LAST RECORD:C200([PON_ELEM_DEFS:178])
					End if 
					
			End case 
			
		End for 
		
		NEXT RECORD:C51([PON_ELEM_DEFS:178])
	End while 
	CLOSE WINDOW:C154
	ALERT:C41("DONE - Scanned "+String:C10($totalCount_L)+" ElemKey/EnvKeys,  Updated "+String:C10($Updates_L)+" Created New "+String:C10($New_L))
	READ ONLY:C145([PON_ELEM_COSTS:180])
	SET AUTOMATIC RELATIONS:C310($one_b; $many_b)
Else 
	ALERT:C41("This method should only be executed at the Boston Server!!!!")
End if 
//End PON_UpdateCosts