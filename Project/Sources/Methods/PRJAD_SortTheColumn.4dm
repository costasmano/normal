//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): root
	// User name (4D): Designer
	// Date and time: 10/18/07, 11:58:09
	// ----------------------------------------------------
	// Method: PRJAD_SortTheColumn
	// Description
	// Perform the sort for the 4D View area used in 
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2007_CM12_5302
	Mods_2011_06  // CJ Miller`06/14/11, 13:25:05      ` Type all local variables for v11
End if 
C_BOOLEAN:C305($0)
C_LONGINT:C283($1; $2; $3; $4; $5; $6)
//If ($5=0)  //If the click takes place in a header
//C_LONGINT($tableNum;$fieldNum;$i;$k;$newSort)  //Command Replaced was o_C_INTEGER
//C_TEXT($Arrname)
//C_POINTER($arrPtr;$Bdeptptr;$BINptr;$LastSortptr;$Helparrayptr)
//$0:=True  //Cancels the event
//$Arrname:=PV Get cell variable ($1;$4;1)
//$Arrname:=Substring($Arrname;1;(Position("{";$Arrname)-1))
//$arrPtr:=Get pointer($Arrname)
//$LastSortptr:=PRJAD_sortArrays_ap{1}
//$k:=Find in array(PRJAD_sortArrays_ap;$arrPtr)
//For ($i;1;Size of array(PRJAD_sortArrays_ap))
//If ($i#$k)
//PRJAD_sortArrayOrder_aL{$i}:=0
//Else 
//If (PRJAD_sortArrayOrder_aL{$i}=1)
//$newSort:=-1
//Else 
//$newSort:=1
//End if 
//PRJAD_sortArrayOrder_aL{$i}:=2
//End if 
//End for 
//$Bdeptptr:=->PRJAD_BridgeNo_atxt
//$Helparrayptr:=->PRJAD_HelperSortArray_aL
//Case of 
//: ($arrPtr#$Bdeptptr)
//$k:=Find in array(PRJAD_sortArrays_ap;$Bdeptptr)
//PRJAD_sortArrayOrder_aL{$k}:=3
//$k:=Find in array(PRJAD_sortArrays_ap;$Helparrayptr)
//If (($Arrname="@_ad") & ($newSort=1))  // a date array ascending...
//PRJAD_sortArrayOrder_aL{$k}:=1  //use the helper array
//Else 
//PRJAD_sortArrayOrder_aL{$k}:=0
//End if 

//SORT ARRAY(PRJAD_sortArrayOrder_aL;PRJAD_sortArrays_ap)
//PRJAD_sortArrayOrder_aL{Size of array(PRJAD_sortArrayOrder_aL)-1}:=$newSort
//PRJAD_sortArrayOrder_aL{Size of array(PRJAD_sortArrayOrder_aL)}:=1  //the bdept is sorted ascending
//: ($arrPtr=$Bdeptptr)
//PRJAD_sortArrayOrder_aL{$k}:=$newSort
//End case 
//If (($Arrname="@_ad") & ($newSort=1))  // a date array ascending...
//For ($i;1;Size of array($arrptr->))
//If ($arrPtr->{$i}#!00-00-00!)
//$Helparrayptr->{$i}:=0
//Else 
//$Helparrayptr->{$i}:=1
//End if 
//End for 
//End if 

//SHORT_MESSAGE ("Sorting, Please Wait..")
//MULTI SORT ARRAY(PRJAD_sortArrays_ap;PRJAD_sortArrayOrder_aL)

//CREATE SELECTION FROM ARRAY(pFile->;PRJAD_RecNum_aL)
//PV GOTO CELL (AdStatusVArea;1;1)
//PV_SetSelectedRow (AdStatusVArea;0)
//CLOSE WINDOW
//End if   //Linked values in the columns are automatically sorted