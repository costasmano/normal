//%attributes = {"invisible":true}
C_LONGINT:C283($zzValue; $zoomValue)
C_TEXT:C284($url; $sBDEPT)
$zzValue:=16
$zoomValue:=1
$url:="http://maps.google.com/maps?f=q&source=s_q&hl=en&geocode=&q=<!--#4DVAR $brgLatVal"+"ue-->"
$url:=$url+",<!--#4DVAR $BrgLongValue-->+(<!--#4DVAR $sBDEPT-->)&ie=UTF8&z=<!--#4DVAR $zzValu"+"e-->"
$url:=$url+"&iwloc=addr@zoom=<!--#4DVAR $zoomValue-->&t=h"
C_REAL:C285($brgLatValue; $brgLongValue)
$brgLatValue:=42.499107
$brgLongValue:=-71.41893
$brgLatValue:=Round:C94($brgLatValue; 8)
$brgLongValue:=Round:C94($brgLongValue; 8)
$sBDEPT:="A02013 [26K] : ST119 /ST2 A / NASHOBA BROOK"
PROCESS 4D TAGS:C816($url; $url)
C_LONGINT:C283($Version4D_L)
$Version4D_L:=Num:C11(Substring:C12(Application version:C493; 1; 2))
If ($Version4D_L>8)
	OPEN URL:C673($url)
Else 
	OPEN URL:C673($url; *)
End if 