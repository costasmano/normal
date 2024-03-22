//%attributes = {"invisible":true}

// ----------------------------------------------------
// User name (OS): Costas Manousakis
// Date and time: 01/17/17, 16:37:11
// ----------------------------------------------------
// Method: ut_CheckIfPDFsExported
// Description
// Not used can be deleted
//
// Parameters
// ----------------------------------------------------

Compiler_clone
Compiler_SQL
C_BOOLEAN:C305($Locked_B; $Invisible_B)
C_DATE:C307($PNGCreated_d; $JPGCreated_d; $TIFCreated_d; $Created_d; $ModifiedOn_d)
C_TIME:C306($Created_tm; $ModifiedOn_tm)
C_BLOB:C604($Report_blb)
SET BLOB SIZE:C606($Report_blb; 0)
TEXT TO BLOB:C554("Inspection ID"+Char:C90(Tab:K15:37)+"Photo ID"+Char:C90(Tab:K15:37)+"Inspection Date"+Char:C90(Tab:K15:37)+"Newest Create date"+Char:C90(Tab:K15:37)+"Prod Log Date"+Char:C90(Tab:K15:37)+"Dev Log Date"+Char:C90(Tab:K15:37)+"Status"+Char:C90(Carriage return:K15:38); $Report_blb; UTF8 text without length:K22:17; *)

READ ONLY:C145(*)

C_TEXT:C284($StartConvertedPath_txt; $InspectionID_txt; $UserName_txt; $Password_txt; $ProductionIP_txt; $DevelopmentIP_txt)
QUERY:C277([Parameters:107]; [Parameters:107]ParamCode:1="ConvertedFilePath")
$StartConvertedPath_txt:=[Parameters:107]Description:2
$UserName_txt:="Designer"
$Password_txt:="caesar"
$ProductionIP_txt:="146.243.135.242:19812"
$DevelopmentIP_txt:="146.243.135.150:29902"
ARRAY TEXT:C222($ProdInspectionIDs_atxt; 0)
ARRAY LONGINT:C221($ProdREFIDs_atxt; 0)
ARRAY DATE:C224($ProdNewestChange_ad; 0)

