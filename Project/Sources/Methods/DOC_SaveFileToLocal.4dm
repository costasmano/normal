//%attributes = {"invisible":true}
//Method: DOC_SaveFileToLocal
//Description
// Save a document stored in a Templates record to a local file
// Templates record should be a DOC_ type where the default filename and the doc
// are stored in the Template_ blob field
// Can be called from a menu using the menu item parameter to specify the template 
// or with the template name as parameter 1
// for menu item parameter to work, the menu item should be executed in the same process
// Parameters
// $1 : $Template_txt : 
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Created : 
	//Date and time: Dec 14, 2023, 18:49:03
	Mods_2023_12
	// ----------------------------------------------------
	
	C_TEXT:C284(DOC_SaveFileToLocal; $1)
End if 
//
C_TEXT:C284($par_txt)

If (Count parameters:C259=1)
	$par_txt:=$1
Else 
	$par_txt:=Get selected menu item parameter:C1005
End if 

Case of 
	: ($par_txt="")
		ALERT:C41("Blank Template name passed to "+Current method name:C684+"\nCall Chain:\n"+\
			JSON Stringify:C1217(Get call chain:C1662; *))
		
	Else 
		C_OBJECT:C1216($templ_o)
		READ ONLY:C145([Templates:86])
		QUERY:C277([Templates:86]; [Templates:86]TemplateName:2=$par_txt)
		
		If (Records in selection:C76([Templates:86])=1)
			C_BLOB:C604($DocBlob_x; $FullBlob_x)
			If (BLOB size:C605([Templates:86]Template_:3)>0)
				C_TEXT:C284($FileName_txt; $PathToStore_txt)
				C_LONGINT:C283($offset_L)
				$offset_L:=0
				BLOB TO VARIABLE:C533([Templates:86]Template_:3; $FileName_txt; $offset_L)
				BLOB TO VARIABLE:C533([Templates:86]Template_:3; $DocBlob_x; $offset_L)
				$PathToStore_txt:=Select folder:C670("Select Folder to store the created file")
				If (OK=1)
					C_BOOLEAN:C305($Create_b)
					$Create_b:=True:C214
					If (Test path name:C476($PathToStore_txt+$FileName_txt)=Is a document:K24:1)
						//file exists!!! 
						$Create_b:=False:C215
						
						CONFIRM:C162("File "+$FileName_txt+" already exists!  Replace?"; "Cancel"; "Replace")
						If (OK=0)
							$Create_b:=True:C214
						End if 
						
					End if 
					If ($Create_b)
						
						BLOB TO DOCUMENT:C526(($PathToStore_txt+$FileName_txt); $DocBlob_x)
						If (OK=1)
							ut_OpenDocument($PathToStore_txt+$FileName_txt)
						End if 
						
					End if 
					
				End if 
				
			End if 
			
			SET BLOB SIZE:C606($DocBlob_x; 0)
			SET BLOB SIZE:C606($FullBlob_x; 0)
		Else 
			ALERT:C41("Document Template "+$par_txt+" not found!"+"\nCall Chain:\n"+\
				JSON Stringify:C1217(Get call chain:C1662; *))
		End if 
		
End case 

//End DOC_SaveFileToLocal   