If (False:C215)
	// Modified by: costasmanousakis-(Designer)-(12/10/10 20:39:45)
	Mods_2010_12
End if 

Case of 
		
	: (Form event code:C388=On Clicked:K2:4)
		C_LONGINT:C283($RowSel_L; $Ret_L)
		$RowSel_L:=ITMLB_ItemNos_as
		If ($RowSel_L>0)
			
			If ((Right click:C712) | (Macintosh control down:C544))
				C_TEXT:C284($PopMenuCmds_txt)
				
				$PopMenuCmds_txt:=". Choises for"+ITMLB_ItemNos_as{$RowSel_L}
				$PopMenuCmds_txt:=$PopMenuCmds_txt+<>sCR+"Edit Contractor Estimate"
				$PopMenuCmds_txt:=$PopMenuCmds_txt+<>sCR+"Edit Office Estimate"
				If (ITMLB_ItemDesc_atxt{$RowSel_L}="BASE LABOR RATE")
					$PopMenuCmds_txt:=$PopMenuCmds_txt+<>sCR+"Enter ARTISAN Hours"
				Else 
					$PopMenuCmds_txt:=$PopMenuCmds_txt+<>sCR+"Edit Used Quantity"
				End if 
				
				
				C_LONGINT:C283($Ret_L)
				$Ret_L:=Pop up menu:C542($PopMenuCmds_txt)
				Case of 
					: ($Ret_L=2)
						EDIT ITEM:C870(DCM_P_ITMLB_ItemQCEST_ar; $RowSel_L)
					: ($Ret_L=3)
						EDIT ITEM:C870(DCM_P_ITMLB_ItemQOEST_ar; $RowSel_L)
					: ($Ret_L=4)
						If (ITMLB_ItemDesc_atxt{$RowSel_L}="BASE LABOR RATE")
							C_LONGINT:C283(DCM_P_HOURSINDX_L)
							DCM_P_HOURSINDX_L:=$RowSel_L
							EDIT ITEM:C870(DCM_P_ITMLB_ItemQEnt_ar; $RowSel_L)
							
						Else 
							EDIT ITEM:C870(DCM_P_ITMLB_ItemQEnt_ar; $RowSel_L)
						End if 
						
				End case 
				
			End if 
		End if 
		
End case 