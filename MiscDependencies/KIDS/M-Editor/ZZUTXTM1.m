ZZUTXTM1 ;jli/oifo-oak - unit test routine for XTMRPAR1 ;10/28/10  15:27
 ;;7.3;TOOLKIT;**81**;Apr 25, 1995
 D EN^XTMUNIT("ZZUTXTM1")
 Q
 ;
GETWORD ;
 N LINE,WORD,TERM,TYPE S (WORD,TERM,TYPE)=""
 S LINE=$$GETWORD^XTMRPAR1("EN^XTMUNIT(""ZZJLIUTR"") X=XQ1",.WORD,.TERM,.TYPE)
 D CHKEQ^XTMUNIT(WORD,"EN","FIRST CHARS NOT FOUND")
 D CHKEQ^XTMUNIT(TERM,"^","FIRST TERM NOT FOUND")
 D CHKEQ^XTMUNIT(TYPE,"WORD","FIRST TYPE NOT FOUND")
 ;
 S LINE=$$GETWORD^XTMRPAR1(LINE,.WORD,.TERM,.TYPE)
 D CHKEQ^XTMUNIT(WORD,"XTMUNIT","FIRST CHARS NOT FOUND")
 D CHKEQ^XTMUNIT(TERM,"(","FIRST TERM NOT FOUND")
 D CHKEQ^XTMUNIT(TYPE,"WORD","FIRST TYPE NOT FOUND")
 ;
 S LINE=$$GETWORD^XTMRPAR1(LINE,.WORD,.TERM,.TYPE)
 D CHKEQ^XTMUNIT(WORD,"""ZZJLIUTR""","FIRST CHARS NOT FOUND")
 D CHKEQ^XTMUNIT(TERM,")","FIRST TERM NOT FOUND")
 D CHKEQ^XTMUNIT(TYPE,"STRING","FIRST TYPE NOT FOUND")
 ;
 S LINE=$$GETWORD^XTMRPAR1(LINE,.WORD,.TERM,.TYPE)
 S LINE=$$GETWORD^XTMRPAR1(LINE,.WORD,.TERM,.TYPE)
 D CHKEQ^XTMUNIT(WORD,"X","FIRST CHARS NOT FOUND")
 D CHKEQ^XTMUNIT(TERM,"=","FIRST TERM NOT FOUND")
 D CHKEQ^XTMUNIT(TYPE,"WORD","FIRST TYPE NOT FOUND")
 ;
 S LINE=$$GETWORD^XTMRPAR1(LINE,.WORD,.TERM,.TYPE)
 D CHKEQ^XTMUNIT(WORD,"XQ1","FIRST CHARS NOT FOUND")
 D CHKEQ^XTMUNIT(TERM,"","FIRST TERM NOT FOUND")
 D CHKEQ^XTMUNIT(TYPE,"WORD","FIRST TYPE NOT FOUND")
 ;
 S LINE=$$GETWORD^XTMRPAR1("X=15,Y=$O(A)",.WORD,.TERM,.TYPE)
 S LINE=$$GETWORD^XTMRPAR1(LINE,.WORD,.TERM,.TYPE)
 D CHKEQ^XTMUNIT(WORD,"15","NUMBERS CHARS NOT FOUND")
 D CHKEQ^XTMUNIT(TERM,",","FIRST TERM NOT FOUND")
 D CHKEQ^XTMUNIT(TYPE,"NUMBER","NUMBER TYPE NOT FOUND")
 ;
 S LINE=$$GETWORD^XTMRPAR1(LINE,.WORD,.TERM,.TYPE)
 S LINE=$$GETWORD^XTMRPAR1(LINE,.WORD,.TERM,.TYPE)
 D CHKEQ^XTMUNIT(WORD,"$O","FIRST CHARS NOT FOUND")
 D CHKEQ^XTMUNIT(TERM,"(","FIRST TERM NOT FOUND")
 D CHKEQ^XTMUNIT(TYPE,"FUNCTION","FIRST TYPE NOT FOUND")
 ;
 S LINE=$$GETWORD^XTMRPAR1("X=$$GETWORD^XTMRPAR1(),Y=^TMP($J,A)",.WORD,.TERM,.TYPE)
 S LINE=$$GETWORD^XTMRPAR1(LINE,.WORD,.TERM,.TYPE)
 D CHKEQ^XTMUNIT(WORD,"$$GETWORD^XTMRPAR1","NUMBERS CHARS NOT FOUND")
 D CHKEQ^XTMUNIT(TERM,"(","FIRST TERM NOT FOUND")
 D CHKEQ^XTMUNIT(TYPE,"FUNCTION","NUMBER TYPE NOT FOUND")
 ;
 S LINE=$$GETWORD^XTMRPAR1(LINE,.WORD,.TERM,.TYPE)
 S LINE=$$GETWORD^XTMRPAR1(LINE,.WORD,.TERM,.TYPE)
 S LINE=$$GETWORD^XTMRPAR1(LINE,.WORD,.TERM,.TYPE)
 S LINE=$$GETWORD^XTMRPAR1(LINE,.WORD,.TERM,.TYPE)
 D CHKEQ^XTMUNIT(WORD,"^TMP","FIRST CHARS NOT FOUND")
 D CHKEQ^XTMUNIT(TERM,"(","FIRST TERM NOT FOUND")
 D CHKEQ^XTMUNIT(TYPE,"GLOBAL","FIRST TYPE NOT FOUND")
 ;
 Q
 ;
