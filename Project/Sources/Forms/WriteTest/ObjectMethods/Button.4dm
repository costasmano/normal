//Method: Object Method: WriteTest.Button
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 11/05/13, 09:28:54
	// ----------------------------------------------------
	//Created : 
	Mods_2013_11
End if 
//
//C_TEXT(WrtTest_codes_txt;WrtTest_txt;WrtTest_Props_txt;WrtTest_FormatTxtBlb_txt;$blob_txt;$blobWords_txt)

//WrtTest_txt:=WR Get selected text (WriteArea)

//C_LONGINT($txtLen_L;$loop_L;$start_L;$end_L)
//WR GET SELECTION (WriteArea;$start_L;$end_L)
//WrtTest_txt:=WR Get text (WriteArea;$start_L;$end_L)
//$txtLen_L:=Length(WrtTest_txt)
//C_BLOB($FormatTxt_blb)

//If ($txtLen_L>0)

//WrtTest_codes_txt:=String(Character code(Substring(WrtTest_txt;1;1)))
//For ($loop_L;2;$txtLen_L)
//WrtTest_codes_txt:=WrtTest_codes_txt+";"+String(Character code(Substring(WrtTest_txt;$loop_L;1)))
//End for 

//Else 
//WrtTest_txt:=""
//WrtTest_codes_txt:=""
//End if 
//$FormatTxt_blb:=WR Get styled text (WriteArea)
//$blob_txt:=BLOB to text($FormatTxt_blb;Mac text without length)
//$txtLen_L:=Length($blob_txt)

//If ($txtLen_L>0)
//WrtTest_FormatTxtBlb_txt:=String(Character code(Substring($blob_txt;1;1)))+"("+Substring($blob_txt;1;1)+")"
//$blobWords_txt:=Substring($blob_txt;1;1)
//For ($loop_L;2;$txtLen_L)
//WrtTest_FormatTxtBlb_txt:=WrtTest_FormatTxtBlb_txt+";"+String(Character code(Substring($blob_txt;$loop_L;1)))

//If (Character code(Substring($blob_txt;$loop_L;1))=0)
//WrtTest_FormatTxtBlb_txt:=WrtTest_FormatTxtBlb_txt+"()"
//$blobWords_txt:=$blobWords_txt+"^"
//Else 
//WrtTest_FormatTxtBlb_txt:=WrtTest_FormatTxtBlb_txt+"("+Substring($blob_txt;$loop_L;1)+")"
//$blobWords_txt:=$blobWords_txt+Substring($blob_txt;$loop_L;1)
//End if 

//End for 
//WrtTest_FormatTxtBlb_txt:=WrtTest_FormatTxtBlb_txt+Char(13)+"words :"+Char(13)+$blobWords_txt

//Else 
//WrtTest_FormatTxtBlb_txt:=""
//End if 

//C_LONGINT($NumChars_L;$style_blob;$blobsize_L;$blobByte_L;$charposinText_L;$charPos_L;$lastpos_L)
//$NumChars_L:=$end_L-$start_L
//$blobsize_L:=BLOB size($FormatTxt_blb)
//For ($charPos_L;1;$NumChars_L)
//  //blob addresses are from 0 to blobSize -1
//$blobByte_L:=$blobsize_L-(2*$charPos_L)  // this steps backwards from the end of the blob
//$charposinText_L:=$end_L-$charPos_L+1
//If ($FormatTxt_blb{$blobByte_L+1}=0)
//  //second byte is 0 , just deal with 1st byte
//Case of 
//: ($FormatTxt_blb{$blobByte_L}=188)
//  //1/4 sign
//  //replacetext(Writearea;$charposinText_L;"1/4")
//: ($FormatTxt_blb{$blobByte_L}=189)
//  //1/2 sign
//  //replacetext(Writearea;$charposinText_L;"1/2")
//: ($FormatTxt_blb{$blobByte_L}=190)
//  //3/4 sign
//  //replacetext(Writearea;$charposinText_L;"3/4")
//End case 

//Else 
//  //second byte is non zero - check combinations

//Case of 
//: (($FormatTxt_blb{$blobByte_L}=Character code("M")) & ($FormatTxt_blb{$blobByte_L+1}=Character code("!")))

//: (($FormatTxt_blb{$blobByte_L}=Character code("N")) & ($FormatTxt_blb{$blobByte_L+1}=Character code("!")))

//: (($FormatTxt_blb{$blobByte_L}=Character code("O")) & ($FormatTxt_blb{$blobByte_L+1}=Character code("!")))

//: (($FormatTxt_blb{$blobByte_L}=Character code("P")) & ($FormatTxt_blb{$blobByte_L+1}=Character code("!")))

//: (($FormatTxt_blb{$blobByte_L}=Character code("Q")) & ($FormatTxt_blb{$blobByte_L+1}=Character code("!")))

//: (($FormatTxt_blb{$blobByte_L}=Character code("R")) & ($FormatTxt_blb{$blobByte_L+1}=Character code("!")))

//: (($FormatTxt_blb{$blobByte_L}=Character code("S")) & ($FormatTxt_blb{$blobByte_L+1}=Character code("!")))

//End case 

//End if 

