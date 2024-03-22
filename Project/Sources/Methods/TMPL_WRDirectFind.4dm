//%attributes = {"invisible":true}
// Method: TMPL_WRDirectFind
// Description
// look for a string or an expression in a list of records in [Templates]
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 09/17/07, 12:42:22
	// ----------------------------------------------------
	// ----------------------------------------------------
	
	Mods_2007_CM12_5301
	// Modified by: costasmanousakis-(Designer)-(9/22/10 16:54:45)
	Mods_2010_09
	//  `Added an ON ERR CALL to avoid errors when loading some docs with formulas that cause errors
	//  `Also loop thru the "Frames" main body , headers , footers
	// Modified by: Costas Manousakis-(Designer)-(3/12/21 16:51:39)
	Mods_2021_03
	//  `search for WRT@ (4D Write) templates to distinguish from WRP (Write Pro) 
	Mods_2021_Delete
End if 

//C_TEXT($SearchString_txt;$FoundSet;$OriginalTmpl)
//C_BOOLEAN($ReadWrite_b;$StringVar_b)
//$FoundSet:="FOUNDBLOBSTRINGS"
//$OriginalTmpl:="ORIGINALTEMPLATES"
//CREATE EMPTY SET([Templates];$FoundSet)
//$SearchString_txt:=Request("Enter String to search for")
//C_LONGINT($RECS_L;$I)
//CONFIRM("Is this a string or a variable?";"String";"Variable")
//$StringVar_b:=(OK=1)
//If (Read only state([Templates]))
//$ReadWrite_b:=False
//Else 
//$ReadWrite_b:=True
//End if 
//If ($ReadWrite_b)
//READ ONLY([Templates])
//End if 
//C_LONGINT($TempArea;$NumRefs;$RefCount;$Table;$Field;$Type;$DateF;$TimeF)
//C_TEXT($RefName;$NumF)
//COPY NAMED SELECTION([Templates];$OriginalTmpl)
//QUERY SELECTION([Templates];[Templates]TemplateName="WRT@")
//SHORT_MESSAGE ("Searching...")
//FIRST RECORD([Templates])
//While (Not(End selection([Templates])))
//If ($StringVar_b)
//If (WR Direct find ([Templates]Template_;$SearchString_txt;0;0)>0)
//ADD TO SET([Templates];$FoundSet)
//End if 
//Else 
//$RefName:=""
//$TempArea:=WR New offscreen area 
//WR BLOB TO AREA ($TempArea;[Templates]Template_)
//C_LONGINT($FrameCount_L)
//For ($FrameCount_L;0;wr first footer)

//WR SET FRAME ($TempArea;$FrameCount_L)
//$NumRefs:=WR Count ($TempArea;wr nb objects)
//For ($RefCount;1;$NumRefs)
//WR SELECT ($TempArea;1;$RefCount;MAXLONG)
//WR GET REFERENCE ($TempArea;$Table;$Field;$RefName;$Type;$NumF;$DateF;$TimeF)
//If (($RefName=("@"+$SearchString_txt+"@")) | ($RefName=$SearchString_txt))
//ADD TO SET([Templates];$FoundSet)
//$RefCount:=$NumRefs+1
//$FrameCount_L:=$FrameCount_L+wr first footer+1
//End if 
//End for 

//End for 
//WR DELETE OFFSCREEN AREA ($TempArea)
//End if 

//ON ERR CALL("Error Handler")  //in case of bad record
//NEXT RECORD([Templates])
//ON ERR CALL("")
//End while 
//CLOSE WINDOW
//If (Records in set($FoundSet)>0)
//USE SET($FoundSet)
//Else 
//ALERT("No Records found!")
//USE NAMED SELECTION($OriginalTmpl)
//End if 
//If ($ReadWrite_b)
//READ WRITE([Templates])
//End if 
//CLEAR NAMED SELECTION($OriginalTmpl)
//CLEAR SET($FoundSet)