//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 5/28/10
	// ----------------------------------------------------
	// Method: DCM_4DWriteDlg_FM
	// Description
	// 
	// 
	// Parameters
	// $1 : $FormEvent_L (optional)
	// ----------------------------------------------------
	
	Mods_2010_05
	// Modified by: costasmanousakis-(Designer)-(7/8/10 04:23:28)
	Mods_2010_09
	//  `Adjustments in the form method
	// Modified by: Costas Manousakis-(Designer)-(6/25/21 17:00:57)
	Mods_2021_WP
	//  `
End if 
C_LONGINT:C283($FormEvent_L)
If (Count parameters:C259>0)
	C_LONGINT:C283($1)
	$FormEvent_L:=$1
Else 
	$FormEvent_L:=Form event code:C388
End if 

Case of 
	: ($FormEvent_L=On Load:K2:1)
		ARRAY TEXT:C222(DCM_4DWriteTab; 7)
		C_LONGINT:C283($arrindx_L)
		DCM_4DWriteTab{1}:="Deficiency"
		DCM_4DWriteTab{2}:="Scope"
		DCM_4DWriteTab{3}:="Traffic"
		DCM_4DWriteTab{4}:="Equipment"
		DCM_4DWriteTab{5}:="Materials"
		DCM_4DWriteTab{6}:="Schedule"
		DCM_4DWriteTab{7}:="Special Instructions"
		
		C_POINTER:C301($WParea_ptr)
		$WParea_ptr:=OBJECT Get pointer:C1124(Object named:K67:5; "WriteProArea")
		C_OBJECT:C1216($body)
		
		If (BLOB size:C605(DCM_WO_Write_ptr->)>0)
			$WParea_ptr->:=WP New:C1317(DCM_WO_Write_ptr->)
			
		Else 
			$WParea_ptr->:=WP New:C1317
			$body:=WP Text range:C1341($WParea_ptr->; wk start text:K81:165; wk end text:K81:164)
			WP SET TEXT:C1574($body; ""; wk replace:K81:177; wk include in range:K81:180)
			WP SET ATTRIBUTES:C1342($body; wk font family:K81:65; "Times New Roman"; wk font size:K81:66; 12)
		End if 
End case 