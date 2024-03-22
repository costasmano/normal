//%attributes = {"invisible":true}
//Method: CU_CondUnitsSubForm_FM
//Description
// Form method for [Cond Units];"Cond_Units_SUB" subform
// Parameters
// $1 : $FormEvent
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 02/10/20, 14:17:51
	// ----------------------------------------------------
	//Created : 
	Mods_2020_02
	
	C_LONGINT:C283(CU_CondUnitsSubForm_FM; $1)
	// Modified by: Costas Manousakis-(Designer)-(5/1/20 12:48:47)
	Mods_2020_05
	//  `Fixed name of LB
End if 
//

C_LONGINT:C283($FormEvent_L)

If (Count parameters:C259>0)
	C_LONGINT:C283($1)
	$FormEvent_L:=$1
Else 
	$FormEvent_L:=Form event code:C388
End if 

C_TEXT:C284($LB_Name)
$LB_Name:="LBCondUnits_SUB"
C_POINTER:C301($LB_ptr)
$LB_ptr:=OBJECT Get pointer:C1124(Object named:K67:5; $LB_Name)

Case of 
	: ($FormEvent_L=On Clicked:K2:4)
		
	: ($FormEvent_L=On Double Clicked:K2:5)
		If (Not:C34(InDoubleClick_B))
			InDoubleClick_B:=True:C214
			C_LONGINT:C283($RowSelected_L; $LastID_L; $Loop_L; $Column_L)
			$RowSelected_L:=Selected record number:C246([Cond Units:45])
			
			If ($RowSelected_L>0)
				GOTO SELECTED RECORD:C245([Cond Units:45]; $RowSelected_L)
				LOAD RECORD:C52([Cond Units:45])
				If (Read only state:C362([Cond Units:45]))
					DIALOG:C40([Cond Units:45]; "Cond Units In")
				Else 
					FORM SET INPUT:C55([Cond Units:45]; "Cond Units In")
					MODIFY RECORD:C57([Cond Units:45])
				End if 
			End if 
			$RowSelected_L:=Selected record number:C246([Cond Units:45])
			CREATE EMPTY SET:C140([Cond Units:45]; "ListBoxSet0")
			GOTO SELECTED RECORD:C245([Cond Units:45]; $RowSelected_L)
			ADD TO SET:C119([Cond Units:45]; "ListBoxSet0")
			OBJECT SET SCROLL POSITION:C906(*; "LBCondUnits_SUB"; $RowSelected_L)
			InDoubleClick_B:=False:C215
			
		End if 
	: ($FormEvent_L=On Display Detail:K2:22)
		
		display_1cuLB
		
	: ($FormEvent_L=On Load:K2:1)
		
		READ WRITE:C146([Cond Units:45])
		If ([Inspections:27]Insp Type:6="PON")
			OBJECT SET VISIBLE:C603(*; "DE AddPontisInspection"; False:C215)
			OBJECT SET VISIBLE:C603(*; "DE CopyPontisInspection"; False:C215)
			OBJECT SET VISIBLE:C603(*; "DE btnCUAdd"; False:C215)
			
		Else 
			OBJECT SET ENABLED:C1123(*; "DE AddPontisInspection"; Not:C34(vbinspectionLocked))
			OBJECT SET ENABLED:C1123(*; "DE CopyPontisInspection"; Not:C34(vbinspectionLocked))
			OBJECT SET ENABLED:C1123(*; "DE btnCUAdd"; Not:C34(vbinspectionLocked))
			
			
		End if 
		LISTBOX SELECT ROW:C912(*; $LB_Name; 0; lk remove from selection:K53:3)
		REDRAW:C174($LB_ptr->)
		
	: ($FormEvent_L=On Resize:K2:27)
		
		REDRAW:C174($LB_ptr->)
		
End case 
//End CU_CondUnitsSubForm_FM