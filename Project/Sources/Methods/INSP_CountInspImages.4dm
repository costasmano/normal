//%attributes = {"invisible":true}
//Method: INSP_CountInspImages
//Description
// Count Inspection image types
// Parameters
// $0 : $Counts_o : object containing counts
//  .total
//  .photos
//  .sketches
//  .charts
// $1 : $InspId_L ( optional) default is current inspection ID
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 2022-04-22T00:00:00, 14:58:13
	// ----------------------------------------------------
	//Created : 
	Mods_2022_04
	
	C_OBJECT:C1216(INSP_CountInspImages; $0)
	C_LONGINT:C283(INSP_CountInspImages; $1)
End if 
//
C_LONGINT:C283($inspID_L)
C_LONGINT:C283($photoCount_L; $sketchCount_L; $chartCount_L; $total_L)
$inspID_L:=[Inspections:27]InspID:2
If (Count parameters:C259>0)
	C_LONGINT:C283($1)
	$inspID_L:=$1
End if 
C_TEXT:C284($photoType_txt; $sketchType_txt; $chartType_txt)
$photoType_txt:=BMS Photo
$chartType_txt:=BMS Chart
$sketchType_txt:=BMS Sketch
C_OBJECT:C1216($Counts_o)

Begin SQL
	select count(*) from [Standard Photos]
	where [Standard Photos].[InspID] = :$inspID_L
	and [Standard Photos].[PictType] = :$photoType_txt
	into :$photoCount_L ;
	select count(*) from [Standard Photos]
	where [Standard Photos].[InspID] = :$inspID_L
	and [Standard Photos].[PictType] = :$chartType_txt
	into :$chartCount_L ;
	select count(*) from [Standard Photos]
	where [Standard Photos].[InspID] = :$inspID_L
	and [Standard Photos].[PictType] = :$sketchType_txt
	into :$sketchCount_L ;
End SQL

$Counts_o:=New object:C1471("photos"; $photoCount_L; \
"charts"; $chartCount_L; \
"sketches"; $sketchCount_L; \
"total"; ($photoCount_L+$chartCount_L+$sketchCount_L))

$0:=$Counts_o

//End INSP_CountInspImages