//%attributes = {"invisible":true}
If (False:C215)
	//G_CreateImageLog
	//Add the image log for an Inspection to a 4D Write area.
	//Use the current selection of [Standard Photos]
	// Modified by: costasmanousakis-(Designer)-(12/17/07 09:34:38)
	Mods_2007_CM_5401
	//Combine Selection to array commands
	// Modified by: Costas Manousakis-(Designer)-(3/22/21 17:36:25)
	Mods_2021_03
	//  `make sure we only use photos sketches or charts in the image log
End if 

C_LONGINT:C283($1; $mainarea)

$mainarea:=$1
C_LONGINT:C283($i; $numphotos)
$numphotos:=Records in selection:C76([Standard Photos:36])

// save selection of photos/sketches
COPY NAMED SELECTION:C331([Standard Photos:36]; "AllPicts")

QUERY SELECTION:C341([Standard Photos:36]; [Standard Photos:36]PictType:5=BMS Photo; *)
QUERY SELECTION:C341([Standard Photos:36];  | ; [Standard Photos:36]PictType:5=BMS Sketch; *)
QUERY SELECTION:C341([Standard Photos:36];  | ; [Standard Photos:36]PictType:5=BMS Chart)

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
//add it to the 4D Write area. Indent Labels by 0.7 inches.
G_addItemtoWr($mainarea; $vsLabel; $vtIndex; 0.9)

USE NAMED SELECTION:C332("AllPicts")
CLEAR NAMED SELECTION:C333("AllPicts")