//clone_ControlConnect 
SQLConnectionMade_b:=True:C214
If (SQLConnectionMade_b)
	
	
	C_TEXT:C284($FolderPath_txt; $FileName_txt; $PathToPDF_txt; $ConvertedPath_txt; $Changes_txt)
	ARRAY TEXT:C222($InsideFolders_atxt; 0)
	C_DATE:C307($v_59_005_d)
	$FolderPath_txt:=Select folder:C670("Select Folder with PDFs to check"; "")
	C_LONGINT:C283($DocumentLoop_L; $FolderLoop_L; $loop_l)
	
	If (OK=1)
		If (Test path name:C476($FolderPath_txt)=Is a folder:K24:2)
			FOLDER LIST:C473($FolderPath_txt; $InsideFolders_atxt)
			For ($FolderLoop_L; 1; Size of array:C274($InsideFolders_atxt))
				$PathToPDF_txt:=$FolderPath_txt+$InsideFolders_atxt{$FolderLoop_L}
				ARRAY TEXT:C222($Documents_atxt; 0)
				DOCUMENT LIST:C474($PathToPDF_txt; $Documents_atxt)
				For ($DocumentLoop_L; 1; Size of array:C274($Documents_atxt))
					
					If (Position:C15("PDF"; $Documents_atxt{$DocumentLoop_L})>0)
						Compiler_FieldVariables(Table:C252(->[Inspections:27]))
						Compiler_FieldVariables(Table:C252(->[Activity Log:59]))
						$FileName_txt:=Replace string:C233($Documents_atxt{$DocumentLoop_L}; ".pdf"; "")
						$FileName_txt:=Replace string:C233($FileName_txt; "~~"; "")
						ARRAY TEXT:C222($Parts_atxt; 0)
						
						ut_NewTextToArray($FileName_txt; ->$Parts_atxt; "_")
						v_27_002_L:=Num:C11($Parts_atxt{1})
						v_59_015_txt:=$Parts_atxt{2}
						$InspectionID_txt:=$Parts_atxt{1}
						clone_sqlConnect($UserName_txt; $Password_txt; $ProductionIP_txt)
						C_LONGINT:C283($StartRefID_L)
						$StartRefID_L:=15000000
						ARRAY LONGINT:C221($ProdRefID_aL; 0)
						ARRAY LONGINT:C221($DevRefID_aL; 0)
						C_BLOB:C604($Data_blb)
						C_DATE:C307($ProdChanged_d)
						
						Begin SQL
							select
							[Inspections].[Insp Date]
							from
							[Inspections]
							where
							[Inspections].[InspID] = :v_27_002_L
							into :v_27_078_d;
							
							select
							[Activity Log].[RefID]
							from
							[Activity Log]
							where
							[Activity Log].[File Number] = 36
							and 
							[Activity Log].[Local ID] = :v_59_015_txt
							and
							[Activity Log].[RefID] >= :$StartRefID_L
							and
							[Activity Log].[Activity Type] = 'GRP'
							into
							:$ProdRefID_aL;
						End SQL
						
						For ($loop_l; 1; Size of array:C274($ProdRefID_aL))
							$StartRefID_L:=$ProdRefID_aL{$loop_l}
							Begin SQL
								select
								[Activity Log].[Data], 
								[Activity Log].[dDate]
								from
								[Activity Log]
								where [Activity Log].[RefID] = :$StartRefID_L
								into
								:$Data_blb, 
								:$ProdChanged_d
							End SQL
							//$Changes_txt:=ut_ConvertAlogDataToText ($Data_blb)
						End for 
						SQL LOGOUT:C872
						If (v_59_005_d=!00-00-00!)
							TRACE:C157
						End if 
						$v_59_005_d:=!00-00-00!
						clone_sqlConnect($UserName_txt; $Password_txt; $DevelopmentIP_txt)
						C_BOOLEAN:C305($Complete_B)
						Compiler_FieldVariables
						Repeat 
							Begin SQL
								select
								[Activity Log].[RefID],
								
								from
								[Activity Log]
								where
								[Activity Log].[File Number]=36
								and
								[Activity Log].[Local ID]=:v_59_015_txt
								into
								:$v_59_005_d;
							End SQL
						Until ($Complete_B)
						
						SQL LOGOUT:C872
						$Created_d:=!00-00-00!
						$ConvertedPath_txt:=CNV_CreatePathNoInspection(Folder separator:K24:12; $StartConvertedPath_txt; v_27_078_d; $InspectionID_txt)
						ARRAY DATE:C224($CreateDates_ad; 0)
						ARRAY TEXT:C222($Type_atxt; 0)
						
						If (Test path name:C476($ConvertedPath_txt+v_59_015_txt+".png")=Is a document:K24:1)
							
							GET DOCUMENT PROPERTIES:C477($ConvertedPath_txt+v_59_015_txt+".png"; $Locked_B; $Invisible_B; $Created_d; $Created_tm; $ModifiedOn_d; $ModifiedOn_tm)
							APPEND TO ARRAY:C911($CreateDates_ad; $Created_d)
							APPEND TO ARRAY:C911($Type_atxt; "png")
							
						End if 
						If (Test path name:C476($ConvertedPath_txt+v_59_015_txt+".jpg")=Is a document:K24:1)
							
							GET DOCUMENT PROPERTIES:C477($ConvertedPath_txt+v_59_015_txt+".jpg"; $Locked_B; $Invisible_B; $Created_d; $Created_tm; $ModifiedOn_d; $ModifiedOn_tm)
							APPEND TO ARRAY:C911($CreateDates_ad; $Created_d)
							APPEND TO ARRAY:C911($Type_atxt; "jpg")
							
						End if 
						If (Test path name:C476($ConvertedPath_txt+v_59_015_txt+".TIF")=Is a document:K24:1)
							
							GET DOCUMENT PROPERTIES:C477($ConvertedPath_txt+v_59_015_txt+".tif"; $Locked_B; $Invisible_B; $Created_d; $Created_tm; $ModifiedOn_d; $ModifiedOn_tm)
							APPEND TO ARRAY:C911($CreateDates_ad; $Created_d)
							APPEND TO ARRAY:C911($Type_atxt; "tif")
							
						End if 
						If (Size of array:C274($CreateDates_ad)>0)
							
							SORT ARRAY:C229($CreateDates_ad; $Type_atxt; <)
							$Created_d:=$CreateDates_ad{1}
							If (Position:C15("~~"; $Documents_atxt{$DocumentLoop_L})>0)
								MOVE DOCUMENT:C540($PathToPDF_txt+Folder separator:K24:12+"~~"+$Documents_atxt{$DocumentLoop_L}; $PathToPDF_txt+Folder separator:K24:12+$Documents_atxt{$DocumentLoop_L})
							End if 
							If ($Created_d>=v_59_005_d) & ($v_59_005_d#!00-00-00!)
								If (Position:C15("~~"; $Documents_atxt{$DocumentLoop_L})>0)
								Else 
									MOVE DOCUMENT:C540($PathToPDF_txt+Folder separator:K24:12+$Documents_atxt{$DocumentLoop_L}; $PathToPDF_txt+Folder separator:K24:12+"~~"+$Documents_atxt{$DocumentLoop_L})
								End if 
								TEXT TO BLOB:C554(String:C10(v_27_002_L)+Char:C90(Tab:K15:37)+v_59_015_txt+Char:C90(Tab:K15:37)+String:C10(v_27_078_d)+Char:C90(Tab:K15:37)+String:C10($Created_d)+Char:C90(Tab:K15:37)+String:C10(v_59_005_d)+Char:C90(Tab:K15:37)+String:C10($v_59_005_d)+Char:C90(Tab:K15:37)+"Document Renamed"+Char:C90(Carriage return:K15:38); $Report_blb; UTF8 text without length:K22:17; *)
							Else 
								TEXT TO BLOB:C554(String:C10(v_27_002_L)+Char:C90(Tab:K15:37)+v_59_015_txt+Char:C90(Tab:K15:37)+String:C10(v_27_078_d)+Char:C90(Tab:K15:37)+String:C10($Created_d)+Char:C90(Tab:K15:37)+String:C10(v_59_005_d)+Char:C90(Tab:K15:37)+String:C10($v_59_005_d)+Char:C90(Tab:K15:37)+"Document to be reviewed"+Char:C90(Carriage return:K15:38); $Report_blb; UTF8 text without length:K22:17; *)
								
								
							End if 
						Else 
							TEXT TO BLOB:C554(String:C10(v_27_002_L)+Char:C90(Tab:K15:37)+v_59_015_txt+Char:C90(Tab:K15:37)+String:C10(v_27_078_d)+Char:C90(Tab:K15:37)+String:C10($Created_d)+Char:C90(Tab:K15:37)+String:C10(v_59_005_d)+Char:C90(Tab:K15:37)+String:C10($v_59_005_d)+Char:C90(Tab:K15:37)+"Document not found"+Char:C90(Carriage return:K15:38); $Report_blb; UTF8 text without length:K22:17; *)
						End if 
					End if 
				End for 
				
				
				
			End for 
			C_TIME:C306($Doc_tm)
			
			$Doc_tm:=Create document:C266("")
			CLOSE DOCUMENT:C267($Doc_tm)
			BLOB TO DOCUMENT:C526(Document; $Report_blb)
			
		End if 
		
	End if 
	SQL LOGOUT:C872
End if 