Case of 
	: (Form event code:C388=On Load:K2:1)
		C_REAL:C285(CurrAssTotalLimFeeDes; CurrAssTotalLimFeeCons; CurrAssDirExpense)
		C_REAL:C285(CurrAssTotalLimFeeDesP; CurrAssTotalLimFeeConsP; CurrAssDirExpenseP)
		C_REAL:C285(CurrAssTotalLimFeeDesL; CurrAssTotalLimFeeConsL; CurrAssDirExpenseL)
		
		If ([Invoice_AssignNo_Maintenance:94]AssignNo:2#0)
			POPUPMENUC(->CM_AssgnDesc; ->CM_AssgnNo_aI; ->[Invoice_AssignNo_Maintenance:94]AssignNo:2)
			//Self->:=[Invoice_AssignNo_Maintenance]AssignNo
			If (CM_AssgnDesc>0)
				CurrAssTotalLimFeeDes:=CM_AssgnEstTLF_D_aR{CM_AssgnDesc}
				CurrAssTotalLimFeeCons:=CM_AssgnEstTLF_C_aR{CM_AssgnDesc}
				CurrAssDirExpense:=CM_AssgnEstDE_aR{CM_AssgnDesc}
				
				CM_GetPrevInvoiceAssgnData
				
				CurrAssTotalLimFeeDesL:=CurrAssTotalLimFeeDes-(CurrAssTotalLimFeeDesP+[Invoice_AssignNo_Maintenance:94]TotalLimFeeDes:3)
				CurrAssTotalLimFeeConsL:=CurrAssTotalLimFeeCons-(CurrAssTotalLimFeeConsP+[Invoice_AssignNo_Maintenance:94]TotalLimFeeConstr:4)
				CurrAssDirExpenseL:=CurrAssDirExpense-(CurrAssDirExpenseP+[Invoice_AssignNo_Maintenance:94]DirectExpense:5)
			End if 
		Else 
			Self:C308->:=0
			CurrAssTotalLimFeeDes:=0
			CurrAssTotalLimFeeCons:=0
			CurrAssDirExpense:=0
			CurrAssTotalLimFeeDesP:=0
			CurrAssTotalLimFeeConsP:=0
			CurrAssDirExpenseP:=0
			CurrAssTotalLimFeeDesL:=0
			CurrAssTotalLimFeeConsL:=0
			CurrAssDirExpenseL:=0
			
		End if 
		
	: (Form event code:C388=On Clicked:K2:4)
		POPUPMENUC(->CM_AssgnDesc; ->CM_AssgnNo_aI; ->[Invoice_AssignNo_Maintenance:94]AssignNo:2)
		If ([Invoice_AssignNo_Maintenance:94]AssignNo:2#Old:C35([Invoice_AssignNo_Maintenance:94]AssignNo:2))
			If (Find in array:C230(CM_Inv_AssgnList; [Invoice_AssignNo_Maintenance:94]AssignNo:2)>0)
				ALERT:C41("Already entered data for assignement "+CM_AssgnDesc{CM_AssgnDesc})
				[Invoice_AssignNo_Maintenance:94]AssignNo:2:=Old:C35([Invoice_AssignNo_Maintenance:94]AssignNo:2)
				//Self->:=[Invoice_AssignNo_Maintenance]AssignNo
			Else 
				//$arrIndex_L:=Self->  `The value cannot be zero by design...
				CurrAssTotalLimFeeDes:=CM_AssgnEstTLF_D_aR{CM_AssgnDesc}
				CurrAssTotalLimFeeCons:=CM_AssgnEstTLF_C_aR{CM_AssgnDesc}
				CurrAssDirExpense:=CM_AssgnEstDE_aR{CM_AssgnDesc}
				
				CM_GetPrevInvoiceAssgnData
				
				CurrAssTotalLimFeeDesL:=CurrAssTotalLimFeeDes-(CurrAssTotalLimFeeDesP+[Invoice_AssignNo_Maintenance:94]TotalLimFeeDes:3)
				CurrAssTotalLimFeeConsL:=CurrAssTotalLimFeeCons-(CurrAssTotalLimFeeConsP+[Invoice_AssignNo_Maintenance:94]TotalLimFeeConstr:4)
				CurrAssDirExpenseL:=CurrAssDirExpense-(CurrAssDirExpenseP+[Invoice_AssignNo_Maintenance:94]DirectExpense:5)
				
				OBJECT SET ENTERABLE:C238(*; "DE_@"; True:C214)
				OBJECT SET RGB COLORS:C628(*; "DE_@"; Col_paletteToRGB(Abs:C99(<>Color_Editable)%256); Col_paletteToRGB(Abs:C99(<>Color_Editable)\256))  // **Replaced o OBJECT SET COLOR(*; "DE_@"; <>Color_Editable)
				GOTO OBJECT:C206(*; "DE_TotalLimFeeDes")
			End if 
		End if 
End case 