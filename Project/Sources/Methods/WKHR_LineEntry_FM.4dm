//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 01/01/09, 22:29:31
	// ----------------------------------------------------
	// Method: WKHR_LineEntry_FM
	// Description
	// Form method for line entry form
	// 
	// Parameters
	// ----------------------------------------------------
	Mods_2009_CM_5404  //Copied to Server on : 03/19/09, 11:39:56  ` ("WKHRSMODS")
	
End if 
C_LONGINT:C283($FormEvent_L)
If (Count parameters:C259>0)
	C_LONGINT:C283($1)
	$FormEvent_L:=$1
Else 
	$FormEvent_L:=Form event code:C388
	If ($FormEvent_L=On Load:K2:1)
		If (WKHR_OfficeEstEdit_b)
			OfficeEstItm_Ctrld:=2
			FORM GOTO PAGE:C247(2)
		End if 
	End if 
End if 

Case of 
	: ($FormEvent_L=On Load:K2:1)
		C_LONGINT:C283($i; $NewTextTop; $txtL; $txtT; $txtR; $txtB; $TxtHt; $NewWinHt; $Wl; $Wt; $Wr; $Wb)  //Command Replaced was o_C_INTEGER
		
		C_BOOLEAN:C305(WKHR_EditLineItem; WKHR_CommentsShown)
		If (Not:C34(WKHR_EditLineItem))
			OBJECT SET ENTERABLE:C238(*; "ItemDescr"; False:C215)
			OBJECT SET RGB COLORS:C628(*; "ItemDescr"; Col_paletteToRGB(Abs:C99(WKHR_ItemColor_RO)%256); Col_paletteToRGB(Abs:C99(WKHR_ItemColor_RO)\256))  // **Replaced o OBJECT SET COLOR(*; "ItemDescr"; WKHR_ItemColor_RO)
		Else 
			OBJECT SET ENTERABLE:C238(*; "ItemDescr"; True:C214)
			OBJECT SET RGB COLORS:C628(*; "ItemDescr"; Col_paletteToRGB(Abs:C99(WKHR_ItemColor_WR)%256); Col_paletteToRGB(Abs:C99(WKHR_ItemColor_WR)\256))  // **Replaced o OBJECT SET COLOR(*; "ItemDescr"; WKHR_ItemColor_WR)
		End if 
		//SET VISIBLE(AddCmtsBtn;Not(WKHR_EditLineItem))
		OBJECT SET ENABLED:C1123(CTRLVForCmmtTxt; False:C215)  // Command Replaced was o_DISABLE BUTTON 
		OBJECT SET VISIBLE:C603(*; "AccptReview@"; True:C214)
		If ([Work_Estimate:103]Version_L:47>0)
		Else 
			OBJECT SET VISIBLE:C603(*; "PIC_Title_7"; False:C215)
			OBJECT SET VISIBLE:C603(*; "WkHr_Real_1_7"; False:C215)
			OBJECT SET VISIBLE:C603(*; "ReviewItm_1_7"; False:C215)
			OBJECT SET VISIBLE:C603(*; "OfficeEstItm_7"; False:C215)
		End if 
		
		Case of 
			: (WKHR_RoleReview_b & WKHR_AllowRevieCmts_b)  //Mods_2007_CM12_5301
				OBJECT SET ENTERABLE:C238(*; "Rev@"; True:C214)
				OBJECT SET RGB COLORS:C628(*; "Rev@"; Col_paletteToRGB(Abs:C99(WKHR_RevColor_WR)%256); Col_paletteToRGB(Abs:C99(WKHR_RevColor_WR)\256))  // **Replaced o OBJECT SET COLOR(*; "Rev@"; WKHR_RevColor_WR)
				OBJECT SET ENTERABLE:C238(*; "Rev@6"; False:C215)
				OBJECT SET RGB COLORS:C628(*; "Rev@6"; Col_paletteToRGB(Abs:C99(WKHR_ItemColor_RO)%256); Col_paletteToRGB(Abs:C99(WKHR_ItemColor_RO)\256))  // **Replaced o OBJECT SET COLOR(*; "Rev@6"; WKHR_ItemColor_RO)
				OBJECT SET VISIBLE:C603(*; "AccptReview@"; False:C215)
				
			: (WKHR_RoleApprove_b & WKHR_AllowRevieCmts_b)  //Mods_2007_CM12_5301
				OBJECT SET ENTERABLE:C238(*; "Rev@"; True:C214)
				OBJECT SET RGB COLORS:C628(*; "Rev@"; Col_paletteToRGB(Abs:C99(WKHR_RevColor_WR)%256); Col_paletteToRGB(Abs:C99(WKHR_RevColor_WR)\256))  // **Replaced o OBJECT SET COLOR(*; "Rev@"; WKHR_RevColor_WR)
				OBJECT SET ENTERABLE:C238(*; "Rev@6"; False:C215)
				OBJECT SET RGB COLORS:C628(*; "Rev@6"; Col_paletteToRGB(Abs:C99(WKHR_ItemColor_RO)%256); Col_paletteToRGB(Abs:C99(WKHR_ItemColor_RO)\256))  // **Replaced o OBJECT SET COLOR(*; "Rev@6"; WKHR_ItemColor_RO)
				OBJECT SET VISIBLE:C603(*; "AccptReview@"; False:C215)
			Else 
				OBJECT SET ENTERABLE:C238(*; "Rev@"; False:C215)
				OBJECT SET RGB COLORS:C628(*; "Rev@"; Col_paletteToRGB(Abs:C99(WKHR_RevColor_RO)%256); Col_paletteToRGB(Abs:C99(WKHR_RevColor_RO)\256))  // **Replaced o OBJECT SET COLOR(*; "Rev@"; WKHR_RevColor_RO)
				OBJECT SET RGB COLORS:C628(*; "Rev@6"; Col_paletteToRGB(Abs:C99(WKHR_ItemColor_RO)%256); Col_paletteToRGB(Abs:C99(WKHR_ItemColor_RO)\256))  // **Replaced o OBJECT SET COLOR(*; "Rev@6"; WKHR_ItemColor_RO)
		End case 
		Case of 
			: (WKHR_OfficeEstEdit_b)
				OBJECT SET VISIBLE:C603(*; "OfficeEstItm@"; True:C214)
				OBJECT SET ENTERABLE:C238(*; "OfficeEstItm@"; True:C214)
				OBJECT SET ENTERABLE:C238(OfficeEstItm_6; False:C215)
				OBJECT SET VISIBLE:C603(*; "OffEst@"; True:C214)
				OBJECT SET ENTERABLE:C238(*; "OffEst@"; True:C214)
				OBJECT SET ENTERABLE:C238(*; "OffEst@6"; False:C215)
				OBJECT SET ENABLED:C1123(*; "OffEst@"; True:C214)  // Command Replaced was o_ENABLE BUTTON 
				If ([Work_Estimate:103]Version_L:47>0)
				Else 
					OBJECT SET VISIBLE:C603(*; "OfficeEstItm@_7"; False:C215)
					OBJECT SET VISIBLE:C603(*; "OffEst@_7"; False:C215)
				End if 
				
				If (WKHR_OffEstSubItemCount>0)
					OBJECT SET ENTERABLE:C238(*; "OfficeEstItm_@"; False:C215)  //if sub items no direct entry
					OBJECT SET RGB COLORS:C628(*; "OfficeEstItm_@"; Col_paletteToRGB(Abs:C99(WKHR_ItemColor_RO)%256); Col_paletteToRGB(Abs:C99(WKHR_ItemColor_RO)\256))  // **Replaced o OBJECT SET COLOR(*; "OfficeEstItm_@"; WKHR_ItemColor_RO)
				Else 
					OBJECT SET ENTERABLE:C238(*; "OfficeEstItm_@"; True:C214)  //if sub items no direct entry
					OBJECT SET RGB COLORS:C628(*; "OfficeEstItm_@"; Col_paletteToRGB(Abs:C99(WKHR_RevColor_WR)%256); Col_paletteToRGB(Abs:C99(WKHR_RevColor_WR)\256))  // **Replaced o OBJECT SET COLOR(*; "OfficeEstItm_@"; WKHR_RevColor_WR)
					OBJECT SET ENTERABLE:C238(*; "OfficeEstItm_6@"; False:C215)  //if sub items no direct entry
					OBJECT SET RGB COLORS:C628(*; "OfficeEstItm_6@"; Col_paletteToRGB(Abs:C99(WKHR_ItemColor_RO)%256); Col_paletteToRGB(Abs:C99(WKHR_ItemColor_RO)\256))  // **Replaced o OBJECT SET COLOR(*; "OfficeEstItm_6@"; WKHR_ItemColor_RO)
				End if 
				If (WKHR_OffEstSubItemCount<WKHR_MaxNumSubBreakDwn)
					OBJECT SET ENABLED:C1123(*; "OffEstButtonPlus@"; True:C214)  // Command Replaced was o_ENABLE BUTTON 
				Else 
					OBJECT SET ENABLED:C1123(*; "OffEstButtonPlus@"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
				End if 
			: (WKHR_OfficeEstView_b)
				OBJECT SET VISIBLE:C603(*; "OfficeEstItm@"; True:C214)
				OBJECT SET VISIBLE:C603(*; "OffEst@"; True:C214)
				If ([Work_Estimate:103]Version_L:47>0)
				Else 
					OBJECT SET VISIBLE:C603(*; "OfficeEstItm@_7"; False:C215)
					OBJECT SET VISIBLE:C603(*; "OffEst@_7"; False:C215)
				End if 
				OBJECT SET ENTERABLE:C238(*; "OffEst@"; False:C215)
				OBJECT SET ENTERABLE:C238(*; "OfficeEstItm@"; False:C215)
				OBJECT SET ENABLED:C1123(*; "OffEst@"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
			Else 
				OBJECT SET VISIBLE:C603(*; "OfficeEstItm@"; False:C215)
				OBJECT SET VISIBLE:C603(*; "OffEst@"; False:C215)
		End case 
		
		If (WKHR_LockEstimate)
			OBJECT SET ENTERABLE:C238(*; "WKHR_@"; False:C215)
			OBJECT SET ENTERABLE:C238(*; "ItemDescr"; False:C215)
			OBJECT SET ENTERABLE:C238(*; "ItemComments"; False:C215)
			OBJECT SET ENTERABLE:C238(*; "Sub@"; False:C215)
			OBJECT SET ENABLED:C1123(*; "Add@"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
			OBJECT SET ENABLED:C1123(*; "Button@"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
			OBJECT SET VISIBLE:C603(*; "AccptReview@"; False:C215)
		Else 
			If (WKHR_SubItemCount>0)
				OBJECT SET ENTERABLE:C238(*; "WKHR_Real_@"; False:C215)  //if sub items no direct entry
				OBJECT SET RGB COLORS:C628(*; "WKHR_@"; Col_paletteToRGB(Abs:C99(WKHR_ItemColor_RO)%256); Col_paletteToRGB(Abs:C99(WKHR_ItemColor_RO)\256))  // **Replaced o OBJECT SET COLOR(*; "WKHR_@"; WKHR_ItemColor_RO)
			Else 
				OBJECT SET ENTERABLE:C238(*; "WKHR_Real_@"; True:C214)  //if sub items no direct entry
				OBJECT SET RGB COLORS:C628(*; "WKHR_@"; Col_paletteToRGB(Abs:C99(WKHR_ItemColor_WR)%256); Col_paletteToRGB(Abs:C99(WKHR_ItemColor_WR)\256))  // **Replaced o OBJECT SET COLOR(*; "WKHR_@"; WKHR_ItemColor_WR)
				OBJECT SET ENTERABLE:C238(*; "WKHR_Real_6@"; False:C215)  //if sub items no direct entry
				OBJECT SET RGB COLORS:C628(*; "WKHR_Real_6@"; Col_paletteToRGB(Abs:C99(WKHR_ItemColor_RO)%256); Col_paletteToRGB(Abs:C99(WKHR_ItemColor_RO)\256))  // **Replaced o OBJECT SET COLOR(*; "WKHR_Real_6@"; WKHR_ItemColor_RO)
			End if 
			
			If (WKHR_SubItemCount<WKHR_MaxNumSubBreakDwn)
				OBJECT SET ENABLED:C1123(*; "ButtonPlus@"; True:C214)  // Command Replaced was o_ENABLE BUTTON 
			Else 
				OBJECT SET ENABLED:C1123(*; "ButtonPlus@"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
			End if 
			
			If (([Work_Estimate:103]WkHrEstReviewed:33=BMS Rejected) | ([Work_Estimate:103]WkHrEstApproved:18=BMS Rejected))
				If (ReviewItm_6=0)
					OBJECT SET VISIBLE:C603(*; "AccptReview@"; False:C215)
				Else 
					OBJECT SET VISIBLE:C603(*; "AccptReview@"; True:C214)
					Case of 
						: (WkHr_Real_1#ReviewItm_1)
						: (WkHr_Real_2#ReviewItm_2)
						: (WkHr_Real_3#ReviewItm_3)
						: (WkHr_Real_4#ReviewItm_4)
						: (WkHr_Real_5#ReviewItm_5)
						: (WkHr_Real_7#ReviewItm_7)
						Else 
							OBJECT SET VISIBLE:C603(*; "AccptReview@"; False:C215)
					End case 
					
				End if 
				
			Else 
				OBJECT SET VISIBLE:C603(*; "AccptReview@"; False:C215)
			End if 
			
		End if 
		OBJECT SET VISIBLE:C603(*; "SubItmV@"; True:C214)
		If ([Work_Estimate:103]Version_L:47>0)
		Else 
			OBJECT SET VISIBLE:C603(*; "SubItmV@_7"; False:C215)
		End if 
		
		OBJECT SET VISIBLE:C603(*; "SubItDsc_@"; True:C214)
		OBJECT SET VISIBLE:C603(*; "ButtonMinus@"; True:C214)
		OBJECT SET VISIBLE:C603(*; "ButtonPlus@"; True:C214)
		For ($i; (WKHR_SubItemCount+1); WKHR_MaxNumSubBreakDwn)
			OBJECT SET VISIBLE:C603(*; "SubItmV"+String:C10($i)+"@"; False:C215)
			OBJECT SET VISIBLE:C603(*; "SubItDsc_"+String:C10($i)+"@"; False:C215)
			OBJECT SET VISIBLE:C603(*; "ButtonMinus"+String:C10($i)+"@"; False:C215)
			OBJECT SET VISIBLE:C603(*; "ButtonPlus"+String:C10($i)+"@"; False:C215)
		End for 
		OBJECT SET VISIBLE:C603(*; "OffEstSubItmV@"; True:C214)
		If ([Work_Estimate:103]Version_L:47>0)
		Else 
			OBJECT SET VISIBLE:C603(*; "OffEstSubItmV@_7"; False:C215)
		End if 
		OBJECT SET VISIBLE:C603(*; "OffEstSubItDsc_@"; True:C214)
		OBJECT SET VISIBLE:C603(*; "OffEstButtonMinus@"; True:C214)
		OBJECT SET VISIBLE:C603(*; "OffEstButtonPlus@"; True:C214)
		For ($i; (WKHR_OffEstSubItemCount+1); WKHR_MaxNumSubBreakDwn)
			OBJECT SET VISIBLE:C603(*; "OffEstSubItmV"+String:C10($i)+"@"; False:C215)
			OBJECT SET VISIBLE:C603(*; "OffEstSubItDsc_"+String:C10($i)+"@"; False:C215)
			OBJECT SET VISIBLE:C603(*; "OffEstButtonMinus"+String:C10($i)+"@"; False:C215)
			OBJECT SET VISIBLE:C603(*; "OffEstButtonPlus"+String:C10($i)+"@"; False:C215)
		End for 
		OBJECT GET COORDINATES:C663(*; "ItemComments@"; $txtL; $txtT; $txtR; $txtB)
		If (Length:C16(ItemCmmts_Txt)>0)
			OBJECT SET VISIBLE:C603(*; "ItemComments@"; True:C214)
			OBJECT SET ENTERABLE:C238(*; "ItemComments@"; Not:C34(WKHR_LockEstimate))
			$TxtHt:=($txtB-$txtT)
			WKHR_CommentsShown:=True:C214
			AddCmtsBtn:=1
		Else 
			OBJECT SET VISIBLE:C603(*; "ItemComments@"; False:C215)
			OBJECT SET ENTERABLE:C238(*; "ItemComments@"; False:C215)
			$TxtHt:=0
			WKHR_CommentsShown:=False:C215
			AddCmtsBtn:=0
		End if 
		$NewTextTop:=WKHR_SetCmmtTxtTop
		$NewWinHt:=$NewTextTop+$TxtHt+WKHR_LineEntryFormMargin  //20 is the  margin for the form..
		//MOVE OBJECT(*;"ItemComments@";$txtL;$NewTextTop;$txtR;$NewTextTop;*)
		GET WINDOW RECT:C443($Wl; $Wt; $Wr; $Wb)
		SET WINDOW RECT:C444($Wl; $Wt; $Wr; ($Wt+$NewWinHt))
		OBJECT MOVE:C664(*; "ItemComments@"; $txtL; $NewTextTop; $txtR; ($NewTextTop+$TxtHt-$NewWinHt+$Wb-$Wt); *)
		
	: ($FormEvent_L=On Data Change:K2:15)
		WkHr_real_6:=WkHr_Real_1+WkHr_Real_2+WkHr_Real_3+WkHr_Real_4+WkHr_Real_5+WkHr_Real_7
		WKHR_DataEntered_B:=True:C214
End case 