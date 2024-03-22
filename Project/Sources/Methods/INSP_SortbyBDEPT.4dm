//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 05/18/06, 12:34:10
	// ----------------------------------------------------
	// Method: INSP_SortbyBDEPT
	// Description
	// Sort a list of inspections by BDEPT
	// 
	// Parameters
	// $1 : Sort order : Integer (value of sort button)
	// ----------------------------------------------------
	Mods_2006_CM04
	// Modified by: costasmanousakis-(Designer)-(8/13/08 12:15:27)
	Mods_2008_CM_5404
	//  `Removed the call to SHORT_MESSAGE for more than 500 records.
	//  `in preparation for 2004 conversion
	// Modified by: Costas Manousakis-(Designer)-(10/31/13 15:55:58)
	Mods_2013_10
	//  `loop thru the aPtrSortOrder  array to set the other sort variables to 0
End if 
C_LONGINT:C283($1; $SortOrder_I)  //Command Replaced was o_C_INTEGER
$SortOrder_I:=$1
If (Records in selection:C76([Inspections:27])>0)
	SET CURSOR:C469(128)
	SET AUTOMATIC RELATIONS:C310(True:C214; True:C214)
	ARRAY LONGINT:C221($RecordNumber_al; 0)
	ARRAY TEXT:C222($Bdept_as; 0)  //Command Replaced was o_ARRAY string length was 6
	SELECTION TO ARRAY:C260([Inspections:27]; $RecordNumber_al; [Bridge MHD NBIS:1]BDEPT:1; $Bdept_as)
	
	If (($SortOrder_I=0) | ($SortOrder_I=1))
		SORT ARRAY:C229($Bdept_as; $RecordNumber_al)
	Else 
		SORT ARRAY:C229($Bdept_as; $RecordNumber_al; <)
	End if 
	
	CREATE SELECTION FROM ARRAY:C640([Inspections:27]; $RecordNumber_al; "SelectedInspecctions")
	USE NAMED SELECTION:C332("SelectedInspecctions")
	CLEAR NAMED SELECTION:C333("SelectedInspecctions")
	ARRAY LONGINT:C221($RecordNumber_al; 0)
	ARRAY TEXT:C222($Bdept_as; 0)  //Command Replaced was o_ARRAY string length was 6
	
	If (Type:C295(aPtrSortOrder)=Pointer array:K8:23)
		C_LONGINT:C283($loop_L)
		For ($loop_L; 1; Size of array:C274(aPtrSortOrder))
			aPtrSortOrder{$loop_L}->:=0
		End for 
	End if 
	ARRAY POINTER:C280(aPtrSortField; 0)
	ARRAY POINTER:C280(aPtrSortOrder; 0)
	
	vbSortedHeader:=True:C214
	
	SET CURSOR:C469(0)
End if 