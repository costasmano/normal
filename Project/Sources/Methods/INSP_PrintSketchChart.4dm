//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 08/22/07, 14:31:09
	// ----------------------------------------------------
	// Method: INSP_PrintSketchChart
	// Description
	// Print the current selection of Sketches or Charts
	// 
	// Parameters
	// $0 : $bPortrait
	// $1 : $bPortrait : starting orientation
	// ----------------------------------------------------
	
	Mods_2007_CM12_5301
End if 
C_BOOLEAN:C305($0; $1; $bPortrait)
C_LONGINT:C283($2; $PrintSketchChart; $vNumPhotos; $i)
$bPortrait:=$1
$PrintSketchChart:=$2
$vNumPhotos:=Records in selection:C76([Standard Photos:36])
FIRST RECORD:C50([Standard Photos:36])
For ($i; 1; $vNumPhotos)
	vPageNo:=vPageNo+1
	If ((PrintFlag) & ($PrintSketchChart=1))
		$bPortrait:=INSP_PrintSketchChartSingle($bPortrait)
		
	End if 
	NEXT RECORD:C51([Standard Photos:36])
End for 

$0:=$bPortrait