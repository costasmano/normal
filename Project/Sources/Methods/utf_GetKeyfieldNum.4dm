//%attributes = {"invisible":true}
// Method: utf_GetKeyfieldNum
// Description
// Get the number of the first unique field for a table
// Parameters
// $0 : $KeyFldNum : Long
// $1 : $TblNum : Long
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 04/02/07, 10:16:08
	// ----------------------------------------------------
	// ----------------------------------------------------
	Mods_2007_CM07
End if 
C_LONGINT:C283($0; $KeyFldNum; $1; $TblNum)
$TblNum:=$1
$KeyFldNum:=0
C_LONGINT:C283($NumFlds; $i; $FldType; $FldLen)
C_BOOLEAN:C305($FldIndx; $FldUnique; $Fldvis)
If (($TblNum>0) & ($TblNum<=Get last table number:C254))
	$NumFlds:=Get last field number:C255($TblNum)
	For ($i; 1; $NumFlds)
		GET FIELD PROPERTIES:C258($TblNum; $i; $FldType; $FldLen; $FldIndx; $FldUnique; $Fldvis)
		If ($FldUnique)
			$KeyFldNum:=$i
			$i:=$NumFlds+1
		End if 
	End for 
End if 
$0:=$KeyFldNum
