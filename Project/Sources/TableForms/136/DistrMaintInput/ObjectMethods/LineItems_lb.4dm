If (False:C215)
	// Modified by: costasmanousakis-(Designer)-(12/10/10 20:40:31)
	Mods_2010_12
End if 

Case of 
	: (Form event code:C388=On Clicked:K2:4)
		If ((Right click:C712) | (Macintosh control down:C544))
			C_LONGINT:C283($RowSel_L; $Ret)
			$RowSel_L:=ITMLB_ItemQ_ar
			//ALERT("Right Clicked on row "+String($RowSel_L)+" "+ITMLB_ItemNos_as{$RowSel_L}+"!!!")
			If (ITMLB_ItemNos_as{$RowSel_L}="999.@")
				C_TEXT:C284($PopMenuCmds_txt)
				$PopMenuCmds_txt:=". Choises for "+ITMLB_ItemNos_as{$RowSel_L}+<>sCR+"Edit Contract Quantity"
				
				If (Find in array:C230(ITMLB_AE_ItemNos_as; ITMLB_ItemNos_as{$RowSel_L})>0)
				Else 
					$PopMenuCmds_txt:=$PopMenuCmds_txt+<>sCR+"Edit Item Description"
					$PopMenuCmds_txt:=$PopMenuCmds_txt+<>sCR+"Delete Item"
				End if 
				
				$Ret:=Pop up menu:C542($PopMenuCmds_txt)
				
				Case of 
					: ($Ret=2)
						DCM_EditContrQ_OM
					: ($Ret=3)
						//Edit  Description
						OBJECT SET ENTERABLE:C238(ITMLB_ItemDesc_atxt; True:C214)
						EDIT ITEM:C870(ITMLB_ItemDesc_atxt; $RowSel_L)
					: ($Ret=4)
						//Delete command
						DCM_DelBidItem($RowSel_L)
						
				End case 
				
			End if 
			
		End if 
End case 