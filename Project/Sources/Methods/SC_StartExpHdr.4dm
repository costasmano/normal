//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 03/10/06, 15:58:05
	// ----------------------------------------------------
	// Method: SC_StartExpHdr
	// Description
	// Initialize export file with calcs for Scour Calcs
	// 
	// Parameters
	// ----------------------------------------------------
	Mods_2006_CM03
	// Modified by: costasmanousakis-(Designer)-(5/27/11 10:49:57)
	Mods_2011_05
	//  `Allow user to select the folder where to save the report.
	//  `This gives a complete path in Document, so no need to figure out later where the file is.
	//  `If user cancels, default folder will be chosen and shown to user
End if 
C_TEXT:C284($0)

If (SC_SAVEASHTML_i>0)
	
	C_TEXT:C284($ExpFile)
	$ExpFile:="ScourCalc_"+ut_ReturnTimeStampFromDate(Current date:C33(*); Current time:C178(*))+".xls"
	C_TIME:C306(vScourCalcDocRef)
	C_TEXT:C284(SC_DataColumnStart_txt)
	C_TEXT:C284($TargetFolder_txt)
	$TargetFolder_txt:=Select folder:C670("Please Choose Folder to save Report")
	If ($TargetFolder_txt="")
		
		//$TargetFolder_txt:=Get 4D folder
		Case of 
			: ((Application type:C494=4D Local mode:K5:1) | (Application type:C494=4D Server:K5:6))  //| (Application type=_o_4D Interpreted desktop) 
				//next to structure file
				$TargetFolder_txt:=GetPath(Structure file:C489)
			: (Application type:C494=4D Volume desktop:K5:2)
				$TargetFolder_txt:=GetPath(Application file:C491)
			: (Application type:C494=4D Remote mode:K5:5)
				//put in the Active 4D folder
				$TargetFolder_txt:=Get 4D folder:C485(Active 4D Folder:K5:10)
		End case 
		ALERT:C41("Report file will be created in "+$TargetFolder_txt)
		//SHOW ON DISK($TargetFolder_txt;*)
	End if 
	
	$ExpFile:=$TargetFolder_txt+$ExpFile
	Case of 
		: (SC_SAVEASHTML_i=1)
			
			vScourCalcDocRef:=Create document:C266($ExpFile; "HTML")
			//_ O _SET DOCUMENT CREATOR($ExpFile;"XCEL")
			SC_DataColumnStart_txt:="<td bgcolor="+<>sQU+"#FFFFFF"+<>sQU+"><Font name="+<>sQU+"Geneva"+<>sQU+" color="+<>sQU+"#000000"+<>sQU+">"
			$0:=Document
		: (SC_SAVEASHTML_i=2)
			vScourCalcDocRef:=Create document:C266($ExpFile; "XMLS")
			//_ O _SET DOCUMENT CREATOR($ExpFile;"XCEL")
			//SC_DataColumnStart_txt:="<Cell ss:StyleID="+◊sQU+"s23"+◊sQU+"><Data ss:Type="
			SC_DataColumnStart_txt:="<Cell><Data ss:Type="
			$0:=Document
	End case 
	
	SC_WriteFileHeaderInfo
	SC_WriteDataHeader
Else 
	$0:=""
End if 