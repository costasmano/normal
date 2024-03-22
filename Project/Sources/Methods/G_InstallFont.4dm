//%attributes = {"invisible":true}
If (False:C215)
	//G_InstallFont 
	// Modified by: costasmanousakis-(Designer)-(4/22/09 16:05:57)
	Mods_2009_04
	//  `Use the new Get 4D folder(4D Client Database Folder) in v 2004 to get the set the 4DX folder in Client mode
End if 

C_TEXT:C284($sysfontDir; $TEMPFOLDER; $SourceFile)
$sysfontDir:=System folder:C487(Fonts:K41:2)
$TEMPFOLDER:=Temporary folder:C486
ARRAY TEXT:C222($FontList_atxt; 0)
FONT LIST:C460($FontList_atxt)
If (Find in array:C230($FontList_atxt; "CODE 39")<=0)
	Case of 
		: (Application type:C494=4D Remote mode:K5:5)
			$SourceFile:=Get 4D folder:C485(4D Client database folder:K5:13)+"WIN4DX"+<>PL_DirectorySep_s
			$SourceFile:=$SourceFile+"CODE39.TTF"
	End case 
	
	If (Test path name:C476($sysfontDir+"CODE39.ttf")=Is a document:K24:1)
	Else 
		ALERT:C41("Font not heree!")
		If (Test path name:C476($SourceFile)=Is a document:K24:1)
			COPY DOCUMENT:C541($SourceFile; $sysfontDir+"CODE39.TTF")
		Else 
			ALERT:C41("SOURCE FONT FILE NOT FOUND")
		End if 
	End if 
	
End if 
