//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 06/19/05, 20:24:46
	// ----------------------------------------------------
	// Method: WKHR_SaveItemValues
	// Description
	// 
	//
	// Parameters
	// ----------------------------------------------------
	
End if 

C_POINTER:C301(arrPtr_1; arrPtr_2; arrPtr_3; arrPtr_4)
arrPtr_1:=Get pointer:C304("Arr_"+CategoryPrefix+"_1")
arrPtr_2:=Get pointer:C304("Arr_"+CategoryPrefix+"_2")
arrPtr_3:=Get pointer:C304("Arr_"+CategoryPrefix+"_Values")
arrPtr_4:=Get pointer:C304("Arr_"+CategoryPrefix+"_Totals")

COPY ARRAY:C226(Arr_ItemNos; arrPtr_1->)
COPY ARRAY:C226(Arr_ItemDesc; arrPtr_2->)
COPY ARRAY:C226(Arr_Values_1; arrPtr_3->{1})
COPY ARRAY:C226(Arr_Values_2; arrPtr_3->{2})
COPY ARRAY:C226(Arr_Values_3; arrPtr_3->{3})
COPY ARRAY:C226(Arr_Values_4; arrPtr_3->{4})
COPY ARRAY:C226(Arr_Values_5; arrPtr_3->{5})
COPY ARRAY:C226(Arr_Values_6; arrPtr_3->{6})

arrPtr_4->{1}:=wkhr_PgTotal_1
arrPtr_4->{2}:=wkhr_PgTotal_2
arrPtr_4->{3}:=wkhr_PgTotal_3
arrPtr_4->{4}:=wkhr_PgTotal_4
arrPtr_4->{5}:=wkhr_PgTotal_5
arrPtr_4->{6}:=wkhr_PgTotal_6
