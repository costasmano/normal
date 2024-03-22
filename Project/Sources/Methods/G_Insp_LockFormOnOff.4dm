//%attributes = {"invisible":true}
//G_Insp_LockFormOnOff
//$1=Boolean Lock:true ; unlock:false
If (False:C215)
	
	Mods_2004_CM11
	Mods_2005_CM05
	Mods_2005_CM12
	Mods_2005_CM16
	// Modified by: costasmanousakis-(Designer)-(10/30/2006 15:23:38)
	Mods_2006_CM07
	// Modified by: costasmanousakis-(Designer)-(9/7/2007 14:06:07)
	Mods_2007_CM12_5301
	// Modified by: costasmanousakis-(Designer)-(5/18/10 11:33:59)
	Mods_2010_05
	//  `Allow DistrictBridge, MaintEngineers, DBIEs access to the calc bridge hi button. will not save anyway.
	// Modified by: Costas Manousakis-(Designer)-(12/7/12 11:52:34)
	Mods_2012_12
	//  `Use ◊CurrentUser_Name instead of  command Current user
	// Modified by: Costas Manousakis-(Designer)-(11/9/18 12:26:08)
	Mods_2018_11
	//  `changed _ o _Enable/disable commands with object set enabled versions
	// Modified by: Costas Manousakis-(Designer)-(5/2/19 16:04:01)
	Mods_2019_05_bug
	//  `removed restriction to the rating request fields for external inspectors - CallReference #634
	// Modified by: Costas Manousakis-(Designer)-(10/09/19 11:22:45)
	Mods_2019_10_bug
	//  `lock field work complete date if it has been entered once. CallReference #663
	// Modified by: Costas Manousakis-(Designer)-(1/27/21 19:27:01)
	Mods_2021_WP
	//  `WP change - skip set enterable true on load - sets the write pro areas to not enterable
	// Modified by: Costas Manousakis-(Designer)-(2021-12-20T00:00:00 21:38:09)
	Mods_2021_12_bug
	//  `moved here code from form method to handle attachments button
	//  `added use of system parameter INSP_Attahcments_on to control visibility of button
	// Modified by: Costas Manousakis-(Designer)-(2022-01-14T00:00:00 18:30:00)
	Mods_2022_01
	//  `when inspection is locked, enable _WP areas so text can be selected and copied from them.
End if 

C_BOOLEAN:C305($1; $vbLock)
$vbLock:=$1
C_BOOLEAN:C305(vbAddRevCmts)
vbAddRevCmts:=False:C215
C_TEXT:C284($CurrUser_txt)
$CurrUser_txt:=<>CurrentUser_Name
If ($vbLock)
	//disable entry if inspection is locked 
	OBJECT SET ENTERABLE:C238(*; "DE@"; False:C215)
	OBJECT SET RGB COLORS:C628(*; "DE@"; Col_paletteToRGB(Abs:C99(<>Color_Not_Editable)%256); Col_paletteToRGB(Abs:C99(<>Color_Not_Editable)\256))  // **Replaced o OBJECT SET COLOR(*; "DE@"; <>Color_Not_Editable)
	OBJECT SET ENABLED:C1123(*; "DE@"; False:C215)  // **replaced _ o _DISABLE BUTTON(*;"DE@")
	//WR LOCK DOCUMENT (AreaGeneralRemarks;1)
	//WR LOCK DOCUMENT (OrientationTextArea;1)
	OBJECT SET ENABLED:C1123(*; "DBIE@"; False:C215)  // **replaced _ o _DISABLE BUTTON(*;"DBIE@")
	OBJECT SET ENTERABLE:C238(*; "DBIE Cld @"; False:C215)
	OBJECT SET RGB COLORS:C628(*; "DBIE Cld @"; Col_paletteToRGB(Abs:C99(<>Color_Not_Editable)%256); Col_paletteToRGB(Abs:C99(<>Color_Not_Editable)\256))  // **Replaced o OBJECT SET COLOR(*; "DBIE Cld @"; <>Color_Not_Editable)
	
	If ((User in group:C338($CurrUser_txt; "MHDInspectionRWAccess")) | (User in group:C338($CurrUser_txt; "Ratings and Overloads")))
		//Allow inspectors to view all comments even for locked inspections.
		OBJECT SET ENABLED:C1123(*; "DE View All Cmts@"; True:C214)  // **replaced _ o _ENABLE BUTTON(*;"DE View All Cmts@")
		OBJECT SET RGB COLORS:C628(*; "DE View All Cmts@"; Col_paletteToRGB(Abs:C99(-(Black:K11:16+(256*Light grey:K11:13)))%256); Col_paletteToRGB(Abs:C99(-(Black:K11:16+(256*Light grey:K11:13)))\256))  // **Replaced o OBJECT SET COLOR(*; "DE View All Cmts@"; -(Black+(256*Light grey)))
	End if 
	
	If (In transaction:C397)
		CANCEL TRANSACTION:C241
	End if 
	If ((vApproveLvl=2) & ([Inspections:27]InspApproved:167=BMS Rejected) & Not:C34([Inspections:27]InspComplete:168))
		OBJECT SET ENABLED:C1123(*; "DE Reply Area@"; True:C214)  // **replaced _ o _ENABLE BUTTON(*;"DE Reply Area@")
		OBJECT SET TITLE:C194(*; "DE Reply Area@"; "Add Comments")
		vbAddRevCmts:=True:C214
	End if 
	If ((vApproveLvl=1) & ([Inspections:27]InspReviewed:12=BMS Rejected) & Not:C34([Inspections:27]InspComplete:168))
		OBJECT SET ENABLED:C1123(*; "DE ReplyDBIE@"; True:C214)  // **replaced _ o _ENABLE BUTTON(*;"DE ReplyDBIE@")
		OBJECT SET TITLE:C194(*; "DE ReplyDBIE@"; "Add Comments")
		vbAddRevCmts:=True:C214
	End if 
	If (User in group:C338($CurrUser_txt; "Area Engineers"))
		OBJECT SET ENABLED:C1123(*; "DE Button Delete"; True:C214)  // **replaced _ o _ENABLE BUTTON(*;"DE Button Delete")
	End if 
	C_BOOLEAN:C305($AccessToRecalcHI_b)
	$AccessToRecalcHI_b:=False:C215
	$AccessToRecalcHI_b:=User in group:C338($CurrUser_txt; "DistrictBridgeEngineers")
	$AccessToRecalcHI_b:=$AccessToRecalcHI_b | User in group:C338($CurrUser_txt; "DistrictStructMntEngrs")
	$AccessToRecalcHI_b:=$AccessToRecalcHI_b | User in group:C338($CurrUser_txt; "Inspection Engineers")
	$AccessToRecalcHI_b:=$AccessToRecalcHI_b | User in group:C338($CurrUser_txt; "Design Access Group")
	
	If ($AccessToRecalcHI_b)
		OBJECT SET ENABLED:C1123(*; "DE CalcHIBtn"; True:C214)  // **replaced _ o _ENABLE BUTTON(*;"DE CalcHIBtn")
	End if 
	
	//Enable WP areas so that text can be copied from them
	OBJECT SET ENABLED:C1123(*; "@_WP"; True:C214)
	
