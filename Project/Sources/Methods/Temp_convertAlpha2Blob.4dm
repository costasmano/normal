//%attributes = {"invisible":true}
If (False:C215)
	Mods_2021_Delete
	//Temp_convertAlpha2Blob
	//Transfer Alpha fields in Inspections and elementssafety to blob fields
	
	//ALL RECORDS([Inspections])
	//C_LONGINT($i;$vNumRecs;$numwords)
	//C_LONGINT($temparea)
	//$vNumRecs:=Records in selection([Inspections])
	//FIRST RECORD([Inspections])
	//For ($i;1;$vNumRecs)
	//If (Length([Inspections]DamageCmtsPg1)>0)
	//$temparea:=WR New offscreen area 
	//Set Doc Margins ($temparea)
	//  //first copy any existing stuff in the blob field
	//If (BLOB size([Inspections]InspComments)>0)
	//WR INSERT STYLED TEXT ($temparea;[Inspections]InspComments)
	//WR INSERT TEXT ($temparea;<>sCR)  //add a line feed
	//End if 
	//WR INSERT TEXT ($temparea;[Inspections]DamageCmtsPg1)
	//$numwords:=WR Count ($temparea;wr nb words)
	//If ($numwords>0)
	//G_Trimlines ($temparea)
	//WR EXECUTE COMMAND ($temparea;wr cmd select all)
	//[Inspections]InspComments:=WR Get styled text ($temparea)
	//Else 
	//SET BLOB SIZE([Inspections]InspComments;0)
	//End if 
	//WR DELETE OFFSCREEN AREA ($temparea)
	//SAVE RECORD([Inspections])
	//End if 
	//NEXT RECORD([Inspections])
	//End for 
	
	//ALL RECORDS([ElementsSafety])
	//$vNumRecs:=Records in selection([ElementsSafety])
	//FIRST RECORD([ElementsSafety])
	//For ($i;1;$vNumRecs)
	//If (Length([ElementsSafety]Comments)>0)
	//$temparea:=WR New offscreen area 
	//Set Doc Margins ($temparea)
	//  //first copy any existing stuff in the blob field
	//If (BLOB size([ElementsSafety]ElmComments)>0)
	//WR INSERT STYLED TEXT ($temparea;[ElementsSafety]ElmComments)
	//WR INSERT TEXT ($temparea;<>sCR)  //add a line feed
	//End if 
	//WR INSERT TEXT ($temparea;[ElementsSafety]Comments)
	//$numwords:=WR Count ($temparea;wr nb words)
	//If ($numwords>0)
	//G_Trimlines ($temparea)
	//WR EXECUTE COMMAND ($temparea;wr cmd select all)
	//[ElementsSafety]ElmComments:=WR Get styled text ($temparea)
	//[ElementsSafety]Comment Flag:=True
	//Else 
	//SET BLOB SIZE([ElementsSafety]ElmComments;0)
	//[ElementsSafety]Comment Flag:=False
	//End if 
	//WR DELETE OFFSCREEN AREA ($temparea)
	//SAVE RECORD([ElementsSafety])
	//End if 
	//NEXT RECORD([ElementsSafety])
	//End for 
End if 
