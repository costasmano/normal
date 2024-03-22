//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 03/07/13, 16:24:13
//----------------------------------------------------
//Method: mbta_ReturnHwySelection
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2013_03  //r001 ` 
	//Modified by: Charles Miller (3/7/13 16:24:14)
	
End if 

ARRAY LONGINT:C221($RecordNumbers_al; 0)
LONGINT ARRAY FROM SELECTION:C647([Bridge MHD NBIS:1]; $RecordNumbers_al)

ARRAY LONGINT:C221($SortOrder_al; Size of array:C274($RecordNumbers_al))
ARRAY TEXT:C222($Bins_atxt; 0)
ARRAY TEXT:C222($Bins_atxt; Size of array:C274($RecordNumbers_al))
ARRAY TEXT:C222($Category_atxt; 0)
ARRAY TEXT:C222($Category_atxt; Size of array:C274($RecordNumbers_al))
SELECTION RANGE TO ARRAY:C368(1; Records in selection:C76([Bridge MHD NBIS:1]); [Bridge MHD NBIS:1]BIN:3; $Bins_atxt; [Bridge MHD NBIS:1]Item8 BridgeCat:207; $Category_atxt)
C_BOOLEAN:C305($Delete_b)
C_LONGINT:C283($Loop_l)

For ($Loop_l; Size of array:C274($RecordNumbers_al); 1; -1)
	$Delete_b:=True:C214
	Case of 
		: ($Category_atxt{$Loop_l}="RRO")
			$SortOrder_al{$Loop_l}:=3
		: ($Category_atxt{$Loop_l}="TRO")
			$SortOrder_al{$Loop_l}:=2
		: ($Category_atxt{$Loop_l}="PED")
			$SortOrder_al{$Loop_l}:=4
		: ($Category_atxt{$Loop_l}="DES")
			$SortOrder_al{$Loop_l}:=5
		: ($Category_atxt{$Loop_l}="REM")
			$SortOrder_al{$Loop_l}:=5
		: ($Category_atxt{$Loop_l}="DUM")
			$SortOrder_al{$Loop_l}:=5
		: ($Category_atxt{$Loop_l}="CLP")
			$SortOrder_al{$Loop_l}:=4
		: ($Category_atxt{$Loop_l}="CLO")
			$SortOrder_al{$Loop_l}:=5
		Else 
			$SortOrder_al{$Loop_l}:=1
			$Delete_b:=False:C215
	End case 
	If ($Delete_b)
		DELETE FROM ARRAY:C228($RecordNumbers_al; $Loop_l; 1)
		DELETE FROM ARRAY:C228($Bins_atxt; $Loop_l; 1)
		DELETE FROM ARRAY:C228($SortOrder_al; $Loop_l; 1)
	End if 
End for 
MULTI SORT ARRAY:C718($SortOrder_al; >; $Bins_atxt; >; $RecordNumbers_al)
CREATE SELECTION FROM ARRAY:C640([Bridge MHD NBIS:1]; $RecordNumbers_al)

//End mbta_ReturnHwySelection