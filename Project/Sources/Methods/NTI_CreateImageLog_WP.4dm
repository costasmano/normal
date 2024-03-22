//%attributes = {"invisible":true}
//Method: NTI_CreateImageLog_WP
//Description
// Create image log for a TIN inspection using 4D Write PRO
// Parameters
// $1 : $WPAreaDoc_obj
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 02/08/21, 18:02:07
	// ----------------------------------------------------
	//Created : 
	Mods_2021_WP
	
	C_OBJECT:C1216(NTI_CreateImageLog_WP; $1)
End if 
//

C_OBJECT:C1216($1; $WParea)

C_LONGINT:C283($i; $numphotos)
$numphotos:=Records in selection:C76([TIN_Insp_Images:186])

ARRAY TEXT:C222($aPhotoDesc; 0)  //Command Replaced was o_ARRAY string length was 255
ARRAY TEXT:C222($aPhotoType; 0)  //Command Replaced was o_ARRAY string length was 2
ARRAY INTEGER:C220($aImgNo; 0)
ORDER BY:C49([TIN_Insp_Images:186]; [TIN_Insp_Images:186]ImageType:5; >; [TIN_Insp_Images:186]SequenceNum:6; >)
SELECTION TO ARRAY:C260([TIN_Insp_Images:186]ImageDescr:4; $aPhotoDesc; [TIN_Insp_Images:186]ImageType:5; $aPhotoType; [TIN_Insp_Images:186]SequenceNum:6; $aImgNo)
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
If ($numphotos>0)
	$vsLabel:=$vsLabel+" Log"
	//add it to the 4D Write PRO area. Indent Labels by 2.5cm
	INSP_AddTextToArea_WP($1; $vsLabel; $vtIndex; "-2.5cm")
End if 


//End NTI_CreateImageLog_WP