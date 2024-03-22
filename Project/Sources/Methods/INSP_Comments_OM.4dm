//%attributes = {"invisible":true}
// Method: INSP_Comments_OM
// Description
// Object method for the comments 4D Write area
// 
// Parameters
// $1 : $MyArea
// $2 : $Field_ptr
// $3 : $FormEvent [Optional]
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 09/05/08, 08:14:57
	// ----------------------------------------------------
	
	Mods_2008_CM_5404  // ("INSPCMMTS")
	Mods_2009_03  //CJM 2004 upgrade   `03/27/09, 15:41:43
	// Modified by: costasmanousakis-(Designer)-(2/1/10 16:48:39)
	Mods_2010_02
	//Added commands to suppress the update mode of the area on the On Load event
	// Modified by: Costas Manousakis-(Designer)-(10/22/19 16:23:20)
	Mods_2019_10_bug
	//  `After loading or saving the 4D Write area, delete the last char because INSP_4DWRITE_SaveToFld adds a carriage return  CallReference #655
	Mods_2021_Delete
End if 
//C_LONGINT($1;$MyArea)
//C_POINTER($2;$Field_ptr)
//$MyArea:=$1
//$Field_ptr:=$2
//C_LONGINT($FormEvent)
//If (Count parameters>2)
//$FormEvent:=$3
//Else 
//$FormEvent:=Form event
//End if 

//Case of 
//: ($FormEvent=On Load)
//WR UPDATE MODE ($MyArea;0)

//WR EXECUTE COMMAND ($MyArea;wr cmd new)
//Set Doc Margins ($MyArea)
//If (BLOB size($Field_ptr->)>0)
//WR INSERT STYLED TEXT ($MyArea;$Field_ptr->)
//  //delete the last character if it is a carr-ret
//C_TEXT($PlainText_txt;$lastchar_txt)
//$PlainText_txt:=WR Get text ($MyArea;0;(2*WR Count ($MyArea;wr nb characters)))
//C_LONGINT($total_L)
//$total_L:=Length($PlainText_txt)
//  //get the last char
//$lastchar_txt:=Substring($PlainText_txt;$total_L;1)
//If ($lastchar_txt=Char(Carriage return))
//WR BACKSPACE ($MyArea)
//End if 

//End if 
//WR SET AREA PROPERTY ($MyArea;wr modified;0;"")
//WR UPDATE MODE ($MyArea;1)

//: (($FormEvent=On Losing Focus) & (Not(bDiveFormValid)))
//C_LONGINT($viAreaMod)  // **replaced _ o _C_INTEGER()
//C_TEXT($vsStrValue)  //needed only for WR Get Area Prop call ` old C_STRING length 2
//WR GET AREA PROPERTY ($MyArea;wr modified;$viAreaMod;$vsStrValue)
//If ($viAreaMod=1)
//INSP_4DWRITE_SaveToFld ($MyArea;$Field_ptr)
//  //saving to field adds a carriage return - need to delete it now
//C_LONGINT($CharCount_L)
//$CharCount_L:=2*WR Count ($MyArea;wr nb characters)
//WR SET SELECTION ($MyArea;$CharCount_L;$CharCount_L)
//WR BACKSPACE ($MyArea)
//  //mark the area as not mofified now.
//WR SET AREA PROPERTY ($MyArea;wr modified;0;$vsStrValue)

//End if 
//: ($FormEvent=On Plug in Area)
//If (vbInspectionLocked)
//Else 
//C_LONGINT($BFirst_l;$Last_l)
//WR UPDATE MODE ($MyArea;0)
//WR GET SELECTION ($MyArea;$BFirst_l;$Last_l)
//If (WRUTIL_Function ($MyArea;"CLEANCHARS"))
//If (vbInspectionLocked)
//OBJECT SET ENABLED(*;"DE@";False)  // **replaced _ o _DISABLE BUTTON(*;"DE@")
//Else 
//OBJECT SET ENABLED(*;"DE@";True)  // **replaced _ o _ENABLE BUTTON(*;"DE@")
//End if 

//WR SET SELECTION ($MyArea;$BFirst_l;$Last_l)
//WR SCROLL TO SELECTION ($MyArea)

//End if 
//WR UPDATE MODE ($MyArea;1)

//End if 
//End case 