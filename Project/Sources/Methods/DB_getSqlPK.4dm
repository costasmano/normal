//%attributes = {"invisible":true}
//Method: DB_getSqlPK
//Description
//DB_getSqlPK (numTable_l {;arrayLong_p) -> ptr
//lecture clé primaire de la table $1
//$2 optionnel tableau du ou des numéros de champs constituant la clé
//$0 :
//  pointeur sur champPK si PK = un seul champ
//  Nil si 
//    1/ table sans PK 
//    2/ PK constituée de plusieurs champs, les lire dans $2
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Created : 
	//Date and time: Jan 11, 2023, 16:57:51
	Mods_2023_01_bug
	// ----------------------------------------------------
	C_POINTER:C301(DB_getSqlPK; $0)
	C_LONGINT:C283(DB_getSqlPK; $1)
	C_POINTER:C301(DB_getSqlPK; $2)
	
End if 
//
//DB_getSqlPK (numTable_l {;arrayLong_p) -> ptr
//lecture clé primaire de la table $1
//$2 optionnel tableau du ou des numéros de champs constituant la clé
//$0 :
//  pointeur sur champPK si PK = un seul champ
//  Nil si 
//    1/ table sans PK 
//    2/ PK constituée de plusieurs champs, les lire dans $2
//comporte contournement bug de la v13.5
C_POINTER:C301($0)
C_LONGINT:C283($1)
C_POINTER:C301($2)

C_LONGINT:C283($params_l)
C_LONGINT:C283($table_l)
C_TEXT:C284($nmc_t)
If (False:C215)
	C_POINTER:C301(DB_getSqlPK; $0)
	C_LONGINT:C283(DB_getSqlPK; $1)
	C_POINTER:C301(DB_getSqlPK; $2)
End if 

//_
$params_l:=Count parameters:C259
$nmc_t:=Current method name:C684
C_TEXT:C284($Constraintype)
$Constraintype:="P"  // constraint P is the primary key 
Case of 
	: (Not:C34(Asserted:C1132($params_l>0; $nmc_t+" $1 missing")))
	: (Not:C34(Asserted:C1132(Is table number valid:C999($1); $nmc_t+" $1 invalid table number")))
	Else 
		$table_l:=$1
		ARRAY LONGINT:C221($field_al; 0x0000)
		C_LONGINT:C283($vers_l)
		$vers_l:=Num:C11(Substring:C12(Application version:C493; 1; 3))
		If ($vers_l=135)  //## workaround bug v13.5
			C_TEXT:C284($tableName_t)
			$tableName_t:=Table name:C256($table_l)
			C_TEXT:C284($uuid_t)
			Begin SQL
				SELECT CONSTRAINT_ID
				FROM _USER_CONSTRAINTS
				WHERE (TABLE_NAME=:$tableName_t)
				AND (CONSTRAINT_TYPE=:$Constraintype)
				INTO :$uuid_t;
			End SQL
			If (Length:C16($uuid_t)>0)
				Begin SQL
					SELECT COLUMN_ID
					FROM _USER_CONS_COLUMNS
					WHERE CONSTRAINT_ID=:$uuid_t
					INTO :$field_al;
				End SQL
			End if 
			
		Else   //version 4D pas boguée
			
			Begin SQL
				SELECT _USER_CONS_COLUMNS.COLUMN_ID
				FROM _USER_CONS_COLUMNS
				JOIN _USER_CONSTRAINTS ON _USER_CONSTRAINTS.CONSTRAINT_ID = _USER_CONS_COLUMNS.CONSTRAINT_ID
				WHERE (_USER_CONSTRAINTS.CONSTRAINT_TYPE =:$Constraintype)
				AND (_USER_CONSTRAINTS.TABLE_ID =:$table_l)
				INTO :$field_al;
			End SQL
			
		End if 
		
		If (Size of array:C274($field_al)=1)  //PK = un seul champ
			$0:=Field:C253($table_l; $field_al{1})
		End if 
		
		If ($params_l>1)  //tableau des numéros de champs constituant la clé
			Case of 
				: (Not:C34(Asserted:C1132(Not:C34(Is nil pointer:C315($2)); $nmc_t+" $2 must be a pointeur on array of long")))
				: (Not:C34(Asserted:C1132((Type:C295($2->)=LongInt array:K8:19); $nmc_t+" $2 must be a pointeur on array of long")))
				Else 
					COPY ARRAY:C226($field_al; $2->)
			End case 
		End if 
End case 
//End DB_getSqlPK   