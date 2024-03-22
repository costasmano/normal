//%attributes = {"invisible":true}
//Method: ut_SpecialReport
//Description
//  ` method to generate a custom text report file from records in a 4D server db.
//  ` will download required fields from the nbi records in the server db. 
//  ` the field must be entered in the code.
//  ` this method is meant as a tool to be run in interpreted mode against a production db

// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 12/7/12
	// ----------------------------------------------------
	//Created : 
	Mods_2012_12
	// Modified by: Costas Manousakis-(Designer)-(4/8/19 11:58:55)
	Mods_2019_04
	//  `use system parameter MADOT_BostonServer for the server address
End if 
//
C_TEXT:C284($SelectFields_txt; $UpdateFields_txt; $FieldName_txt; $TableName_txt)
Compiler_Utilities
C_LONGINT:C283($TableNumber_l; $Loop_l)
$TableNumber_l:=Table:C252(->[Bridge MHD NBIS:1]Item8:206)
$TableName_txt:="["+Table name:C256($TableNumber_l)+"]"

$Loop_l:=Field:C253(->[Bridge MHD NBIS:1]Item8:206)
$FieldName_txt:=Field name:C257(->[Bridge MHD NBIS:1]Item8:206)
ARRAY TEXT:C222(Item8_atxt; 0)
ARRAY LONGINT:C221(Item27_aL; 0)
ARRAY LONGINT:C221(Item106_aL; 0)
ARRAY TEXT:C222(Item43_atxt; 0)
ARRAY TEXT:C222(Item58_atxt; 0)
ARRAY TEXT:C222(Item59_atxt; 0)
ARRAY TEXT:C222(Item60_atxt; 0)
ARRAY TEXT:C222(Item62_atxt; 0)
$SelectFields_txt:=$FieldName_txt
$UpdateFields_txt:=":"+"Item8_atxt"

$FieldName_txt:=Field name:C257(->[Bridge MHD NBIS:1]Item27:83)
$SelectFields_txt:=$SelectFields_txt+","+$FieldName_txt
$UpdateFields_txt:=$UpdateFields_txt+", :"+"Item27_aL"

$Loop_l:=Field:C253(->[Bridge MHD NBIS:1]Item106:84)
$FieldName_txt:=Field name:C257(->[Bridge MHD NBIS:1]Item106:84)
$SelectFields_txt:=$SelectFields_txt+","+$FieldName_txt
$UpdateFields_txt:=$UpdateFields_txt+", :"+"Item106_aL"

$Loop_l:=Field:C253(->[Bridge MHD NBIS:1]Item43:75)
$FieldName_txt:=Field name:C257(->[Bridge MHD NBIS:1]Item43:75)
$SelectFields_txt:=$SelectFields_txt+","+$FieldName_txt
$UpdateFields_txt:=$UpdateFields_txt+", :"+"Item43_atxt"

$Loop_l:=Field:C253(->[Bridge MHD NBIS:1]Item58:130)
$FieldName_txt:=Field name:C257(->[Bridge MHD NBIS:1]Item58:130)
$SelectFields_txt:=$SelectFields_txt+","+$FieldName_txt
$UpdateFields_txt:=$UpdateFields_txt+", :"+"Item58_atxt"
$Loop_l:=Field:C253(->[Bridge MHD NBIS:1]Item59:131)
$FieldName_txt:=Field name:C257(->[Bridge MHD NBIS:1]Item59:131)
$SelectFields_txt:=$SelectFields_txt+","+$FieldName_txt
$UpdateFields_txt:=$UpdateFields_txt+", :"+"Item59_atxt"
$Loop_l:=Field:C253(->[Bridge MHD NBIS:1]Item60:132)
$FieldName_txt:=Field name:C257(->[Bridge MHD NBIS:1]Item60:132)
$SelectFields_txt:=$SelectFields_txt+","+$FieldName_txt
$UpdateFields_txt:=$UpdateFields_txt+", :"+"Item60_atxt"
$Loop_l:=Field:C253(->[Bridge MHD NBIS:1]Item62:134)
$FieldName_txt:=Field name:C257(->[Bridge MHD NBIS:1]Item62:134)
$SelectFields_txt:=$SelectFields_txt+","+$FieldName_txt
$UpdateFields_txt:=$UpdateFields_txt+", :"+"Item62_atxt"


