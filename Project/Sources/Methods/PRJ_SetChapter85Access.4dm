//%attributes = {"invisible":true}
// ----------------------------------------------------
// PRJ_SetChapter85Access
// User name (OS): cjmiller
// Date and time: 10/09/07, 11:19:26
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2007_CJM_v5303  //r003 `10/09/07, 11:19:28
End if 
If (Count parameters:C259=1)
	C_BOOLEAN:C305($1; $AccessAllowed_b)
	$AccessAllowed_b:=$1
Else 
	C_BOOLEAN:C305($AccessAllowed_b)
	$AccessAllowed_b:=PRJ_ReturnAccessAllowed
End if 

If ([PRJ_ProjectFile:117]PF_FileNumber_l:3>0)
	OBJECT SET VISIBLE:C603(PRJ_Chapter85_l; False:C215)
	
	OBJECT SET VISIBLE:C603(*; "PRJ_ConsultantButton@"; False:C215)
	OBJECT SET TITLE:C194(PRJ_AllowProjectEntry_l; "Allow Project Entry")
	OBJECT SET VISIBLE:C603(*; "PRJ_DataEntry32"; False:C215)
	OBJECT SET VISIBLE:C603(*; "PRJ_ConsultantName_txt"; False:C215)
	OBJECT SET VISIBLE:C603(PRJ_DEProjectFileNo_l; True:C214)
Else 
	OBJECT SET VISIBLE:C603(PRJ_Chapter85_l; True:C214)
	
	If ([PRJ_ProjectDetails:115]PRJ_Chapter85_b:52)
		PRJ_Chapter85_l:=1
		OBJECT SET VISIBLE:C603(*; "PRJ_DataEntry3"; False:C215)
		OBJECT SET VISIBLE:C603(*; "PRJ_ConsultantButton@"; True:C214)
		OBJECT SET VISIBLE:C603(PRJ_SelectConsultant_l; False:C215)
		OBJECT SET VISIBLE:C603(*; "PRJ_SelectByDesignContract_l"; False:C215)
		OBJECT SET TITLE:C194(PRJ_AllowProjectEntry_l; "Allow Consult. Entry")
		OBJECT SET VISIBLE:C603(*; "PRJ_DataEntry32"; True:C214)
		OBJECT SET VISIBLE:C603(*; "PRJ_DEProjectFileNo_l"; False:C215)
		OBJECT SET VISIBLE:C603(*; "PRJ_ConsultantName_txt"; True:C214)
		If ($AccessAllowed_b)
			If (PRJ_ConsultantName_txt="")
				OBJECT SET RGB COLORS:C628(PRJ_ConsultantName_txt; Col_paletteToRGB(Abs:C99(<>PRJ_Color_Editable)%256); Col_paletteToRGB(Abs:C99(<>PRJ_Color_Editable)\256))  // **Replaced o OBJECT SET COLOR(PRJ_ConsultantName_txt; <>PRJ_Color_Editable)
				OBJECT SET ENTERABLE:C238(PRJ_ConsultantName_txt; True:C214)
				OBJECT SET VISIBLE:C603(PRJ_AllowProjectEntry_l; False:C215)
			Else 
				OBJECT SET RGB COLORS:C628(PRJ_ConsultantName_txt; Col_paletteToRGB(Abs:C99(<>PRJ_Color_Not_editable)%256); Col_paletteToRGB(Abs:C99(<>PRJ_Color_Not_editable)\256))  // **Replaced o OBJECT SET COLOR(PRJ_ConsultantName_txt; <>PRJ_Color_Not_editable)
				OBJECT SET ENTERABLE:C238(PRJ_ConsultantName_txt; False:C215)
				OBJECT SET VISIBLE:C603(PRJ_AllowProjectEntry_l; True:C214)
			End if 
		Else 
			OBJECT SET RGB COLORS:C628(PRJ_ConsultantName_txt; Col_paletteToRGB(Abs:C99(<>PRJ_Color_Not_editable)%256); Col_paletteToRGB(Abs:C99(<>PRJ_Color_Not_editable)\256))  // **Replaced o OBJECT SET COLOR(PRJ_ConsultantName_txt; <>PRJ_Color_Not_editable)
			OBJECT SET ENTERABLE:C238(PRJ_ConsultantName_txt; False:C215)
		End if 
	Else 
		PRJ_Chapter85_l:=0
		
		OBJECT SET VISIBLE:C603(*; "PRJ_ConsultantButton@"; False:C215)
		OBJECT SET TITLE:C194(PRJ_AllowProjectEntry_l; "Allow Project Entry")
		OBJECT SET VISIBLE:C603(*; "PRJ_DataEntry32"; False:C215)
		OBJECT SET VISIBLE:C603(*; "PRJ_ConsultantName_txt"; False:C215)
		OBJECT SET VISIBLE:C603(PRJ_DEProjectFileNo_l; True:C214)
	End if 
	
	
End if 

//End PRJ_SetChapter85Access