//%attributes = {"invisible":true}
If (False:C215)
	//G_Trimlines
	//Trim trailing blank lines,tabs, and spaces from a 4D write area.
	
	//$1 : 4D write area
	Mods_2021_Delete
	
End if 

//C_LONGINT($1;$MyArea)
//C_LONGINT($vchars;$i;$vCcode;$vlbegin;$vlEnd;$vlNumBreaks)
//$MyArea:=$1
//$vchars:=WR Count ($MyArea;wr nb characters)
//For ($i;$vchars;0;-1)  //start from the end
//WR SET SELECTION ($MyArea;($i-1);$i)
//$vCcode:=Character code(WR Get text ($MyArea;($i-1);$i))
//If (($vCcode=Carriage return) | ($vCcode=Space) | ($vCcode=Tab))
//WR DELETE SELECTION ($MyArea)  //delete spaces ,tabs, or linefeeds.    
//Else 
//$i:=0  //end search    
//End if 
//End for 
//$vlNumBreaks:=WR Count ($MyArea;wr nb page breaks)
//For ($i;1;$vlNumBreaks)
//WR SELECT ($MyArea;7;1;1)
//WR GET SELECTION ($MyArea;$vlbegin;$vlEnd)
//WR SET SELECTION ($MyArea;$vlEnd;$vlEnd)
//WR BACKSPACE ($MyArea)
//End for 