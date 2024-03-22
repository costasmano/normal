//%attributes = {"invisible":true}
// ----------------------------------------------------
// utl_CompareFedDates
// User name (OS): charlesmiller
// Date and time: 08/11/11, 10:30:42
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2011_08  // CJ Miller`08/11/11, 10:30:44      
End if 
READ ONLY:C145(*)

C_TIME:C306($Doc_tm)
C_BLOB:C604($Report_blb)
SET BLOB SIZE:C606($Report_blb; 0)
$Doc_tm:=Open document:C264(""; ""; Read mode:K24:5)

C_TEXT:C284($StructureName_txt; $InspFreq11; $LastMonth11; $Lastyear11)
C_TEXT:C284($InspFreq10; $LastMonth10; $Lastyear10)

C_TEXT:C284($InspFreq09; $LastMonth09; $Lastyear09)
C_TEXT:C284($InspFreq08; $LastMonth08; $Lastyear08)
C_TEXT:C284($InspFreq07; $LastMonth07; $Lastyear07)
C_TEXT:C284($Skip_txt; $month_txt; $year_txt)
C_TEXT:C284($Tab_txt; $CR_txt)
$Tab_txt:=Char:C90(Tab:K15:37)
$CR_txt:=Char:C90(Carriage return:K15:38)

