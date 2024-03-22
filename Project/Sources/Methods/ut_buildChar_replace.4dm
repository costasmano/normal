//%attributes = {"invisible":true}
// ----------------------------------------------------
//User name (OS): Costas Manousakis
//User (4D) : Designer
//Date and time: 02/12/12, 21:07:24
// ----------------------------------------------------
//Method: ut_buildChar_replace
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	//Created : 
	Mods_2012_02
End if 
//

If (User in group:C338(Current user:C182; "Design Access Group"))
	C_TEXT:C284($param_txt; $sample_txt)
	$param_txt:=""
	$sample_txt:=""
	C_LONGINT:C283($ascii_l)
	For ($ascii_l; 1; 256)
		
		Case of 
				
			: ($ascii_l=148)
				//change it to a doule quote
				//WR INSERT TEXT ($MyArea;◊sQU)
				$param_txt:=$param_txt+String:C10($ascii_l)+";"+String:C10(Character code:C91(<>sQU))+Char:C90(13)
				$sample_txt:=$sample_txt+Char:C90($ascii_l)+" "
			: ($ascii_l=165)  //bullets are OK
				$param_txt:=$param_txt+String:C10($ascii_l)+Char:C90(13)
				$sample_txt:=$sample_txt+Char:C90($ascii_l)+" "
			: ($ascii_l=177)
				//change it to a +/-
				//WR INSERT TEXT ($MyArea;"+/-")
				$sample_txt:=$sample_txt+Char:C90($ascii_l)+" "
				$param_txt:=$param_txt+String:C10($ascii_l)+";"
				$param_txt:=$param_txt+"WR SET TEXT PROPERTY ($MyArea;wr superscript or subscript ;wr superscript )"+"<WRC>"
				$param_txt:=$param_txt+"WR INSERT TEXT ($MyArea;"+<>sQU+"+"+<>sQU+")"+"<WRC>"
				$param_txt:=$param_txt+"WR SET TEXT PROPERTY ($MyArea;wr superscript or subscript ;wr none )"+"<WRC>"
				$param_txt:=$param_txt+"WR INSERT TEXT ($MyArea;"+<>sQU+"/"+<>sQU+")"+"<WRC>"
				$param_txt:=$param_txt+"WR SET TEXT PROPERTY ($MyArea;wr superscript or subscript ;wr subscript )"+"<WRC>"
				$param_txt:=$param_txt+"WR INSERT TEXT ($MyArea;"+<>sQU+"-"+<>sQU+")"+"<WRC>"
				$param_txt:=$param_txt+"WR SET TEXT PROPERTY ($MyArea;wr superscript or subscript ;wr none )"+"<WRC>"
				$param_txt:=$param_txt+Char:C90(13)
			: ($ascii_l=178)
				//change it to a +/-
				//WR INSERT TEXT ($MyArea;"+/-")
				$sample_txt:=$sample_txt+Char:C90($ascii_l)+" "
				$param_txt:=$param_txt+String:C10($ascii_l)+";"
				$param_txt:=$param_txt+"WR SET TEXT PROPERTY ($MyArea;wr underline ;1 )"+"<WRC>"
				$param_txt:=$param_txt+"WR INSERT TEXT ($MyArea;"+<>sQU+"<"+<>sQU+")"+"<WRC>"
				$param_txt:=$param_txt+"WR SET TEXT PROPERTY ($MyArea;wr underline ;0 )"+"<WRC>"
				$param_txt:=$param_txt+Char:C90(13)
			: ($ascii_l=179)  //gt or equal
				//change it to a +/-
				//WR INSERT TEXT ($MyArea;"+/-")
				$sample_txt:=$sample_txt+Char:C90($ascii_l)+" "
				$param_txt:=$param_txt+String:C10($ascii_l)+";"
				$param_txt:=$param_txt+"WR SET TEXT PROPERTY ($MyArea;wr underline ;1 )"+"<WRC>"
				$param_txt:=$param_txt+"WR INSERT TEXT ($MyArea;"+<>sQU+">"+<>sQU+")"+"<WRC>"
				$param_txt:=$param_txt+"WR SET TEXT PROPERTY ($MyArea;wr underline ;0 )"+"<WRC>"
				$param_txt:=$param_txt+Char:C90(13)
				
			: ($ascii_l=183)  //bullets are OK
				$sample_txt:=$sample_txt+Char:C90($ascii_l)+" "
				$param_txt:=$param_txt+String:C10($ascii_l)+Char:C90(13)
			: ($ascii_l=188)  //degree sign are OK
				$sample_txt:=$sample_txt+Char:C90($ascii_l)+" "
				$param_txt:=$param_txt+String:C10($ascii_l)+Char:C90(13)
			: ($ascii_l=197)  //approx sign are OK
				$sample_txt:=$sample_txt+Char:C90($ascii_l)+" "
				$param_txt:=$param_txt+String:C10($ascii_l)+Char:C90(13)
			: ($ascii_l=202)
				//WR INSERT TEXT ($MyArea;" ")
				$sample_txt:=$sample_txt+Char:C90($ascii_l)+" "
				$param_txt:=$param_txt+String:C10($ascii_l)+";"+String:C10(Character code:C91(" "))
				$param_txt:=$param_txt+Char:C90(13)
			: ($ascii_l=208)
				//WR INSERT TEXT ($MyArea;"-")
				$sample_txt:=$sample_txt+Char:C90($ascii_l)+" "
				$param_txt:=$param_txt+String:C10($ascii_l)+";"+String:C10(Character code:C91("-"))
				$param_txt:=$param_txt+Char:C90(13)
			: ($ascii_l=210)
				//change it to a doule quote
				//WR INSERT TEXT ($MyArea;◊sQU)
				$sample_txt:=$sample_txt+Char:C90($ascii_l)+" "
				$param_txt:=$param_txt+String:C10($ascii_l)+";"+String:C10(Character code:C91(<>sQU))+Char:C90(13)
			: ($ascii_l=211)
				//change it to a doule quote
				//WR INSERT TEXT ($MyArea;◊sQU)
				$sample_txt:=$sample_txt+Char:C90($ascii_l)+" "
				$param_txt:=$param_txt+String:C10($ascii_l)+";"+String:C10(Character code:C91(<>sQU))+Char:C90(13)
			: (($ascii_l=213) | ($ascii_l=212))
				//change it to a single quote
				//WR INSERT TEXT ($MyArea;Char(39))
				$sample_txt:=$sample_txt+Char:C90($ascii_l)+" "
				$param_txt:=$param_txt+String:C10($ascii_l)+";"+String:C10(Character code:C91("'"))
				$param_txt:=$param_txt+Char:C90(13)
			: (($ascii_l=218) | ($ascii_l=189))
				//change it to a 1/2
				//WR INSERT TEXT ($MyArea;"1/2")
				$sample_txt:=$sample_txt+Char:C90($ascii_l)+" "
				$param_txt:=$param_txt+String:C10($ascii_l)+";"
				$param_txt:=$param_txt+"WR SET TEXT PROPERTY ($MyArea;wr superscript or subscript ;wr superscript )"+"<WRC>"
				$param_txt:=$param_txt+"WR INSERT TEXT ($MyArea;"+<>sQU+"1"+<>sQU+")"+"<WRC>"
				$param_txt:=$param_txt+"WR SET TEXT PROPERTY ($MyArea;wr superscript or subscript ;wr none )"+"<WRC>"
				$param_txt:=$param_txt+"WR INSERT TEXT ($MyArea;"+<>sQU+"/"+<>sQU+")"+"<WRC>"
				$param_txt:=$param_txt+"WR SET TEXT PROPERTY ($MyArea;wr superscript or subscript ;wr subscript )"+"<WRC>"
				$param_txt:=$param_txt+"WR INSERT TEXT ($MyArea;"+<>sQU+"2"+<>sQU+")"+"<WRC>"
				$param_txt:=$param_txt+"WR SET TEXT PROPERTY ($MyArea;wr superscript or subscript ;wr none )"+"<WRC>"
				$param_txt:=$param_txt+Char:C90(13)
			: ($ascii_l=188)
				//change it to a 1/4
				//WR INSERT TEXT ($MyArea;"1/2")
				$sample_txt:=$sample_txt+Char:C90($ascii_l)+" "
				$param_txt:=$param_txt+String:C10($ascii_l)+";"
				$param_txt:=$param_txt+"WR SET TEXT PROPERTY ($MyArea;wr superscript or subscript ;wr superscript )"+"<WRC>"
				$param_txt:=$param_txt+"WR INSERT TEXT ($MyArea;"+<>sQU+"1"+<>sQU+")"+"<WRC>"
				$param_txt:=$param_txt+"WR SET TEXT PROPERTY ($MyArea;wr superscript or subscript ;wr none )"+"<WRC>"
				$param_txt:=$param_txt+"WR INSERT TEXT ($MyArea;"+<>sQU+"/"+<>sQU+")"+"<WRC>"
				$param_txt:=$param_txt+"WR SET TEXT PROPERTY ($MyArea;wr superscript or subscript ;wr subscript )"+"<WRC>"
				$param_txt:=$param_txt+"WR INSERT TEXT ($MyArea;"+<>sQU+"4"+<>sQU+")"+"<WRC>"
				$param_txt:=$param_txt+"WR SET TEXT PROPERTY ($MyArea;wr superscript or subscript ;wr none )"+"<WRC>"
				$param_txt:=$param_txt+Char:C90(13)
			: ($ascii_l=190)
				//change it to a 3/4
				//WR INSERT TEXT ($MyArea;"1/2")
				$sample_txt:=$sample_txt+Char:C90($ascii_l)+" "
				$param_txt:=$param_txt+String:C10($ascii_l)+";"
				$param_txt:=$param_txt+"WR SET TEXT PROPERTY ($MyArea;wr superscript or subscript ;wr superscript )"+"<WRC>"
				$param_txt:=$param_txt+"WR INSERT TEXT ($MyArea;"+<>sQU+"3"+<>sQU+")"+"<WRC>"
				$param_txt:=$param_txt+"WR SET TEXT PROPERTY ($MyArea;wr superscript or subscript ;wr none )"+"<WRC>"
				$param_txt:=$param_txt+"WR INSERT TEXT ($MyArea;"+<>sQU+"/"+<>sQU+")"+"<WRC>"
				$param_txt:=$param_txt+"WR SET TEXT PROPERTY ($MyArea;wr superscript or subscript ;wr subscript )"+"<WRC>"
				$param_txt:=$param_txt+"WR INSERT TEXT ($MyArea;"+<>sQU+"4"+<>sQU+")"+"<WRC>"
				$param_txt:=$param_txt+"WR SET TEXT PROPERTY ($MyArea;wr superscript or subscript ;wr none )"+"<WRC>"
				$param_txt:=$param_txt+Char:C90(13)
			: ($ascii_l=225)  //change this to a 'regular' bullet
				$sample_txt:=$sample_txt+Char:C90($ascii_l)+" "
				//WR INSERT TEXT ($MyArea;Char(165))
				$param_txt:=$param_txt+String:C10($ascii_l)+";"+String:C10(165)
				$param_txt:=$param_txt+Char:C90(13)
				
		End case 
		
	End for 
	QUERY:C277([Parameters:107]; [Parameters:107]ParamCode:1="CHAR_REPLACED")
	If (Records in selection:C76([Parameters:107])=1)
		CONFIRM:C162("Replace existing contents of parmaeter CHAR_REPLACED with the new one?")
		
		If (OK=1)
			If (ut_LoadRecordInteractiveV2(->[Parameters:107])=1)
				[Parameters:107]Description:2:=$param_txt
				LogChanges(->[Parameters:107]Description:2; ->[Parameters:107]ParamCode:1; ->[Parameters:107]ParamCode:1; ->[Parameters:107]ParamCode:1; 0)
				SAVE RECORD:C53([Parameters:107])
			End if 
			
		End if 
		
	End if 
	ut_BigAlert($param_txt)
	SET TEXT TO PASTEBOARD:C523($sample_txt)
	
End if 

//End temp_buildChar_replace