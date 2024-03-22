//%attributes = {}

C_LONGINT:C283($0; $credentialOK_l; $vlElem)
$credentialOK_l:=0
C_TEXT:C284($1; $userName_t)
$userName_t:=$1
C_TEXT:C284($2; $userPass_t)
$userPass_t:=$2


GET USER LIST:C609($atUserName; $alUserID)
$vlElem:=Find in array:C230($atUserName; $userName_t)
If ($vlElem>0)
	If (Validate password:C638($alUserID{$vlElem}; $userPass_t))
		$credentialOK_l:=1
	Else 
		$credentialOK_l:=0
	End if 
Else 
	$credentialOK_l:=-1
End if 


$0:=$credentialOK_l
