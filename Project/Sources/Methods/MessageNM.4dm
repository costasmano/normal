//%attributes = {"invisible":true}
If (False:C215)
	//procedure: MessageNM  
	//create a nonmodal window for messages
	//created: 11/3/97
	//by: Albert Leung
End if 

C_TEXT:C284($Message)
C_LONGINT:C283($Len; $hMarg; $vMarg; $Width; $Height)

$Message:=$1
$Len:=Length:C16($Message)
If ($Len>50)
	$Len:=50
End if 
$hMarg:=1
$vMarg:=2
$Width:=($Len+(2*$hMarg))*6  //6 pixels per character wide.
$Height:=(1+(2*$vMarg))*11  //11 pixels per line high.
NewWindow($Width; $Height; 0; -5)
GOTO XY:C161($hMarg; $vMarg)
MESSAGE:C88(Substring:C12($Message; 1; $Len))
