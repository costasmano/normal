//%attributes = {"invisible":true}
If (False:C215)
	//f_Var_to_Series
	//Convert a character to a series of char variables either X or blank
	//$1 : String variable Alpha 1
	//$2 : Root of Char variable series Alpha 30
	//$3 : Character list Alpha 30
	//$4 : Default char - optional
	Mods_2012_02  //r002   `Fix bug where resolve pointer not retuning corect data
	//Modified by: Charles Miller (2/9/12 14:43:44)
End if 

C_TEXT:C284($1; $4; $vsVar; $vsDefCh)  // Command Replaced was o_C_STRING length was 1
C_TEXT:C284($2; $3; $vRoot; $vSrchStr)  // Command Replaced was o_C_STRING length was 30
C_POINTER:C301($pvar)
C_BOOLEAN:C305($bPtrOK)
C_LONGINT:C283($i; $vPos; $NumOpts)  //Command Replaced was o_C_INTEGER
C_TEXT:C284($pvName)  // Command Replaced was o_C_STRING length was 32
C_LONGINT:C283($vPN; $vpF)

$vsVar:=$1
$vRoot:=$2
$vSrchStr:=$3
$vsDefCh:=""
If (Count parameters:C259>3)
	$vsDefCh:=$4
End if 
$NumOpts:=Length:C16($vSrchStr)
$vPos:=Position:C15($vsVar; $vSrchStr)
If (($vPos<=0) & ($vsDefCh#""))
	If (Position:C15($vsDefCh; $vSrchStr)>0)
		$vPos:=Position:C15($vsDefCh; $vSrchStr)
	End if 
End if 

For ($i; 1; $NumOpts)
	$pvar:=Get pointer:C304($vRoot+String:C10($i))
	//RESOLVE POINTER($pvar;$pvName;$vPN;$vPF)
	$bPtrOK:=(Type:C295($pvar->)#5)
	//$bPtrOK:=($pvName=($vRoot+String($i)))
	If ($bPtrOK)
		If ($i=$vPos)
			$pvar->:="X"
		Else 
			$pvar->:=""
		End if 
	End if 
End for 
