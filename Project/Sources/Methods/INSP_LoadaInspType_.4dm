//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 11/29/12, 16:23:49
//----------------------------------------------------
//Method: insp_LoadaInspType_
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2012_11  //r002 ` 
	//Modified by: Charles Miller (11/29/12 16:23:50)
	// Modified by: Costas Manousakis-(Designer)-(12/27/12 14:45:56)
	Mods_2012_12
	//  `Allow extra line for the element labels
	//  `Added optional the parameter for inspection type
	Mods_2013_05  //r003 ` Change [Element Cat]Description from 15 to 20 characters
	//Modified by: Charles Miller (5/7/13 14:35:32)
End if 

C_TEXT:C284($InspType_txt)

If (Count parameters:C259>0)
	C_TEXT:C284($1)
	$InspType_txt:=$1
Else 
	$InspType_txt:=[Inspections:27]Insp Type:6
End if 

READ ONLY:C145([Inspection Type:31])
QUERY:C277([Inspection Type:31]; [Inspection Type:31]Code:1=$InspType_txt)

C_LONGINT:C283($MaxOffset_L; $Offset_L; $ArrayPosition_l; $Position_L)
C_TEXT:C284($ElementType_txt)
$MaxOffset_L:=Length:C16([Inspection Type:31]ElementNumbers_txt:4)
ARRAY TEXT:C222(aInspType_; 0)  //Command Replaced was o_ARRAY string length was 20
ARRAY TEXT:C222(aInspCod_; 0)  //Command Replaced was o_ARRAY string length was 3

$Offset_L:=1
Repeat 
	$Position_L:=Position:C15("\r"; [Inspection Type:31]ElementNumbers_txt:4; $Offset_L)
	If ($Position_L>0)
		$ElementType_txt:=Substring:C12([Inspection Type:31]ElementNumbers_txt:4; $Offset_L; $Position_L-$Offset_L)  //N58, n60 etc
		$Offset_L:=$Position_L+1
		
		$ArrayPosition_l:=Find in array:C230(<>ALLElmtCatCode_as; $ElementType_txt)
		If ($ArrayPosition_l>0)
			APPEND TO ARRAY:C911(aInspCod_; <>ALLElmtCatCode_as{$ArrayPosition_l})
			APPEND TO ARRAY:C911(aInspType_; <>ALLElmtCatDesc_as{$ArrayPosition_l})
			
		Else 
			ALERT:C41("Missing Element Type")
		End if 
		$Position_L:=Position:C15("\r"; [Inspection Type:31]ElementNumbers_txt:4; $Offset_L)  //element numbers 100, 101, etc
		If ($Position_L>0)
			$Offset_L:=$Position_L+1
			$Position_L:=Position:C15("\r"; [Inspection Type:31]ElementNumbers_txt:4; $Offset_L)  //element labels 1., 2.,  etc
			If ($Position_L>0)
				$Offset_L:=$Position_L+1
			Else 
				$Offset_L:=$MaxOffset_L
			End if 
		Else 
			$Offset_L:=$MaxOffset_L
		End if 
	Else 
		$Offset_L:=$MaxOffset_L
		
	End if 
	
Until ($Offset_L>=$MaxOffset_L)
APPEND TO ARRAY:C911(aInspCod_; "ALL")
APPEND TO ARRAY:C911(aInspType_; "All Elements")

CurCat:="ALL"
//End insp_LoadaInspType_