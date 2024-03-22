//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 11/10/08, 16:41:05
	// ----------------------------------------------------
	// Method: CIR_RatgInspCost_OM
	// Description
	// 
	// 
	// Parameters
	// $1 : $Field_ptr
	// ----------------------------------------------------
	
	Mods_2008_CM_5404
End if 
C_POINTER:C301($1; $Field_ptr)

C_POINTER:C301($IndirCost_ptr; $Salary_ptr; $NetFee_ptr; $TLF_ptr; $DirCost_ptr; $TotalCost_ptr)
C_POINTER:C301($Table_ptr)

$Field_ptr:=$1

$Table_ptr:=Table:C252(Table:C252($Field_ptr))
C_TEXT:C284($FldName_txt)
$FldName_txt:=Substring:C12(Field name:C257($Field_ptr); 1; 4)
C_BOOLEAN:C305($OKWithField_b)
$OKWithField_b:=True:C214
Case of 
	: ($Table_ptr=->[Cons Inspection Cost:76])
		Case of 
			: ($FldName_txt="Act ")
				$IndirCost_ptr:=->[Cons Inspection Cost:76]Act IndirectCost:23
				$Salary_ptr:=->[Cons Inspection Cost:76]Act Salary:22
				$NetFee_ptr:=->[Cons Inspection Cost:76]Act NetFee:24
				$TLF_ptr:=->[Cons Inspection Cost:76]Act TotalLimitFee:25
				$DirCost_ptr:=->[Cons Inspection Cost:76]Act TotalDirectCost:37
				$TotalCost_ptr:=->[Cons Inspection Cost:76]Act TotalCost:38
			: ($FldName_txt="Neg ")
				$IndirCost_ptr:=->[Cons Inspection Cost:76]Neg IndirectCost:4
				$Salary_ptr:=->[Cons Inspection Cost:76]Neg Salary:3
				$NetFee_ptr:=->[Cons Inspection Cost:76]Neg NetFee:5
				$TLF_ptr:=->[Cons Inspection Cost:76]Neg TotalLimitFee:6
				$DirCost_ptr:=->[Cons Inspection Cost:76]Neg TotalDirectCost:18
				$TotalCost_ptr:=->[Cons Inspection Cost:76]Neg TotalCost:19
				
			Else 
				ALERT:C41("Bad Field passed to method "+Current method name:C684+" ! Field :"+Field name:C257($Field_ptr)+" is not and Act or Neg field!")
				
		End case 
		
	: ($Table_ptr=->[Conslt Rating Cost:74])
		Case of 
			: ($FldName_txt="Act ")
				$IndirCost_ptr:=->[Conslt Rating Cost:74]Act IndirectCost:39
				$Salary_ptr:=->[Conslt Rating Cost:74]Act Salary:21
				$NetFee_ptr:=->[Conslt Rating Cost:74]Act NetFee:22
				$TLF_ptr:=->[Conslt Rating Cost:74]Act TotalLimitFee:23
				$DirCost_ptr:=->[Conslt Rating Cost:74]Act TotalDirectCost:34
				$TotalCost_ptr:=->[Conslt Rating Cost:74]Act TotalCost:35
				
			: ($FldName_txt="Neg ")
				$IndirCost_ptr:=->[Conslt Rating Cost:74]Neg IndirectCost:4
				$Salary_ptr:=->[Conslt Rating Cost:74]Neg Salary:3
				$NetFee_ptr:=->[Conslt Rating Cost:74]Neg NetFee:5
				$TLF_ptr:=->[Conslt Rating Cost:74]Neg TotalLimitFee:6
				$DirCost_ptr:=->[Conslt Rating Cost:74]Neg TotalDirectCost:17
				$TotalCost_ptr:=->[Conslt Rating Cost:74]Neg TotalCost:18
				
			Else 
				ALERT:C41("Bad Field passed to method "+Current method name:C684+" ! Field :"+Field name:C257($Field_ptr)+" is not and Act or Neg field!")
				
		End case 
		
End case 