//End for 
//C_LONGINT($lastpos_L;$wordSt_L;$wordend_L;$wordLen_L;$charloop_L)
//$lastpos_L:=$start_L
//WrtTest_Props_txt:=""
//Repeat 
//WR SET SELECTION (WriteArea;$lastpos_L;$lastpos_L)
//WR SELECT (WriteArea;wr select word)
//WR GET SELECTION (WriteArea;$wordSt_L;$wordend_L)
//$lastPos_L:=$wordend_L+1
//$wordLen_L:=$wordend_L-$wordSt_L
//$FormatTxt_blb:=WR Get styled text (WriteArea)
//$blobsize_L:=BLOB size($FormatTxt_blb)
//For ($charloop_L;1;$wordLen_L)
//$blobByte_L:=$blobsize_L-(2*$charloop_L)  // this steps backwards from the end of the blob
//$charposinText_L:=$wordend_L-$charloop_L+1
//If ($FormatTxt_blb{$blobByte_L+1}=0)
//WrtTest_Props_txt:="[("+String($FormatTxt_blb{$blobByte_L})+") ("+String($FormatTxt_blb{$blobByte_L+1})+")  ("+Char($FormatTxt_blb{$blobByte_L})+") ()] "+WrtTest_Props_txt

//  //second byte is 0 , just deal with 1st byte
//Case of 
//: ($FormatTxt_blb{$blobByte_L}=176)
//  //degree sign
//: ($FormatTxt_blb{$blobByte_L}=177)
//  //plus minus

//: ($FormatTxt_blb{$blobByte_L}=178)
//  //square power
//: ($FormatTxt_blb{$blobByte_L}=179)
//  //cube power

//: ($FormatTxt_blb{$blobByte_L}=188)
//  //1/4 sign
//  //replacetext(Writearea;$charposinText_L;"1/4")
//: ($FormatTxt_blb{$blobByte_L}=189)
//  //1/2 sign
//  //replacetext(Writearea;$charposinText_L;"1/2")
//: ($FormatTxt_blb{$blobByte_L}=190)
//  //3/4 sign
//  //replacetext(Writearea;$charposinText_L;"3/4")
//End case 

//Else 
//  //second byte is non zero - check combinations
//WrtTest_Props_txt:="[("+String($FormatTxt_blb{$blobByte_L})+") ("+String($FormatTxt_blb{$blobByte_L+1})+")  ("+Char($FormatTxt_blb{$blobByte_L})+") ("+Char($FormatTxt_blb{$blobByte_L+1})+")] "+WrtTest_Props_txt

//Case of 
//: (($FormatTxt_blb{$blobByte_L}=Character code("M")) & ($FormatTxt_blb{$blobByte_L+1}=Character code("!")))

//: (($FormatTxt_blb{$blobByte_L}=Character code("N")) & ($FormatTxt_blb{$blobByte_L+1}=Character code("!")))

//: (($FormatTxt_blb{$blobByte_L}=Character code("O")) & ($FormatTxt_blb{$blobByte_L+1}=Character code("!")))

//: (($FormatTxt_blb{$blobByte_L}=Character code("P")) & ($FormatTxt_blb{$blobByte_L+1}=Character code("!")))
//  //1/7 mac only
//: (($FormatTxt_blb{$blobByte_L}=Character code("Q")) & ($FormatTxt_blb{$blobByte_L+1}=Character code("!")))
//  //1/9 mac only
//: (($FormatTxt_blb{$blobByte_L}=Character code("R")) & ($FormatTxt_blb{$blobByte_L+1}=Character code("!")))
//  //1/10 mac only
//: (($FormatTxt_blb{$blobByte_L}=Character code("S")) & ($FormatTxt_blb{$blobByte_L+1}=Character code("!")))
//  //1/3
//: (($FormatTxt_blb{$blobByte_L}=Character code("T")) & ($FormatTxt_blb{$blobByte_L+1}=Character code("!")))
//  //2/3
//: (($FormatTxt_blb{$blobByte_L}=Character code("U")) & ($FormatTxt_blb{$blobByte_L+1}=Character code("!")))
//  //1/5
//: (($FormatTxt_blb{$blobByte_L}=Character code("V")) & ($FormatTxt_blb{$blobByte_L+1}=Character code("!")))
//  //2/5
//: (($FormatTxt_blb{$blobByte_L}=Character code("W")) & ($FormatTxt_blb{$blobByte_L+1}=Character code("!")))
//  //3/5
//: (($FormatTxt_blb{$blobByte_L}=Character code("X")) & ($FormatTxt_blb{$blobByte_L+1}=Character code("!")))
//  //4/5
//: (($FormatTxt_blb{$blobByte_L}=Character code("Y")) & ($FormatTxt_blb{$blobByte_L+1}=Character code("!")))
//  //1/6
//: (($FormatTxt_blb{$blobByte_L}=Character code("Z")) & ($FormatTxt_blb{$blobByte_L+1}=Character code("!")))
//  //5/6
//: (($FormatTxt_blb{$blobByte_L}=Character code("[")) & ($FormatTxt_blb{$blobByte_L+1}=Character code("!")))
//  //1/8
//: (($FormatTxt_blb{$blobByte_L}=Character code("\\")) & ($FormatTxt_blb{$blobByte_L+1}=Character code("!")))
//  //3/8
//: (($FormatTxt_blb{$blobByte_L}=Character code("]")) & ($FormatTxt_blb{$blobByte_L+1}=Character code("!")))
//  //5/8
//: (($FormatTxt_blb{$blobByte_L}=Character code("^")) & ($FormatTxt_blb{$blobByte_L+1}=Character code("!")))
//  //7/8
//End case 

//End if 


//End for 
//WrtTest_Props_txt:=WrtTest_Props_txt+Char(13)
//Until ($lastpos_L>=$end_L)

//  //End Object Method: WriteTest.Button