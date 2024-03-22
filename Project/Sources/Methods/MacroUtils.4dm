//%attributes = {"invisible":true}
//Method: MacroUtils
//  ` Method to be used in 4D macros.
// 
// Parameters
// $1 : Task for MacroUtils Method
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 01/25/12, 16:10:35
	// ----------------------------------------------------
	//Created : 
	Mods_2012_01
	// Modified by: Costas Manousakis-(Designer)-(3/4/16 13:52:20)
	Mods_2016_03_bug
	//  `added  param SQLTBL   to split a highlighted tablle and field name to a sql format [tbl].[field]
	// Modified by: Costas Manousakis-(Designer)-(5/23/16 14:56:32)
	Mods_2016_05
	//  `added CompilerDecl to make compiler declarations
	// Modified by: Costas Manousakis-(Designer)-(6/20/16 16:53:01)
	Mods_2016_06
	//  `added option "FormName" to  make  form name in [tbl];"formname" format
	// Modified by: Costas Manousakis-(Designer)-(2/3/17 15:17:16)
	Mods_2017_02
	//  `added NewName@  so that it formats the form method and object methdod; 
	//  `adjusted CompilerDecl to use wildcard to pass the method name from the macro -
	//  ` sample call is  :<text><method>MacroUtils("CompilerDecl"+"<method_name/>")</method></text>
	//  `added ModComments@  to put the current text with the method name in pasteboard so that it can be copied into a Mods_ method; 
	// Modified by: Costas Manousakis-(Designer)-(9/27/17 11:33:41)
	Mods_2017_09
	//  `fixed code in ModComments and NewName to check the method name containing left bracket
	//  //Added EndofRelease
	// Modified by: Costas Manousakis-(Designer)-(2022-06-06 16:51:07)
	Mods_2022_06
	//  `added DEV_ConvertObjectSetColor to the "RemoveObsolete" task
End if 
//

C_TEXT:C284($HeaderTask_txt)
C_TEXT:C284($isodate)
$HeaderTask_txt:="ModsRelease"
If (Count parameters:C259>0)
	C_TEXT:C284($1)
	$HeaderTask_txt:=$1
End if 
C_TEXT:C284($Output_txt; $Input_txt)
$isodate:=Substring:C12(String:C10(Current date:C33(*); ISO date:K1:8); 1; 10)

