//Method: Object Method: WriteTest.Button1
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 11/22/13, 13:28:28
	// ----------------------------------------------------
	//Created : 
	Mods_2013_11
End if 
//

//C_BLOB($st_x)
//$st_x:=WR Get styled text (WriteArea)
//WrtTest_FormatTxtBlb_txt:=BLOB to text($st_x;Mac text without length)

//TEXT TO BLOB(WrtTest_Props_txt;$st_x;Mac C string)
//WR INSERT TEXT (WriteArea;"Mac C string"+Char(13))
//WR INSERT STYLED TEXT (WriteArea;$st_x)

//C_BLOB($st_x)
//WR INSERT TEXT (WriteArea;"Mac Pascal string"+Char(13))
//TEXT TO BLOB(WrtTest_Props_txt;$st_x;Mac Pascal string)
//WR INSERT STYLED TEXT (WriteArea;$st_x)

//C_BLOB($st_x)
//WR INSERT TEXT (WriteArea;"Mac text with length"+Char(13))
//TEXT TO BLOB(WrtTest_Props_txt;$st_x;Mac text with length)
//WR INSERT STYLED TEXT (WriteArea;$st_x)

//C_BLOB($st_x)
//WR INSERT TEXT (WriteArea;"Mac text without length"+Char(13))
//TEXT TO BLOB(WrtTest_Props_txt;$st_x;Mac text without length)
//WR INSERT STYLED TEXT (WriteArea;$st_x)
//C_BLOB($st_x)
//WR INSERT TEXT (WriteArea;"UTF8 C string"+Char(13))
//TEXT TO BLOB(WrtTest_Props_txt;$st_x;UTF8 C string)
//WR INSERT STYLED TEXT (WriteArea;$st_x)
//C_BLOB($st_x)
//WR INSERT TEXT (WriteArea;"UTF8 text with length"+Char(13))
//TEXT TO BLOB(WrtTest_Props_txt;$st_x;UTF8 text with length)
//WR INSERT STYLED TEXT (WriteArea;$st_x)
//C_BLOB($st_x)
//WR INSERT TEXT (WriteArea;"UTF8 text without length"+Char(13))
//TEXT TO BLOB(WrtTest_Props_txt;$st_x;UTF8 text without length)
//WR INSERT STYLED TEXT (WriteArea;$st_x)
//ARRAY TEXT($sigs_atxt;0)
//ARRAY TEXT($ntypes_atxt;0)

//GET PASTEBOARD DATA TYPE($sigs_atxt;$ntypes_atxt)

//C_LONGINT($rtf_L;$html_L)
//$rtf_L:=Find in array($sigs_atxt;"@.rtf@")
//$html_L:=Find in array($sigs_atxt;"@.html@")

//C_TEXT($html_txt;$rtf_txt)
//C_BLOB($html_x;$rtf_x)
//GET PASTEBOARD DATA($sigs_atxt{$html_L};$html_x)
//GET PASTEBOARD DATA($sigs_atxt{$rtf_L};$rtf_x)


//If (False)
//C_PICTURE($preview_pic)
//$preview_pic:=WR Build preview (WriteArea;1)
//WrtTest_txt:="Pic size :"+String(Picture size($preview_pic))
//C_LONGINT($pw;$ph)
//PICTURE PROPERTIES($preview_pic;$pw;$ph)
//WrtTest_txt:=WrtTest_txt+" "+String($pw)+"W x "+String($ph)+"H"
//SET PICTURE TO PASTEBOARD($preview_pic)

//  //  //C_TEXT($styleit_txt)
//  //$styleit_txt:=ST Get text(WrtTest_Props_txt)

//  //  //WR INSERT STYLED TEXT (WriteArea;$styleit_txt)

//  //  //C_BLOB($st_x)
//  //  //VARIABLE TO BLOB($styleit_txt;$st_x)
//  //  //WR INSERT STYLED TEXT (WriteArea;$st_x)

//  //SET TEXT TO PASTEBOARD($styleit_txt)
//  //WR EXECUTE COMMAND (WriteArea;wr cmd paste)

//End if 

//$html_txt:=BLOB to text($html_x;UTF8 text without length)

//WR INSERT HTML EXPRESSION (WriteArea;$html_txt)

//WR INSERT TEXT (WriteArea;Char(13))

//$rtf_txt:=BLOB to text($rtf_x;Mac text without length)
//WR INSERT RTF EXPRESSION (WriteArea;$rtf_txt)


//  //End Object Method: WriteTest.Button1