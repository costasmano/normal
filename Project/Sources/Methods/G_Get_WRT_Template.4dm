//%attributes = {"invisible":true}
//G_Get_WRT_Template
//Get the path to a WRT Template

C_TEXT:C284($0; $mypath)
C_TEXT:C284($1; $TemplateName)

C_LONGINT:C283($appType)  //Command Replaced was o_C_INTEGER
C_TEXT:C284($structFileName)

$TemplateName:=$1
$mypath:=""

$appType:=Application type:C494
$structFileName:=Structure file:C489

//check if running client
If ($appType=4D Remote mode:K5:5)
	$mypath:=Get 4D folder:C485(4D Client database folder:K5:13)
Else 
	$mypath:=GetPath(Structure file:C489)
End if 

If (<>PL_LPlatfrm<3)
	$mypath:=$mypath+"MAC4DX:"
Else 
	$mypath:=$mypath+"WIN4DX\\"
End if 

$mypath:=$mypath+$TemplateName

If (Test path name:C476($mypath)#Is a document:K24:1)
	$mypath:=""  //return a blank if not found
End if 


$0:=$mypath