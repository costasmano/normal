//%attributes = {"invisible":true}
// Method: WRUTIL_Function
// Description
// Perform various functions in a 4D Write area
// Parameters
// $0 : $Result_b
// $1 : $MyArea
// $2 : $Function ("RESETFONTSIZE" | "CLEANCHARS" | "ZOOM"| "SHOWMENUBAR")
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 09/05/08, 08:09:53
	
	Mods_2008_CM_5404  // ("INSPCMMTS")
	// Modified by: costasmanousakis-(Designer)-(11/29/09 11:26:50)
	Mods_2009_12
	//Enhanced the CLEANCHARS functions to handle special characters
	// Modified by: costasmanousakis-(Designer)-(12/14/09 10:27:56)
	Mods_2009_12
	//Added Char 211 for Mac cleanchar; do the same translations for Mac and Win
	//Also added code to copy and then re-apply all the paragraph settings. They get 
	//destroyed when characters are re-typed.  Big problem are the 1/4 , 3/4 fractions that
	//apparently have ascii code 63 = "?"
	// Modified by: costasmanousakis-(Designer)-(12/15/09 22:18:48)
	Mods_2009_12
	//  `Added function  "ZOOM"
	//  `Changed the CleanChars  to loop thru the text backwards. Then we don't need a repeat loop
	//  `Removed the condition to check for platform.
	// Modified by: costasmanousakis-(Designer)-(1/8/10 11:31:43)
	Mods_2010_01
	//  `added a 'busy' cursor while cleaning. ; `approx sign are OK
	// Modified by: costasmanousakis-(Designer)-(1/14/10 08:53:58)
	Mods_2010_01
	//  `Changed the Alert to ut_BigAlert for more text. In the message include the enclosing text.
	//  ` Also make the character font 22 and change to green fgd/red bkd.
	// Modified by: costasmanousakis-(Designer)-(2/1/10 15:37:18)
	Mods_2010_02
	//For the "ZOOM" option  added cases for the On load event to initialize the zoom dropdown
	//and the remember the last zoom used for this dropdown
	// Modified by: costasmanousakis-(Designer)-(9/2/10 09:40:13)
	Mods_2010_09
	//  `Added Function "SHOWMENUBAR"
	Mods_2011_06  // CJ Miller`06/14/11, 13:25:05      ` Type all local variables for v11
	// Modified by: costasmanousakis-(Designer)-(11/3/11 09:39:18)
	Mods_2011_11
	//  `Added codes 202 and 210 in Cleanchars function
	// Modified by: costasmanousakis-(Designer)-(11/10/11 08:28:27)
	Mods_2011_11
	//  `Enabled Cleanchars for all users
	// Modified by: costasmanousakis-(Designer)-(12/2/11 16:52:02)
	Mods_2011_12
	//  `Make sure right par margin is not less than zero
	// Modified by: Costas Manousakis-(Designer)-(2/2/12 10:12:31)
	Mods_2012_01
	//  `Removed  WR INSERT TEXT ($MyArea;Char($ascii_l)) - was causing changes in formatting
	// Modified by: Costas Manousakis-(Designer)-(2/10/12 19:44:03)
	Mods_2012_02
	//  `Added code for the Plus minus sign;  Use a system parameter CHAR_REPLACED to get the 
	//  `ascii replacement codes
	// Modified by: Costas Manousakis-(Designer)-(2/29/12 14:56:25)
	Mods_2012_02
	//  `Modified coding so that ClenChars can do replacements using embeded WR commands in the CHAR_REPLACED
	//  `parameter. Allows to enter superscript, subscript, underlines etc for better representation of special characters 
	// Modified by: Costas Manousakis-(Designer)-(5/9/12 15:58:36)
	Mods_2012_05
	//  `Added Function "FORMATPULLDOWN"
	// Modified by: Costas Manousakis-(Designer)-(11/2/12 15:31:58)
	Mods_2012_11
	//  `Added debug text copied to clipboard for design users in the CLEANCHARS code 
	// Modified by: Costas Manousakis-(Designer)-(4/9/13 08:43:22)
	Mods_2013_04
	//  `Added process var WRUTIL_WRArea_L because EXECUTE FORMULA cannot refer to the local variable $MyArea in a compiled db
	//  `must change parameter CHAR_REPLACED to use the new variable
	// Modified by: Costas Manousakis-(Designer)-(4/30/14 17:00:14)
	Mods_2014_04
	//  `In the FORMATPULLDOWN added  Get Plain text, Save and Load options for Design users;
	//  `Also added functions "GETPLAINTEXT" , "SAVEAS" ,"LOADFROM"
	// Modified by: Costas Manousakis-(Designer)-(5/1/14 16:13:14)
	Mods_2014_05_bug
	//  `to fix crashing bug when  printing comments, added code  in CLEANCHARS to remove all negative tabs in the 4D write areas
	// Modified by: Costas Manousakis-(Designer)-(4/14/16 12:48:18)
	Mods_2016_04_bug
	//  `Added code in "CLEANCHARS" to address "?"  which could be a foot or inch mark - look in the styled text last two bytes
	// Modified by: Costas Manousakis-(Designer)-(10/21/16 16:35:08)
	Mods_2016_10
	//  `Added code in CLEANCHARS to remove bullets that are to the left of the left margin
	// Modified by: Costas Manousakis-(Designer)-(6/22/17 14:27:55)
	Mods_2017_06_bug
	//  `for ZOOM function store the selected factor index in a process variable - use REDRAW WINDOW to update the view
	//  //for CLEANCHARS don't mark any more the bad characters
	// Modified by: Costas Manousakis-(Designer)-(10/29/19 11:41:51)
	Mods_2019_10_bug
	//  `added cases for codes 8211 (dash) , 8217 (single quote) 8220,8221 (double quote)
	Mods_2021_Delete
	
