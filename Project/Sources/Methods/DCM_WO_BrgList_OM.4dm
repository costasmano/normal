//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 07/06/10, 05:33:09
	// ----------------------------------------------------
	// Method: DCM_WO_BrgList_OM
	// Description
	//  `  `Method for the Bridge List box in the work order input form
	// 
	// Parameters
	// $1 : $FormEvent_L
	// $2 : $Lb_Ptr
	// ----------------------------------------------------
	
	Mods_2010_09
	// Modified by: costasmanousakis-(Designer)-(4/6/11 16:09:03)
	Mods_2011_04
	//  `Fixed misstyped name of input form.
	Mods_2017_07_bug  //Add InDoubleClick_B so that user can nor double click into a list box. This is a workaround to a 4D bug
	//Modified by: Chuck Miller (7/14/17 11:50:35)
End if 

C_LONGINT:C283($FormEvent_L)
C_LONGINT:C283($1)
$FormEvent_L:=$1
C_POINTER:C301($2)

Case of 
	: ($FormEvent_L=On Load:K2:1)
		C_LONGINT:C283($loop_L)
		For ($loop_L; 1; Size of array:C274($2->))
			$2->{$loop_L}:=False:C215
		End for 
		LISTBOX SELECT ROW:C912($2->; 0; 2)
		
	: ($FormEvent_L=On Data Change:K2:15)
		
	: ($FormEvent_L=On Double Clicked:K2:5)
		If (Not:C34(InDoubleClick_B))
			InDoubleClick_B:=True:C214
			C_LONGINT:C283($Row_L; $CurrID_L)
			$Row_L:=($2->)
			If ($Row_L>0)
				GOTO SELECTED RECORD:C245([DCM_Project:138]; $Row_L)
				
				FORM SET INPUT:C55([DCM_Project:138]; "DistrWorkOrderInput")
				If (ut_LoadRecordInteractive(->[DCM_Project:138]))
					MODIFY RECORD:C57([DCM_Project:138])
				Else 
					READ ONLY:C145([DCM_Project:138])
					LOAD RECORD:C52([DCM_Project:138])
					DIALOG:C40([DCM_Project:138]; "DistrWorkOrderInput")
				End if 
				$CurrID_L:=[DCM_Project:138]ProjectID:1
				QUERY:C277([DCM_Project:138]; [DCM_Project:138]AssignID:13=[DCM_WorkOrders:137]AssignID:3)
				ORDER BY:C49([DCM_Project:138]; [DCM_Project:138]BIN:5)
				DCM_WO_PrjLB_Control("LOAD")
				C_LONGINT:C283($CurRow_L)
				$CurRow_L:=Find in array:C230(DCM_WO_RecNo_aL; $CurrID_L)
				
				C_LONGINT:C283($loop_L)
				For ($loop_L; 1; Size of array:C274($2->))
					If ($CurRow_L=$loop_L)
						$2->{$loop_L}:=True:C214
						LISTBOX SELECT ROW:C912($2->; $loop_L; 0)
					Else 
						$2->{$loop_L}:=False:C215
					End if 
					
				End for 
				
			End if 
			InDoubleClick_B:=False:C215
		End if 
		
End case 