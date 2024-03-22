//%attributes = {"invisible":true}
//Method: DEV_ConvertButtonCmd
//Description
// replace old enable/disable button and redraw list commands - return true if changes were made
// Parameters
// $0 : $NewMethod_b (method has been changed)
// $1 : $MethodText_txt
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 02/12/18, 16:48:57
	// ----------------------------------------------------
	//Created : 
	Mods_2018_02
	
	C_BOOLEAN:C305(DEV_ConvertButtonCmd; $0)
	C_POINTER:C301(DEV_ConvertButtonCmd; $1)
	// Modified by: Costas Manousakis-(Designer)-(1/25/19 10:28:08)
	Mods_2019_01_bug
	//  `added code to account for _o_ commands in the first and last line and added _o_redraw List
	// Modified by: Costas Manousakis-(Designer)-(2/13/20 11:45:30)
	Mods_2020_02_bug
	//  `Improve regex pattern to match start and end of string 
End if 
//

C_BOOLEAN:C305($0)
C_POINTER:C301($1)
C_TEXT:C284($meth_txt; $cmts_txt; $repl_txt)
C_BOOLEAN:C305($newMeth_b; $disable_b)
$newMeth_b:=False:C215

$meth_txt:=$1->

C_LONGINT:C283($loop_L; $start_L)
ARRAY LONGINT:C221($start_aL; 0)
ARRAY LONGINT:C221($len_aL; 0)
$start_L:=1
//_ o _DISABLE BUTTON
Repeat 
	$disable_b:=Match regex:C1019("(^|\r)(_o_DISABLE BUTTON)(\\()(.*)(\\))(.*)($|\r)"; $meth_txt; $start_L; $start_aL; $len_aL)
	
	If ($disable_b)
		$cmts_txt:=""
		If (Size of array:C274($start_aL)=7)
			$cmts_txt:=Substring:C12($meth_txt; $start_aL{6}; $len_aL{6})
		End if 
		$repl_txt:="OBJECT SET ENABLED("+Substring:C12($meth_txt; $start_aL{4}; $len_aL{4})+"; false)"+$cmts_txt+\
			" ` **Replaced o DISABLE BUTTON("+Substring:C12($meth_txt; $start_aL{4}; $len_aL{4})+")"+\
			Substring:C12($meth_txt; $start_aL{7}; $len_aL{7})
		
		If ($start_aL{0}>1) | ($len_aL{1}>0)
			$meth_txt:=Substring:C12($meth_txt; 1; $start_aL{0})+$repl_txt+\
				Substring:C12($meth_txt; ($start_aL{0}+$len_aL{0}))
		Else 
			$meth_txt:=$repl_txt+\
				Substring:C12($meth_txt; ($start_aL{0}+$len_aL{0}))
		End if 
		$start_L:=$start_aL{0}+Length:C16($repl_txt)-5
		$newMeth_b:=True:C214
	End if 
	
Until (Not:C34($disable_b))

$start_L:=1
//_ o _ENABLE BUTTON
Repeat 
	$disable_b:=Match regex:C1019("(^|\r)(_o_ENABLE BUTTON)(\\()(.*)(\\))(.*)($|\r)"; $meth_txt; $start_L; $start_aL; $len_aL)
	
	If ($disable_b)
		$cmts_txt:=""
		If (Size of array:C274($start_aL)=7)
			$cmts_txt:=Substring:C12($meth_txt; $start_aL{6}; $len_aL{6})
		End if 
		$repl_txt:="OBJECT SET ENABLED("+Substring:C12($meth_txt; $start_aL{4}; $len_aL{4})+"; True)"+$cmts_txt+\
			" ` **Replaced  o ENABLE BUTTON("+Substring:C12($meth_txt; $start_aL{4}; $len_aL{4})+")"+\
			Substring:C12($meth_txt; $start_aL{7}; $len_aL{7})
		
		If ($start_aL{0}>1) | ($len_aL{1}>0)
			$meth_txt:=Substring:C12($meth_txt; 1; $start_aL{0})+$repl_txt+\
				Substring:C12($meth_txt; ($start_aL{0}+$len_aL{0}))
		Else 
			$meth_txt:=$repl_txt+\
				Substring:C12($meth_txt; ($start_aL{0}+$len_aL{0}))
		End if 
		$start_L:=$start_aL{0}+Length:C16($repl_txt)-5
		$newMeth_b:=True:C214
	End if 
	
Until (Not:C34($disable_b))

$start_L:=1
//_ o _Redraw List
Repeat 
	$disable_b:=Match regex:C1019("(^|\r)(_o_REDRAW LIST)(\\()(.*)(\\))(.*)($|\r)"; $meth_txt; $start_L; $start_aL; $len_aL)
	
	If ($disable_b)
		$cmts_txt:=""
		If (Size of array:C274($start_aL)=7)
			$cmts_txt:=Substring:C12($meth_txt; $start_aL{6}; $len_aL{6})
		End if 
		$repl_txt:="REDRAW("+Substring:C12($meth_txt; $start_aL{4}; $len_aL{4})+")"+$cmts_txt+\
			" ` **Replaced o REDRAW LIST("+Substring:C12($meth_txt; $start_aL{4}; $len_aL{4})+")"+\
			Substring:C12($meth_txt; $start_aL{7}; $len_aL{7})
		
		If ($start_aL{0}>1) | ($len_aL{1}>0)
			$meth_txt:=Substring:C12($meth_txt; 1; $start_aL{0})+$repl_txt+\
				Substring:C12($meth_txt; ($start_aL{0}+$len_aL{0}))
		Else 
			$meth_txt:=$repl_txt+\
				Substring:C12($meth_txt; ($start_aL{0}+$len_aL{0}))
		End if 
		$start_L:=$start_aL{0}+Length:C16($repl_txt)-5
		$newMeth_b:=True:C214
	End if 
	
Until (Not:C34($disable_b))

If ($newMeth_b)
	$1->:=$meth_txt
End if 

$0:=$newMeth_b

//End DEV_ConvertButtonCmd