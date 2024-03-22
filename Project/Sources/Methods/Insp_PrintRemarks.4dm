//%attributes = {"invisible":true}
//Method: Insp_PrintRemarks
//Description
// Print Inspection remarks assembled in a 4D Write area using a form with a 4D Write area on it.
// Replaces the method of using the result of WR Build Preview.
// Parameters
// $1 : $Area
// $2 : $FirstPageForm_txt (Optional) Form to be used to print the first page
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 09/28/16, 15:35:56
	// ----------------------------------------------------
	//Created : 
	Mods_2016_09
	C_LONGINT:C283(Insp_PrintRemarks; $1)
	C_TEXT:C284(Insp_PrintRemarks; $2)
	// Modified by: Costas Manousakis-(Designer)-(11/14/18 16:19:50)
	Mods_2018_11
	//  `added progress while scanning pages
	// Modified by: Costas Manousakis-(Designer)-(10/22/19 16:23:20)
	Mods_2019_10_bug
	//  `instead of scanning character by character to find starts and ends of pages, use page count
	//  `when printing the last page, add a carriage return to preserve any paragraph formatting such as bullets - CallReference #655
	Mods_2021_Delete
	
End if 
//  //
//C_LONGINT($1)
//C_LONGINT($mainarea)

//$mainarea:=$1
//C_TEXT($FirstPageForm_txt)
//$FirstPageForm_txt:="Dive Pr Pg 2 wrt"
//If (Count parameters>1)
//C_TEXT($2)
//$FirstPageForm_txt:=$2
//End if 

//C_LONGINT($startSel_L;$endSel_L;$CurrPos_L;$NumChars_L;$CurPage_L;$CurCol_L;$CurLine_L;$CurPos_L;$SelPage_L)
//C_LONGINT($i;$numpages)
//$NumChars_L:=WR Count ($mainarea;wr nb characters)
//$numpages:=WR Count ($mainarea;wr nb pages)
//$startSel_L:=0
//ARRAY LONGINT($PageStart_aL;0)
//ARRAY LONGINT($pageEnd_aL;0)
//APPEND TO ARRAY($PageStart_aL;0)
//$CurPage_L:=1
//  //build arrays with start and end of page markers
//  //start the bar
//C_OBJECT($progress_o)

//$progress_o:=ProgressNew ("Preparing for printing";$numpages;False;" - ";3)

//ARRAY LONGINT($PageStart_aL;$numpages)
//ARRAY LONGINT($pageEnd_aL;$numpages)

//For ($i;2;$numpages)
//WR SET CURSOR POSITION ($mainarea;$i;1;1;1)
//WR GET SELECTION ($mainarea;$startSel_L;$endSel_L)
//$PageStart_aL{$i}:=$startSel_L
//$pageEnd_aL{$i-1}:=$startSel_L-1
//UpdateProgressNew ($progress_o;$i)

//End for 
//$pageEnd_aL{$numpages}:=$NumChars_L+1

//  //quit progress
//Progress QUIT (OB Get($progress_o;"progress";Is longint))

//C_BLOB(vCmtsArea_)
//For ($i;1;$numpages)

//If ($i=$numpages)
//WR SET SELECTION ($mainarea;$pageEnd_aL{$i};$pageEnd_aL{$i})
//WR INSERT TEXT ($mainarea;Char(13))
//WR SET SELECTION ($mainarea;$PageStart_aL{$i};($pageEnd_aL{$i}+1))

//Else 
//WR SET SELECTION ($mainarea;$PageStart_aL{$i};($pageEnd_aL{$i}+1))
//End if 

//vCmtsArea_:=WR Get styled text ($mainarea)
//PAGE BREAK(>)

//If ($i=1)
//Print form([Inspections];$FirstPageForm_txt)

//Else 
//Print form([Inspections];"Dive Pr Pg 2 wrt")

//End if 

//If (viInspPreviewErr#0)
//  //exit if preview error
//$i:=$numpages+1
//End if 

//End for 
//SET BLOB SIZE(vCmtsArea_;0)

//  //End Insp_PrintRemarks