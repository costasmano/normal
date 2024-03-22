//%attributes = {"invisible":true}
// ----------------------------------------------------
//User name (OS): Costas Manousakis
//User (4D) : Designer
//Date and time: 02/22/12, 16:16:15
// ----------------------------------------------------
//Method: ut_getFormVariables
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	//Created : 
	Mods_2012_02
	
	// Modified by: ManousakisC (7/19/2022)
	Mods_2022_09_bug
	// use name \"BMS VertCLRSign\" instead of pic if 886
End if 
//

If ((User in group:C338(Current user:C182; "Design Access Group")) & Not:C34(Is compiled mode:C492))
	C_BOOLEAN:C305(TTTTDOVARSCAN_B)
	If (TTTTDOVARSCAN_B)
		SCPOA_Variables("INIT")
		C_TIME:C306($DocRef_t)
		C_TEXT:C284(TTTTSaveVars_txt; TTTTInpVars_txt)
		C_TEXT:C284(TTTTFileName_txt)
		
		C_TEXT:C284($1)
		ARRAY TEXT:C222($objnames_atxt; 0)
		ARRAY POINTER:C280($objptrs_aptr; 0)
		ARRAY LONGINT:C221($objPage_aL; 0)
		FORM GET OBJECTS:C898($objnames_atxt; $objptrs_aptr; $objPage_aL)
		C_POINTER:C301($VarPtr)
		C_TEXT:C284($varNames_txt; $format_txt; $CompDirs_txt; $inits_txt; $loads_txt; $save_txt; $Clears_txt; $notinInput_txt; $var_0_txt; $var_txt)
		C_LONGINT:C283($loop_L; $vartype_L; $tbl_L; $fld_L)
		For ($loop_L; 1; Size of array:C274($objptrs_aptr))
			RESOLVE POINTER:C394($objptrs_aptr{$loop_L}; $var_txt; $tbl_L; $fld_L)
			If ($var_txt#"")
				$vartype_L:=Type:C295($objptrs_aptr{$loop_L}->)
				
				If ($var_txt="@_P")
					$var_0_txt:=Substring:C12($var_txt; 1; Length:C16($var_txt)-2)
				Else 
					$var_0_txt:=$var_txt
				End if 
				
				If (($var_0_txt="SCPOA_@") & ($objnames_atxt{$loop_L}#"@_btn@") & (Find in array:C230(SCPOA_SectionPage_aL; $objPage_aL{$loop_L})>0))
					
					If (($var_0_txt#"@_P") & ($objPage_aL{$loop_L}#0))
						
						If (Position:C15(("VARIABLE TO BLOB("+$var_0_txt+";$tempBlb;*)"); TTTTSaveVars_txt)>0)
							//ALERT("Variable "+$var_txt+" already saved!")
						Else 
							//ALERT("Variable "+$var_txt+" not in saved SCPOA blob!")
							$save_txt:=$save_txt+"BLOB TO VARIABLE($tempBlb;"+$var_0_txt+";$BlbOffset)"+"`  "+$1+" "+Char:C90(13)
							$loads_txt:=$loads_txt+"VARIABLE TO BLOB("+$var_0_txt+";$tempBlb;*)"+"`  "+$1+" "+Char:C90(13)
							Case of 
								: ($vartype_L=Is picture:K8:10)
									
								: ($vartype_L=Is integer:K8:5) | ($vartype_L=Is longint:K8:6)
									$Clears_txt:=$Clears_txt+$var_0_txt+":=0"+Char:C90(13)
								: ($vartype_L=Is string var:K8:2) | ($vartype_L=Is text:K8:3)
									$Clears_txt:=$Clears_txt+$var_0_txt+":="+Char:C90(Double quote:K15:41)+Char:C90(Double quote:K15:41)+Char:C90(13)
								: ($vartype_L=Is date:K8:7)
									$Clears_txt:=$Clears_txt+$var_0_txt+":=!/0/0/0000!"+Char:C90(13)
								: ($vartype_L=Is real:K8:4)
									$Clears_txt:=$Clears_txt+$var_0_txt+":=0"+Char:C90(13)
								: ($vartype_L=Real array:K8:17)
								: ($vartype_L=Text array:K8:16)
								: ($vartype_L=LongInt array:K8:19)
								: ($var_0_txt="@_P") | ($var_0_txt="@_L")
									$Clears_txt:=$Clears_txt+$var_0_txt+":=0"+Char:C90(13)
								: ($var_0_txt="@_r")
									$Clears_txt:=$Clears_txt+$var_0_txt+":=0"+Char:C90(13)
								: ($var_0_txt="@date") | ($var_0_txt="@_d")
									$Clears_txt:=$Clears_txt+$var_0_txt+":=!0/0/0000!"+Char:C90(13)
								: ($var_0_txt="@_txt") | ($var_0_txt="@_s")
									$Clears_txt:=$Clears_txt+$var_0_txt+":="+Char:C90(Double quote:K15:41)+Char:C90(Double quote:K15:41)+Char:C90(13)
								Else 
							End case 
							
						End if 
						
						If (TTTTInpVars_txt#"")
							
							If (Position:C15("SCPOA_InpFormMethod"+Char:C90(9)+$var_0_txt+Char:C90(9); TTTTInpVars_txt)>0)
								
							Else 
								//ALERT("Variable "+$var_0_txt+" not in the input form!")
								$notinInput_txt:=$notinInput_txt+$var_0_txt+Char:C90(13)
							End if 
							
						End if 
						
						
					End if 
					
				End if 
				
				Case of 
					: ($vartype_L=Is picture:K8:10)
						$CompDirs_txt:=$CompDirs_txt+"C_PICTURE("+$var_txt+")"+Char:C90(13)
						$inits_txt:=$inits_txt+"GET PICTURE FROM LIBRARY(\"BMS VertCLRSign\";"+$var_txt+")"+Char:C90(13)
					: ($vartype_L=Is integer:K8:5) | ($vartype_L=Is longint:K8:6)
						$CompDirs_txt:=$CompDirs_txt+"C_LONGINT("+$var_txt+")"+Char:C90(13)
						$inits_txt:=$inits_txt+$var_txt+":=1"+Char:C90(13)
					: ($vartype_L=Is string var:K8:2) | ($vartype_L=Is text:K8:3)
						$CompDirs_txt:=$CompDirs_txt+"C_TEXT("+$var_txt+")"+Char:C90(13)
						$inits_txt:=$inits_txt+$var_txt+":="+Char:C90(Double quote:K15:41)+"Sample text"+Char:C90(Double quote:K15:41)+Char:C90(13)
					: ($vartype_L=Is date:K8:7)
						$CompDirs_txt:=$CompDirs_txt+"C_DATE("+$var_txt+")"+Char:C90(13)
						$inits_txt:=$inits_txt+$var_txt+":=!/1/1/2011!"+Char:C90(13)
					: ($vartype_L=Is real:K8:4)
						$CompDirs_txt:=$CompDirs_txt+"C_REAL("+$var_txt+")"+Char:C90(13)
						$inits_txt:=$inits_txt+$var_txt+":=1.5"+Char:C90(13)
					: ($vartype_L=Real array:K8:17)
						$CompDirs_txt:=$CompDirs_txt+"array real("+$var_txt+";0)"+Char:C90(13)
					: ($vartype_L=Text array:K8:16)
						$CompDirs_txt:=$CompDirs_txt+"array text("+$var_txt+";0)"+Char:C90(13)
					: ($vartype_L=LongInt array:K8:19)
						$CompDirs_txt:=$CompDirs_txt+"array longint("+$var_txt+";0)"+Char:C90(13)
						
					: ($var_txt="@_P") | ($var_txt="@_L")
						$CompDirs_txt:=$CompDirs_txt+"C_LONGINT("+$var_txt+")"+Char:C90(13)
						$inits_txt:=$inits_txt+$var_txt+":=1"+Char:C90(13)
					: ($var_txt="@_r")
						$CompDirs_txt:=$CompDirs_txt+"C_REAL("+$var_txt+")"+Char:C90(13)
						$inits_txt:=$inits_txt+$var_txt+":=1.5"+Char:C90(13)
					: ($var_txt="@date") | ($var_txt="@_d")
						$CompDirs_txt:=$CompDirs_txt+"C_DATE("+$var_txt+")"+Char:C90(13)
						$inits_txt:=$inits_txt+$var_txt+":=!1/1/2012!"+Char:C90(13)
						
					: ($var_txt="@_txt") | ($var_txt="@_s")
						$CompDirs_txt:=$CompDirs_txt+"C_TEXT("+$var_txt+")"+Char:C90(13)
						$inits_txt:=$inits_txt+$var_txt+":="+Char:C90(Double quote:K15:41)+"Sample text"+Char:C90(Double quote:K15:41)+Char:C90(13)
					Else 
						$CompDirs_txt:=$CompDirs_txt+"` C_WHAT("+$var_txt+")"+Char:C90(13)
				End case 
				
				$format_txt:=OBJECT Get format:C894($objptrs_aptr{$loop_L}->)
				$varNames_txt:=$varNames_txt+$1+Char:C90(9)+$var_txt+Char:C90(9)+String:C10($objPage_aL{$loop_L})+Char:C90(9)+String:C10($vartype_L)+Char:C90(13)
				
				If ($var_txt="@_P")
					$var_txt:=Substring:C12($var_txt; 1; Length:C16($var_txt)-2)
					$VarPtr:=Get pointer:C304($var_txt)
					$vartype_L:=Type:C295($VarPtr->)
					Case of 
						: ($vartype_L=Is picture:K8:10)
							$CompDirs_txt:=$CompDirs_txt+"C_PICTURE("+$var_txt+")"+Char:C90(13)
							$inits_txt:=$inits_txt+"GET PICTURE FROM LIBRARY(\"BMS VertCLRSign\";"+$var_txt+")"+Char:C90(13)
						: ($vartype_L=Is integer:K8:5) | ($vartype_L=Is longint:K8:6)
							$CompDirs_txt:=$CompDirs_txt+"C_LONGINT("+$var_txt+")"+Char:C90(13)
							$inits_txt:=$inits_txt+$var_txt+":=1"+Char:C90(13)
						: ($vartype_L=Is string var:K8:2) | ($vartype_L=Is text:K8:3)
							$CompDirs_txt:=$CompDirs_txt+"C_TEXT("+$var_txt+")"+Char:C90(13)
							$inits_txt:=$inits_txt+$var_txt+":="+Char:C90(Double quote:K15:41)+"Sample text"+Char:C90(Double quote:K15:41)+Char:C90(13)
						: ($vartype_L=Is date:K8:7)
							$CompDirs_txt:=$CompDirs_txt+"C_DATE("+$var_txt+")"+Char:C90(13)
							$inits_txt:=$inits_txt+$var_txt+":=!/1/1/2011!"+Char:C90(13)
						: ($vartype_L=Is real:K8:4)
							$CompDirs_txt:=$CompDirs_txt+"C_REAL("+$var_txt+")"+Char:C90(13)
							$inits_txt:=$inits_txt+$var_txt+":=1.5"+Char:C90(13)
						: ($vartype_L=Real array:K8:17)
							$CompDirs_txt:=$CompDirs_txt+"array real("+$var_txt+";0)"+Char:C90(13)
						: ($vartype_L=Text array:K8:16)
							$CompDirs_txt:=$CompDirs_txt+"array text("+$var_txt+";0)"+Char:C90(13)
						: ($vartype_L=LongInt array:K8:19)
							$CompDirs_txt:=$CompDirs_txt+"array longint("+$var_txt+";0)"+Char:C90(13)
							
						: ($var_txt="@_P") | ($var_txt="@_L")
							$CompDirs_txt:=$CompDirs_txt+"C_LONGINT("+$var_txt+")"+Char:C90(13)
							$inits_txt:=$inits_txt+$var_txt+":=1"+Char:C90(13)
						: ($var_txt="@_r")
							$CompDirs_txt:=$CompDirs_txt+"C_REAL("+$var_txt+")"+Char:C90(13)
							$inits_txt:=$inits_txt+$var_txt+":=1.5"+Char:C90(13)
						: ($var_txt="@date") | ($var_txt="@_d")
							$CompDirs_txt:=$CompDirs_txt+"C_DATE("+$var_txt+")"+Char:C90(13)
							$inits_txt:=$inits_txt+$var_txt+":=!1/1/2012!"+Char:C90(13)
							
						: ($var_txt="@_txt") | ($var_txt="@_s")
							$CompDirs_txt:=$CompDirs_txt+"C_TEXT("+$var_txt+")"+Char:C90(13)
							$inits_txt:=$inits_txt+$var_txt+":="+Char:C90(Double quote:K15:41)+"Sample text"+Char:C90(Double quote:K15:41)+Char:C90(13)
						Else 
							$CompDirs_txt:=$CompDirs_txt+"` C_WHAT("+$var_txt+")"+Char:C90(13)
					End case 
					$varNames_txt:=$varNames_txt+$1+Char:C90(9)+$var_txt+Char:C90(9)+String:C10($objPage_aL{$loop_L})+Char:C90(9)+String:C10($vartype_L)+Char:C90(13)
					
				End if 
				
			End if 
			
		End for 
		
		If (OK=1)
			//TTTTFileName_txt:=Document
			If (Test path name:C476(TTTTFileName_txt+"_ObjNames")=Is a document:K24:1)
				$DocRef_t:=Append document:C265(TTTTFileName_txt+"_ObjNames")
			Else 
				$DocRef_t:=Create document:C266(TTTTFileName_txt+"_ObjNames"; "TEXT")
			End if 
			SEND PACKET:C103($DocRef_t; $varNames_txt)
			CLOSE DOCUMENT:C267($DocRef_t)
			If (Test path name:C476(TTTTFileName_txt+"_Compiler")=Is a document:K24:1)
				$DocRef_t:=Append document:C265(TTTTFileName_txt+"_Compiler")
			Else 
				$DocRef_t:=Create document:C266(TTTTFileName_txt+"_Compiler"; "TEXT")
			End if 
			SEND PACKET:C103($DocRef_t; $CompDirs_txt)
			CLOSE DOCUMENT:C267($DocRef_t)
			If (Test path name:C476(TTTTFileName_txt+"_Testinit")=Is a document:K24:1)
				$DocRef_t:=Append document:C265(TTTTFileName_txt+"_Testinit")
			Else 
				$DocRef_t:=Create document:C266(TTTTFileName_txt+"_Testinit"; "TEXT")
			End if 
			SEND PACKET:C103($DocRef_t; $inits_txt)
			CLOSE DOCUMENT:C267($DocRef_t)
			
			If (Test path name:C476(TTTTFileName_txt+"_Load")=Is a document:K24:1)
				$DocRef_t:=Append document:C265(TTTTFileName_txt+"_Load")
			Else 
				$DocRef_t:=Create document:C266(TTTTFileName_txt+"_Load"; "TEXT")
			End if 
			SEND PACKET:C103($DocRef_t; "``  "+$1+" Load var commands "+Char:C90(13))
			SEND PACKET:C103($DocRef_t; $loads_txt)
			CLOSE DOCUMENT:C267($DocRef_t)
			If (Test path name:C476(TTTTFileName_txt+"_Save")=Is a document:K24:1)
				$DocRef_t:=Append document:C265(TTTTFileName_txt+"_Save")
			Else 
				$DocRef_t:=Create document:C266(TTTTFileName_txt+"_Save"; "TEXT")
			End if 
			SEND PACKET:C103($DocRef_t; "``  "+$1+"  Save var commands "+Char:C90(13))
			SEND PACKET:C103($DocRef_t; $save_txt)
			CLOSE DOCUMENT:C267($DocRef_t)
			If (Test path name:C476(TTTTFileName_txt+"_Clear")=Is a document:K24:1)
				$DocRef_t:=Append document:C265(TTTTFileName_txt+"_Clear")
			Else 
				$DocRef_t:=Create document:C266(TTTTFileName_txt+"_Clear"; "TEXT")
			End if 
			SEND PACKET:C103($DocRef_t; "``  "+$1+"  Clear var commands "+Char:C90(13))
			SEND PACKET:C103($DocRef_t; $Clears_txt)
			CLOSE DOCUMENT:C267($DocRef_t)
			If (Test path name:C476(TTTTFileName_txt+"_Miss")=Is a document:K24:1)
				$DocRef_t:=Append document:C265(TTTTFileName_txt+"_Miss")
			Else 
				$DocRef_t:=Create document:C266(TTTTFileName_txt+"_Miss"; "TEXT")
			End if 
			SEND PACKET:C103($DocRef_t; "``  "+$1+" variables missing from input form "+Char:C90(13))
			SEND PACKET:C103($DocRef_t; $notinInput_txt)
			CLOSE DOCUMENT:C267($DocRef_t)
			
		End if 
		SCPOA_FormTester
		
	End if 
	
End if 

//End Temp_getFormVariables