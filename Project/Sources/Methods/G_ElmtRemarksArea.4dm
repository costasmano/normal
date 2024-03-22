//%attributes = {"invisible":true}
//G_ElmtRemarksArea Method
//Project method called from the 4D Write object method of
// ElementSafety input forms
//Parameters
//$1: Area
If (False:C215)
	
	// Modified by: costasmanousakis-(Designer)-(8/14/08 16:22:32)
	Mods_2008_CM_5404
	//  `Added optional second parameter to pass the form event.
	// Modified by: costasmanousakis-(Designer)-(9/5/08 09:05:21)
	Mods_2008_CM_5404
	//  `Use INSP_4DWRITE_SaveToFld
	Mods_2009_03  //CJM 2004 upgrade   `03/27/09, 11:47:06
	// Modified by: Costas Manousakis-(Designer)-(10/22/19 16:23:20)
	Mods_2019_10_bug
	//  `delete the last char if it is a carr.ret CallReference #655
	Mods_2021_Delete
End if 

//C_LONGINT($1;$MyArea)
//$MyArea:=$1
//C_LONGINT($FormEvent_L)
//If (Count parameters>1)
//C_LONGINT($2)
//$FormEvent_L:=$2
//Else 
//$FormEvent_L:=Form event
//End if 

//Case of 
//: ($FormEvent_L=On Load)

//  //ALERT("loading record :"+[ElementsSafety]Description)
//WR EXECUTE COMMAND ($MyArea;wr cmd new)
//Set Doc Margins ($MyArea)
//If (BLOB size([ElementsSafety]ElmComments)>0)
//WR INSERT STYLED TEXT ($MyArea;[ElementsSafety]ElmComments)

//  // remove the last char only if it is a carriage return.
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
//WR SET AREA PROPERTY ($MyArea;wr modified;0;"")  //pretend area is not modified

//: (($FormEvent_L=On Losing Focus) & (bElmNotValidated))
//  //ALERT("changed record "+[ElementsSafety]Description)
//C_LONGINT($viAreaMod)  // **replaced _ o _C_INTEGER()
//C_TEXT($vsStrValue)  // **Replaced old C_STRING length 2
//WR GET AREA PROPERTY ($MyArea;wr modified;$viAreaMod;$vsStrValue)
//If ($viAreaMod=1)
//INSP_4DWRITE_SaveToFld ($MyArea;->[ElementsSafety]ElmComments;2)

//[ElementsSafety]Comment Flag:=(BLOB size([ElementsSafety]ElmComments)>0)
//PushChange (2;->[ElementsSafety]Comment Flag)

//End if 
//End case 