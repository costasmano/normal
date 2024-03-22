//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 11/15/12, 13:37:01
//----------------------------------------------------
//Method: insp_NewCreateElementDictHlist
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2012_11  //r002 ` Add new inspection types
	//Modified by: Charles Miller (11/15/12 13:37:02)
	// Modified by: Costas Manousakis-(Designer)-(12/27/12 14:46:29)
	Mods_2012_12
	//  `Allow extra line for the element labels
End if 
C_LONGINT:C283($MaxOffset_L; $Offset_L; $ArrayPosition_l; $Position_L)
$MaxOffset_L:=Length:C16([Inspection Type:31]ElementNumbers_txt:4)
//ARRAY STRING(15;aInspType_;0)
//ARRAY STRING(6;aInspCod_;0)

C_TEXT:C284($ElementType_txt; $ElementNumbers_txt; $ElementLbls_txt)

C_LONGINT:C283($0; $hlList)
$hlList:=New list:C375
$Offset_L:=1
Repeat 
	$Position_L:=Position:C15("\r"; [Inspection Type:31]ElementNumbers_txt:4; $Offset_L)
	If ($Position_L>0)
		$ElementType_txt:=Substring:C12([Inspection Type:31]ElementNumbers_txt:4; $Offset_L; $Position_L-$Offset_L)  //N58, n60 etc
		$Offset_L:=$Position_L+1
		$ArrayPosition_l:=Find in array:C230(<>ALLElmtCatCode_as; $ElementType_txt)
		If ($ArrayPosition_l>0)
			//APPEND TO ARRAY(aInspCod_;◊ALLElmtCatCode_as{$ArrayPosition_l})
			//APPEND TO ARRAY(aInspType_;◊ALLElmtCatDesc_as{$ArrayPosition_l})
		Else 
			ALERT:C41("Missing / Invalid Element Category Type : ["+$ElementType_txt+"] in ElementNumbers for Inspection type :{"+[Inspection Type:31]Description:2+"]!")
		End if 
		$Position_L:=Position:C15("\r"; [Inspection Type:31]ElementNumbers_txt:4; $Offset_L)  //element numbers 100, 101, etc
		If ($Position_L>0)
			$ElementNumbers_txt:=Substring:C12([Inspection Type:31]ElementNumbers_txt:4; $Offset_L; $Position_L-$Offset_L)  //element numbers 100, 101, etc 
			$Offset_L:=$Position_L+1
			$Position_L:=Position:C15("\r"; [Inspection Type:31]ElementNumbers_txt:4; $Offset_L)  //element labels 1.,2.,a. etc
			
			If ($Position_L>0)
				$ElementLbls_txt:=Substring:C12([Inspection Type:31]ElementNumbers_txt:4; $Offset_L; $Position_L-$Offset_L)  // `element labels 1.,2.,a. etc
				$Offset_L:=$Position_L+1
			Else 
				$ElementLbls_txt:=Substring:C12([Inspection Type:31]ElementNumbers_txt:4; $Offset_L)
				$Offset_L:=$MaxOffset_L
			End if 
		Else 
			$Offset_L:=$MaxOffset_L
		End if 
		ARRAY TEXT:C222($ElementNumbers_atxt; 0)
		ut_NewTextToArray($ElementNumbers_txt; ->$ElementNumbers_atxt; ",")
	Else 
		$Offset_L:=$MaxOffset_L
	End if 
	INSP_NewAddElmtCat2HL($hlList; $ElementType_txt; ->$ElementNumbers_atxt)
Until ($Offset_L>=$MaxOffset_L)
$0:=$hlList
//End insp_NewCreateElementDictHlist