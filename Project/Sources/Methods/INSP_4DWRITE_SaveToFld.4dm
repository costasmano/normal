//%attributes = {"invisible":true}
// Method: INSP_4DWRITE_SaveToFld
// Description
//  ` Save a 4D Write area to a field doing some processing
// Parameters
// $1 : $MyArea
// $2 : $Fld_Ptr
// $3 : $StackNo (Optional) default to 1
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 09/05/08, 08:12:41
	// ----------------------------------------------------
	
	Mods_2008_CM_5404  // ("INSPCMMTS")
	// Modified by: costasmanousakis-(Designer)-(10/31/08 11:19:42)
	Mods_2008_CM_5404
	//Fixed bug that did not get the 3rd parameter - the stack level
	// Modified by: costasmanousakis-(Designer)-(12/8/09 16:48:35)
	Mods_2009_12
	//Enabled new method of cleaning characters - to execute the CLEANCHARS part of WRUTIL_Function
	// Modified by: Costas Manousakis-(Designer)-(10/22/19 16:23:20)
	Mods_2019_10_bug
	//  `add a carriage return at the end of the on screen document before copying the styled text.
	//  `This is to include paragraph formatting of the last paragraph in the save styled text. - CallReference #655
	Mods_2021_Delete
End if 
//C_LONGINT($1;$MyArea)
//C_POINTER($2;$Fld_Ptr)
//$MyArea:=$1
//$Fld_Ptr:=$2
//C_LONGINT($StackNo)
//If (Count parameters>2)
//C_LONGINT($3)
//$StackNo:=$3
//Else 
//$StackNo:=1
//End if 

//C_LONGINT($vStartSel;$vEndSel)
//WR GET SELECTION ($MyArea;$vStartSel;$vEndSel)
//G_Trimlines ($MyArea)
//  //``````````````````````````
//C_BOOLEAN($vbNewMethod)
//$vbNewMethod:=True
//If ($vbNewMethod)  //new version of event
//WR UPDATE MODE ($MyArea;0)

//If (WRUTIL_Function ($MyArea;"CLEANCHARS"))
//If (WRUTIL_Function ($MyArea;"RESETFONTSIZE"))
//  //$Fld_Ptr->:=WR Get styled text ($MyArea)

//  //add a carriage return at the bottom of comments this preserves paragraph formatting when the contents are copied
//  // must delete the CarrRet when loading the blob back , or when combining to print all comments
//WR SET SELECTION ($MyArea;2*WR Count ($MyArea;wr nb characters);2*WR Count ($MyArea;wr nb characters))
//WR INSERT TEXT ($MyArea;Char(Carriage return))

//WR EXECUTE COMMAND ($MyArea;wr cmd select all)

//$Fld_Ptr->:=WR Get styled text ($MyArea)
//Else 
//SET BLOB SIZE($Fld_Ptr->;0)
//End if 
//PushChange ($StackNo;$Fld_Ptr)
//WR SET AREA PROPERTY ($MyArea;wr modified;0;"")
//WR SET SELECTION ($MyArea;$vStartSel;$vEndSel)
//WR SCROLL TO SELECTION ($MyArea)
//If (vbInspectionLocked)
//OBJECT SET ENABLED(*;"DE@";False)  // **replaced _ o _DISABLE BUTTON(*;"DE@")
//Else 
//OBJECT SET ENABLED(*;"DE@";True)  // **replaced _ o _ENABLE BUTTON(*;"DE@")
//End if 
//End if 
//WR UPDATE MODE ($MyArea;1)
//Else 
//If (WRUTIL_Function ($MyArea;"RESETFONTSIZE"))
//WR EXECUTE COMMAND ($MyArea;wr cmd select all)
//$Fld_Ptr->:=WR Get styled text ($MyArea)
//Else 
//SET BLOB SIZE($Fld_Ptr->;0)
//End if 
//PushChange ($StackNo;$Fld_Ptr)
//WR SET AREA PROPERTY ($MyArea;wr modified;0;"")
//WR SET SELECTION ($MyArea;$vStartSel;$vEndSel)
//WR SCROLL TO SELECTION ($MyArea)
//End if   //old version of event