Case of 
	: ($HeaderTask_txt="ModsRelease")
		$Output_txt:="Mods_"+String:C10(Year of:C25(Current date:C33(*)))+"_"+String:C10(Month of:C24(Current date:C33(*)); "00")
		SET MACRO PARAMETER:C998(Highlighted method text:K5:18; $Output_txt)
		
	: ($HeaderTask_txt="4DUser")
		$Output_txt:=Current user:C182+" - "+Current system user:C484
		SET MACRO PARAMETER:C998(Highlighted method text:K5:18; $Output_txt)
		
	: ($HeaderTask_txt="RemoveObsolete")
		GET MACRO PARAMETER:C997(Highlighted method text:K5:18; $Output_txt)
		If (DEV_Convert_o_c_Declarations(->$Output_txt))
			SET MACRO PARAMETER:C998(Highlighted method text:K5:18; $Output_txt)
			
		End if 
		If (DEV_ConvertButtonCmd(->$Output_txt))
			SET MACRO PARAMETER:C998(Highlighted method text:K5:18; $Output_txt)
		End if 
		If (DEV_ConvertObjectSetColor(->$Output_txt))
			SET MACRO PARAMETER:C998(Highlighted method text:K5:18; $Output_txt)
		End if 
		
	: ($HeaderTask_txt="SQLTBL")
		GET MACRO PARAMETER:C997(Highlighted method text:K5:18; $Output_txt)
		If (Substring:C12($Output_txt; 1; 1)#"[")
			$Output_txt:="["+$Output_txt
		End if 
		C_LONGINT:C283($pos_RBracket_L)
		$pos_RBracket_L:=Position:C15("]"; $Output_txt)
		
		Case of 
			: ($pos_RBracket_L<=0)
				$Output_txt:=$Output_txt+"]"
			: ($pos_RBracket_L=Length:C16($Output_txt))
				//nothing left to do
			: ($pos_RBracket_L>0)
				$Output_txt:=Substring:C12($Output_txt; 1; $pos_RBracket_L)+".["+Substring:C12($Output_txt; ($pos_RBracket_L+1))+"]"
		End case 
		SET MACRO PARAMETER:C998(Highlighted method text:K5:18; $Output_txt)
		
	: ($HeaderTask_txt="FormName")
		GET MACRO PARAMETER:C997(Highlighted method text:K5:18; $Input_txt)
		If (Substring:C12($Input_txt; 1; 1)#"[")  //table not included
			$Output_txt:="\""+$Input_txt
		Else 
			$Output_txt:=$Input_txt
		End if 
		C_LONGINT:C283($pos_RBracket_L)
		$pos_RBracket_L:=Position:C15("]"; $Output_txt)
		
		C_LONGINT:C283($Period_L)
		
		Case of 
			: ($pos_RBracket_L<=0)
				$Period_L:=Position:C15("."; $Output_txt)
				If ($Period_L>0)
					//replace the "." with a quote +"." - unless it 
					$Output_txt:=Replace string:C233($Output_txt; "."; "\".")
				Else 
					$Output_txt:=$Output_txt+"\""  //just add the end quote
				End if 
				
			: ($pos_RBracket_L=Length:C16($Output_txt))
				//only a table?? 
				$Output_txt:=$Input_txt  //leave as is
			: ($pos_RBracket_L>0)
				
				If (Substring:C12($Output_txt; ($pos_RBracket_L+1); 1)=".")
					//we have an object notation
					$Output_txt:=Substring:C12($Output_txt; 1; $pos_RBracket_L)+";\""+Substring:C12($Output_txt; ($pos_RBracket_L+2))
					//check for another "."
					$Period_L:=Position:C15("."; $Output_txt)
					
					If ($Period_L>0)
						//replace the "." with a quote +"." - unless it 
						$Output_txt:=Replace string:C233($Output_txt; "."; "\".")
					Else 
						$Output_txt:=$Output_txt+"\""  //just add the end quote
					End if 
					
				Else 
					$Output_txt:=Substring:C12($Output_txt; 1; $pos_RBracket_L)+";\""+Substring:C12($Output_txt; ($pos_RBracket_L+1))+"\""
					
				End if 
				
		End case 
		
		SET MACRO PARAMETER:C998(Highlighted method text:K5:18; $Output_txt)
		
	: ($HeaderTask_txt="BMSVer")
		$Output_txt:="````"+Char:C90(13)
		$Output_txt:=$Output_txt+"````   **** End of Release "+<>Version+Char:C90(13)
		$Output_txt:=$Output_txt+"````"+Char:C90(13)
		
		SET MACRO PARAMETER:C998(Highlighted method text:K5:18; $Output_txt)
		
	: ($HeaderTask_txt="CompilerDecl@")
		
		C_TEXT:C284($Name_txt)
		$Name_txt:=Replace string:C233($HeaderTask_txt; "CompilerDecl"; "")
		//C_TEXT($2)  ` current method name
		GET MACRO PARAMETER:C997(Highlighted method text:K5:18; $Output_txt)
		//find first "("
		C_LONGINT:C283($Pos_Paren)
		$Pos_Paren:=Position:C15("("; $Output_txt)
		
		If ($Pos_Paren>1)
			$Output_txt:=Substring:C12($Output_txt; 1; $Pos_Paren)+$Name_txt+";"+Substring:C12($Output_txt; ($Pos_Paren+1))
		End if 
		
		SET MACRO PARAMETER:C998(Highlighted method text:K5:18; $Output_txt)
		
	: ($HeaderTask_txt="NewName@")
		C_TEXT:C284($NewName_txt; $Name_txt; $Base_txt)
		$NewName_txt:=Replace string:C233($HeaderTask_txt; "NewName"; "")
		//ALERT($2)
		C_LONGINT:C283($Bracket_L)
		$Bracket_L:=Position:C15("["; $NewName_txt)
		
		Case of 
			: (($NewName_txt="Form Method@") | ($NewName_txt="Object Method@") | ($Bracket_L=1))
				//find "["
				If ($Bracket_L>0)
					$Name_txt:=Substring:C12($NewName_txt; $Bracket_L)
					$Base_txt:=Substring:C12($NewName_txt; 1; ($Bracket_L-1))
					C_LONGINT:C283($pos_RBracket_L)
					$pos_RBracket_L:=Position:C15("]"; $Name_txt)
					
					Case of 
						: ($pos_RBracket_L<=0)
							$Name_txt:=$Name_txt+"\""
						: ($pos_RBracket_L=Length:C16($Name_txt))
							//only a table?? 
							$Name_txt:=$Name_txt  //leave as is
						: ($pos_RBracket_L>0)
							
							If (Substring:C12($Name_txt; ($pos_RBracket_L+1); 1)=".")
								//we have an object notation
								$Name_txt:=Substring:C12($Name_txt; 1; $pos_RBracket_L)+";\""+Substring:C12($Name_txt; ($pos_RBracket_L+2))
								//check for another "."
								C_LONGINT:C283($Period_L)
								$Period_L:=Position:C15("."; $Name_txt)
								
								If ($Period_L>0)
									//replace the "." with a quote +"." - unless it 
									$Name_txt:=Replace string:C233($Name_txt; "."; "\".")
								Else 
									$Name_txt:=$Name_txt+"\""  //just add the end quote
								End if 
								
							Else 
								$Name_txt:=Substring:C12($Name_txt; 1; $pos_RBracket_L)+";\""+Substring:C12($Name_txt; ($pos_RBracket_L+1))+"\""
								
							End if 
							
					End case 
					$NewName_txt:=$Base_txt+$Name_txt
				End if 
		End case 
		
		SET MACRO PARAMETER:C998(Highlighted method text:K5:18; "` "+$NewName_txt)
		
	: ($HeaderTask_txt="ModComments@")
		C_TEXT:C284($NewName_txt; $Name_txt; $Base_txt)
		$NewName_txt:=Replace string:C233($HeaderTask_txt; "ModComments"; "")
		//ALERT($2)
		C_LONGINT:C283($Bracket_L)
		$Bracket_L:=Position:C15("["; $NewName_txt)
		
		Case of 
			: (($NewName_txt="Form Method@") | ($NewName_txt="Object Method@") | ($Bracket_L=1))
				//find "["
				If ($Bracket_L>0)
					$Name_txt:=Substring:C12($NewName_txt; $Bracket_L)
					$Base_txt:=Substring:C12($NewName_txt; 1; ($Bracket_L-1))
					C_LONGINT:C283($pos_RBracket_L)
					$pos_RBracket_L:=Position:C15("]"; $Name_txt)
					
					Case of 
						: ($pos_RBracket_L<=0)
							$Name_txt:=$Name_txt+"\""
						: ($pos_RBracket_L=Length:C16($Name_txt))
							//only a table?? 
							$Name_txt:=$Name_txt  //leave as is
						: ($pos_RBracket_L>0)
							
							If (Substring:C12($Name_txt; ($pos_RBracket_L+1); 1)=".")
								//we have an object notation
								$Name_txt:=Substring:C12($Name_txt; 1; $pos_RBracket_L)+";\""+Substring:C12($Name_txt; ($pos_RBracket_L+2))
								//check for another "."
								C_LONGINT:C283($Period_L)
								$Period_L:=Position:C15("."; $Name_txt)
								
								If ($Period_L>0)
									//replace the "." with a quote +"." - unless it 
									$Name_txt:=Replace string:C233($Name_txt; "."; "\".")
								Else 
									$Name_txt:=$Name_txt+"\""  //just add the end quote
								End if 
								
							Else 
								$Name_txt:=Substring:C12($Name_txt; 1; $pos_RBracket_L)+";\""+Substring:C12($Name_txt; ($pos_RBracket_L+1))+"\""
								
							End if 
							
					End case 
					$NewName_txt:=$Base_txt+$Name_txt
				End if 
		End case 
		
		GET MACRO PARAMETER:C997(Highlighted method text:K5:18; $output_txt)
		$output_txt:="` "+$NewName_txt+Char:C90(13)+$output_txt
		SET TEXT TO PASTEBOARD:C523($output_txt)
		
	: ($HeaderTask_txt="EndofRelease")
		$Output_txt:=""
		$Output_txt:=$Output_txt+Char:C90(13)+"````"
		$Output_txt:=$Output_txt+Char:C90(13)+"````    **** End of Release "+<>Version
		$Output_txt:=$Output_txt+Char:C90(13)+"````"
		$Output_txt:=$Output_txt+Char:C90(13)
		
		SET MACRO PARAMETER:C998(Highlighted method text:K5:18; $Output_txt)
		
	: ($HeaderTask_txt="ISODATE")
		SET MACRO PARAMETER:C998(Highlighted method text:K5:18; Substring:C12(String:C10(Current date:C33(*); ISO date:K1:8); 1; 10))
	: ($HeaderTask_txt="Mymods")
		$Output_txt:="`**********`Modified by: "+Current system user:C484+"-("+Current user:C182+")-("+$isodate+")\r"
		SET MACRO PARAMETER:C998(Highlighted method text:K5:18; $Output_txt)
	: ($HeaderTask_txt="Codemodif")
		$Output_txt:="` Modified by: "+Current system user:C484+"-("+Current user:C182+")-("+$isodate+" "+String:C10(Current time:C178(*))+")\r"+\
			"Mods_"+String:C10(Year of:C25(Current date:C33(*)))+"_"+String:C10(Month of:C24(Current date:C33(*)); "00")+"\r"+\
			"//  `"
		SET MACRO PARAMETER:C998(Highlighted method text:K5:18; $Output_txt)
		
	: ($HeaderTask_txt="MethodInit@")
		C_TEXT:C284($Name_txt)
		$Name_txt:=Replace string:C233($HeaderTask_txt; "MethodInit"; "")
		$Output_txt:="// Method: "+$Name_txt+"\r"+\
			"// Description\r"+\
			"//\r"+\
			"  //\r"+\
			"// Parameters\r"+\
			"// ----------------------------------------------------\r"+\
			"If (False)\r"+\
			"// ----------------------------------------------------\r"+\
			"// User name (OS): "+Current system user:C484+"\r"+\
			"// User name (4D): "+Current user:C182+"\r"+\
			"// Date and time: "+$isodate+", "+String:C10(Current time:C178(*))+"\r"+\
			"// ----------------------------------------------------\r"+\
			"// First Release\r"+\
			"ModsRelease"+"\r"+\
			"End if\r"+\
			"\r"+\
			"\r"+\
			"` End of "+$Name_txt
		SET MACRO PARAMETER:C998(Highlighted method text:K5:18; $Output_txt)
		
	Else 
		SET MACRO PARAMETER:C998(Highlighted method text:K5:18; "`` Bad Param passed to MacroUtils :"+$HeaderTask_txt)
End case 

//End MacroUtils