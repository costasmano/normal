//%attributes = {"invisible":true}
If (False:C215)
	// G_ApplySheet 
	//Apply StyleSheet to  a 4D Write Area- apply both text and Paragraph settings.
	
	//$1 : Longint  : Area ID
	//$2 : Longint : Style Sheet number
	Mods_2004_CM11
	
	Mods_2021_Delete
End if 

//C_LONGINT($1;$vlWriteArea;$2;$vlStyleSheetNum)
//$vlWriteArea:=$1
//$vlStyleSheetNum:=$2

//C_TEXT($vsStyleName)  // Command Replaced was o_C_STRING length was 132
//C_TEXT($vsStyleShort)  // Command Replaced was o_C_STRING length was 1
//C_LONGINT($viStyleApply;$viStyleProt)  //Command Replaced was o_C_INTEGER

//WR GET STYLESHEET INFO ($vlWriteArea;$vlStyleSheetNum;$vsStyleName;$viStyleApply;$viStyleProt;$vsStyleShort)
//WR SET STYLESHEET INFO ($vlWriteArea;$vlStyleSheetNum;"";1;"")  //apply to Paragraph
//WR APPLY STYLESHEET ($vlWriteArea;$vlStyleSheetNum)
//WR SET STYLESHEET INFO ($vlWriteArea;$vlStyleSheetNum;"";0;"")  //apply to text
//WR APPLY STYLESHEET ($vlWriteArea;$vlStyleSheetNum)
//WR SET STYLESHEET INFO ($vlWriteArea;$vlStyleSheetNum;$vsStyleName;$viStyleApply;$vsStyleShort)