//RECEIVE PACKET($Doc_tm;$Skip_txt;Char(Carriage return ))
//TEXT TO BLOB($Skip_txt+$CR_txt;$Report_blb;Text without length ;*)
RECEIVE PACKET:C104($Doc_tm; $Skip_txt; Char:C90(Carriage return:K15:38))
TEXT TO BLOB:C554($Skip_txt+$CR_txt; $Report_blb; Mac text without length:K22:10; *)
C_LONGINT:C283($Number_l; $Loop_l)
Repeat 
	RECEIVE PACKET:C104($Doc_tm; $StructureName_txt; Char:C90(Tab:K15:37))  //1
	If (OK=1)
		TEXT TO BLOB:C554($StructureName_txt+$Tab_txt; $Report_blb; Mac text without length:K22:10; *)
		RECEIVE PACKET:C104($Doc_tm; $Skip_txt; Char:C90(Tab:K15:37))  //2
		TEXT TO BLOB:C554($Skip_txt+$Tab_txt; $Report_blb; Mac text without length:K22:10; *)
		RECEIVE PACKET:C104($Doc_tm; $Skip_txt; Char:C90(Tab:K15:37))  //3
		TEXT TO BLOB:C554($Skip_txt+$Tab_txt; $Report_blb; Mac text without length:K22:10; *)
		RECEIVE PACKET:C104($Doc_tm; $Skip_txt; Char:C90(Tab:K15:37))  //4
		TEXT TO BLOB:C554($Skip_txt+$Tab_txt; $Report_blb; Mac text without length:K22:10; *)
		RECEIVE PACKET:C104($Doc_tm; $Skip_txt; Char:C90(Tab:K15:37))  //5
		TEXT TO BLOB:C554($Skip_txt+$Tab_txt; $Report_blb; Mac text without length:K22:10; *)
		RECEIVE PACKET:C104($Doc_tm; $InspFreq11; Char:C90(Tab:K15:37))  //6
		TEXT TO BLOB:C554($InspFreq11+$Tab_txt; $Report_blb; Mac text without length:K22:10; *)
		RECEIVE PACKET:C104($Doc_tm; $LastMonth11; Char:C90(Tab:K15:37))  //7
		TEXT TO BLOB:C554($LastMonth11+$Tab_txt; $Report_blb; Mac text without length:K22:10; *)
		RECEIVE PACKET:C104($Doc_tm; $Lastyear11; Char:C90(Tab:K15:37))  //8
		TEXT TO BLOB:C554($Lastyear11+$Tab_txt; $Report_blb; Mac text without length:K22:10; *)
		
		RECEIVE PACKET:C104($Doc_tm; $Skip_txt; Char:C90(Tab:K15:37))  //9
		TEXT TO BLOB:C554($Skip_txt+$Tab_txt; $Report_blb; Mac text without length:K22:10; *)
		RECEIVE PACKET:C104($Doc_tm; $Skip_txt; Char:C90(Tab:K15:37))  //10
		TEXT TO BLOB:C554($Skip_txt+$Tab_txt; $Report_blb; Mac text without length:K22:10; *)
		
		RECEIVE PACKET:C104($Doc_tm; $InspFreq10; Char:C90(Tab:K15:37))  //11
		TEXT TO BLOB:C554($InspFreq10+$Tab_txt; $Report_blb; Mac text without length:K22:10; *)
		RECEIVE PACKET:C104($Doc_tm; $LastMonth10; Char:C90(Tab:K15:37))  //12
		TEXT TO BLOB:C554($LastMonth10+$Tab_txt; $Report_blb; Mac text without length:K22:10; *)
		RECEIVE PACKET:C104($Doc_tm; $Lastyear10; Char:C90(Tab:K15:37))  //13
		TEXT TO BLOB:C554($Lastyear10+$Tab_txt; $Report_blb; Mac text without length:K22:10; *)
		
		RECEIVE PACKET:C104($Doc_tm; $Skip_txt; Char:C90(Tab:K15:37))  //14
		TEXT TO BLOB:C554($Skip_txt+$Tab_txt; $Report_blb; Mac text without length:K22:10; *)
		RECEIVE PACKET:C104($Doc_tm; $Skip_txt; Char:C90(Tab:K15:37))  //15
		TEXT TO BLOB:C554($Skip_txt+$Tab_txt; $Report_blb; Mac text without length:K22:10; *)
		
		RECEIVE PACKET:C104($Doc_tm; $InspFreq09; Char:C90(Tab:K15:37))  //16
		TEXT TO BLOB:C554($InspFreq09+$Tab_txt; $Report_blb; Mac text without length:K22:10; *)
		RECEIVE PACKET:C104($Doc_tm; $LastMonth09; Char:C90(Tab:K15:37))  //17
		TEXT TO BLOB:C554($LastMonth09+$Tab_txt; $Report_blb; Mac text without length:K22:10; *)
		RECEIVE PACKET:C104($Doc_tm; $Lastyear09; Char:C90(Tab:K15:37))  //18
		TEXT TO BLOB:C554($Lastyear09+$Tab_txt; $Report_blb; Mac text without length:K22:10; *)
		
		RECEIVE PACKET:C104($Doc_tm; $Skip_txt; Char:C90(Tab:K15:37))  //19
		TEXT TO BLOB:C554($Skip_txt+$Tab_txt; $Report_blb; Mac text without length:K22:10; *)
		RECEIVE PACKET:C104($Doc_tm; $Skip_txt; Char:C90(Tab:K15:37))  //20
		TEXT TO BLOB:C554($Skip_txt+$Tab_txt; $Report_blb; Mac text without length:K22:10; *)
		
		RECEIVE PACKET:C104($Doc_tm; $InspFreq08; Char:C90(Tab:K15:37))  //21
		TEXT TO BLOB:C554($InspFreq08+$Tab_txt; $Report_blb; Mac text without length:K22:10; *)
		RECEIVE PACKET:C104($Doc_tm; $LastMonth08; Char:C90(Tab:K15:37))  //22
		TEXT TO BLOB:C554($LastMonth08+$Tab_txt; $Report_blb; Mac text without length:K22:10; *)
		RECEIVE PACKET:C104($Doc_tm; $Lastyear08; Char:C90(Tab:K15:37))  //23
		TEXT TO BLOB:C554($Lastyear08+$Tab_txt; $Report_blb; Mac text without length:K22:10; *)
		
		RECEIVE PACKET:C104($Doc_tm; $Skip_txt; Char:C90(Tab:K15:37))  //24
		TEXT TO BLOB:C554($Skip_txt+$Tab_txt; $Report_blb; Mac text without length:K22:10; *)
		RECEIVE PACKET:C104($Doc_tm; $Skip_txt; Char:C90(Tab:K15:37))  //25
		TEXT TO BLOB:C554($Skip_txt+$Tab_txt; $Report_blb; Mac text without length:K22:10; *)
		
		RECEIVE PACKET:C104($Doc_tm; $InspFreq07; Char:C90(Tab:K15:37))  //26
		TEXT TO BLOB:C554($InspFreq07+$Tab_txt; $Report_blb; Mac text without length:K22:10; *)
		RECEIVE PACKET:C104($Doc_tm; $LastMonth07; Char:C90(Tab:K15:37))  //27
		TEXT TO BLOB:C554($LastMonth07+$Tab_txt; $Report_blb; Mac text without length:K22:10; *)
		RECEIVE PACKET:C104($Doc_tm; $Lastyear07; Char:C90(Tab:K15:37))  //28
		TEXT TO BLOB:C554($Lastyear07+$Tab_txt; $Report_blb; Mac text without length:K22:10; *)
		
		RECEIVE PACKET:C104($Doc_tm; $Skip_txt; Char:C90(Carriage return:K15:38))  //36
		TEXT TO BLOB:C554($Skip_txt+$CR_Txt; $Report_blb; Mac text without length:K22:10; *)
		
		QUERY:C277([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]Item8:206=$StructureName_txt)
		If (Records in selection:C76([Bridge MHD NBIS:1])=1)
			
			SET QUERY DESTINATION:C396(Into set:K19:2; "CombinedSet")
			
			QUERY:C277([Combined Inspections:90]; [Combined Inspections:90]BIN:1=[Bridge MHD NBIS:1]BIN:3)
			USE SET:C118("CombinedSet")
			SET QUERY DESTINATION:C396(Into current selection:K19:1)
			
			QUERY SELECTION:C341([Combined Inspections:90]; [Combined Inspections:90]InspType:5="RTN@")
			
			If (Records in selection:C76([Combined Inspections:90])=0)
				USE SET:C118("CombinedSet")
				QUERY SELECTION:C341([Combined Inspections:90]; [Combined Inspections:90]InspType:5="CUL@")
			End if 
			ORDER BY:C49([Combined Inspections:90]; [Combined Inspections:90]InspDate:4; <)
			REDUCE SELECTION:C351([Combined Inspections:90]; 5)
			ORDER BY:C49([Combined Inspections:90]; [Combined Inspections:90]InspDate:4; <)
			
			$Number_l:=Records in selection:C76([Combined Inspections:90])
			
			TEXT TO BLOB:C554(""+$Tab_txt; $Report_blb; Mac text without length:K22:10; *)
			TEXT TO BLOB:C554(""+$Tab_txt; $Report_blb; Mac text without length:K22:10; *)
			TEXT TO BLOB:C554(""+$Tab_txt; $Report_blb; Mac text without length:K22:10; *)
			TEXT TO BLOB:C554(""+$Tab_txt; $Report_blb; Mac text without length:K22:10; *)
			TEXT TO BLOB:C554(""+$Tab_txt; $Report_blb; Mac text without length:K22:10; *)
			TEXT TO BLOB:C554(""+$Tab_txt; $Report_blb; Mac text without length:K22:10; *)
			
			For ($Loop_l; 1; $Number_l)
				$month_txt:=String:C10(Month of:C24([Combined Inspections:90]InspDate:4))
				$year_txt:=String:C10(Year of:C25([Combined Inspections:90]InspDate:4))
				TEXT TO BLOB:C554($month_txt+$Tab_txt; $Report_blb; Mac text without length:K22:10; *)
				TEXT TO BLOB:C554($year_txt+$Tab_txt; $Report_blb; Mac text without length:K22:10; *)
				TEXT TO BLOB:C554(""+$Tab_txt; $Report_blb; Mac text without length:K22:10; *)
				TEXT TO BLOB:C554(""+$Tab_txt; $Report_blb; Mac text without length:K22:10; *)
				TEXT TO BLOB:C554(""+$Tab_txt; $Report_blb; Mac text without length:K22:10; *)
				
				NEXT RECORD:C51([Combined Inspections:90])
			End for 
			TEXT TO BLOB:C554($CR_Txt; $Report_blb; Mac text without length:K22:10; *)
			
		Else 
			TEXT TO BLOB:C554(String:C10(Records in selection:C76([Bridge MHD NBIS:1]))+" records found"+$CR_Txt; $Report_blb; Mac text without length:K22:10; *)
		End if 
		
	End if 
Until (OK=0)
CLOSE DOCUMENT:C267($Doc_tm)
$Doc_tm:=Create document:C266("")
If (OK=1)
	CLOSE DOCUMENT:C267($Doc_tm)
	BLOB TO DOCUMENT:C526(Document; $Report_blb)
End if 


//End utl_CompareFedDates