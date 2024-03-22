//%attributes = {"invisible":true}
If (False:C215)
	//Procedure: FilesToArray(array ptr;array ptr)
	//Created By:  Tom Nee
	//Date:  2/2/98
	
	//Legend:
	//$1 - pointer to array to put fieldnames into.
	//$2 - pointer to array to put pointers to fields into.
	
	//Purpose:
	//Copies file names into an array and copies file pointers into second array.
	//Modified :
	//Dec-2001 : Get only tables that are visible.
	// Modified by: Costas Manousakis-(Designer)-(9/2/20 17:28:18)
	Mods_2020_09_bug
	//  `convert from using AP pack
	
End if 

C_POINTER:C301($1; $2)
C_LONGINT:C283($i; $vTableVisible; $vTableDestruct; $vInfoResult)
C_BOOLEAN:C305($invis_b)

For ($i; 1; Get last table number:C254)
	GET TABLE PROPERTIES:C687($i; $invis_b)
	//$vInfoResult:=AP Get table info ($i;$vTableVisible;$vTableDestruct)
	If (Not:C34($invis_b))
		//INSERT IN ARRAY($1->;$i)
		//$1->{Size of array($1->)}:=Table name($i)
		//INSERT IN ARRAY($2->;$i)
		//$2->{Size of array($2->)}:=Table($i)
		APPEND TO ARRAY:C911($1->; Table name:C256($i))
		APPEND TO ARRAY:C911($2->; Table:C252($i))
	End if 
End for 
//End of procedure 