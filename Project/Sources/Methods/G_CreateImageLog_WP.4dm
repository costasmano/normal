//%attributes = {"invisible":true}
//Method: G_CreateImageLog_WP
//Description
// Add the images log to a Write Pro document
// Parameters
// $1 : $WPArea_object
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 01/24/21, 18:41:07
	// ----------------------------------------------------
	//Created : 
	Mods_2021_WP
	
	C_OBJECT:C1216(G_CreateImageLog_WP; $1)
	
	// Modified by: Costas Manousakis-(Designer)-(2022-04-22 14:48:25)
	Mods_2022_04_bug
	//  `save and restore the selection of images; make sure we only use photos/skectches/charts
End if 
//

C_OBJECT:C1216($1)

COPY NAMED SELECTION:C331([Standard Photos:36]; "Log_AllPicts")

QUERY:C277([Standard Photos:36]; [Standard Photos:36]InspID:1=[Inspections:27]InspID:2)

QUERY SELECTION:C341([Standard Photos:36]; [Standard Photos:36]PictType:5=BMS Photo; *)
QUERY SELECTION:C341([Standard Photos:36];  | ; [Standard Photos:36]PictType:5=BMS Sketch; *)
QUERY SELECTION:C341([Standard Photos:36];  | ; [Standard Photos:36]PictType:5=BMS Chart)

C_LONGINT:C283($numphotos)
$numphotos:=Records in selection:C76([Standard Photos:36])

ARRAY TEXT:C222($aPhotoDesc; 0)  //Command Replaced was o_ARRAY string length was 255
ARRAY TEXT:C222($aPhotoType; 0)  //Command Replaced was o_ARRAY string length was 2
ARRAY INTEGER:C220($aImgNo; 0)
G_SortInspImages
SELECTION TO ARRAY:C260([Standard Photos:36]Description:2; $aPhotoDesc; [Standard Photos:36]PictType:5; $aPhotoType; [Standard Photos:36]SeqNum:6; $aImgNo)
C_TEXT:C284($vtIndex)
C_TEXT:C284($vsLabel)  // Command Replaced was o_C_STRING length was 80
C_BOOLEAN:C305($vbPhotos; $vbSketches; $vbCharts)

$vbPhotos:=False:C215
$vbSketches:=False:C215
$vbCharts:=False:C215
$vtIndex:=""
//build the index first
C_LONGINT:C283($i)
For ($i; 1; $numphotos)
	
	Case of 
		: ($aPhotoType{$i}=BMS Photo)  // Photo
			$vtIndex:=$vtIndex+"Photo "
			$vbPhotos:=True:C214
		: ($aPhotoType{$i}=BMS Sketch)  // Sketch       
			$vtIndex:=$vtIndex+"Sketch "
			$vbSketches:=True:C214
		: ($aPhotoType{$i}=BMS Chart)  // Chart        
			$vtIndex:=$vtIndex+"Chart "
			$vbCharts:=True:C214
	End case 
	$vtIndex:=$vtIndex+String:C10($aImgNo{$i})+" : "+<>sTAB+$aPhotoDesc{$i}
	If ($i#$numphotos)
		$vtIndex:=$vtIndex+<>sCR  //add linefeed except the last one.
	End if 
End for 
//build the label
$vsLabel:=""
If ($vbSketches)
	$vsLabel:="Sketch"
End if 
If ($vbCharts)
	If ($vsLabel="")
		$vsLabel:="Chart"
	Else 
		$vsLabel:=$vsLabel+" / Chart"
	End if 
End if 
If ($vbPhotos)
	If ($vsLabel="")
		$vsLabel:="Photo"
	Else 
		$vsLabel:=$vsLabel+" / Photo"
	End if 
End if 
$vsLabel:=$vsLabel+" Log"

INSP_AddTextToArea_WP($1; $vsLabel; $vtIndex; "-2.5cm")

USE NAMED SELECTION:C332("Log_AllPicts")
CLEAR NAMED SELECTION:C333("Log_AllPicts")
//End G_CreateImageLog_WP