//%attributes = {"invisible":true}
//Method: LSS_ExportInspElmtConfig
//Description
// Utility Method to export to files in csv format the current configuration of Elements
// by inspection type as defined in table [LSS_refInspectionType]
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Created : 
	//Date and time: May 3, 2024, 14:55:05
	Mods_2024_05
	// ----------------------------------------------------
	
End if 
//

C_TEXT:C284($file_; $folder_)
$folder_:=Select folder:C670("Select folder where the CSV files will be placed")

If (OK=1)
	
	C_OBJECT:C1216($file_o)
	C_TEXT:C284($b_x)
	C_OBJECT:C1216($insptypes_es; $insptype_e)
	$insptypes_es:=ds:C1482.LSS_refInspectionType.all()
	C_COLLECTION:C1488($elemdescParts_c)
	For each ($insptype_e; $insptypes_es)
		LSS_CreateElementArraysForQuery($insptype_e.LSS_AllowedElements_txt; True:C214)
		C_LONGINT:C283($i)
		For ($i; 1; Size of array:C274(v_162_002_atxt))
			
			If (v_162_002_atxt{$i}="@blank element@")
				$elemdescParts_c:=Split string:C1554(v_162_002_atxt{$i}; " "; sk trim spaces:K86:2)
				
				If ($elemdescParts_c.length>2)
					v_162_002_atxt{$i}:=$elemdescParts_c[0]+" "+$elemdescParts_c[2]
					
				End if 
				
			End if 
			
		End for 
		
		$b_x:=ut_ArrayToText_CSV(","; ->v_162_001_aL; ->LSS_Headers_atxt; ->v_162_002_atxt)
		$b_x:="ElementID,Section,Description"+Char:C90(Carriage return:K15:38)+$b_x
		$file_o:=File:C1566($folder_+Substring:C12($insptype_e.LSS_InspectionTypeId_s; 1; 2)+"_"+$insptype_e.LSS_Description_txt+".csv"; fk platform path:K87:2)
		$file_o.setText($b_x)
	End for each 
	
	SHOW ON DISK:C922($folder_)
	
End if 

//End LSS_ExportInspElmtConfig   