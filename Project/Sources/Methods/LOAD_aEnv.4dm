//%attributes = {"invisible":true}
//GP LOAD_aEnv
//Copyright © 1996, Thomas D. Nee, All Rights Reserved.

C_BOOLEAN:C305(vLaEnv)
C_LONGINT:C283($NoEnv; $i)  //Command Replaced was o_C_INTEGER
ARRAY TEXT:C222(aEnv; 0)  //Command Replaced was o_ARRAY string length was 43
ARRAY INTEGER:C220(aEnvID; 0)

ALL RECORDS:C47([Environments:48])
SELECTION TO ARRAY:C260([Environments:48]Envir No:1; aEnvID; [Environments:48]Envir Descr:3; aEnv)
REDUCE SELECTION:C351([Environments:48]; 0)
SORT ARRAY:C229(aEnvID; aEnv)

$NoEnv:=Size of array:C274(aEnvID)
For ($i; 1; $NoEnv)
	aEnv{$i}:=String:C10(aEnvID{$i})+") "+aEnv{$i}
End for 

//aEnv has been loaded.
//It is not necessary to load it again until there is a change in [Environments].
vLaEnv:=False:C215