End if 
//C_BOOLEAN($0;$Result_b)
//C_LONGINT($1;$MyArea)
//C_LONGINT(WRUTIL_WRArea_L)
//C_TEXT($2;$Function)
//$MyArea:=$1
//WRUTIL_WRArea_L:=$MyArea
//$Function:=$2
//$Result_b:=False
//C_LONGINT($uniform)  // **replaced _ o _C_INTEGER()
//Case of 
//: ($Function="FORMATPULLDOWN")
//C_POINTER($3;$Format_ptr)
//$Format_ptr:=$3
//C_LONGINT($Pick_L)
//Case of 
//: (Form event=On Load)
//$Format_ptr->:=0

//If (User in group(Current user;"Design Access Group"))

//If (Find in array($Format_ptr->;"Get Plain Text")>0)
//Else 
//APPEND TO ARRAY($Format_ptr->;"Get Plain Text")
//APPEND TO ARRAY($Format_ptr->;"Save document")
//APPEND TO ARRAY($Format_ptr->;"Load Document")
//End if 

//End if 

//: (Form event=On Clicked)
//Case of 
//: ($Format_ptr->=1)
//WR EXECUTE COMMAND ($MyArea;wr cmd character)
//: ($Format_ptr->=2)
//WR EXECUTE COMMAND ($MyArea;wr cmd paragraph)
//: ($Format_ptr->=3)
//WR EXECUTE COMMAND ($MyArea;wr cmd tabs)
//: ($Format_ptr->=4)
//WR EXECUTE COMMAND ($MyArea;wr cmd borders)
//: ($Format_ptr->=5)
//WRUTIL_Function ($MyArea;"GETPLAINTEXT")
//: ($Format_ptr->=6)
//WRUTIL_Function ($MyArea;"SAVEAS")
//: ($Format_ptr->=7)
//WRUTIL_Function ($MyArea;"LOADFROM")

//End case 
//GOTO OBJECT($MyArea)

//End case 
//: ($Function="GETPLAINTEXT")
//C_LONGINT($numChars_L)
//C_TEXT($plain_txt)
//$numChars_L:=WR Count ($MyArea;wr nb characters)
//C_BOOLEAN($GetPlaintxt_b)
//$GetPlaintxt_b:=True
//If ($numChars_L>32000)
//CONFIRM("There are more than 32,000 characters in the area ("+String($numChars_L;"###,###,###")+")! Only 1st 32,000 will be copied! "+" Continue?";"Continue")
//$GetPlaintxt_b:=(OK=1)
//End if 
//If ($GetPlaintxt_b)
//$plain_txt:=WR Get text ($MyArea;0;32000)
//WR EXECUTE COMMAND ($MyArea;wr cmd new)
//Set Doc Margins ($MyArea)
//WR INSERT TEXT ($MyArea;$plain_txt)
//End if 

