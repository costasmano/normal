//Method: Object Method: WebAreaTest.Button
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 11/06/13, 13:45:07
	// ----------------------------------------------------
	//Created : 
	Mods_2013_11
End if 
//
//WA EXECUTE JAVASCRIPT FUNCTION(web area;"From4DzoomBounds")
//
//ALERT("done 1")
QUERY:C277([Bridge MHD NBIS:1])
C_POINTER:C301($area)
$area:=OBJECT Get pointer:C1124(Object named:K67:5; "web area")

If (OK=1)
	
	If (Records in selection:C76([Bridge MHD NBIS:1])>0)
		MAP_GetData
		C_TEXT:C284($file_txt)
		$file_txt:=Convert path system to POSIX:C1106(MAP_HTMLOutputFile_txt)
		Web Area_url:="file:///"+$file_txt
		SHOW ON DISK:C922(MAP_HTMLOutputFile_txt)
		//WA OPEN URL(Web Area;"file://"+$file_txt)
		WA REFRESH CURRENT URL:C1023(*; "Web area")
		
	End if 
	
End if 

//End Object Method: WebAreaTest.Button