//%attributes = {"invisible":true}
//Method: ConvertBorderStateNBE
//Description
// Convert an .xml file with NBEs from a Border state to MassDOT
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Created : 
	//Date and time: Mar 7, 2023, 18:09:32
	Mods_2023_03
	// ----------------------------------------------------
	
End if 
//
C_TEXT:C284($borderxmlFile; $ConvertedFile)
$borderxmlFile:=Select document:C905(""; ".xml"; "Select xml file from border state"; 0)
If (OK=1)
	C_OBJECT:C1216($borderxmlFile_o; $converted_o)
	$borderxmlFile_o:=File:C1566(Document; fk platform path:K87:2)
	$ConvertedFile:=$borderxmlFile_o.parent.platformPath+$borderxmlFile_o.name+"-MassDOT"+".xml"
	$converted_o:=File:C1566($ConvertedFile; fk platform path:K87:2)
	If ($converted_o.exists)
	Else 
		$converted_o.create()
	End if 
	
	C_BLOB:C604($XMl_x)
	$XMl_x:=$borderxmlFile_o.getContent()
	
	C_TEXT:C284($NBEXML)
	$NBEXML:=DOM Parse XML variable:C720($XMl_x)
	
	C_TEXT:C284($NBEElmt; $StateElmt; $strucElmt; $childname; $childvalue; $stateCode; $structNum)
	$NBEElmt:=DOM Get first child XML element:C723($NBEXML; $childname; $childvalue)
	C_BOOLEAN:C305($StructNotFound)
	$StructNotFound:=False:C215
	While (OK=1)
		$StateElmt:=DOM Find XML element:C864($NBEElmt; "/FHWAED/STATE")
		DOM GET XML ELEMENT VALUE:C731($StateElmt; $stateCode)
		DOM SET XML ELEMENT VALUE:C868($StateElmt; "25")  // 25 is Mass state code
		$strucElmt:=DOM Find XML element:C864($NBEElmt; "/FHWAED/STRUCNUM")
		DOM GET XML ELEMENT VALUE:C731($strucElmt; $structNum)
		QUERY:C277([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]Item99:74=$structNum; *)
		QUERY:C277([Bridge MHD NBIS:1];  & ; [Bridge MHD NBIS:1]Item98A:72=$stateCode+"@")  //statecode in xml is the first two digits of 98A
		
		If (Records in selection:C76([Bridge MHD NBIS:1])=1)
			
			If ([Bridge MHD NBIS:1]FHWAItem8:229#"")
				DOM SET XML ELEMENT VALUE:C868($strucElmt; [Bridge MHD NBIS:1]FHWAItem8:229)
			Else 
				DOM SET XML ELEMENT VALUE:C868($strucElmt; [Bridge MHD NBIS:1]Item8:206)
			End if 
		Else 
			DOM SET XML ELEMENT VALUE:C868($strucElmt; $structNum+" not found in Item99")
			$StructNotFound:=True:C214
		End if 
		
		$NBEElmt:=DOM Get next sibling XML element:C724($NBEElmt; $childname; $childvalue)
		
	End while 
	
	DOM EXPORT TO FILE:C862($NBEXML; $ConvertedFile)
	
	DOM CLOSE XML:C722($NBEXML)
	If ($StructNotFound)
		ALERT:C41("There were structure numbers in the source xml that were not found in the database!"+\
			" Open the resulting xml to search for them!")
	End if 
	SHOW ON DISK:C922($ConvertedFile)
End if 

//End ConvertBorderStateNBE   