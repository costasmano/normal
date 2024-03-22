//%attributes = {"invisible":true}
//Method: DBG_Get4DWritePrintProps
//Description
// get print properties of a 4D Write area - return as a text
// Parameters
// $0 : $opts_txt
// $1 : $Area_L
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 11/22/17, 12:42:19
	// ----------------------------------------------------
	//Created : 
	Mods_2017_11
	C_TEXT:C284(DBG_Get4DWritePrintProps; $0)
	C_LONGINT:C283(DBG_Get4DWritePrintProps; $1)
	
	Mods_2021_Delete
End if 
//  //
//C_TEXT($0)
//C_LONGINT($1)

//C_TEXT($opts_txt)
//$opts_txt:=""

//C_LONGINT($val1_L;$val2_L)
//C_TEXT($val3_txt)

//WR GET PRINT OPTION ($1;wr color option;$val1_L;$val2_L;$val3_txt)
//$opts_txt:=$opts_txt+"wr color option "+Char(9)+String($val1_L)+Char(9)+String($val2_L)+Char(9)+$val3_txt+Char(13)
//WR GET PRINT OPTION ($1;wr destination option;$val1_L;$val2_L;$val3_txt)
//$opts_txt:=$opts_txt+"wr destination option "+Char(9)+String($val1_L)+Char(9)+String($val2_L)+Char(9)+$val3_txt+Char(13)
//WR GET PRINT OPTION ($1;wr double sided option;$val1_L;$val2_L;$val3_txt)
//$opts_txt:=$opts_txt+"wr double sided option "+Char(9)+String($val1_L)+Char(9)+String($val2_L)+Char(9)+$val3_txt+Char(13)
//WR GET PRINT OPTION ($1;wr number of copies option;$val1_L;$val2_L;$val3_txt)
//$opts_txt:=$opts_txt+"wr number of copies option "+Char(9)+String($val1_L)+Char(9)+String($val2_L)+Char(9)+$val3_txt+Char(13)
//WR GET PRINT OPTION ($1;wr orientation option;$val1_L;$val2_L;$val3_txt)
//$opts_txt:=$opts_txt+"wr orientation option "+Char(9)+String($val1_L)+Char(9)+String($val2_L)+Char(9)+$val3_txt+Char(13)
//WR GET PRINT OPTION ($1;wr pages from option;$val1_L;$val2_L;$val3_txt)
//$opts_txt:=$opts_txt+"wr pages from option "+Char(9)+String($val1_L)+Char(9)+String($val2_L)+Char(9)+$val3_txt+Char(13)
//WR GET PRINT OPTION ($1;wr pages to option;$val1_L;$val2_L;$val3_txt)
//$opts_txt:=$opts_txt+"wr pages to option "+Char(9)+String($val1_L)+Char(9)+String($val2_L)+Char(9)+$val3_txt+Char(13)
//WR GET PRINT OPTION ($1;wr paper option;$val1_L;$val2_L;$val3_txt)
//$opts_txt:=$opts_txt+"wr paper option "+Char(9)+String($val1_L)+Char(9)+String($val2_L)+Char(9)+$val3_txt+Char(13)
//WR GET PRINT OPTION ($1;wr paper source option;$val1_L;$val2_L;$val3_txt)
//$opts_txt:=$opts_txt+"wr paper source option "+Char(9)+String($val1_L)+Char(9)+String($val2_L)+Char(9)+$val3_txt+Char(13)
//WR GET PRINT OPTION ($1;wr scale option;$val1_L;$val2_L;$val3_txt)
//$opts_txt:=$opts_txt+"wr scale option "+Char(9)+String($val1_L)+Char(9)+String($val2_L)+Char(9)+$val3_txt+Char(13)
//WR GET PRINT OPTION ($1;wr spooler document name option;$val1_L;$val2_L;$val3_txt)
//$opts_txt:=$opts_txt+"wr spooler document name option "+Char(9)+String($val1_L)+Char(9)+String($val2_L)+Char(9)+$val3_txt+Char(13)

//$0:=$opts_txt
//  //End DBG_Get4DWritePrintProps