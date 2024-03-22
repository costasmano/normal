//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 09/08/14, 09:29:17
//----------------------------------------------------
//Method: clone_CreateSQLLimits
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2018_06
	Mods_2020_01  //Make sure that tables with blobs only get 100 at a time FROM BF
	//Modified by: CJ (1/14/20 11:45:03)
	
End if 


C_LONGINT:C283($Loop_L; $Limit_L; $Count_L; $UniqueFldNumber_l)
C_TEXT:C284($ListValue_txt; $TableName_txt; $Variable_txt)
ARRAY TEXT:C222(SQL_LimitNames_atxt; 0)
ARRAY LONGINT:C221(SQL_Limits_AL; 0)
ARRAY LONGINT:C221($Limits_aL; 0)
C_BOOLEAN:C305($ProcessMe_b)
C_BOOLEAN:C305($HasPictureOrBlob_b)
C_BOOLEAN:C305($UseTableName_B)
For ($Loop_L; 1; Get last table number:C254)
	If (Is table number valid:C999($Loop_L))
		$HasPictureOrBlob_b:=clone_ReturnUniqueKeys($Loop_L; ->$UniqueFldNumber_l; ->$Variable_txt; True:C214)
		
		$TableName_txt:=Table name:C256($Loop_L)
		$ProcessMe_b:=True:C214
		Case of 
			: ($HasPictureOrBlob_b)
				$ListValue_txt:=$TableName_txt
				$Limit_L:=100
			: (Get last field number:C255($Loop_L)>250)
				$ListValue_txt:="251"
				$Limit_L:=100
			: (Get last field number:C255($Loop_L)>200)
				$ListValue_txt:="201"
				$Limit_L:=250
			: (Get last field number:C255($Loop_L)>150)
				$ListValue_txt:="151"
				$Limit_L:=400
			: (Get last field number:C255($Loop_L)>100)
				$ListValue_txt:="101"
				$Limit_L:=500
			: (Get last field number:C255($Loop_L)>50)
				$ListValue_txt:="51"
				$Limit_L:=1000
			: (Get last field number:C255($Loop_L)>25)
				$ListValue_txt:="26"
				$Limit_L:=5000
			: (Get last field number:C255($Loop_L)>10)
				$ListValue_txt:="11"
				$Limit_L:=7500
			Else 
				$ListValue_txt:="0"
				$Limit_L:=25000
		End case 
		
		$UseTableName_B:=True:C214
		Case of 
			: ($TableName_txt="DCM_Contracts")
				QUERY:C277([TableOfLists:125]; [TableOfLists:125]ListValue_s:2=$TableName_txt)
			: ($TableName_txt="DCM_Project")
				QUERY:C277([TableOfLists:125]; [TableOfLists:125]ListValue_s:2=$TableName_txt)
			: ($TableName_txt="ElementsSafety")
				QUERY:C277([TableOfLists:125]; [TableOfLists:125]ListValue_s:2=$TableName_txt)
			: ($TableName_txt="Inspections")
				QUERY:C277([TableOfLists:125]; [TableOfLists:125]ListValue_s:2=$TableName_txt)
			: ($TableName_txt="IS_ControlProcess")
				QUERY:C277([TableOfLists:125]; [TableOfLists:125]ListValue_s:2=$TableName_txt)
			: ($TableName_txt="PRJ_ConstructionProject")
				QUERY:C277([TableOfLists:125]; [TableOfLists:125]ListValue_s:2=$TableName_txt)
			: ($TableName_txt="ScourPOA")
				QUERY:C277([TableOfLists:125]; [TableOfLists:125]ListValue_s:2=$TableName_txt)
			: ($TableName_txt="ScourPOA_Images")
				QUERY:C277([TableOfLists:125]; [TableOfLists:125]ListValue_s:2=$TableName_txt)
			: ($TableName_txt="Templates")
				QUERY:C277([TableOfLists:125]; [TableOfLists:125]ListValue_s:2=$TableName_txt)
			: ($TableName_txt="TIN_Insp_Images")
				QUERY:C277([TableOfLists:125]; [TableOfLists:125]ListValue_s:2=$TableName_txt)
			: ($TableName_txt="Work_Estimate")
				QUERY:C277([TableOfLists:125]; [TableOfLists:125]ListValue_s:2=$TableName_txt)
			: ($TableName_txt="WorkHour_Config")
				QUERY:C277([TableOfLists:125]; [TableOfLists:125]ListValue_s:2=$TableName_txt)
				
			: ($TableName_txt="InventoryPhotos")
				QUERY:C277([TableOfLists:125]; [TableOfLists:125]ListValue_s:2=$TableName_txt)
				
			: ($TableName_txt="Standard Photos")
				QUERY:C277([TableOfLists:125]; [TableOfLists:125]ListValue_s:2=$TableName_txt)
				
			: ($TableName_txt="LSS_Photos")
				QUERY:C277([TableOfLists:125]; [TableOfLists:125]ListValue_s:2=$TableName_txt)
				
			Else 
				$UseTableName_B:=False:C215
				If (Find in array:C230($Limits_aL; $Limit_L)>0)
					$ProcessMe_b:=False:C215
				Else 
					QUERY:C277([TableOfLists:125]; [TableOfLists:125]ListValue_s:2=$ListValue_txt)
					APPEND TO ARRAY:C911($Limits_aL; $Limit_L)
				End if 
				QUERY SELECTION:C341([TableOfLists:125]; [TableOfLists:125]ListSequence_l:3=$Limit_L)
		End case 
		If ($ProcessMe_b)
			$Count_L:=Records in selection:C76([TableOfLists:125])
			If ($Count_L=0)
				CREATE RECORD:C68([TableOfLists:125])
				[TableOfLists:125]ListName_s:1:="SQL_Limits"
				Case of 
					: ($TableName_txt="DCM_Contracts")
						[TableOfLists:125]ListValue_s:2:=$TableName_txt
						[TableOfLists:125]ListSequence_l:3:=100
					: ($TableName_txt="DCM_Project")
						[TableOfLists:125]ListValue_s:2:=$TableName_txt
						[TableOfLists:125]ListSequence_l:3:=100
					: ($TableName_txt="ElementsSafety")
						[TableOfLists:125]ListValue_s:2:=$TableName_txt
						[TableOfLists:125]ListSequence_l:3:=100
					: ($TableName_txt="Inspections")
						[TableOfLists:125]ListValue_s:2:=$TableName_txt
						[TableOfLists:125]ListSequence_l:3:=100
					: ($TableName_txt="IS_ControlProcess")
						[TableOfLists:125]ListValue_s:2:=$TableName_txt
						[TableOfLists:125]ListSequence_l:3:=100
					: ($TableName_txt="PRJ_ConstructionProject")
						[TableOfLists:125]ListValue_s:2:=$TableName_txt
						[TableOfLists:125]ListSequence_l:3:=100
					: ($TableName_txt="ScourPOA")
						[TableOfLists:125]ListValue_s:2:=$TableName_txt
						[TableOfLists:125]ListSequence_l:3:=100
					: ($TableName_txt="ScourPOA_Images")
						[TableOfLists:125]ListValue_s:2:=$TableName_txt
						[TableOfLists:125]ListSequence_l:3:=100
					: ($TableName_txt="Templates")
						[TableOfLists:125]ListValue_s:2:=$TableName_txt
						[TableOfLists:125]ListSequence_l:3:=100
					: ($TableName_txt="TIN_Insp_Images")
						[TableOfLists:125]ListValue_s:2:=$TableName_txt
						[TableOfLists:125]ListSequence_l:3:=50
					: ($TableName_txt="Work_Estimate")
						[TableOfLists:125]ListValue_s:2:=$TableName_txt
						[TableOfLists:125]ListSequence_l:3:=100
					: ($TableName_txt="WorkHour_Config")
						[TableOfLists:125]ListValue_s:2:=$TableName_txt
						[TableOfLists:125]ListSequence_l:3:=100
						
					: ($TableName_txt="Standard Photos")
						[TableOfLists:125]ListValue_s:2:=$TableName_txt
						[TableOfLists:125]ListSequence_l:3:=100
					: ($TableName_txt="LSS_Photos")
						[TableOfLists:125]ListValue_s:2:=$TableName_txt
						[TableOfLists:125]ListSequence_l:3:=100
					: ($TableName_txt="InventoryPhotos")
						[TableOfLists:125]ListValue_s:2:=$TableName_txt
						[TableOfLists:125]ListSequence_l:3:=50
						
					Else 
						[TableOfLists:125]ListValue_s:2:=$ListValue_txt
						[TableOfLists:125]ListSequence_l:3:=$Limit_L
						
				End case 
				Inc_Sequence("TableOfLists"; ->[TableOfLists:125]ListKeyID_L:4)
				If ($UseTableName_B)
					$Limit_L:=[TableOfLists:125]ListSequence_l:3
				End if 
				SAVE RECORD:C53([TableOfLists:125])
				UNLOAD RECORD:C212([TableOfLists:125])
			Else 
				If ($UseTableName_B)
					$Limit_L:=[TableOfLists:125]ListSequence_l:3
				End if 
			End if 
			
		End if 
		If ($UseTableName_B)
			$ListValue_txt:=$TableName_txt
		End if 
		If (Find in array:C230(SQL_LimitNames_atxt; $ListValue_txt)>0)
		Else 
			APPEND TO ARRAY:C911(SQL_LimitNames_atxt; $ListValue_txt)
			APPEND TO ARRAY:C911(SQL_Limits_AL; $Limit_L)
		End if 
	End if 
	
	
	
End for 
//End clone_CreateSQLLimits