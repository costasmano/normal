//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 03/07/13, 12:55:11
//----------------------------------------------------
//Method: mbta_SortRecords
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2013_03  //r001 ` Created to allow for custom sort when displaying mbta bridges
	//Modified by: Charles Miller (3/7/13 12:55:17)
	// Modified by: Costas Manousakis-(Designer)-(4/9/13 14:41:10)
	Mods_2013_04
	//  `Added sorting by line, milepost.  sort otder is  Category,  LineName, Milepost, BIN
	//  `Only Commuter Rail bridges are sorteb by milepost, so for other categories the milepost array elements are set to 0
End if 
ARRAY LONGINT:C221($RecordNumbers_al; 0)

LONGINT ARRAY FROM SELECTION:C647([Bridge MHD NBIS:1]; $RecordNumbers_al)
C_LONGINT:C283($numRecs_L)
$numRecs_L:=Size of array:C274($RecordNumbers_al)
ARRAY TEXT:C222($Bins_atxt; 0)
ARRAY TEXT:C222($Bins_atxt; $numRecs_L)
ARRAY TEXT:C222($Category_atxt; 0)
ARRAY TEXT:C222($Category_atxt; $numRecs_L)
ARRAY REAL:C219($MilePts_ar; 0)
ARRAY REAL:C219($MilePts_ar; $numRecs_L)
ARRAY TEXT:C222($LineName_atxt; 0)
ARRAY TEXT:C222($LineName_atxt; $numRecs_L)

SELECTION RANGE TO ARRAY:C368(1; Records in selection:C76([Bridge MHD NBIS:1]); [Bridge MHD NBIS:1]BIN:3; $Bins_atxt; [Bridge MHD NBIS:1]Item8 BridgeCat:207; $Category_atxt; [Bridge MHD NBIS:1]RRBranch:210; $LineName_atxt; [Bridge MHD NBIS:1]RRBridgeNo:211; $MilePts_ar)

ARRAY LONGINT:C221($SortOrder_al; Size of array:C274($RecordNumbers_al))

C_LONGINT:C283($Loop_l)

For ($Loop_l; 1; Size of array:C274($RecordNumbers_al))
	
	Case of 
		: ($Category_atxt{$Loop_l}="RRO")
			$SortOrder_al{$Loop_l}:=3
		: ($Category_atxt{$Loop_l}="TRO")
			$SortOrder_al{$Loop_l}:=2
			$MilePts_ar{$Loop_l}:=0
		: ($Category_atxt{$Loop_l}="PED")
			$SortOrder_al{$Loop_l}:=4
			$MilePts_ar{$Loop_l}:=0
		: ($Category_atxt{$Loop_l}="DES")
			$SortOrder_al{$Loop_l}:=5
			$MilePts_ar{$Loop_l}:=0
		: ($Category_atxt{$Loop_l}="REM")
			$SortOrder_al{$Loop_l}:=5
			$MilePts_ar{$Loop_l}:=0
		: ($Category_atxt{$Loop_l}="DUM")
			$SortOrder_al{$Loop_l}:=5
			$MilePts_ar{$Loop_l}:=0
		: ($Category_atxt{$Loop_l}="CLP")
			$SortOrder_al{$Loop_l}:=4
			$MilePts_ar{$Loop_l}:=0
		: ($Category_atxt{$Loop_l}="CLO")
			$SortOrder_al{$Loop_l}:=5
			$MilePts_ar{$Loop_l}:=0
		Else 
			$SortOrder_al{$Loop_l}:=1
			$MilePts_ar{$Loop_l}:=0
	End case 
End for 

If (Count parameters:C259=1)
	C_LONGINT:C283($1)
	If ($1=1)
		MULTI SORT ARRAY:C718($SortOrder_al; >; $LineName_atxt; >; $MilePts_ar; >; $Bins_atxt; >; $RecordNumbers_al)
	Else 
		MULTI SORT ARRAY:C718($SortOrder_al; <; $LineName_atxt; >; $MilePts_ar; >; $Bins_atxt; >; $RecordNumbers_al)
	End if 
Else 
	MULTI SORT ARRAY:C718($SortOrder_al; >; $LineName_atxt; >; $MilePts_ar; >; $Bins_atxt; >; $RecordNumbers_al)
	For ($Loop_l; 1; Size of array:C274(BRGList_SortPtr_ap))
		BRGList_SortPtr_ap{$Loop_l}->:=0
	End for 
End if 
CREATE SELECTION FROM ARRAY:C640([Bridge MHD NBIS:1]; $RecordNumbers_al)

//End mbta_SortRecords