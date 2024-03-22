//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 03/11/07, 20:14:56
	// ----------------------------------------------------
	// Method: PRJ_PT_GetProjectEWOs
	// Description
	// Get the EWOs from the Projects table for the TImeSheet Entry
	// 
	// Parameters
	// ----------------------------------------------------
	Mods_TimeTracking
	// Modified by: costasmanousakis-(Designer)-(2/26/09 16:03:26)
	Mods_2009_CM_5404
	//Added the EWOs in the project selection HLists to help differentiate between diff projects on same bridge.
	// Modified by: costasmanousakis-(Designer)-(4/19/11 16:18:42)
	Mods_2011_04
	//  `Added a check when collecting Bridge numbers in case the Non-Bridge field is also blank.
End if 
ARRAY TEXT:C222($PT_ProjectList_as; 0)  //Command Replaced was o_ARRAY string length was 28
ARRAY TEXT:C222($NonBridgeNos_as; 0)  //Command Replaced was o_ARRAY string length was 28

ARRAY TEXT:C222(PT_ProjectListEWO_as; 0)  //Command Replaced was o_ARRAY string length was 21
ARRAY TEXT:C222(PT_ProjectListConsEWO_as; 0)  //Command Replaced was o_ARRAY string length was 21
ARRAY TEXT:C222($Local_ConsEWO_as; 0)  //Command Replaced was o_ARRAY string length was 21
ARRAY TEXT:C222($Local_DesEWO_as; 0)  //Command Replaced was o_ARRAY string length was 21
ARRAY LONGINT:C221(PT_ProjectListID_aL; 0)
READ ONLY:C145([PRJ_ProjectDetails:115])
ALL RECORDS:C47([PRJ_ProjectDetails:115])
SELECTION TO ARRAY:C260([PRJ_ProjectDetails:115]PRJ_ProjectID_l:1; PT_ProjectListID_aL; [PRJ_ProjectDetails:115]PRJ_BridgeNo_s:5; $PT_ProjectList_as; [PRJ_ProjectFile:117]PF_EWO_s:4; PT_ProjectListEWO_as; [PRJ_ProjectDetails:115]PRJ_EnteredDesignEWO_s:43; $Local_DesEWO_as)
SELECTION TO ARRAY:C260([PRJ_ProjectDetails:115]PRJ_NonBridge_s:7; $NonBridgeNos_as; [PRJ_ProjectDetails:115]PRJ_EnteredConstructionEWO_s:31; $Local_ConsEWO_as; [PRJ_ConstructionProject:116]CP_EWO_s:9; PT_ProjectListConsEWO_as)
//ARRAY STRING(21;$Local_DesEWO_as;Size of array(PT_ProjectListEWO_as))
C_BOOLEAN:C305($Complete_b)
C_LONGINT:C283($Pos_L)
$Pos_L:=1
$Complete_b:=False:C215
Repeat 
	$Pos_L:=Find in array:C230($PT_ProjectList_as; ""; $Pos_L)
	If ($Pos_L>0)
		$PT_ProjectList_as{$Pos_L}:=$NonBridgeNos_as{$Pos_L}
		If ($PT_ProjectList_as{$Pos_L}="")
			$Pos_L:=$Pos_L+1
		End if 
	Else 
		$Complete_b:=True:C214
	End if 
Until ($Complete_b)
$Pos_L:=1
$Complete_b:=False:C215
Repeat 
	$Pos_L:=Find in array:C230(PT_ProjectListConsEWO_as; ""; $Pos_L)
	If ($Pos_L>0)
		PT_ProjectListConsEWO_as{$Pos_L}:=$Local_ConsEWO_as{$Pos_L}
		$Pos_L:=$Pos_L+1
	Else 
		$Complete_b:=True:C214
	End if 
Until ($Complete_b)
$Pos_L:=1
$Complete_b:=False:C215
Repeat 
	$Pos_L:=Find in array:C230(PT_ProjectListEWO_as; ""; $Pos_L)
	If ($Pos_L>0)
		PT_ProjectListEWO_as{$Pos_L}:=$Local_DesEWO_as{$Pos_L}
		$Pos_L:=$Pos_L+1
	Else 
		$Complete_b:=True:C214
	End if 
Until ($Complete_b)

SORT ARRAY:C229($PT_ProjectList_as; PT_ProjectListEWO_as; PT_ProjectListConsEWO_as; PT_ProjectListID_aL)
C_LONGINT:C283(PT_DesignProjectList_HL; $CatList_HL; $i)
PT_DesignProjectList_HL:=New list:C375
$CatList_HL:=New list:C375
C_TEXT:C284($CurrCat_s; $NextCat_s)  // Command Replaced was o_C_STRING length was 1
$CurrCat_s:=""
For ($i; 1; Size of array:C274($PT_ProjectList_as))
	$NextCat_s:=Substring:C12($PT_ProjectList_as{$i}; 1; 1)
	If ($NextCat_s#$CurrCat_s)
		If (Count list items:C380($CatList_HL)>0)
			APPEND TO LIST:C376(PT_DesignProjectList_HL; $CurrCat_s; 0; $CatList_HL; True:C214)
		End if 
		$CatList_HL:=New list:C375
		$CurrCat_s:=$NextCat_s
	End if 
	If ($PT_ProjectList_as{$i}#"")
		APPEND TO LIST:C376($CatList_HL; ($PT_ProjectList_as{$i}+":"+PT_ProjectListEWO_as{$i}); $i)
	End if 
End for 
If (Count list items:C380($CatList_HL)>0)
	APPEND TO LIST:C376(PT_DesignProjectList_HL; $CurrCat_s; 0; $CatList_HL; True:C214)
End if 

SELECT LIST ITEMS BY POSITION:C381(PT_DesignProjectList_HL; 0)
REDRAW:C174(PT_DesignProjectList_HL)  // Command Replaced was o_REDRAW LIST 

C_LONGINT:C283(PT_ConstructionProjectList_HL; $CatList_HL; $i)
PT_ConstructionProjectList_HL:=New list:C375
$CatList_HL:=New list:C375
C_TEXT:C284($CurrCat_s; $NextCat_s)  // Command Replaced was o_C_STRING length was 1
$CurrCat_s:=""
For ($i; 1; Size of array:C274($PT_ProjectList_as))
	If (PT_ProjectListConsEWO_as{$i}="") | (PT_ProjectListConsEWO_as{$i}=" ")
	Else 
		$NextCat_s:=Substring:C12($PT_ProjectList_as{$i}; 1; 1)
		If ($NextCat_s#$CurrCat_s)
			If (Count list items:C380($CatList_HL)>0)
				APPEND TO LIST:C376(PT_ConstructionProjectList_HL; $CurrCat_s; 0; $CatList_HL; True:C214)
			End if 
			$CatList_HL:=New list:C375
			$CurrCat_s:=$NextCat_s
		End if 
		If ($PT_ProjectList_as{$i}#"") & (PT_ProjectListConsEWO_as{$i}#"")
			APPEND TO LIST:C376($CatList_HL; ($PT_ProjectList_as{$i}+":"+PT_ProjectListConsEWO_as{$i}); $i)
		End if 
	End if 
End for 

If (Count list items:C380($CatList_HL)>0)
	APPEND TO LIST:C376(PT_ConstructionProjectList_HL; $CurrCat_s; 0; $CatList_HL; True:C214)
End if 

SELECT LIST ITEMS BY POSITION:C381(PT_ConstructionProjectList_HL; 0)
REDRAW:C174(PT_ConstructionProjectList_HL)  // Command Replaced was o_REDRAW LIST 