//: ($Function="SAVEAS")
//WR SAVE DOCUMENT ($MyArea;"")

//: ($Function="LOADFROM")
//WR EXECUTE COMMAND ($MyArea;wr cmd new)
//Set Doc Margins ($MyArea)
//WR OPEN DOCUMENT ($MyArea;"")

//: ($Function="ZOOM")

//C_POINTER($3;$ZoomArr_ptr)
//$ZoomArr_ptr:=$3
//C_LONGINT($Zoom_L;$Pick_L;$Dum_L)
//C_TEXT($ZoomArrName_txt)
//C_POINTER($ZoomArrIndx_ptr)
//RESOLVE POINTER($ZoomArr_ptr;$ZoomArrName_txt;$Dum_L;$Dum_L)
//EXECUTE FORMULA("C_LONGINT("+$ZoomArrName_txt+"_L)")
//$ZoomArrIndx_ptr:=Get pointer($ZoomArrName_txt+"_L")

//Case of 
//: (Form event=On Load)
//WR UPDATE MODE ($MyArea;0)

//$Pick_L:=$ZoomArrIndx_ptr->
//$Zoom_L:=Find in array($ZoomArr_ptr->;String(100))  // do not allow less than 100% on start
//If ($Pick_L<$Zoom_L)
//$Pick_L:=$Zoom_L
//Else 

//End if 
//$ZoomArr_ptr->:=$Pick_L
//$Zoom_L:=Num($ZoomArr_ptr->{$Pick_L})
//If ($Zoom_L>0)
//WR SET AREA PROPERTY ($MyArea;wr zoom factor;$Zoom_L;"")
//End if 
//WR UPDATE MODE ($MyArea;1)

//: (Form event=On Clicked)
//$Pick_L:=$ZoomArr_ptr->
//If ($Pick_L>0)
//$Zoom_L:=Num($ZoomArr_ptr->{$Pick_L})
//If ($Zoom_L>0)
//WR SET AREA PROPERTY ($MyArea;wr zoom factor;$Zoom_L;"")
//REDRAW WINDOW
//  //WR UPDATE MODE ($MyArea;1)
//$ZoomArrIndx_ptr->:=$Pick_L
//End if 

//End if 

//End case 

//: ($Function="RESETFONTSIZE")
//  //Check and if needed reset the font and fontsize.
//  //Return true if there are words in the area, False if 4Dwrite area is blank.
//If (WR Count ($MyArea;wr nb words)>0)
//C_LONGINT($vStartSel;$vEndSel)
//WR GET SELECTION ($MyArea;$vStartSel;$vEndSel)
//WR EXECUTE COMMAND ($MyArea;wr cmd select all)
//  //make sure all text is the same font
//C_TEXT($vFont)  // **Replaced old C_STRING length 132
//C_LONGINT($vUniform;$vFontSize)  // **replaced _ o _C_INTEGER()
//$vFont:=WR Get font ($MyArea;$vUniform)
//If (($vUniform=0) | ($vFont#vInspFontName))
//WR SET FONT ($MyArea;vInspFontName)
//End if 
//$vFontSize:=WR Get text property ($MyArea;wr font size;$vUniform)
//If (($vUniform=0) | ($vFontSize#vInspFontSize))
//WR SET TEXT PROPERTY ($MyArea;wr font size;vInspFontSize)
//End if 
//$Result_b:=True
//WR SET SELECTION ($MyArea;$vStartSel;$vEndSel)
//Else 
//$Result_b:=False
//End if 

//: ($Function="CLEANCHARS")