PARSLINE ;
 N LOCSTOR
 S LOCSTOR="PARSLINE" K @LOCSTOR
 D PARSLINE^XTMRPAR1("TAG N LOCSTOR S LOCSTOR=""ARGCOND"" K @LOCSTOR D ^%ZIS Q:POP",1,LOCSTOR)
 D CHKEQ^XTMUNIT($G(@LOCSTOR@(1,1,"CMD")),"NEW","PARSLINE - MISSED FIRST CMD")
 D CHKEQ^XTMUNIT($G(@LOCSTOR@(1,1,"CMD","ARG",1)),"LOCSTOR","PARSLINE - MISSED FIRST ARG")
 D CHKEQ^XTMUNIT($G(@LOCSTOR@(1,2,"CMD")),"SET","PARSLINE - MISSED SECOND CMD")
 D CHKEQ^XTMUNIT($G(@LOCSTOR@(1,2,"CMD","ARG",1)),"LOCSTOR=""ARGCOND""","PARSLINE - MISSED SECOND ARG")
 D CHKEQ^XTMUNIT($G(@LOCSTOR@(1,3,"CMD")),"KILL","PARSLINE - MISSED THIRD COMMAND")
 D CHKEQ^XTMUNIT($G(@LOCSTOR@(1,5,"CMD")),"QUIT","PARSLINE - MISSED FIFTH COMMAND")
 D CHKEQ^XTMUNIT($G(@LOCSTOR@(1,5,"CMD","COND",1)),"POP","PARSLINE - MISSED FIFTH POST COND")
 K @LOCSTOR
 Q
 ;
ARGCOND ;
 N LOCSTOR,LINE
 S LOCSTOR="ARGCOND"
 K @LOCSTOR
 ;S X=$$INITEASY^XTMLOG("ZZJLIUTR")
 S LINE=$$GETARGS^XTMRPAR1("X1=""DATA"":X1="""",X2=$S(X1'="""":X1,1:""A""):X0>0 R X",LOCSTOR)
 D CHKEQ^XTMUNIT($G(@LOCSTOR@("ARG",1)),"X1=""DATA""","DIDN'T GET FIRST ARGUMENT")
 D CHKEQ^XTMUNIT($G(@LOCSTOR@("ARG",1,"COND")),"X1=""""","DIDN'T GET FIRST CONDITIONAL RIGHT")
 D CHKEQ^XTMUNIT($G(@LOCSTOR@("ARG",2)),"X2=$S(X1'="""":X1,1:""A"")","DIDN'T GET SECOND ARGUMENT")
 D CHKEQ^XTMUNIT($G(@LOCSTOR@("ARG",2,"COND")),"X0>0","DIDN'T GET SECOND CONDITIONAL RIGHT")
 ;D ENDLOG^XTMLOG("ZZJLIUTR")
 K @LOCSTOR
 Q
 ;
