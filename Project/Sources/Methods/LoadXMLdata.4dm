//%attributes = {"invisible":true}
// Method: LoadXMLdata
// Description
// Use to import data from an XML export from BrM 5.2.1+
// Load data into tables from an XML file.
// File format is :
// <root_element>
//   <tablename>
//       <fieldname> value </fieldname>
//       .....
//       <fieldname> value </fieldname>
//   </tablename>
// </root_element>
//
// will assume 1st level under root is the table name. once find a table we have, start adding record and modifying fields.
// if the field exists in our table.
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 02/18/15, 16:39:39
	// ----------------------------------------------------
	//Created : 
	Mods_2015_02
End if 

C_TIME:C306($xmldoc_t)
$xmldoc_t:=Open document:C264(""; "XML"; Read mode:K24:5)
If (OK=1)
	C_LONGINT:C283($SAXevt_L; $tbl_L; $fld_L; $testTbl_L; $counter_L)
	C_TEXT:C284($elmtname_txt; $elmPref_txt; $elmtValue_t; $tablename_t; $fieldname_t)
	ARRAY TEXT:C222($elmAttrs_atxt; 0)
	ARRAY TEXT:C222($elmtAttrVals_atxt; 0)
	C_POINTER:C301($tbl_ptr; $fld_ptr; $null_ptr)
	$tbl_L:=0
	$counter_L:=0
	C_BOOLEAN:C305($startTbl_b)
	ARRAY TEXT:C222($SaxLevels_atxt; 0)
	SHORT_MESSAGE("Scanning XML file To Load records....")
	Repeat 
		$SAXevt_L:=SAX Get XML node:C860($xmldoc_t)
		
		Case of 
			: ($SAXevt_L=XML start element:K45:10)
				
				SAX GET XML ELEMENT:C876($xmldoc_t; $elmtname_txt; $elmPref_txt; $elmAttrs_atxt; $elmtAttrVals_atxt)
				APPEND TO ARRAY:C911($SaxLevels_atxt; $elmtname_txt)
				Case of 
					: ($tbl_L=0) & (Size of array:C274($SaxLevels_atxt)=2)
						//no table yet check if we have a table
						$tbl_ptr:=getTableByName($elmtname_txt)
						If (Not:C34(Is nil pointer:C315($tbl_ptr)))
							$tbl_L:=Table:C252($tbl_ptr)
							$startTbl_b:=True:C214
							$tablename_t:=$elmtname_txt
							//create a record
							CREATE RECORD:C68($tbl_ptr->)
						End if 
					: ($tbl_L>0) & (Size of array:C274($SaxLevels_atxt)=3)
						$fld_ptr:=getFieldbyname($tablename_t; $elmtname_txt)
						If (Not:C34(Is nil pointer:C315($fld_ptr)))
							$fld_L:=Field:C253($fld_ptr)
						End if 
				End case 
				
			: ($SAXevt_L=XML DATA:K45:12)
				If ($fld_L>0)
					C_LONGINT:C283($fldType_L)
					$fld_ptr:=Field:C253($tbl_L; $fld_L)
					
					$fldType_L:=Type:C295($fld_ptr->)
					SAX GET XML ELEMENT VALUE:C877($xmldoc_t; $fld_ptr->)
					
				Else 
					//just get value to see - not needed
					SAX GET XML ELEMENT VALUE:C877($xmldoc_t; $elmtValue_t)
					
				End if 
			: ($SAXevt_L=XML end element:K45:11)
				DELETE FROM ARRAY:C228($SaxLevels_atxt; Size of array:C274($SaxLevels_atxt))
				Case of 
					: ($fld_L>0)
						$fld_L:=0
					: ($tbl_L>0)
						//save record
						SAVE RECORD:C53(Table:C252($tbl_L)->)
						UNLOAD RECORD:C212(Table:C252($tbl_L)->)
						$counter_L:=$counter_L+1
						MESSAGE:C88("record "+String:C10($counter_L)+" in Table "+Table name:C256($tbl_L)+Char:C90(13))
						$tbl_L:=0
						$tablename_t:=""
				End case 
		End case 
	Until ($SAXevt_L=XML end document:K45:15)
	
	CLOSE WINDOW:C154
	CLOSE DOCUMENT:C267($xmldoc_t)
	ALERT:C41("Finished Reading XML Document")
End if 
//End LoadXMLdata