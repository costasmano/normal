//%attributes = {"invisible":true}
//Method: DBG_Get4DWriteAreaProps
//Description
// get Area properties of a 4D Write area - return as a text
// Parameters
// $0 : $opts_txt
// $1 : $Area_L
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 11/22/17, 12:12:08
	// ----------------------------------------------------
	//Created : 
	Mods_2017_11
	C_TEXT:C284(DBG_Get4DWriteAreaProps; $0)
	C_LONGINT:C283(DBG_Get4DWriteAreaProps; $1)
	
	Mods_2021_Delete
End if 
//

//C_TEXT($0)
//C_LONGINT($1)

//C_TEXT($opts_txt)
//$opts_txt:=""

//C_LONGINT($value_L)
//C_TEXT($str_txt)

//WR GET AREA PROPERTY ($1;wr allow drag;$value_L;$str_txt)
//$opts_txt:=$opts_txt+"wr allow drag : "+Char(9)+String($value_L)+Char(9)+"<"+$str_txt+">"+Char(13)
//WR GET AREA PROPERTY ($1;wr allow drop;$value_L;$str_txt)
//$opts_txt:=$opts_txt+"wr allow drop : "+Char(9)+String($value_L)+Char(9)+"<"+$str_txt+">"+Char(13)
//WR GET AREA PROPERTY ($1;wr allow undo;$value_L;$str_txt)
//$opts_txt:=$opts_txt+"wr allow undo : "+Char(9)+String($value_L)+Char(9)+"<"+$str_txt+">"+Char(13)
//WR GET AREA PROPERTY ($1;wr confirm dialog;$value_L;$str_txt)
//$opts_txt:=$opts_txt+"wr confirm dialog : "+Char(9)+String($value_L)+Char(9)+"<"+$str_txt+">"+Char(13)
//WR GET AREA PROPERTY ($1;wr convert by token;$value_L;$str_txt)
//$opts_txt:=$opts_txt+"wr convert by token : "+Char(9)+String($value_L)+Char(9)+"<"+$str_txt+">"+Char(13)
//WR GET AREA PROPERTY ($1;wr convert dialog;$value_L;$str_txt)
//$opts_txt:=$opts_txt+"wr convert dialog : "+Char(9)+String($value_L)+Char(9)+"<"+$str_txt+">"+Char(13)
//WR GET AREA PROPERTY ($1;wr fixed print size;$value_L;$str_txt)
//$opts_txt:=$opts_txt+"wr fixed print size : "+Char(9)+String($value_L)+Char(9)+"<"+$str_txt+">"+Char(13)
//WR GET AREA PROPERTY ($1;wr load template on server;$value_L;$str_txt)
//$opts_txt:=$opts_txt+"wr load template on server : "+Char(9)+String($value_L)+Char(9)+"<"+$str_txt+">"+Char(13)
//WR GET AREA PROPERTY ($1;wr minimized button title;$value_L;$str_txt)
//$opts_txt:=$opts_txt+"wr minimized button title : "+Char(9)+String($value_L)+Char(9)+"<"+$str_txt+">"+Char(13)
//WR GET AREA PROPERTY ($1;wr minimum height;$value_L;$str_txt)
//$opts_txt:=$opts_txt+"wr minimum height : "+Char(9)+String($value_L)+Char(9)+"<"+$str_txt+">"+Char(13)
//WR GET AREA PROPERTY ($1;wr minimum width;$value_L;$str_txt)
//$opts_txt:=$opts_txt+"wr minimum width : "+Char(9)+String($value_L)+Char(9)+"<"+$str_txt+">"+Char(13)
//WR GET AREA PROPERTY ($1;wr modified;$value_L;$str_txt)
//$opts_txt:=$opts_txt+"wr modified : "+Char(9)+String($value_L)+Char(9)+"<"+$str_txt+">"+Char(13)
//WR GET AREA PROPERTY ($1;wr on the fly spellchecking;$value_L;$str_txt)
//$opts_txt:=$opts_txt+"wr on the fly spellchecking : "+Char(9)+String($value_L)+Char(9)+"<"+$str_txt+">"+Char(13)
//WR GET AREA PROPERTY ($1;wr save preview;$value_L;$str_txt)
//$opts_txt:=$opts_txt+"wr save preview : "+Char(9)+String($value_L)+Char(9)+"<"+$str_txt+">"+Char(13)
//WR GET AREA PROPERTY ($1;wr save template on server;$value_L;$str_txt)
//$opts_txt:=$opts_txt+"wr save template on server : "+Char(9)+String($value_L)+Char(9)+"<"+$str_txt+">"+Char(13)
//WR GET AREA PROPERTY ($1;wr timer frequency;$value_L;$str_txt)
//$opts_txt:=$opts_txt+"wr timer frequency : "+Char(9)+String($value_L)+Char(9)+"<"+$str_txt+">"+Char(13)
//WR GET AREA PROPERTY ($1;wr use saved zoom value;$value_L;$str_txt)
//$opts_txt:=$opts_txt+"wr use saved zoom value : "+Char(9)+String($value_L)+Char(9)+"<"+$str_txt+">"+Char(13)
//WR GET AREA PROPERTY ($1;wr window title;$value_L;$str_txt)
//$opts_txt:=$opts_txt+"wr window title : "+Char(9)+String($value_L)+Char(9)+"<"+$str_txt+">"+Char(13)
//WR GET AREA PROPERTY ($1;wr zoom factor;$value_L;$str_txt)
//$opts_txt:=$opts_txt+"wr zoom factor : "+Char(9)+String($value_L)+Char(9)+"<"+$str_txt+">"+Char(13)

//$0:=$opts_txt
//  //End DBG_Get4DWriteAreaProps