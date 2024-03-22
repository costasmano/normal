//%attributes = {"invisible":true}
If (False:C215)
	//F_ImageSort
	//Change the sort order of images for an inspection.
	//F_ImageSort(ImgType;ImgSeq)
	
End if 

C_TEXT:C284($1; $vsImgType)  // Command Replaced was o_C_STRING length was 2
C_LONGINT:C283($2; $vlImgSeq)
C_LONGINT:C283($0; $vlNewSeq)
$vsImgType:=$1
$vlImgSeq:=$2
$vlNewSeq:=0
Case of 
	: ($vsImgType=BMS Sketch)
		$vlNewSeq:=1000
	: ($vsImgType=BMS Chart)
		$vlNewSeq:=2000
	: ($vsImgType=BMS Photo)
		$vlNewSeq:=3000
	Else 
		$vlNewSeq:=4000
End case 
$vlNewSeq:=$vlNewSeq+$vlImgSeq
$0:=$vlNewSeq