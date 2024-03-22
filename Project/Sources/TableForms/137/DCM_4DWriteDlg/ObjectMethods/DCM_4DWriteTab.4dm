If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 02/18/10, 08:12:11
	// ----------------------------------------------------
	// Method: Object Method: DCM_4DWriteTab
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2010_02("DCM")
End if 

Case of 
	: (Form event code:C388=On Load:K2:1)
		DCM_4DWriteTab:=1
		
	: (Form event code:C388=On Clicked:K2:4)
		C_LONGINT:C283($tab_L)
		$tab_L:=DCM_4DWriteTab
		C_BLOB:C604($tempBlb_x)
		SET BLOB SIZE:C606($tempBlb_x; 0)
		
		C_POINTER:C301($WpArea_ptr)
		$WpArea_ptr:=OBJECT Get pointer:C1124(Object named:K67:5; "WriteProArea")
		
		C_OBJECT:C1216($Range)
		$Range:=WP Text range:C1341($WpArea_ptr->; wk start text:K81:165; wk end text:K81:164)
		If ($Range.end>1)
			WP EXPORT VARIABLE:C1319($WpArea_ptr->; $tempBlb_x; wk 4wp:K81:4; wk normal:K81:7)
		End if 
		DCM_WO_Write_ptr->:=$tempBlb_x
		Case of 
			: (DCM_4DWriteTab{$tab_L}="Special Instr@")
				DCM_WO_Write_ptr:=->DCM_WO_SpecInst_x
			: (DCM_4DWriteTab{$tab_L}="Traffic")
				DCM_WO_Write_ptr:=->DCM_WO_Traffic_x
			: (DCM_4DWriteTab{$tab_L}="Schedule")
				DCM_WO_Write_ptr:=->DCM_WO_Sched_x
			: (DCM_4DWriteTab{$tab_L}="Scope")
				DCM_WO_Write_ptr:=->DCM_WO_Scope_x
			: (DCM_4DWriteTab{$tab_L}="Deficiency")
				DCM_WO_Write_ptr:=->DCM_WO_Deficiency_x
			: (DCM_4DWriteTab{$tab_L}="Equipment")
				DCM_WO_Write_ptr:=->DCM_WO_Equipment_x
			: (DCM_4DWriteTab{$tab_L}="Materials")
				DCM_WO_Write_ptr:=->DCM_WO_Materials_x
				
		End case 
		DCM_4DWriteDlg_FM(On Load:K2:1)
End case 