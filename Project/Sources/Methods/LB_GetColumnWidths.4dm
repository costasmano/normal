//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 12/29/11, 14:00:42
//----------------------------------------------------
//Method: LB_GetColumnWidths
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2011_12  //r004
	//Modified by: Charles Miller (12/29/11 14:00:43)
	Compiler_LB
End if 
If (ColumnWidths_txt="")
	C_LONGINT:C283($Loop_l; $Length_l)
	C_TEXT:C284($name)
	
	For ($loop_l; 1; Size of array:C274(arrColNames))
		$name:=arrColNames{$loop_l}
		$Length_l:=LISTBOX Get column width:C834(*; $name)
		If (Length:C16(ColumnWidths_txt)=0)
			ColumnWidths_txt:=String:C10($Length_l)
		Else 
			ColumnWidths_txt:=ColumnWidths_txt+", "+String:C10($Length_l)
		End if 
		
	End for 
End if 
//End LB_GetColumnWidths