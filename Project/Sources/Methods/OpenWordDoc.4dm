//%attributes = {"invisible":true}
//Method: OpenWordDoc
//Description
// Open a Ms Word document with a script
// Parameters
// $1 : $param_o 
//  // .filename
//  // .fontsize
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 2022-05-20T00:00:00, 12:29:25
	// ----------------------------------------------------
	//Created : 
	Mods_2022_05
	
	C_OBJECT:C1216(OpenWordDoc; $1)
	
	// Modified by: Costas Manousakis-(Designer)-(2022-12-09 11:41:12)
	Mods_2022_12_bug
	//  `fix first line in windows script - add .save after changing font size
	//  ` add save after changing font size in windows and Mac
End if 
//

C_OBJECT:C1216($1; $params_o)
C_TEXT:C284($file_txt)
C_LONGINT:C283($fontsize)

$file_txt:=OB Get:C1224($1; "filename"; Is text:K8:3)
$fontsize:=OB Get:C1224($1; "fontsize"; Is longint:K8:6)

C_TEXT:C284($scrip; $scriptResult)
If (Is Windows:C1573)
	//test to change active document font size 
	$scrip:="Set objWord = CreateObject(\"Word.Application\")"+Char:C90(Carriage return:K15:38)
	$scrip:=$scrip+"objWord.Visible = True"+Char:C90(Carriage return:K15:38)
	$scrip:=$scrip+"objWord.Activate"+Char:C90(Carriage return:K15:38)
	$scrip:=$scrip+"Set objDoc = objWord.Documents.Open( \""+$file_txt+"\")"+Char:C90(Carriage return:K15:38)
	If ($fontsize>0)
		$scrip:=$scrip+"Set objBody = objDoc.Range()"+Char:C90(Carriage return:K15:38)
		$scrip:=$scrip+"objBody.Font.Size="+String:C10($fontsize)+Char:C90(Carriage return:K15:38)
		$scrip:=$scrip+"objDoc.Save"
	End if 
	$scriptResult:=ut_RunScript($scrip)
	
Else 
	$scrip:="tell application \"Microsoft Word\""+Char:C90(Carriage return:K15:38)+\
		"activate"+Char:C90(Carriage return:K15:38)+\
		"open file \""+$file_txt+"\""+Char:C90(Carriage return:K15:38)
	If ($fontsize>0)
		$scrip:=$scrip+"set body to text object of active document"+Char:C90(Carriage return:K15:38)+\
			"set font size of font object of body to "+String:C10($fontsize)+Char:C90(Carriage return:K15:38)+\
			"save active document\n"
	End if 
	$scrip:=$scrip+"end tell"
	$scriptResult:=ut_RunScript($scrip)
	
End if 

//End OpenWordDoc