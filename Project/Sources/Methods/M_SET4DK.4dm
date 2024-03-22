//%attributes = {"invisible":true}
//  //$1 resource ID
//  //$2 destination file
//C_LONGINT($1)
//C_TIME($2)

//C_BLOB($blob)
//C_LONGINT($t;$i)  //Command Replaced was o_C_INTEGER
//$t:=Size of array(StringVal)
//  //maximum length is 102 characters
//ARRAY TEXT($Constants;$t)  //Command Replaced was o_ARRAY string length was 102

//For ($i;1;$t)
//$Constants{$i}:=String4DK{$i}+":"+StringVal{$i}+":"+StringT{$i}
//End for 

//_ o_ARRAY TO STRING LIST($Constants;MAXINT-2;$2)
//GET RESOURCE("STR#";MAXINT-2;$blob;$2)
//_ o_DELETE RESOURCE("STR#";MAXINT-2;$2)
//_ o_SET RESOURCE("4DK#";$1;$blob;$2)
//_ o_SET RESOURCE NAME("4DK#";$1;vResourceName;$2)