//C_TEXT($CharArrays_txt;$ReplBy_txt)
//$CharArrays_txt:=ut_GetSysParameter ("CHAR_REPLACED")
//ARRAY TEXT($FirstGo_atxt;0)
//ut_TextToArray ($CharArrays_txt;->$FirstGo_atxt;Char(13))
//ARRAY LONGINT($AsciiReplace_aL;Size of array($FirstGo_atxt))
//ARRAY TEXT($AsciiReplaceby_atxt;Size of array($FirstGo_atxt))
//C_LONGINT($loop2_L)
//For ($loop_L;1;Size of array($FirstGo_atxt))
//ARRAY TEXT($AsciiList_atxt;0)
//ut_TextToArray ($FirstGo_atxt{$loop_L};->$AsciiList_atxt;";")
//$AsciiReplace_aL{$loop_L}:=Num($AsciiList_atxt{1})
//$ReplBy_txt:=""

//If (Size of array($AsciiList_atxt)>1)
//If ($AsciiList_atxt{2}="WR @")
//$AsciiReplaceby_atxt{$loop_L}:=Substring($FirstGo_atxt{$loop_L};Position(";";$FirstGo_atxt{$loop_L})+1)
//Else 
//C_LONGINT($loop2_L)
//For ($loop2_L;2;Size of array($AsciiList_atxt))
//$AsciiList_atxt{$loop2_L}:=Replace string($AsciiList_atxt{$loop2_L};" ";"")
//If ($AsciiList_atxt{$loop2_L}#"")
//$ReplBy_txt:=$ReplBy_txt+Char(Num($AsciiList_atxt{$loop2_L}))
//End if 

//End for 
//$AsciiReplaceby_atxt{$loop_L}:=$ReplBy_txt

//End if 

//End if 

//End for 
//ARRAY TEXT($FirstGo_atxt;0)
//ARRAY TEXT($AsciiList_atxt;0)

//C_LONGINT($Count_l;$First_l;$ascii_l;$Length_l;$firstAscii_L;$NewLength_L;$loop_l;$numPars_L;$start_L;$End_L;$bullet_L)
//WR SET SELECTION ($MyArea;0;0)
//$numPars_L:=WR Count ($MyArea;wr nb paragraphs)
//ARRAY REAL($parLeftMar_ar;$numPars_L)
//ARRAY REAL($parrightMar_ar;$numPars_L)
//ARRAY REAL($parfirstind_ar;$numPars_L)
//C_REAL($LeftMar_r;$FirstParInd_r)
//For ($loop_l;1;$numPars_L)
//WR GET PARAGRAPHS ($MyArea;$start_L;$End_L)
//WR SET SELECTION ($MyArea;$start_L;$End_L)
//$LeftMar_r:=WR Get text property ($MyArea;wr left margin;$uniform)
//$parrightMar_ar{$loop_l}:=WR Get text property ($MyArea;wr right margin;$uniform)
//If ($parrightMar_ar{$loop_l}<0)
//$parrightMar_ar{$loop_l}:=0
//End if 
//$FirstParInd_r:=WR Get text property ($MyArea;wr first indent;$uniform)
//If ($LeftMar_r<0)
//$LeftMar_r:=0
//End if 
//If (($FirstParInd_r+$LeftMar_r)<0)
//$FirstParInd_r:=-$LeftMar_r
//End if 
//$parLeftMar_ar{$loop_l}:=$LeftMar_r
//$parfirstind_ar{$loop_l}:=$FirstParInd_r
//  // Code to clean up bullets to the left of the left margin
//$bullet_L:=WR Get text property ($MyArea;wr bullet)
//If ($bullet_L#0)

//Case of 
//: ($FirstParInd_r>0)
//: (($LeftMar_r+$FirstParInd_r)<=0)
//WR SET TEXT PROPERTY ($MyArea;wr bullet;0)
//End case 

//End if 

//WR SET SELECTION ($MyArea;$End_L;$End_L)

//End for 
//C_BOOLEAN($DoReplace_B)
//$DoReplace_B:=True
//$DoReplace_B:=(<>CurrentUser_Name="Designer") | $DoReplace_B

//C_TEXT($text;$Asciis_txt)
//$firstAscii_L:=-1
//$Count_l:=0
//$Length_l:=WR Count ($MyArea;wr nb characters)
//If ($DoReplace_B)
//SET CURSOR(128)
//SHORT_MESSAGE ("Checking for Illegal Characters...")

