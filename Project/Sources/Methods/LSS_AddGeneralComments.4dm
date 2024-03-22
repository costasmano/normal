//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): administrator
//Date and time: 12/04/14, 10:37:10
//----------------------------------------------------
//Method: LSS_AddGeneralComments
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2014_Lighting  // 
	//Modified by: administrator (12/4/14 10:37:11)
	Mods_2021_Delete
	
End if 
//C_LONGINT($1;$mainarea)

//$mainarea:=$1

//  //copy the insp comments in the area
//If (Not(vbTopOfPage))  //if at top of page no need to add lines
//WR INSERT TEXT ($mainarea;<>sCR)
//G_ApplySheet ($mainarea;1)
//WR INSERT TEXT ($mainarea;<>sCR)
//End if 


//  //copy the insp comments in the area
//WR SET TEXT PROPERTY ($mainarea;wr bold;1)
//WR SET TEXT PROPERTY ($mainarea;wr underline;1)
//WR INSERT TEXT ($mainarea;"GENERAL REMARKS"+<>sCR)
//WR EXECUTE COMMAND ($mainarea;wr cmd plain)
//WR INSERT TEXT ($mainarea;[LSS_Inspection]LSS_GeneralComments_txt)

//G_Insp_ApplyLineSpacing ($mainarea)

//WR SET SELECTION ($mainarea;WR Count ($mainarea;wr nb characters);WR Count ($mainarea;wr nb characters))

//vbTopOfPage:=False  //we have added something to the page   
//  //End LSS_AddGeneralComments