Else 
	
	If (([Inspections:27]Rerating:75=False:C215))
		OBJECT SET ENABLED:C1123(x1; False:C215)  // **replaced _ o _DISABLE BUTTON(x1)
		OBJECT SET ENABLED:C1123(x2; False:C215)  // **replaced _ o _DISABLE BUTTON(x2)
		OBJECT SET ENABLED:C1123(x3; False:C215)  // **Replaced c
	End if 
	
	C_LONGINT:C283(CBClrPost)  // **replaced _ o _C_INTEGER()
	OBJECT SET ENTERABLE:C238(*; "DE Clr@"; ((CBClrPost=0)))
	If (CBClrPost=0)
		OBJECT SET RGB COLORS:C628(*; "DE Clr@"; Col_paletteToRGB(Abs:C99(<>Color_Editable)%256); Col_paletteToRGB(Abs:C99(<>Color_Editable)\256))  // **Replaced o OBJECT SET COLOR(*; "DE Clr@"; <>Color_Editable)
	Else 
		OBJECT SET RGB COLORS:C628(*; "DE Clr@"; Col_paletteToRGB(Abs:C99(<>Color_Not_Editable)%256); Col_paletteToRGB(Abs:C99(<>Color_Not_Editable)\256))  // **Replaced o OBJECT SET COLOR(*; "DE Clr@"; <>Color_Not_Editable)
	End if 
	
	//check if Fieldworkdate has been completed
	If ([Inspections:27]InspFldWorkComplDate:224>!00-00-00!)
		//lock it
		OBJECT SET ENTERABLE:C238([Inspections:27]InspFldWorkComplDate:224; False:C215)
		OBJECT SET RGB COLORS:C628([Inspections:27]InspFldWorkComplDate:224; Col_paletteToRGB(Abs:C99(<>Color_Not_Editable)%256); Col_paletteToRGB(Abs:C99(<>Color_Not_Editable)\256))  // **Replaced o OBJECT SET COLOR([Inspections]InspFldWorkComplDate; <>Color_Not_Editable)
		
	End if 
	
	C_DATE:C307($AttachmentsOn_date)
	$AttachmentsOn_date:=Date:C102(ut_GetSysParameter("INSP_Attachments_on"))
	OBJECT SET VISIBLE:C603(*; "InspAttachments"; False:C215)
	
	If ($AttachmentsOn_date#!00-00-00!)
		If ([Inspections:27]Insp Date:78>=$AttachmentsOn_date)
			OBJECT SET VISIBLE:C603(*; "InspAttachments"; True:C214)
		End if 
	End if 
	
End if 

G_Insp_ApplyRev1_Inp

If (User in group:C338($CurrUser_txt; "ReadOnly"))
	OBJECT SET VISIBLE:C603(*; "@_Enter"; False:C215)
	OBJECT SET VISIBLE:C603(*; "@_Select"; True:C214)
Else 
	OBJECT SET VISIBLE:C603(*; "@_Enter"; True:C214)
	OBJECT SET VISIBLE:C603(*; "@_Select"; False:C215)
End if 