//%attributes = {"invisible":true}
//Method: DEV_ConvertObjectSetColor
//Description
// convert Object set color to Object set rgb colors
// Parameters
// $0 : $NewMethod_b (method has been changed)
// $1 : $MethodText_ptr
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 2021-12-07T00:00:00, 20:27:44
	// ----------------------------------------------------
	//Created : 
	Mods_2021_12_bug
	
	C_BOOLEAN:C305(DEV_ConvertObjectSetColor; $0)
	C_POINTER:C301(DEV_ConvertObjectSetColor; $1)
End if 
//
//OBJECT SET COLOR
//_ o _OBJECT SET COLOR
//OBJECT SET RGB COLORS
//Col_paletteToRGB
C_BOOLEAN:C305($0)
C_POINTER:C301($1)
C_TEXT:C284($meth_txt; $cmts_txt; $repl_txt; $params; $ColorParam; $for_; $back_)
C_BOOLEAN:C305($newMeth_b; $disable_b)
$newMeth_b:=False:C215

$meth_txt:=$1->

C_LONGINT:C283($loop_L; $start_L; $ColorParam_L; $for_L; $back_L)
ARRAY LONGINT:C221($start_aL; 0)
ARRAY LONGINT:C221($len_aL; 0)
$start_L:=1

Repeat 
	$disable_b:=Match regex:C1019("(^|\r)(\t*)(_O_OBJECT SET COLOR)(\\()(.*)(\\))(.*)($|\r)"; $meth_txt; $start_L; $start_aL; $len_aL)
	
	If ($disable_b)
		$cmts_txt:=""
		ARRAY TEXT:C222($parts_atxt; Size of array:C274($start_aL))
		C_LONGINT:C283($parts_L)
		For ($parts_L; 1; Size of array:C274($parts_atxt))
			$parts_atxt{$parts_L}:=Substring:C12($meth_txt; $start_aL{$parts_L}; $len_aL{$parts_L})
		End for 
		
		If (Size of array:C274($start_aL)=8)
			$cmts_txt:=Substring:C12($meth_txt; $start_aL{7}; $len_aL{7})
		End if 
		$params:=Substring:C12($meth_txt; $start_aL{5}; $len_aL{5})
		ARRAY TEXT:C222($params_atxt; 0)
		ut_NewTextToArray($params; ->$params_atxt; ";")  //split parameters by the ;
		$ColorParam:=$params_atxt{Size of array:C274($params_atxt)}
		$for_:="Col_paletteToRGB (Abs("+$ColorParam+")%256)"
		$back_:="Col_paletteToRGB (Abs("+$ColorParam+")\\256)"
		
		If (Size of array:C274($params_atxt)>2)
			//1st param is a *
			$repl_txt:=$parts_atxt{2}+"OBJECT SET RGB COLORS(*;"+$params_atxt{2}+";"+$for_+";"+$back_+")"+$cmts_txt+\
				" ` **Replaced o OBJECT SET COLOR("+Substring:C12($meth_txt; $start_aL{5}; $len_aL{5})+")"+\
				Substring:C12($meth_txt; $start_aL{8}; $len_aL{8})
			
		Else 
			
			$repl_txt:=$parts_atxt{2}+"OBJECT SET RGB COLORS("+$params_atxt{1}+";"+$for_+";"+$back_+")"+$cmts_txt+\
				" ` **Replaced o OBJECT SET COLOR("+Substring:C12($meth_txt; $start_aL{5}; $len_aL{5})+")"+\
				Substring:C12($meth_txt; $start_aL{8}; $len_aL{8})
			
		End if 
		
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

//End DEV_ConvertObjectSetColor