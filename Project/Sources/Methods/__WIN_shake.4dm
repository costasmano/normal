//%attributes = {}
C_LONGINT:C283(\
$wLeft_l; $wTop_l; $wRight_l; $wBottom_l; \
$shakeOffset_l; \
$delay_l; \
$shakeCount_l; \
$loop_l)

GET WINDOW RECT:C443($wLeft_l; $wTop_l; $wRight_l; $wBottom_l; Current form window:C827)

$shakeOffset_l:=10
$delay_l:=2
$shakeCount_l:=4

For ($loop_l; 1; $shakeCount_l)
	SET WINDOW RECT:C444($wLeft_l-$shakeOffset_l; $wTop_l; $wRight_l-$shakeOffset_l; $wBottom_l; Current form window:C827)
	DELAY PROCESS:C323(Current process:C322; $delay_l)
	SET WINDOW RECT:C444($wLeft_l+$shakeOffset_l; $wTop_l; $wRight_l+$shakeOffset_l; $wBottom_l; Current form window:C827)
	DELAY PROCESS:C323(Current process:C322; $delay_l)
End for 

SET WINDOW RECT:C444($wLeft_l; $wTop_l; $wRight_l; $wBottom_l)

