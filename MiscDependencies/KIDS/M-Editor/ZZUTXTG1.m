ZZUTXTG1 ;JLI/FO-OAK - UNIT TEST ROUTINE FOR GLOBAL LISTS ;06/11/08  10:35
 ;;7.3;TOOLKIT
 ;
 D EN^XTMUNIT("ZZUTXTG1")
 Q
 ;
STARTUP ;
 ;D FILEINIT^XTMLOG("ZZUTXTG1")
 Q
 ;
SHUTDOWN ;
 ;D ENDLOG^XTMLOG("ZZUTXTG1")
 Q
 ;
FOLLOWS ;
 D CHKTF^XTMUNIT('$$FOLLOWS^XTECGLO(4,5),"BAD RETURN FOR NUMERIC NOT FOLLOWS")
 Q
 ;
FULL ;
 N ZZGLO,ZZGLOREF,ZZLAST,ZZRESULT
 S ZZGLOREF=$NA(^TMP("ZZUTXTG1",$J)) K @ZZGLOREF
 S @ZZGLOREF@(1)="A",^(2)="B",^(3)="C",^(4)="D",^(2,1)="BA"
 S ZZGLO="TMP(""ZZUTXTG1"",$J"
 S ZZRESULT=$NA(^TMP($J)) K @ZZRESULT
 D LNODE^XTECGLO(ZZRESULT,1000,ZZGLO,1)
 S ZZLAST=$O(^TMP($J,""),-1)
 ; APPENDED JUNK TO BEGINNING OF DATA LINE TO MAKE IT EASIER TO regex the results
 D CHKEQ^XTMUNIT($G(^TMP($J,ZZLAST)),"JUNKD","WRONG FINAL VALUE FOR LIST")
 Q
 ;
PARSGLOB ;
 N ZZGLOB,PARTS
 S ZZGLOB="TMP("
 D PARSGLOB^XTECGLO(ZZGLOB,.PARTS)
 D CHKEQ^XTMUNIT(PARTS(0,1),"TMP(","INCORRECT GLOBAL NAME")
 S ZZGLOB="TMP(""A"","
 D PARSGLOB^XTECGLO(ZZGLOB,.PARTS)
 D CHKEQ^XTMUNIT(PARTS(1,1),"""A""","INCORRECT GLOBAL NODE")
 S ZZGLOB="TMP(""A"",""B"":""C"","
 D PARSGLOB^XTECGLO(ZZGLOB,.PARTS)
 D CHKEQ^XTMUNIT(PARTS(2,1),"""B""","INCORRECT : NODE")
 D CHKEQ^XTMUNIT(PARTS(2,1,1),"""C""","INCORRECT : , NODE")
 ; Following added for OR functionality
 S ZZGLOB="TMP(""A"",""B""!""C"","
 D PARSGLOB^XTECGLO(ZZGLOB,.PARTS)
 D CHKEQ^XTMUNIT(PARTS(1,1),"""A""","INCORRECT FIRST NODE")
 D CHKEQ^XTMUNIT(PARTS(2,1),"""B""","INCORRECT FIRST VALUE OF OR")
 D CHKEQ^XTMUNIT(PARTS(2,2),"""C""","INCORRECT SECOND VALUE OF OR")
 ;
 S ZZGLOB="TMP(""A"",""B""!""C"":""D"","
 D PARSGLOB^XTECGLO(ZZGLOB,.PARTS)
 D CHKEQ^XTMUNIT(PARTS(1,1),"""A""","INCORRECT FIRST NODE")
 D CHKEQ^XTMUNIT(PARTS(2,1),"""B""","INCORRECT FIRST VALUE OF OR")
 D CHKEQ^XTMUNIT(PARTS(2,2),"""C""","INCORRECT SECOND VALUE OF OR")
 D CHKEQ^XTMUNIT(PARTS(2,2,1),"""D""","INCORRECT VALUE OF RANGE ON OR")
 Q
 ;
RANGE ;
 N ZZGLO,ZZGLOREF,ZZLAST,ZZRESULT,ZZUTI
 S ZZGLOREF=$NA(^TMP("ZZUTXTG1",$J)) K @ZZGLOREF
 S @ZZGLOREF@(1)="A",^(2)="B",^(3)="C",^(4)="D",^(2,1)="BA"
 S ZZGLO="TMP(""ZZUTXTG1"",$J,1:3"
 S ZZRESULT=$NA(^TMP($J)) K @ZZRESULT
 D LNODE^XTECGLO(ZZRESULT,1000,ZZGLO,1)
 S ZZLAST=$O(^TMP($J,""),-1)
 D CHKEQ^XTMUNIT($G(^TMP($J,ZZLAST)),"JUNKC","WRONG FINAL VALUE FOR RANGE")
 ; found that range at beginning didn't work correctly
 S ZZUTI="" F  S ZZUTI=$O(^ZZUTXTG1(ZZUTI)) Q:ZZUTI'>0  K ^ZZUTXTG1(ZZUTI)
 K ^ZZUTXTG2(2,2,0)
 S ^ZZUTXTG1(1)="A",^(1,1)="A1",^(1,0)="A10",^(1)="A11",^(2)="A112"
 S ^ZZUTXTG1(2)="B",^(2,1)="B1",^(1,0)="B10",^(1)="B11",^(2)="B112"
 S ^ZZUTXTG1(3)="C",^(3,1)="C1",^(1,0)="C10",^(1)="C11",^(2)="C112"
 S ^ZZUTXTG1(4)="D",^(4,1)="D1",^(1,0)="D10",^(1)="D11",^(2)="D112"
 S ^ZZUTXTG2(2,2,0)="ZZUTXTG2-2-2-0"
 S ZZGLO="ZZUTXTG1(2:3,,0"
 S ZZRESULT=$NA(^TMP("XXX",$J)) K @ZZRESULT
 D LNODE^XTECGLO(ZZRESULT,1000,ZZGLO,1)
 D DEBUG^XTMLOG("BACK",$NA(^TMP("XXX",$J))_",",1)
 S ZZLAST=$O(^TMP($J,""),-1)
 D CHKEQ^XTMUNIT($G(^TMP($J,ZZLAST)),"JUNKC","WRONG FINAL VALUE FOR RANGE")
 S ZZUTI="" F  S ZZUTI=$O(^ZZUTXTG1(ZZUTI)) Q:ZZUTI'>0  K ^ZZUTXTG1(ZZUTI)
 K ^ZZUTXTG2(2,2,0)
 ;
 K @ZZRESULT
 ;D FILEINIT^XTMLOG("ZZUTXTG1")
 D LNODE^XTECGLO(ZZRESULT,"","^DD(8992,.02:.03,0)",1)
 ;D ENDLOG^XTMLOG("ZZUTXTG1")
 D CHKTF^XTMUNIT($G(@ZZRESULT@(4))["DATE/TIME","BAD RANGE IN 8992")
 D CHKTF^XTMUNIT($D(@ZZRESULT@(5))=0,"Extra nodes in 8992")
 Q
 ;
SEARCH ;
 N ZZGLO,ZZGLOREF,ZZRESULT
 S ZZGLOREF=$NA(^TMP("ZZUTXTG1",$J)) K @ZZGLOREF
 S @ZZGLOREF@(1)="A",^(2)="B",^(3)="C",^(4)="BC",^(2,1)="BA"
 S ZZGLO="TMP(""ZZUTXTG1"",$J,2:3"
 S ZZRESULT=$NA(^TMP($J)) K @ZZRESULT
 D LNODE^XTECGLO(ZZRESULT,1000,ZZGLO,"1^0^0^B")
 D CHKEQ^XTMUNIT($G(^TMP($J,2)),"JUNKB","WRONG VALUE FOR SEARCH")
 D CHKEQ^XTMUNIT($G(^TMP($J,4)),"JUNKBA","WRONG VALUE FOR SECOND LEVELSEARCH")
 Q
 ;
CHEKGLOB ;
 N FINAL,GLOBNODE,MAXCOMMA,ARRAY,VALID
 K ARRAY S MAXCOMMA=0 ; NO CONSTRAINTS, NO LIMIT ON COMMA PIECES
 S GLOBNODE="^TMP(24678,""TEST1"",25)"
 S VALID=$$CHEKGLOB^XTECGLO(GLOBNODE,MAXCOMMA,.ARRAY)
 D CHKTF^XTMUNIT(VALID,"RETURNED NOT VALID FOR CHEKGLOB")
 ;
 K ARRAY S MAXCOMMA=2
 S GLOBNODE="^TMP(24678,""TEST1"",25)"
 S VALID=$$CHEKGLOB^XTECGLO(GLOBNODE,MAXCOMMA,.ARRAY)
 D CHKTF^XTMUNIT('VALID,"RETURNED VALID FOR LIMITED COMMAS")
 ;
 K ARRAY S MAXCOMMA=0 S ARRAY(2,1)="""TEST1""",ARRAY(2,1,1)="""TEST1"""
 S GLOBNODE="^TMP(24678,""TEST1"",25)"
 S VALID=$$CHEKGLOB^XTECGLO(GLOBNODE,MAXCOMMA,.ARRAY)
 D CHKTF^XTMUNIT(VALID,"RETURNED INVALID FOR MATCHED TEXT")
 ;
 K ARRAY S MAXCOMMA=0 S ARRAY(3,1)=20,ARRAY(3,2)=25
 S GLOBNODE="^TMP(24678,""TEST1"",25)"
 K ^XTMP("ZZUTXTG1")
 S VALID=$$CHEKGLOB^XTECGLO(GLOBNODE,MAXCOMMA,.ARRAY)
 D CHKTF^XTMUNIT(VALID,"RETURNED INVALID FOR SECOND OR")
 Q
 ;
GETLIMIT ;
 N FIXED,MAXCOMMA,INFO
 ; FIXED GLOBAL SPEC, OPEN ENDED
 S FIXED=$$GETLIMIT^XTECGLO("^TMP($J,""AB"",",.MAXCOMMA,.INFO)
 D CHKEQ^XTMUNIT(MAXCOMMA,0,"INCORRECT MAXCOMMA FOR FIXED SPEC")
 D CHKEQ^XTMUNIT(FIXED,"^TMP(","INCORRECT FIXED PART FOR FIXED SPEC")
 D CHKEQ^XTMUNIT($D(INFO),10,"INFO NOT EMPTY FOR FIXED SPEC")
 ; FIXED WITH RANGE, OPEN ENDED
 S FIXED=$$GETLIMIT^XTECGLO("^TMP($J,""A"",1:3",.MAXCOMMA,.INFO)
 D CHKEQ^XTMUNIT(MAXCOMMA,0,"INCORRECT MAXCOMMA FOR RANGE-OPEN SPEC")
 D CHKEQ^XTMUNIT(FIXED,"^TMP(","INCORRECT FIXED PART FOR RANGE-OPEN SPEC")
 D CHKEQ^XTMUNIT($D(INFO(1))+$D(INFO(2)),20,"INFO NOT EMPTY FOR 1,2 FOR RANGE-OPEN SPEC")
 D CHKEQ^XTMUNIT($G(INFO(3,1)),1,"BAD VALUE FOR FIRST VALUE IN RANGE RANGE-OPEN")
 D CHKEQ^XTMUNIT($G(INFO(3,1,1)),3,"BAD VALUE FOR SECOND VALUE IN RANGE RANGE-OPEN")
 ; FIXED WITH RANGE, THREE NODE LIMIT
 S FIXED=$$GETLIMIT^XTECGLO("^TMP($J,""A"",1:3)",.MAXCOMMA,.INFO)
 D CHKEQ^XTMUNIT(MAXCOMMA,3,"INCORRECT MAXCOMMA FOR RAMGE-CLOSED SPEC")
 D CHKEQ^XTMUNIT(FIXED,"^TMP(","INCORRECT FIXED PART FOR RANGE-CLOSED SPEC")
 D CHKEQ^XTMUNIT($D(INFO(1))+$D(INFO(2)),20,"INFO NOT EMPTY FOR 1,2 FOR RANGE-CLOSED SPEC")
 D CHKEQ^XTMUNIT($G(INFO(3,1)),1,"BAD VALUE FOR FIRST RANGE VALUE RANGE-CLOSED")
 D CHKEQ^XTMUNIT($G(INFO(3,1,1)),3,"BAD VALUE FOR SECOND RANGE VALUE RANGE-CLOSED")
 ; NO FIXED PART, EMPTY AND RANGE
 S FIXED=$$GETLIMIT^XTECGLO("^JUNK(,1:3",.MAXCOMMA,.INFO)
 D CHKEQ^XTMUNIT(MAXCOMMA,0,"INCORRECT MAXCOMMA FOR EMPTY-RANGE SPEC")
 D CHKEQ^XTMUNIT(FIXED,"^JUNK(","INCORRECT FIXED PART FOR EMPTY-RANGE SPEC")
 D CHKEQ^XTMUNIT($D(INFO(1)),10,"INFO NOT EMPTY FOR 1,2 FOR EMPTY-RANGE SPEC")
 D CHKEQ^XTMUNIT($G(INFO(2,1)),1,"BAD VALUE FOR FIRST RANGE VALUE EMPTY-RANGE")
 D CHKEQ^XTMUNIT($G(INFO(2,1,1)),3,"BAD VALUE FOR SECOND RANGE VALUE EMPTY-RANGE")
 ; MAX WITH ORED VALUES
 S FIXED=$$GETLIMIT^XTECGLO("^JUNK(45,4!5!7,0)",.MAXCOMMA,.INFO)
 D CHKEQ^XTMUNIT(MAXCOMMA,3,"INCORRECT MAXCOMMA FOR MAX WITH ORED SPEC")
 D CHKEQ^XTMUNIT(FIXED,"^JUNK(","INCORRECT FIXED PART FOR MAX WITH ORED SPEC")
 D CHKEQ^XTMUNIT($D(INFO(1)),10,"INFO NOT EMPTY FOR 1 FOR MAX WITH ORED SPEC")
 D CHKEQ^XTMUNIT($G(INFO(2,1)),4,"BAD VALUE FOR FIRST ORED VALUE")
 D CHKEQ^XTMUNIT($D(INFO(2,1,1)),0,"UNEXPECTED NODE FOR FIRST ORED SPEC")
 D CHKEQ^XTMUNIT($G(INFO(2,2)),5,"BAD VALUE FOR SECOND ORED VALUE")
 D CHKEQ^XTMUNIT($D(INFO(2,2,1)),0,"UNEXPECTED NODE FOR SECOND ORED SPEC")
 D CHKEQ^XTMUNIT($G(INFO(2,3)),7,"BAD VALUE FOR SECOND OR VALUE")
 D CHKEQ^XTMUNIT($D(INFO(2,3,1)),0,"UNEXPECTED NODE FOR THIRD ORED SPEC")
 D CHKEQ^XTMUNIT($G(INFO(3,1)),0,"BAD FIXED NODE FOR MAX ORED SPEC")
 D CHKEQ^XTMUNIT($D(INFO(3,1,1)),0,"UNEXPECTED NODE FOR FIXED MAX ORED SPEC")
 ; ORED RANGES
 S FIXED=$$GETLIMIT^XTECGLO("^JUNK(42,1:3!7:9,0",.MAXCOMMA,.INFO)
 D CHKEQ^XTMUNIT(MAXCOMMA,0,"INCORRECT MAXCOMMA FOR MAX WITH ORED RANGES SPEC")
 D CHKEQ^XTMUNIT(FIXED,"^JUNK(","INCORRECT FIXED PART FOR MAX WITH ORED SPEC")
 D CHKEQ^XTMUNIT($D(INFO(1)),10,"INFO NOT EMPTY FOR 1 FOR MAX WITH ORED RANGES")
 D CHKEQ^XTMUNIT($G(INFO(2,1)),1,"BAD VALUE FOR FIRST VALUE IN FIRST RANGE")
 D CHKEQ^XTMUNIT($G(INFO(2,1,1)),3,"BAD VALUE FOR SECOND VALUE IN FIRST RAMGE")
 D CHKEQ^XTMUNIT($G(INFO(2,2)),7,"BAD VALUE FOR FIRST VALUE IN SECOND RAMGE")
 D CHKEQ^XTMUNIT($G(INFO(2,2,1)),9,"BAD VALUE FOR SECOND VALUE IN SECOND RANGE")
 D CHKEQ^XTMUNIT($G(INFO(3,1)),0,"BAD FIXED NODE FOR MAX ORED SPEC")
 D CHKEQ^XTMUNIT($D(INFO(3,1,1)),0,"UNEXPECTED NODE FOR FIXED MAX ORED SPEC")
 Q
 ;
OR ;
 N ARR,GLOBLOC,GLOBRES,I
 S GLOBLOC=$NA(^TMP("ZZUTXTG1",$J)) K @GLOBLOC
 F I=1:1:10 S @GLOBLOC@(I)=I
 S GLOBRES=$NA(^TMP($J)) K @GLOBRES
 D LNODE^XTECGLO(GLOBRES,0,"^TMP(""ZZUTXTG1"",$J,1!3!5!7)",1)
 S ARR(1)=1,ARR(2)=3,ARR(3)=5,ARR(4)=7
 ; GLOBAL VALUES ON EVERY SECOND LINE IN GLOBRES
 F I=1:1:4 D CHKEQ^XTMUNIT($G(@GLOBRES@(I*2)),ARR(I),"BAD VALUE FOR FIRST OR TEST")
 ;
 K @GLOBLOC F I=1:1:10 S @GLOBLOC@(I)=I
 K @GLOBRES
 D LNODE^XTECGLO(GLOBRES,0,"^TMP(""ZZUTXTG1"",$J,8!6!4!3)",1)
 S ARR(1)=8,ARR(2)=6,ARR(3)=4,ARR(4)=3
 ; GLOBAL VALUES ON EVERY SECOND LINE IN GLOBRES
 F I=1:1:4 D CHKEQ^XTMUNIT($G(@GLOBRES@(I*2)),ARR(I),"BAD VALUE FOR SECOND OR TEST")
 K @GLOBRES,@GLOBLOC
 Q
 ;
NULL ;
 N GLOBRES,COUNT,NODE
 S GLOBRES=$NA(^TMP($J)) K @GLOBRES
 D LNODE^XTECGLO(GLOBRES,0,"^DD(8992,,0)",1)
 S NODE="",COUNT=0
 F  S NODE=$O(^DD(8992,NODE)) Q:NODE=""  I $D(^DD(8992,NODE,0))#2 S COUNT=COUNT+2 D CHKEQ^XTMUNIT($G(@GLOBRES@(COUNT)),"JUNK"_^DD(8992,NODE,0),"BAD VALUE FOR NODE "_NODE)
 D CHKEQ^XTMUNIT($D(@GLOBRES@(COUNT+1)),0,"DATA PRESENT IN RESULTS NODE "_(COUNT+1)_" NOT EXPECTED")
 K @GLOBRES
 Q
 ;
CLOSPARN ;
 N GLOBLOC,GLOBRES
 S GLOBLOC=$NA(^TMP("ZZUTXTG1",$J)) K @GLOBLOC
 S @GLOBLOC@(1)=1,@GLOBLOC@(1,1)=11,@GLOBLOC@(2)=2,@GLOBLOC@(2,1)=21
 S GLOBRES=$NA(^TMP($J)) K @GLOBRES
 ;D FILEINIT^XTMLOG("ZZUTXTG1")
 D LNODE^XTECGLO(GLOBRES,0,"^TMP(""ZZUTXTG1"",$J,)",1)
 ;D ENDLOG^XTMLOG("ZZUTXTG1")
 D CHKEQ^XTMUNIT($G(@GLOBRES@(2)),"JUNK1","BAD VALUE FOR FIRST ENTRY")
 D CHKEQ^XTMUNIT($G(@GLOBRES@(4)),"JUNK2","BAD VALUE FOR SECOND ENTRY")
 D CHKEQ^XTMUNIT($D(@GLOBRES@(5)),0,"DATA FOR THIRD ENTRY UNEXPECTED")
 K @GLOBLOC,@GLOBRES
 Q
 ;
NULLSRCH ;
 N GLOBRES,COUNT,NODE
 S GLOBRES=$NA(^TMP($J)) K @GLOBRES
 ;D FILEINIT^XTMLOG("ZZUTXTG1")
 D LNODE^XTECGLO(GLOBRES,0,"^DD(8992,,0)","1^0^0^X")
 ;D ENDLOG^XTMLOG("ZZUTXTG1")
 ; NOTE THAT NO VALUES OF ^DD(8992,NODE,0) CONTAIN AN X
 S COUNT=0,NODE="" F  S NODE=$O(^DD(8992,NODE)) Q:NODE=""  I $D(^DD(8992,NODE,0))#2,^(0)["X" S COUNT=COUNT+2 D CHKEQ^XTMUNIT("JUNK"_^(0),$G(@GLOBRES@(COUNT)),"UNEXPECTED DIFFERENCE IN SEARCHED TEXT")
 D CHKTF^XTMUNIT($D(@GLOBRES@(COUNT+1))=0,"UNEXPECTED DATA IN RESULTS AT NODE "_COUNT)
 K @GLOBRES
 Q
 ;
MIXEDVAL ;
 N GLOBVAL,GLOBRES,GLOBVAL1
 S GLOBVAL=$NA(^TMP("ZZUTXTG1",$J)) K @GLOBVAL
 S GLOBVAL1=$NA(^TMP("ZZUTXTG1","A")) K @GLOBVAL1
 S @GLOBVAL@(1)=1,^(2)=2,^(2,1)=21,@GLOBVAL@("A")="A",^("B")="B",^("C")="C",^("B",1)="B1"
 S @GLOBVAL1@(1)=10,^(2)=20,^(2,1)=210,@GLOBVAL1@("A")="A",^("B")="B",^("C")="C",^("B",1)="B1"
 S GLOBRES=$NA(^TMP($J)) K @GLOBRES
 D LNODE^XTECGLO(GLOBRES,0,"^TMP(""ZZUTXTD1"",$J,2",1)
 ;D CHKEQ^XTMUNIT(
 Q
 ;
CHEKTERM ;
 N GLOBVAL,TERM,ARRAY
 S GLOBVAL=$NA(^TMP("ZZUTXTG1",$J)) K @GLOBVAL
 S ARRAY(0,1)="^TMP("
 S TERM=$$CHEKTERM^XTECGLO("^TMP","^XTMP(45)",0,.ARRAY)
 D CHKEQ^XTMUNIT(TERM,1,"BAD TERM FOR GLOBAL NAME ONLY")
 S @GLOBVAL@(1)=1,@GLOBVAL@(2)=2,@GLOBVAL@("A")="A",@GLOBVAL@("B")="B"
 K ARRAY S ARRAY(0,1)="^TMP(",ARRAY(1,1)="""ZUTXTG1""",ARRAY(2,1)=$J,ARRAY(3,1)=1
 S TERM=$$CHEKTERM^XTECGLO($NA(@GLOBVAL@(1)),$NA(@GLOBVAL@(2)),0,.ARRAY)
 D CHKEQ^XTMUNIT(TERM,1,"BAD TERM FOR NUMERICS")
 K ARRAY S ARRAY(0,1)="^TMP(",ARRAY(1,1)="""ZUTXTG1""",ARRAY(2,1)=$J,ARRAY(3,1)=2
 S TERM=$$CHEKTERM^XTECGLO($NA(@GLOBVAL@(2)),$NA(@GLOBVAL@("A")),0,.ARRAY)
 D CHKEQ^XTMUNIT(TERM,1,"BAD TERM FOR NUMERIC-ALPHA")
 K ARRAY S ARRAY(0,1)="^TMP(",ARRAY(1,1)="""ZUTXTG1""",ARRAY(2,1)=$J,ARRAY(3,1)="""A"""
 S TERM=$$CHEKTERM^XTECGLO($NA(@GLOBVAL@("A")),$NA(@GLOBVAL@("B")),0,.ARRAY)
 D CHKEQ^XTMUNIT(TERM,1,"BAD TERM FOR ALPHAS")
 Q
 ;
XTROU ;
XTENT ;
 ;;FULL;GLOBAL LIST
 ;;PARSGLOB;PARSE GLOBAL PARTS
 ;;RANGE;GLOBAL LIST FOR RANGE XX:YY
 ;;SEARCH;SEARCH FOR TEXT IN GLOBALS OR VALUES
 ;;CHEKGLOB;check validity of current global location
 ;;GETLIMIT;return fixed part of spec and other data in array
 ;;CLOSPARN;handle closing parens
 ;;NULL;handle NULL nodes
 ;;NULLSRCH;does search, null node, and fixed comma pieces
 ;;MIXEDVAL;correct problem with numbers to quotes
 ;;CHEKTERM;check for termination of base
 ;;FOLLOWS;check for value follows base