//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 09/24/07, 14:29:02
	// ----------------------------------------------------
	// Method: PV_SetColumnFormat
	// Description
	// set the column formats for an area from 6 arrays.
	// modeled after PV_SetColumnWidths by DBatton
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2007_CM12_5302
End if 

//C_POINTER($areaPtr)  // $1 intentionally left out here. Handled below.
//C_POINTER(${2})
//C_LONGINT($columns;$rows;$column)

//If (Type($1)#Is pointer)
//ALERT("You must pass a pointer to the 4D View area when calling "+Current method name+".")
//TRACE
//Else 
//C_POINTER($1)
//$areaPtr:=$1
//C_POINTER($HorAlignptr;$AlphaFptr;$NumFptr;$DateFptr;$BoolFptr;$PicFptr;$firstArrptr)
//C_TEXT($firstColArrName)

//$HorAlignptr:=$2
//$AlphaFptr:=$3
//$NumFptr:=$4
//$DateFptr:=$5
//$BoolFptr:=$6
//$PicFptr:=$7
//$columns:=Size of array($HorAlignptr->)
//$firstColArrName:=PV Get cell variable ($areaPtr->;1;1)
//If (Position("{";$firstColArrName)>0)
//$firstColArrName:=Substring($firstColArrName;1;(Position("{";$firstColArrName)-1))
//End if 
//$firstArrptr:=Get pointer($firstColArrName)
//$rows:=Size of array($firstArrptr->)

//  // Get the current selection, so we can restore it. - DB021204
//ARRAY LONGINT(PV_SelectedRowsArray;0)
//PV_GetSelectedRows ($areaPtr->;->PV_SelectedRowsArray)

//  // Set the column headers.
//For ($column;1;$columns)
//PV SET RANGE PROPERTY ($areaPtr->;$column;1;$column;$rows;pv style hor alignment;$HorAlignptr->{$column})
//PV SET RANGE PROPERTY ($areaPtr->;$column;1;$column;$rows;pv style format alpha;$AlphaFptr->{$column})
//PV SET RANGE PROPERTY ($areaPtr->;$column;1;$column;$rows;pv style format num;$NumFptr->{$column})
//PV SET RANGE PROPERTY ($areaPtr->;$column;1;$column;$rows;pv style format date time;$DateFptr->{$column})
//PV SET RANGE PROPERTY ($areaPtr->;$column;1;$column;$rows;pv style format bool;$BoolFptr->{$column})
//PV SET RANGE PROPERTY ($areaPtr->;$column;1;$column;$rows;pv style format picture;$PicFptr->{$column})
//End for 

//PV_SetSelectedRows ($areaPtr->;->PV_SelectedRowsArray)
//End if 