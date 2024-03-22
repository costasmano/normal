//%attributes = {"invisible":true}
//Method: MAP_FormatDate
//Description
// format a date for inclusion in GeoJSON files
// Parameters
// $0 : $formatedDate_txt
// $1 : $date_d
// $2 : $FormatOption_L : from popup menu of this
// "MM/DD/YYYY;YYYY-MM-DD;YYYY MM DD;YYYY_MM_DD;Month Day Year;YYYY-MM-DDTHH:MM:SSZ;YYYY-MM-DDTHH:MM:SSZ GMT"
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Created : 
	//Date and time: Nov 8, 2023, 11:53:34
	Mods_2023_11
	// ----------------------------------------------------
	
	C_TEXT:C284(MAP_FormatDate; $0)
	C_DATE:C307(MAP_FormatDate; $1)
	C_LONGINT:C283(MAP_FormatDate; $2)
	
End if 
//
C_TEXT:C284($0)
C_DATE:C307($1)
C_LONGINT:C283($2)

Case of 
	: ($2=1)  //M/D/YY
		$0:=String:C10($1; System date short:K1:1)
		
	: ($2=2)  //YYYY-MM-DD
		$0:=Substring:C12(String:C10($1; ISO date:K1:8); 1; 10)
		
	: ($2=3)  //YYYY MM DD
		$0:=Replace string:C233(Substring:C12(String:C10($1; ISO date:K1:8); 1; 10); "-"; " ")
		
	: ($2=4)  //YYYY_MM_DD
		$0:=Replace string:C233(Substring:C12(String:C10($1; ISO date:K1:8); 1; 10); "-"; "_")
		
	: ($2=5)  //Mo Day, Year
		$0:=Replace string:C233(Replace string:C233(String:C10($1; System date abbreviated:K1:2); " "; "_"); ","; "")
		
	: ($2=6)  //YYYY-MM-DDTHH:MM:SSZ
		$0:=String:C10($1; ISO date:K1:8)
		
	: ($2=7)  //YYYY-MM-DDTHH:MM:SSZ GMT
		$0:=String:C10($1; ISO date GMT:K1:10)
		
	: ($2=8)  //MM/DD/YYYY
		$0:=String:C10($1; Internal date short:K1:7)
		
	: ($2=9)  //MM.DD.YYYY
		$0:=Replace string:C233(String:C10($1; Internal date short:K1:7); "/"; ".")
		
	: ($2=10)  //YYYY.MM.DD
		$0:=Replace string:C233(Substring:C12(String:C10($1; ISO date:K1:8); 1; 10); "-"; ".")
		
	: ($2=11)  //Mo_YYYY
		$0:=Substring:C12(String:C10($1; System date abbreviated:K1:2); 1; 3)+"_"+String:C10(Year of:C25($1))
		
	Else 
		$0:=String:C10($1)
End case 

//End MAP_FormatDate   