CMDCOND ;
 N LINE,TERM,LOCSTOR,VALUE,LINENUM,ARGNUM
 S LOCSTOR="GETCOND",VALUE="",LINENUM=1,ARGNUM=0
 K @LOCSTOR
 S LINE=$$GETCMD^XTMRPAR1("S:X'="""" Y=Y1+2 REST OF LINE",LINENUM,.ARGNUM,LOCSTOR)
 D CHKEQ^XTMUNIT($G(@LOCSTOR@(LINENUM,ARGNUM,"CMD")),"SET","DIDN'T GET COMMAND RIGHT")
 D CHKEQ^XTMUNIT($G(@LOCSTOR@(LINENUM,ARGNUM,"CMD","COND",1)),"X'=""""","DIDN'T GET CONDITION RIGHT")
 D CHKEQ^XTMUNIT($G(@LOCSTOR@(LINENUM,ARGNUM,"CMD","ARG",1)),"Y=Y1+2","DIDN'T GET ARG RIGHT")
 K @LOCSTOR
 Q
 ;
GETPAREN ;
 N LINE,TERM,VALUE
 S TERM="(",VALUE=""
 S LINE=$$GETPAREN^XTMRPAR1("GETCMD,GETCMD1) ",.VALUE,.TERM)
 D CHKEQ^XTMUNIT(VALUE,"(GETCMD,GETCMD1)","GETPAREN FAILED")
 Q
 ;
