//%attributes = {"invisible":true}
If (False:C215)
	
End if 
C_BOOLEAN:C305($0; $1; $bPortrait; $2; $NewPage_b)
$bPortrait:=$1
If (Count parameters:C259>1)
	$NewPage_b:=$2
Else 
	$NewPage_b:=True:C214
End if 

vPicture1:=[Standard Photos:36]Std Photo:3
Case of 
	: ([Standard Photos:36]PictType:5=BMS Sketch)
		vPage2Title:="SKETCHES"
		vPhotoNum1:="Sketch "+String:C10([Standard Photos:36]SeqNum:6)+":"
	: ([Standard Photos:36]PictType:5=BMS Chart)
		vPage2Title:="CHARTS"
		vPhotoNum1:="Chart "+String:C10([Standard Photos:36]SeqNum:6)+":"
End case 
INSP_ConvertSKCH([Standard Photos:36]Portrait:4)
If ([Standard Photos:36]Portrait:4)
	If ([Standard Photos:36]Portrait:4#$bPortrait)
		PAGE BREAK:C6
		G_PrintOptions
		$bPortrait:=True:C214
	Else 
		If ($NewPage_b)
			PAGE BREAK:C6(>)
		End if 
	End if 
	If (viInspPreviewErr=0)
		Print form:C5([Standard Photos:36]; "PrintPhotoPortrait")
	End if 
Else 
	If ([Standard Photos:36]Portrait:4#$bPortrait)
		PAGE BREAK:C6
		G_PrintOptions(2)
		$bPortrait:=False:C215
	Else 
		If ($NewPage_b)
			PAGE BREAK:C6(>)
		End if 
	End if 
	If (viInspPreviewErr=0)
		Print form:C5([Standard Photos:36]; "PrintPhotoLand")
	End if 
End if 

$0:=$bPortrait