//C_LONGINT($indx_L;$cmdloop_L)
//C_TEXT($rtfexpr_txt;$DebugText_txt;$contains_txt)
//$DebugText_txt:=""
//$contains_txt:=""
//For ($loop_l;$Length_l;1;-1)
//WR SET SELECTION ($MyArea;$loop_l-1;$loop_l)
//$text:=WR Get selected text ($MyArea)
//$ascii_l:=Character code($text)
//If (($ascii_l>128) | ($ascii_l=0))
//If (User in group(<>CurrentUser_Name;"Design Access Group"))
//$contains_txt:=""
//$DebugText_txt:=$DebugText_txt+Char(13)+"Pos: "+String($loop_l-1)+" Code:"+String($ascii_l)+" : <"+$text+">"+Char(13)
//WR SET SELECTION ($MyArea;$loop_l-5;$loop_l+5)
//$contains_txt:=WR Get selected text ($MyArea)
//$DebugText_txt:=$DebugText_txt+$contains_txt

//WR SET SELECTION ($MyArea;$loop_l-1;$loop_l)
//End if 

//$indx_L:=Find in array($AsciiReplace_aL;$ascii_l)

//Case of 
//: ($indx_L>0)
//If ($AsciiReplaceby_atxt{$indx_L}#"")

//If (Position("WR ";$AsciiReplaceby_atxt{$indx_L})=1)  //start with WR
//ARRAY TEXT($WrCommands_atxt;0)
//ut_TextToArray ($AsciiReplaceby_atxt{$indx_L};->$WrCommands_atxt;"<WRC>")  //commands are divided by <WRC>

//For ($cmdloop_L;1;Size of array($WrCommands_atxt))
//EXECUTE FORMULA($WrCommands_atxt{$cmdloop_L})
//End for 

//Else 
//WR INSERT TEXT ($MyArea;$AsciiReplaceby_atxt{$indx_L})
//End if 

//End if 

//: ($ascii_l=148)  //double quote
//  //change it to a doule quote
//WR INSERT TEXT ($MyArea;<>sQU)
//: ($ascii_l=165)  //bullets are OK
//: ($ascii_l=177)  //plusminus
//  //change it to a +/-
//WR INSERT TEXT ($MyArea;"+/-")
//: ($ascii_l=183)  //bullets are OK
//: ($ascii_l=188)  //degree sign are OK
//: ($ascii_l=197)  //approx sign are OK
//: ($ascii_l=202)  //space
//WR INSERT TEXT ($MyArea;" ")
//: ($ascii_l=208) | ($ascii_l=8211)  //dash
//WR INSERT TEXT ($MyArea;"-")
//: ($ascii_l=210) | ($ascii_l=8221) | ($ascii_l=8220)  //double quote
//  //change it to a doule quote
//WR INSERT TEXT ($MyArea;<>sQU)
//: ($ascii_l=211)  //double quote
//  //change it to a doule quote
//WR INSERT TEXT ($MyArea;<>sQU)
//: ($ascii_l=213) | ($ascii_l=8217)  // single quote
//  //change it to a single quote
//WR INSERT TEXT ($MyArea;Char(39))
//: ($ascii_l=218)  //1/2
//  //change it to a 1/2
//EXECUTE FORMULA("WR SET TEXT PROPERTY (WRUTIL_WRArea_L;wr superscript or subscript ;wr superscript )")
//EXECUTE FORMULA("WR INSERT TEXT (WRUTIL_WRArea_L;"+<>sQU+"1"+<>sQU+")")
//EXECUTE FORMULA("WR SET TEXT PROPERTY (WRUTIL_WRArea_L;wr superscript or subscript ;wr none )")
//EXECUTE FORMULA("WR INSERT TEXT (WRUTIL_WRArea_L;"+<>sQU+"/"+<>sQU+")")
//EXECUTE FORMULA("WR SET TEXT PROPERTY (WRUTIL_WRArea_L;wr superscript or subscript ;wr subscript )")
//EXECUTE FORMULA("WR INSERT TEXT (WRUTIL_WRArea_L;"+<>sQU+"2"+<>sQU+")")
//EXECUTE FORMULA("WR SET TEXT PROPERTY (WRUTIL_WRArea_L;wr superscript or subscript ;wr none )")