GETARGS ;
 N LOCSTOR,LINE S LOCSTOR="GETARGS"
 K @LOCSTOR
 S LINE=$$GETARGS^XTMRPAR1("GETCMD,GETCMD1 R X",LOCSTOR)
 D CHKEQ^XTMUNIT($G(@LOCSTOR@("ARG",1)),"GETCMD","DIDN'T GET FIRST ARGUMENT")
 D CHKEQ^XTMUNIT($G(@LOCSTOR@("ARG",2)),"GETCMD1","DIDN'T GET SECOND ARGUMENT")
 ; +6
 K @LOCSTOR
 S LINE=$$GETARGS^XTMRPAR1("GETCMD(VAR1,VAR2),$$GETCMD1(A,""NEW"",C) R X",LOCSTOR)
 D CHKEQ^XTMUNIT($G(@LOCSTOR@("ARG",1)),"GETCMD(VAR1,VAR2)","DIDN'T GET FIRST ARGUMENT")
 D CHKEQ^XTMUNIT($G(@LOCSTOR@("ARG",2)),"$$GETCMD1(A,""NEW"",C)","DIDN'T GET SECOND ARGUMENT")
 ; +11
 K @LOCSTOR
 S LINE=$$GETARGS^XTMRPAR1("X1=""DATA"",X2=$S(X1'="""":X1,1:""A"") R X",LOCSTOR)
 D CHKEQ^XTMUNIT($G(@LOCSTOR@("ARG",1)),"X1=""DATA""","DIDN'T GET FIRST ARGUMENT")
 D CHKEQ^XTMUNIT($G(@LOCSTOR@("ARG",2)),"X2=$S(X1'="""":X1,1:""A"")","DIDN'T GET SECOND ARGUMENT")
 ;
 ;S X=$$INITEASY^XTMLOG("ZZJLIUTR")
 S LINE=$$GETARGS^XTMRPAR1("X1=$$GETARGS^XTMRPAR1,X2=^TMP($J,A) R X",LOCSTOR)
 D CHKEQ^XTMUNIT($G(@LOCSTOR@("ARG",1)),"X1=$$GETARGS^XTMRPAR1","DIDN'T GET FIRST ARGUMENT")
 D CHKEQ^XTMUNIT($G(@LOCSTOR@("ARG",2)),"X2=^TMP($J,A)","DIDN'T GET SECOND ARGUMENT")
 ;D ENDLOG^XTMLOG("ZZJLIUTR")
 ; +11
 K @LOCSTOR
 Q
 ;
PATTERN ; parse line including pattern match
 N LOCSTOR,LINE
 S LINE="TAG I $P(LA7Y(LA7X),""^"",2)?1(1""S"",1""L"") S X=1"
 S LOCSTOR="PATTERN" K @LOCSTOR
 D PARSLINE^XTMRPAR1(LINE,1,LOCSTOR)
 D CHKEQ^XTMUNIT($G(@LOCSTOR@(1,1,"CMD")),"IF","PATTERN - MISSED FIRST COMMAND")
 D CHKEQ^XTMUNIT($G(@LOCSTOR@(1,1,"CMD","ARG",1)),"$P(LA7Y(LA7X),""^"",2)?1(1""S"",1""L"")","PARSLINE - MISSED FIRST ARG")
 D CHKEQ^XTMUNIT($G(@LOCSTOR@(1,2,"CMD")),"SET","PARSLINE - MISSED SECOND CMD")
 D CHKEQ^XTMUNIT($G(@LOCSTOR@(1,2,"CMD","ARG",1)),"X=1","PARSLINE - MISSED SECOND ARG")
 K @LOCSTOR
 Q
 ;
PATTERN2 ; parse line including pattern match with .AN
 N LOCSTOR,LINE
 S LINE="TAG I FROM'="""",FROM'?1(1""%"",1A).AN,X=0 S FLG=""-1^INVALID 'FROM' NAME"""
 S LOCSTOR="PATTERN" K @LOCSTOR
 D PARSLINE^XTMRPAR1(LINE,1,LOCSTOR)
 D CHKEQ^XTMUNIT($G(@LOCSTOR@(1,1,"CMD")),"IF","PATTERN2 - MISSED FIRST COMMAND")
 D CHKEQ^XTMUNIT($G(@LOCSTOR@(1,1,"CMD","ARG",1)),"FROM'=""""","PATTERN2- MISSED FIRST ARG")
 D CHKEQ^XTMUNIT($G(@LOCSTOR@(1,1,"CMD","ARG",2)),"FROM'?1(1""%"",1A).AN","PATTERN2 - MISSED 2ND ARG FIRST CMD")
 D CHKEQ^XTMUNIT($G(@LOCSTOR@(1,1,"CMD","ARG",3)),"X=0","PATTERN2 - MISSED 3RD ARG FIRST CMD")
 D CHKEQ^XTMUNIT($G(@LOCSTOR@(1,2,"CMD")),"SET","PATTERN2 - MISSED SECOND CMD")
 D CHKEQ^XTMUNIT($G(@LOCSTOR@(1,2,"CMD","ARG",1)),"FLG=""-1^INVALID 'FROM' NAME""","PATTERN2 - MISSED SECOND ARG")
 K @LOCSTOR
 S LINE="TAG I X[""BET"" I X?.AN S Y=1"
 S LOCSTOR="PATTERN" K @LOCSTOR
 D PARSLINE^XTMRPAR1(LINE,1,LOCSTOR)
 D CHKEQ^XTMUNIT($G(@LOCSTOR@(1,1,"CMD")),"IF","PATTERN2-B - MISSED FIRST COMMAND")
 D CHKEQ^XTMUNIT($G(@LOCSTOR@(1,1,"CMD","ARG",1)),"X[""BET""","PATTERN2-B - MISSED FIRST ARG")
 D CHKEQ^XTMUNIT($G(@LOCSTOR@(1,2,"CMD")),"IF","PATTERN2-B - MISSED SECOND CMD")
 D CHKEQ^XTMUNIT($G(@LOCSTOR@(1,2,"CMD","ARG",1)),"X?.AN","PATTERN2-B - MISSED SECOND ARG")
 D CHKEQ^XTMUNIT($G(@LOCSTOR@(1,3,"CMD")),"SET","PATTERN2-B - MISSED SET COMMAND")
 D CHKEQ^XTMUNIT($G(@LOCSTOR@(1,3,"CMD","ARG",1)),"Y=1","MISSED ARG FOR SET COMMAND")
 K @LOCSTOR
 Q
 ;
NAKDVARS ; make sure characters in a pattern match aren't identified as variables
 N LINE,WORD,TERM,TYPE
 S LINE="FROM'="""",FROM'?1(1""%"",1A).AN"
 S LINE=$$GETWORD^XTMRPAR1(LINE,.WORD,.TERM,.TYPE)
 D CHKEQ^XTMUNIT(WORD,"FROM","GETWORD FAILED ON FIRST")
 S LINE=$$GETWORD^XTMRPAR1(LINE,.WORD,.TERM,.TYPE)
 S LINE=$$GETWORD^XTMRPAR1(LINE,.WORD,.TERM,.TYPE)
 S LINE=$$GETWORD^XTMRPAR1(LINE,.WORD,.TERM,.TYPE)
 D CHKEQ^XTMUNIT(WORD,"FROM","GETWORD FAILED ON FOURTH")
 D CHKEQ^XTMUNIT(LINE,"?1(1""%"",1A).AN","LINE INCORRECT ON FOURTH CALL")
 S LINE=$$GETWORD^XTMRPAR1(LINE,.WORD,.TERM,.TYPE)
 D CHKEQ^XTMUNIT(WORD,"","GETWORD FAILED ON PATTERN")
 D CHKEQ^XTMUNIT(LINE,"","LINE NOT NULL ON FIFTH CALL")
 ;
 S LINE="X?.AN"
 S LINE=$$GETWORD^XTMRPAR1(LINE,.WORD,.TERM,.TYPE)
 D CHKEQ^XTMUNIT(WORD,"X","GETWORD FAILED ON FIRST")
 D CHKEQ^XTMUNIT(LINE,".AN","BAD LINE FROM FIRST CALL")
 S LINE=$$GETWORD^XTMRPAR1(LINE,.WORD,.TERM,.TYPE)
 D CHKEQ^XTMUNIT(WORD,"","GETWORD FAILED ON FIRST")
 D CHKEQ^XTMUNIT(LINE,"AN","BAD LINE FROM FIRST CALL")
 S LINE=$$GETWORD^XTMRPAR1(LINE,.WORD,.TERM,.TYPE)
 D CHKEQ^XTMUNIT(WORD,"AN","GETWORD FAILED ON FIRST")
 D CHKEQ^XTMUNIT(TYPE,"WORD")
 D CHKEQ^XTMUNIT(TERM,"","BAD LINE FROM FIRST CALL")
 Q
 ;
XTROU ;
 ;;ZZUTXTM2;continuation of this set of tests
XTENT ;
 ;;GETARGS;get arguments
 ;;GETPAREN;get values inside parentheses
 ;;CMDCOND;get conditionals
 ;;ARGCOND;get post conditionals on args
 ;;PARSLINE;parse a line into types of tokens
 ;;GETWORD;parse characters for words
 ;;PATTERN;parse line including pattern match
 ;;PATTERN2;parse line including pattern match with .AN
 ;;NAKDVARS;make sure characters in a pattern match aren't identified as variables
