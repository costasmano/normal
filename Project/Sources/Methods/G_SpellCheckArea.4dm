//%attributes = {"invisible":true}
If (False:C215)
	//Project Method G_SpellCheckArea
	//Esecute a Spell Check on an area and save changes to the field.
	
	Mods_2005_CM05
	// Modified by: costasmanousakis-(Designer)-(8/21/08 09:18:20)
	Mods_2008_CM_5404
	//  `Fixed coding; adjusted where selection is left at the end of routine.
	Mods_2011_06  // CJ Miller`06/13/11, 17:07:50      ` Type all local variables for v11
	Mods_2021_Delete
End if 

//C_LONGINT($1;$MyArea)  //4D Write Area ID
//C_POINTER($2;$MyField)  //Pointer to Field used in the 4D Write Area
//C_LONGINT($3;$MyStack)  //Command Replaced was o_C_INTEGER//Stack number in the Changes log
//$MyArea:=$1
//$MyField:=$2
//$MyStack:=$3
//C_LONGINT($vStartSel;$vEndSel)
//WR GET SELECTION ($MyArea;$vStartSel;$vEndSel)
//WR EXECUTE COMMAND ($MyArea;wr cmd spellcheck)
//C_LONGINT($viAreaMod)  //Command Replaced was o_C_INTEGER
//C_TEXT($vsStrValue)  // Command Replaced was o_C_STRING length was 2//needed only for WR Get Area Prop call
//WR GET AREA PROPERTY ($MyArea;wr modified;$viAreaMod;$vsStrValue)
//If ($viAreaMod=1)
//If (WR Count ($MyArea;wr nb words)>0)
//WR EXECUTE COMMAND ($MyArea;wr cmd select all)
//$MyField->:=WR Get styled text ($MyArea)
//WR SET SELECTION ($MyArea;$vStartSel;$vEndSel)
//Else 
//  //delete inspection comments
//SET BLOB SIZE($MyField->;0)
//End if 
//PushChange ($MyStack;$MyField)
//WR SET AREA PROPERTY ($MyArea;wr modified;0;"")
//End if 
//WR UPDATE MODE ($MyArea;0)
//C_LONGINT($Count_l;$First_l;$ascii_l;$Length_l;$loop_l)
//C_TEXT($text)

//$Length_l:=WR Count ($MyArea;wr nb characters)
//$Count_l:=0
//For ($loop_l;1;$Length_l)
//WR SET SELECTION ($MyArea;$loop_l-1;$loop_l)
//$text:=WR Get selected text ($MyArea)
//If (Character code($text)=0)
//If ($First_l=0)
//$First_l:=$Loop_l
//End if 
//$Count_l:=$Count_l+1
//End if 
//End for 

//If ($Count_l>0)
//C_TEXT($Alert_txt)
//$Alert_txt:="You have "+String($Count_l)+" illegal characters in your text!"
//$Alert_txt:=$Alert_txt+<>sCR+"Press Return to go to the first offending character!"
//ALERT($Alert_txt)
//WR SCROLL TO SELECTION ($MyArea)
//WR SET SELECTION ($MyArea;$First_l-1;$First_l)
//Else 
//WR SET SELECTION ($MyArea;$vStartSel;$vEndSel)
//End if 