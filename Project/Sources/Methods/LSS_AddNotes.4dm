//%attributes = {"invisible":true}
//Method: LSS_AddNotes
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 09/04/18, 14:28:07
	// ----------------------------------------------------
	//Created : 
	Mods_2018_09
	Mods_2021_Delete
	
End if 
//  //
//C_LONGINT($1;$mainarea)

//$mainarea:=$1

//C_TEXT($2;$3;$Header_txt;$TextToAdd_txt)
//$Header_txt:=$2
//$TextToAdd_txt:=$3

//  //copy the insp comments in the area
//If (Not(vbTopOfPage))  //if at top of page no need to add lines
//WR INSERT TEXT ($mainarea;<>sCR)
//G_ApplySheet ($mainarea;1)
//WR INSERT TEXT ($mainarea;<>sCR)
//End if 


//  //copy the insp comments in the area
//WR SET TEXT PROPERTY ($mainarea;wr bold;1)
//WR SET TEXT PROPERTY ($mainarea;wr underline;1)
//WR INSERT TEXT ($mainarea;$Header_txt+<>sCR)
//WR EXECUTE COMMAND ($mainarea;wr cmd plain)
//WR INSERT TEXT ($mainarea;$TextToAdd_txt)

//G_Insp_ApplyLineSpacing ($mainarea)

//WR SET SELECTION ($mainarea;WR Count ($mainarea;wr nb characters);WR Count ($mainarea;wr nb characters))

//vbTopOfPage:=False  //we have added something to the page   

//  //End LSS_AddNotes