//: ($ascii_l=225)  //change this to a 'regular' bullet
//WR INSERT TEXT ($MyArea;Char(165))
//Else 

//If (False)
//$First_l:=$Loop_l
//$firstAscii_L:=$ascii_l
//$Asciis_txt:=$Asciis_txt+"-"+String($ascii_l)+"["+Substring($text;1;1)+"] "
//$Count_l:=$Count_l+1
//WR SET TEXT PROPERTY ($MyArea;wr font size;22)
//WR SET TEXT PROPERTY ($MyArea;wr text color;0xFF00)
//WR SET TEXT PROPERTY ($MyArea;wr text back color;0x00FF0000)

//End if 

//End case 
//Else 

//If ($ascii_l=63)  // a question mark
//C_BLOB($thistest_x;$PrevTest_x)
//$thistest_x:=WR Get styled text ($MyArea)
//C_LONGINT($b_loop_L;$byte1_L;$Byte2_L)
//$byte1_L:=$thistest_x{BLOB size($thistest_x)-2}
//$Byte2_L:=$thistest_x{BLOB size($thistest_x)-1}
//Case of 
//: ($byte1_L=186) & ($Byte2_L#0)  // inch mark
//WR INSERT TEXT ($MyArea;<>sQU)

//: ($byte1_L=185) & ($Byte2_L#0)  // foot mark
//WR INSERT TEXT ($MyArea;Char(39))

//End case 

//End if 

//  //WR INSERT TEXT ($MyArea;Char($ascii_l))
//End if 

//End for 
//CLOSE WINDOW
//SET CURSOR(0)

//If ((User in group(<>CurrentUser_Name;"Design Access Group")) & ($DebugText_txt#""))
//CONFIRM("Found Illegal Characters! Copy debug text to clipboard?";"Copy")
//If (OK=1)
//SET TEXT TO PASTEBOARD($DebugText_txt)
//End if 
//End if 
//$DebugText_txt:=""
//$contains_txt:=""

//End if 
//WR SET SELECTION ($MyArea;0;0)
//$numPars_L:=WR Count ($MyArea;wr nb paragraphs)
//For ($loop_l;1;$numPars_L)
//WR GET PARAGRAPHS ($MyArea;$start_L;$End_L)
//WR SET SELECTION ($MyArea;$start_L;$End_L)
//WR SET TEXT PROPERTY ($MyArea;wr left margin;$parLeftMar_ar{$loop_l})
//WR SET TEXT PROPERTY ($MyArea;wr right margin;$parrightMar_ar{$loop_l})
//WR SET TEXT PROPERTY ($MyArea;wr first indent;$parfirstind_ar{$loop_l})
//WR SET SELECTION ($MyArea;$End_L;$End_L)
//End for 

//If ($Count_l>0)
//C_TEXT($Alert_txt;$plr_txt;$pos_txt)
//$plr_txt:=f_Boolean2String (($Count_l>1);"s")
//If ($Count_l>1)
//$pos_txt:="their"
//Else 
//$pos_txt:="it's"
//End if 

//$Alert_txt:="You have "+String($Count_l)+" illegal character"+$plr_txt+" in your text!"
//$Alert_txt:=$Alert_txt+"You must correct them before you can save!"
//$Alert_txt:=$Alert_txt+<>sCR+"To assist in locating the character"+$plr_txt+" in question, "+$pos_txt+" font size "
//$Alert_txt:=$Alert_txt+"has been increased to 22pt, and "+$pos_txt+" color changed to Green on Red background."+<>sCR

//If ($Count_l>1)
//$Alert_txt:=$Alert_txt+"This is a list of the character codes and the characters :"+<>sCR+$Asciis_txt
//Else 
//$Alert_txt:=$Alert_txt+"This is the character code and the character :"+<>sCR+$Asciis_txt
//End if 

//ut_BigAlert ($Alert_txt)

//WR SET SELECTION ($MyArea;$First_l-1;$First_l)
//WR SCROLL TO SELECTION ($MyArea)
//GOTO OBJECT($MyArea)
//$Result_b:=False
//Else 
//$Result_b:=True
//End if 

