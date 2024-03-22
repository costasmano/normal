If (False:C215)
	// **************************************************************************************
	// This button should be deleted once its script has been executed.
	// Its goal is to copy certain resources from the 4D application into your database
	// The resources are used inside the buttons and in the color menu. Some .xlf files
	// **************************************************************************************
	
	
	C_LONGINT:C283($j; $k; $m; $n)
	C_TEXT:C284($4DResourcesFolder; $4dRsrFolder; $4dSubfolder)
	C_TEXT:C284($LocalResourcesFolder; $localRsrFolder; $LocalSubfolder)
	C_TEXT:C284($4dXlif; $localXlif)
	//_O_PLATFORM PROPERTIES($platform)// MassDOT_PS - conversion v19R7
	If (Is Windows:C1573)
		$4DResourcesFolder:=Application file:C491
		$n:=Length:C16($4DResourcesFolder)
		Repeat 
			$n:=$n-1
		Until ($4DResourcesFolder[[$n]]=Folder separator:K24:12)
		$4DResourcesFolder:=Substring:C12($4DResourcesFolder; 1; $n)+"Resources"+Folder separator:K24:12+"ObjectLib.4DLibrary"+Folder separator:K24:12+"Resources"+Folder separator:K24:12
	Else 
		$4DResourcesFolder:=Application file:C491+Folder separator:K24:12+"Contents"+Folder separator:K24:12+"Resources"+Folder separator:K24:12+"ObjectLib.4DLibrary"+Folder separator:K24:12+"Resources"+Folder separator:K24:12
	End if 
	
	$LocalResourcesFolder:=Get 4D folder:C485(Current resources folder:K5:16)
	
	If (Test path name:C476($4DResourcesFolder)=Is a folder:K24:2)
		
		//#1 copy .lproj folder
		ARRAY TEXT:C222($_Folders; 0)
		ARRAY TEXT:C222($_Files; 0)
		FOLDER LIST:C473($4DResourcesFolder; $_Folders)
		C_LONGINT:C283($i)
		For ($i; 1; Size of array:C274($_Folders))
			Case of 
					
				: ($_Folders{$i}="@.lproj")
					$4dRsrFolder:=$4DResourcesFolder+$_Folders{$i}+Folder separator:K24:12+"RTA4D"+Folder separator:K24:12+"Styles"+Folder separator:K24:12
					
					If (Test path name:C476($4dRsrFolder)=Is a folder:K24:2)
						
						$localRsrFolder:=$LocalResourcesFolder+$_Folders{$i}+Folder separator:K24:12
						If (Test path name:C476($localRsrFolder)#Is a folder:K24:2)
							CREATE FOLDER:C475($localRsrFolder)
						End if 
						$localRsrFolder:=$localRsrFolder+"RTA4D"+Folder separator:K24:12
						If (Test path name:C476($localRsrFolder)#Is a folder:K24:2)
							CREATE FOLDER:C475($localRsrFolder)
						End if 
						$localRsrFolder:=$localRsrFolder+"Styles"+Folder separator:K24:12
						If (Test path name:C476($localRsrFolder)#Is a folder:K24:2)
							CREATE FOLDER:C475($localRsrFolder)
						End if 
						
						ARRAY TEXT:C222($_Files; 0)
						DOCUMENT LIST:C474($4dRsrFolder; $_Files)
						For ($j; 1; Size of array:C274($_Files))
							If (Test path name:C476($localRsrFolder+$_Files{$j})#Is a document:K24:1)
								COPY DOCUMENT:C541($4dRsrFolder+$_Files{$j}; $localRsrFolder+$_Files{$j})
							End if 
						End for 
						
					End if 
					
					$4dXlif:=$4DResourcesFolder+$_Folders{$i}+Folder separator:K24:12+"RTA4D.xlf"
					$localXlif:=$LocalResourcesFolder+$_Folders{$i}+Folder separator:K24:12+"RTA4D.xlf"
					If (Test path name:C476($4dXlif)=Is a document:K24:1) & (Test path name:C476($localXlif)#Is a document:K24:1)
						COPY DOCUMENT:C541($4dXlif; $localXlif)
					End if 
					
				: ($_Folders{$i}="RTA4D")
					
					$4dRsrFolder:=$4DResourcesFolder+"RTA4D"+Folder separator:K24:12
					$localRsrFolder:=$LocalResourcesFolder+"RTA4D"+Folder separator:K24:12
					
					If (Test path name:C476($localRsrFolder)#Is a folder:K24:2)
						CREATE FOLDER:C475($localRsrFolder)
					End if 
					
					ARRAY TEXT:C222($_Subfolders; 0)
					FOLDER LIST:C473($4dRsrFolder; $_Subfolders)  // Functions, Styles…
					
					For ($k; 1; Size of array:C274($_Subfolders))
						
						$4dSubfolder:=$4dRsrFolder+$_Subfolders{$k}+Folder separator:K24:12
						$LocalSubfolder:=$localRsrFolder+$_Subfolders{$k}+Folder separator:K24:12
						If (Test path name:C476($LocalSubfolder)#Is a folder:K24:2)
							CREATE FOLDER:C475($LocalSubfolder)
						End if 
						
						DOCUMENT LIST:C474($4dRsrFolder+$_Subfolders{$k}; $_Files)
						
						For ($m; 1; Size of array:C274($_Files))
							If (Test path name:C476($LocalSubfolder+$_Files{$m})#Is a document:K24:1)
								COPY DOCUMENT:C541($4dSubfolder+$_Files{$m}; $LocalSubfolder+$_Files{$m})
							End if 
						End for 
						
					End for 
			End case 
			
			
		End for 
		
	End if 
	
End if 