//%attributes = {"invisible":true}
//Method: Print_TrimText
//Description
// Fit a text object in available space  on a print form.
// return the number of characters that the text object was trinmmed to.
// Parameters
// $0 : $Chars_L  = number of characters that the objext was trimmed to (0 = no trimming done)
// $1 : $Objvar_ptr = pointer to the text object (variable or field pointer)
// $2 : $BottomCoord_L = coord (points) of bottom of available area on page
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 12/19/16, 11:07:02
	// ----------------------------------------------------
	//Created : 
	Mods_2016_12
	C_LONGINT:C283(Print_TrimText; $0)
	C_POINTER:C301(Print_TrimText; $1)
	C_LONGINT:C283(Print_TrimText; $2)
End if 
//
C_LONGINT:C283($0)
C_POINTER:C301($1)
C_LONGINT:C283($2)

C_LONGINT:C283($trimTo_L; $BottomCoord_L)
C_POINTER:C301($Object_ptr)
$trimTo_L:=0
$Object_ptr:=$1
$BottomCoord_L:=$2

C_TEXT:C284($StartText_txt)
$StartText_txt:=$Object_ptr->
If (Length:C16($StartText_txt)>0)
	//get starting pos of object
	C_LONGINT:C283($L0; $T0; $R0; $B0; $fixed_wdth1; $wdth1; $hght1; $TextBottomNeeded_L; $HtAvail_L)
	OBJECT GET COORDINATES:C663($Object_ptr->; $L0; $T0; $R0; $B0)
	$HtAvail_L:=$BottomCoord_L
	$fixed_wdth1:=$R0-$L0  //Calculation of the text field width
	OBJECT GET BEST SIZE:C717($Object_ptr->; $wdth1; $hght1; $fixed_wdth1)
	If ($hght1>$HtAvail_L)
		//exceeds limits - need to trim
		C_REAL:C285($Ratio_r)
		C_LONGINT:C283($PageLen_L; $FirstGuess_L)
		//find how much is exceeded
		$Ratio_r:=$hght1/$HtAvail_L
		//approx chars / page (page is the max allowed area of the object)
		$PageLen_L:=Length:C16($StartText_txt)/$Ratio_r
		//try 5% over from pagelength
		$FirstGuess_L:=$PageLen_L*1.05
		//check if oversized still
		$Object_ptr->:=Substring:C12($StartText_txt; 1; $FirstGuess_L)
		OBJECT GET BEST SIZE:C717($Object_ptr->; $wdth1; $hght1; $fixed_wdth1)
		If ($hght1>$HtAvail_L)
			//ok - now we trim back
		Else 
			$Ratio_r:=1.05
			//keep adding .05% till we are over
			Repeat 
				$Ratio_r:=$Ratio_r+0.05
				$FirstGuess_L:=$PageLen_L*$Ratio_r
				$Object_ptr->:=Substring:C12($StartText_txt; 1; $FirstGuess_L)
				OBJECT GET BEST SIZE:C717($Object_ptr->; $wdth1; $hght1; $fixed_wdth1)
			Until ($hght1>$HtAvail_L)
			
		End if 
		//now start trimming the text from $FirstGuess_L back to 1
		C_LONGINT:C283($charIndx_L)
		For ($charIndx_L; $FirstGuess_L; 1; -1)
			$Object_ptr->:=Substring:C12($StartText_txt; 1; $charIndx_L)
			OBJECT GET BEST SIZE:C717($Object_ptr->; $wdth1; $hght1; $fixed_wdth1)
			If ($hght1<=$HtAvail_L)
				//done - need to check for whole word
				C_LONGINT:C283($code_L; $Code2_L)
				$code_L:=Character code:C91($StartText_txt[[$charIndx_L]])
				$Code2_L:=Character code:C91($StartText_txt[[$charIndx_L+1]])
				
				Case of 
					: (($code_L=Tab:K15:37) | ($code_L=32) | ($code_L=Carriage return:K15:38) | ($code_L=Line feed:K15:40))
						//done
					: ((Position:C15(Char:C90($code_L); ".,!?;:")>0) & (($Code2_L=Tab:K15:37) | ($Code2_L=32) | ($Code2_L=Carriage return:K15:38) | ($Code2_L=Line feed:K15:40)))
						//done
					: (($Code2_L=Tab:K15:37) | ($Code2_L=32) | ($Code2_L=Carriage return:K15:38) | ($Code2_L=Line feed:K15:40))
						//done
					Else 
						//move back until it is
						Repeat 
							$charIndx_L:=$charIndx_L-1
							$code_L:=Character code:C91($StartText_txt[[$charIndx_L]])
						Until (($code_L=Tab:K15:37) | ($code_L=32) | ($code_L=Carriage return:K15:38) | ($code_L=Line feed:K15:40))
						//update the text var
						$Object_ptr->:=Substring:C12($StartText_txt; 1; $charIndx_L)
						
				End case 
				
				$trimTo_L:=$charIndx_L
				$charIndx_L:=0
			End if 
		End for 
		
	End if 
	
End if 

$0:=$trimTo_L
//End Print_TrimText