$SelectFields_txt:="BRG."+$SelectFields_txt
$SelectFields_txt:=Replace string:C233($SelectFields_txt; ","; ", BRG.")
C_TEXT:C284(SQL_txt; SQLCount_txt)
C_BOOLEAN:C305(SQLError_b; 4DError_b; SQLConnectionMade_b)

SQL_txt:="SELECT "+$SelectFields_txt+" FROM "+$TableName_txt+" BRG where CAST([bridge mhd nbis].FHWARecord as INT) = 1 order by BRG.[Item8] INTO "+$UpdateFields_txt
SQLCount_txt:="SELECT Count(*) FROM "+$TableName_txt+" where CAST([bridge mhd nbis].FHWARecord as INT) = 1  into :Count_l"

SQLError_b:=False:C215
4DError_b:=False:C215

C_TEXT:C284($IPAddress_txt; $username_txt; $password_txt)
$IPAddress_txt:=ut_GetSysParameter("MADOT_BostonServer"; "mhdbms.root.eot.gov")
$IPAddress_txt:=$IPAddress_txt+":19812"
$IPAddress_txt:=Request:C163("Enter Server Address"; $IPAddress_txt)
$username_txt:=Request:C163("Enter username"; "designer")
$password_txt:=Request:C163("Enter password for "+$username_txt)
SQLConnectionMade_b:=False:C215
ut_SQLConnect($username_txt; $password_txt; $IPAddress_txt)

C_LONGINT:C283(Count_l; $validItems_L)
ON ERR CALL:C155("SQL_Error")
Begin SQL
	EXECUTE IMMEDIATE :SQLCount_txt;
End SQL

If (Count_l>0)
	C_TIME:C306($reportFile_t)
	$reportFile_t:=Create document:C266("")
	If (OK=1)
		
		ON ERR CALL:C155("SQL_Error")
		Begin SQL
			EXECUTE IMMEDIATE :SQL_txt;
		End SQL
		If (ut_fTestForSQLor4DError)
			ON ERR CALL:C155("4D_Errors")
			
			C_TEXT:C284($line_txt)
			C_REAL:C285($avg_r)
			
			For ($loop_L; 1; Size of array:C274(Item8_atxt))
				$validItems_L:=fn_BridgeConditionAvg(->$avg_r; Item58_atxt{$loop_L}; Item59_atxt{$loop_L}; Item60_atxt{$loop_L}; Item62_atxt{$loop_L})
				$line_txt:=Item8_atxt{$loop_L}+Char:C90(Tab:K15:37)+QR_I43A_MajorGroups(Item43_atxt{$loop_L})+Char:C90(Tab:K15:37)+QR_BridgeCondCategory($avg_r)+Char:C90(Tab:K15:37)+String:C10(QR_BridgeAge(Item27_aL{$loop_L}; Item106_aL{$loop_L}))+Char:C90(Tab:K15:37)+String:C10(QR_Ceiling(QR_BridgeAge(Item27_aL{$loop_L}; Item106_aL{$loop_L}); 5))+Char:C90(Carriage return:K15:38)
				SEND PACKET:C103($reportFile_t; $line_txt)
			End for 
			Offset_l:=Offset_l+1
		End if 
		
		CLOSE DOCUMENT:C267($reportFile_t)
		
	End if 
End if 
ut_SQLLogout

ARRAY TEXT:C222(Item8_atxt; 0)
ARRAY LONGINT:C221(Item27_aL; 0)
ARRAY LONGINT:C221(Item106_aL; 0)
ARRAY TEXT:C222(Item43_atxt; 0)
ARRAY TEXT:C222(Item58_atxt; 0)
ARRAY TEXT:C222(Item59_atxt; 0)
ARRAY TEXT:C222(Item60_atxt; 0)
ARRAY TEXT:C222(Item62_atxt; 0)

//End ut_SpecialReport