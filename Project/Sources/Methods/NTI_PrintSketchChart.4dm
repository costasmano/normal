//%attributes = {"invisible":true}
//Method: NTI_PrintSketchChart
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 06/02/16, 16:06:13
	// ----------------------------------------------------
	//Created : 
	Mods_2016_NTE
	
	C_BOOLEAN:C305(NTI_PrintSketchChart; $0; $1)
	C_LONGINT:C283(NTI_PrintSketchChart; $2)
	
End if 
//
C_BOOLEAN:C305($0; $1; $bPortrait)
C_LONGINT:C283($2; $PrintSketchChart; $vNumPhotos; $i)
$bPortrait:=$1
$PrintSketchChart:=$2
$vNumPhotos:=Records in selection:C76([TIN_Insp_Images:186])
FIRST RECORD:C50([TIN_Insp_Images:186])

For ($i; 1; $vNumPhotos)
	vPageNo:=vPageNo+1
	If ((PrintFlag) & ($PrintSketchChart=1))
		
		$bPortrait:=NTI_PrintSketchChartSingle($bPortrait)
		
	End if 
	NEXT RECORD:C51([TIN_Insp_Images:186])
End for 

$0:=$bPortrait
//End NTI_PrintSketchChart