//ARRAY LONGINT($AsciiReplace_aL;0)
//ARRAY TEXT($AsciiReplaceby_atxt;0)

//WR SET SELECTION ($MyArea;0;0)
//$numPars_L:=WR Count ($MyArea;wr nb paragraphs)
//C_LONGINT($numTabStops_L;$tabLoop_L;$tabAlign_L)
//C_REAL($tabPos_r)
//C_TEXT($tabFill_txt)

//If (False)
//For ($loop_l;1;$numPars_L)
//WR GET PARAGRAPHS ($MyArea;$start_L;$End_L)
//WR SET SELECTION ($MyArea;$start_L;$start_L)
//$numTabStops_L:=WR Get text property ($MyArea;wr tab;$uniform)

//ARRAY REAL($tabsPos_ar;0)
//ARRAY LONGINT($tabsAlign_aL;0)
//ARRAY TEXT($tabFill_atxt;0)

//If ($numTabStops_L>0)
//For ($tabLoop_L;1;$numTabStops_L)
//WR GET TAB ($MyArea;$tabLoop_L;$tabPos_r;$tabAlign_L;$tabFill_txt)
//If ($tabPos_r>0)
//APPEND TO ARRAY($tabsPos_ar;$tabPos_r)
//APPEND TO ARRAY($tabsAlign_aL;$tabAlign_L)
//APPEND TO ARRAY($tabFill_atxt;$tabFill_txt)
//End if 

//End for 
//$tabLoop_L:=$numTabStops_L
//While ($tabLoop_L#0)
//WR DELETE TAB ($MyArea;1)
//$tabLoop_L:=$tabLoop_L-1
//End while 
//For ($tabLoop_L;1;Size of array($tabsPos_ar))
//WR ADD TAB ($MyArea;$tabsPos_ar{$tabLoop_L};$tabsAlign_aL{$tabLoop_L};$tabFill_atxt{$tabLoop_L})
//End for 

//End if 

//WR SET SELECTION ($MyArea;$End_L;$End_L)
//End for 
//Else 
//WR SET SELECTION ($MyArea;0;WR Count ($MyArea;wr nb characters))
//$numTabStops_L:=WR Get text property ($MyArea;wr tab;$uniform)

//ARRAY REAL($tabsPos_ar;0)
//ARRAY LONGINT($tabsAlign_aL;0)
//ARRAY TEXT($tabFill_atxt;0)

//If ($numTabStops_L>0)
//For ($tabLoop_L;1;$numTabStops_L)
//WR GET TAB ($MyArea;$tabLoop_L;$tabPos_r;$tabAlign_L;$tabFill_txt)
//If ($tabPos_r>0)
//APPEND TO ARRAY($tabsPos_ar;$tabPos_r)
//APPEND TO ARRAY($tabsAlign_aL;$tabAlign_L)
//APPEND TO ARRAY($tabFill_atxt;$tabFill_txt)
//End if 

//End for 
//$tabLoop_L:=$numTabStops_L
//While ($tabLoop_L#0)
//WR DELETE TAB ($MyArea;1)
//$tabLoop_L:=$tabLoop_L-1
//End while 
//For ($tabLoop_L;1;Size of array($tabsPos_ar))
//WR ADD TAB ($MyArea;$tabsPos_ar{$tabLoop_L};$tabsAlign_aL{$tabLoop_L};$tabFill_atxt{$tabLoop_L})
//End for 

//End if 

//WR SET SELECTION ($MyArea;0;0)

//End if 

//: ($Function="SHOWMENUBAR")
//C_POINTER($3;$MenuView_ptr)
//$MenuView_ptr:=$3
//Case of 
//: (Form event=On Load)
//If ($MenuView_ptr->=0)
//WR SET DOC PROPERTY ($MyArea;wr view menubar;0)
//Else 
//WR SET DOC PROPERTY ($MyArea;wr view menubar;1)
//End if 

//: (Form event=On Clicked)
//If ($MenuView_ptr->=0)
//WR SET DOC PROPERTY ($MyArea;wr view menubar;0)
//Else 
//WR SET DOC PROPERTY ($MyArea;wr view menubar;1)
//End if 

//End case 
//  //No result needed here

//End case 

//$0:=$Result_b