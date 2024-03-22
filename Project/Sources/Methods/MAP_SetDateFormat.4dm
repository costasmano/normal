//%attributes = {"invisible":true}
//Method: MAP_SetDateFormat
//Description
// return a Date format to be used with MAP_FormatDate
// options accessible from design access group or personnel group MAP_ChooseDateFormat
// default is 5 : Mo_Day_Year, or in parameter MAP_DateFormat
// Parameters
// $0 : $dateformat_L
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Created : 
	//Date and time: Nov 8, 2023, 14:16:03
	Mods_2023_11
	// ----------------------------------------------------
	
	C_LONGINT:C283(MAP_SetDateFormat; $0)
	
End if 
//
C_LONGINT:C283($0; $dateoption_L)
$dateoption_L:=0

If (User in group:C338(Current user:C182; "Design Access Group") | (GRP_UserInGroup("MAP_ChooseDateFormat")=1))
	
	C_TEXT:C284($Dateformats_txt)
	$Dateformats_txt:=Char:C90(1)+"MM/DD/YY;"+\
		"YYYY-MM-DD;"+\
		"YYYY MM DD;"+\
		"YYYY_MM_DD;"+\
		"Mo_Day_Year;"+\
		"YYYY-MM-DDTHH:MM:SS;"+\
		"YYYY-MM-DDTHH:MM:SSZ GMT;"+\
		Char:C90(1)+"MM/DD/YYYY;"+\
		"MM.DD.YYYY;"+\
		"YYYY.MM.DD;"+\
		"Mo_YYYY"
	
	$dateoption_L:=Pop up menu:C542($Dateformats_txt)
End if 

If ($dateoption_L=0)
	$dateoption_L:=Num:C11(ut_GetSysParameter("MAP_DateFormat"; "5"))  // default to Mo_Day_Year
End if 
$0:=$dateoption_L
//End MAP_SetDateFormat   