//%attributes = {"invisible":true}
//Method: DEV_Convert_o_c_Declarations
//Description
// replace old compiler declarations - return true if changes were made
// Parameters
// $0 : $NewMethod_b (method has been changed)
// $1 : $MethodText_txt
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 02/12/18, 17:02:38
	// ----------------------------------------------------
	//Created : 
	Mods_2018_02
	
	C_BOOLEAN:C305(DEV_Convert_o_c_Declarations; $0)
	C_POINTER:C301(DEV_Convert_o_c_Declarations; $1)
	
	// Modified by: Costas Manousakis-(Designer)-(1/25/19 16:50:11)
	Mods_2019_01_bug
	//  `added separate searches for first line and last line.
	// Modified by: Costas Manousakis-(Designer)-(2/12/20 17:48:16)
	Mods_2020_02_bug
	//  `Fixed search patterns to handle begin and end of string
End if 
//

C_BOOLEAN:C305($0)
C_POINTER:C301($1)
C_TEXT:C284($meth_txt; $cmts_txt; $temp_txt; $repl_txt)
C_BOOLEAN:C305($newMeth_b; $disable_b)
$newMeth_b:=False:C215

$meth_txt:=$1->

C_LONGINT:C283($loop_L; $start_L)
ARRAY LONGINT:C221($start_aL; 0)
ARRAY LONGINT:C221($len_aL; 0)

//_ o _C_INTEGER
$start_L:=1

Repeat 
	$disable_b:=Match regex:C1019("(^|\r)(_o_C_INTEGER)(\\()(.*)(\\))(.*)($|\r)"; $meth_txt; $start_L; $start_aL; $len_aL)
	
	If ($disable_b)
		
		$cmts_txt:=""
		If (Size of array:C274($start_aL)=7)
			$cmts_txt:=Substring:C12($meth_txt; $start_aL{6}; $len_aL{6})
		End if 
		
		$repl_txt:="C_LONGINT("+Substring:C12($meth_txt; $start_aL{4}; $len_aL{4})+")"+\
			$cmts_txt+" ` **Replaced old C_INTEGER()"+\
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

//_ o _C_STRING
$start_L:=1

Repeat 
	$disable_b:=Match regex:C1019("(^|\r)(_o_C_STRING)(\\()(\\d+);(.*)(\\))(.*)($|\r)"; $meth_txt; $start_L; $start_aL; $len_aL)
	
	If ($disable_b)
		
		$cmts_txt:=""
		If (Size of array:C274($start_aL)=8)
			$cmts_txt:=Substring:C12($meth_txt; $start_aL{7}; $len_aL{7})
		End if 
		$repl_txt:="C_TEXT("+Substring:C12($meth_txt; $start_aL{5}; $len_aL{5})+")"+$cmts_txt+\
			" ` **Replaced old C_STRING length "+Substring:C12($meth_txt; $start_aL{4}; $len_aL{4})+\
			Substring:C12($meth_txt; $start_aL{8}; $len_aL{8})
		
		If ($start_aL{0}>1) | ($len_aL{1}>0)
			$meth_txt:=Substring:C12($meth_txt; 1; ($start_aL{0}))+$repl_txt+Substring:C12($meth_txt; ($start_aL{0}+$len_aL{0}))
		Else 
			$meth_txt:=$repl_txt+Substring:C12($meth_txt; ($start_aL{0}+$len_aL{0}))
		End if 
		
		$start_L:=$start_aL{0}+Length:C16($repl_txt)-5  //+$len_aL{0}  //+Length("` CommandReplaced ")
		$newMeth_b:=True:C214
	End if 
	
Until (Not:C34($disable_b))

//_ o _C_STRING(Method;
$start_L:=1

Repeat 
	$disable_b:=Match regex:C1019("(^|\r)(_o_C_STRING)(\\()(.*);(\\d+);(.*)(\\))(.*)($|\r)"; $meth_txt; $start_L; $start_aL; $len_aL)
	
	If ($disable_b)
		
		$cmts_txt:=""
		If (Size of array:C274($start_aL)=8)
			$cmts_txt:=Substring:C12($meth_txt; $start_aL{8}; $len_aL{8})
		End if 
		$repl_txt:="C_TEXT("+Substring:C12($meth_txt; $start_aL{4}; $len_aL{4})+";"+Substring:C12($meth_txt; $start_aL{6}; $len_aL{6})+")"+\
			$cmts_txt+" ` **Replaced old C_STRING length "+Substring:C12($meth_txt; $start_aL{5}; $len_aL{5})+\
			Substring:C12($meth_txt; $start_aL{9}; $len_aL{9})
		
		If ($start_aL{0}>1) | ($len_aL{1}>0)
			$meth_txt:=Substring:C12($meth_txt; 1; ($start_aL{0}))+$repl_txt+Substring:C12($meth_txt; ($start_aL{0}+$len_aL{0}))
		Else 
			$meth_txt:=$repl_txt+Substring:C12($meth_txt; ($start_aL{0}+$len_aL{0}))
		End if 
		
		$start_L:=$start_aL{0}+Length:C16($repl_txt)-5
		$newMeth_b:=True:C214
	End if 
	
Until (Not:C34($disable_b))

//_ o _ARRAY STRING
$start_L:=1

Repeat 
	$disable_b:=Match regex:C1019("(^|\r)(_o_ARRAY STRING)(\\()(\\d+);(.*)(\\))(.*)($|\r)"; $meth_txt; $start_L; $start_aL; $len_aL)
	
	If ($disable_b)
		
		$cmts_txt:=""
		If (Size of array:C274($start_aL)=8)
			$cmts_txt:=Substring:C12($meth_txt; $start_aL{7}; $len_aL{7})
		End if 
		$repl_txt:="ARRAY TEXT("+Substring:C12($meth_txt; $start_aL{5}; $len_aL{5})+")"+$cmts_txt+\
			" ` **Replaced old ARRAY STRING length "+Substring:C12($meth_txt; $start_aL{4}; $len_aL{4})+\
			Substring:C12($meth_txt; $start_aL{8}; $len_aL{8})
		
		If ($start_aL{0}>1) | ($len_aL{1}>0)
			$meth_txt:=Substring:C12($meth_txt; 1; ($start_aL{0}))+$repl_txt+Substring:C12($meth_txt; ($start_aL{0}+$len_aL{0}))
		Else 
			$meth_txt:=$repl_txt+Substring:C12($meth_txt; ($start_aL{0}+$len_aL{0}))
		End if 
		
		$start_L:=$start_aL{0}+Length:C16($repl_txt)-5
		$newMeth_b:=True:C214
	End if 
	
Until (Not:C34($disable_b))

If ($newMeth_b)
	$1->:=$meth_txt
End if 

$0:=$newMeth_b

//End DEV_Convert_o_c_Declarations