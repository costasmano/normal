//%attributes = {"invisible":true}
If (False:C215)
	//GP LongName
	//Copyright © 1996, Thomas D. Nee, All Rights Reserved.
	//Returns a string joining the following four fields:
	//     Element Name (never blank)
	//     General Category (rarely blank (1 instance))
	//     Subcategory (sometimes blank)
	//     Element Type (usually blank)
	
	//This procedure does for one element what GP LOAD_aElem does for all elements.  
	
	// Modified by: costasmanousakis-(Designer)-(9/14/05 12:51:57)
	Mods_2005_CM17
End if 
C_TEXT:C284($Name; $0)  // Command Replaced was o_C_STRING length was 100

$Name:=[BMS Elements:47]Element Name:3  //This should never be blank.
If ([BMS Categories:49]General Cat:2#"")
	$Name:=$Name+", "+[BMS Categories:49]General Cat:2
	If (Position:C15("["; $Name)>0)
		$Name:=Substring:C12($Name; 1; (Position:C15("["; $Name)-1))
		$Name:=f_TrimStr($Name; True:C214; True:C214)
	End if 
End if 
If ([BMS Categories:49]Subcategory:3#"")
	$Name:=$Name+", "+[BMS Categories:49]Subcategory:3
End if 
If ([BMS Elements:47]Element Type:4#"")
	$Name:=$Name+", "+[BMS Elements:47]Element Type:4
End if 

$0:=$Name