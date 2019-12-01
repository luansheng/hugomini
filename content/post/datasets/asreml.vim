" Vim syntax file
" Language: ASReml
" Maintainer: Sheng Luan
" Latest Revision: 29 Nov 2019
" Filenames: *.as *.AS

if exists("b:current_syntax")
  finish
endif

syn case match

" Keywords about qualifier and statements with tabulate, predict and vpredict. Case is not sensitive.
syn keyword asQualifierStatement $1 $2 $3 $4 $5 $6 $7 $8 $9 !- !* !/ !^ !^0 !+ !< !<= !<> != !== !=> !> !{ !} !a !A !abs !ABS !adjust !ADJUST !ailoadings !AILOADINGS !aising !AISING !aisingularities !AISINGULARITIES !alpha !ALPHA !aod !AOD !arc !ARC !arcsin !ARCSIN !args !ARGS !ask !ASK !asmv !ASMV !assign !ASSIGN !asuv !ASUV !average !AVERAGE !bin !BIN !binomial !BINOMIAL !blup !BLUP !bmp !BMP !brief !BRIEF !cinv !CINV !colfac !COLFAC !comp !COMP !continue !CONTINUE !contrast !CONTRAST !cos !COS !count !COUNT !csv !CSV !cycle !CYCLE !d !D !datafile !DATAFILE !date !DATE !ddf !DDF !debug !DEBUG !dec !DEC !define !DEFINE !dense !DENSE !deviance !DEVIANCE !devpoints !DEVPOINTS !df !DF !diag !diag !DIAG !DIAG !disp !DISP !display !DISPLAY !dmy !DMY !do !DO !dom !DOM !dopart !DOPART !dopath !DOPATH !e !E !emflag !EMFLAG !end !END !eps !EPS !except !EXCEPT !exp !EXP !extra !EXTRA !facpoints !FACPOINTS !fcon !FCON !filter !FILTER !final !FINAL !float !FLOAT !for !FOR !format !FORMAT !f !F !g !g !G !G !gamma !GAMMA !gf !GF !giv !GIV !gkrige !GKRIGE !gp !GP !graph !GRAPH !groups !groups !gu !GU !hardcopy !HARDCOPY !heron !HERON !hpgl !HPGL !i !I !identity !IDENTITY !ignore !IGNORE !inbred !INBRED !include !include !init !INIT !inv !INV !jddm !JDDM !jmmd !JMMD !join !JOIN !jyyd !JYYD !knots !KNOTS !l !L !last !LAST !ll !LL !log !log !LOG !LOG !logit !LOGIT !m !M !make !MAKE !match !MATCH !max !MAX !maxit !MAXIT !mbf !MBF !mdy !MDY !merge !MERGE !mgs !mgs !mgs !MGS !min !MIN !mm !MM !mod !MOD !mvinclude !MVINCLUDE !mvremove !MVREMOVE !na !NA !negbin !negbin !NEGBIN !NEGBIN !nocheck !NOCHECK !nodisplay !NODISPLAY !nograph !NOGRAPH !noreorder !NOREORDER !normal !NORMAL !noscratch !NOSCRATCH !offset !OFFSET !onerun !ONERUN !onlyuse !ONLYUSE !outfolder !OUTFOLDER !own !OWN !p !P !parallel !PARALLEL !part !PART !path !PATH !pearson !PEARSON !plot !plot !PLOT !PLOT !poisson !POISSON !polpoints !POLPOINTS !ppoints !PPOINTS !present !PRESENT !print !PRINT !printall !PRINTALL !probit !PROBIT !prune !PRUNE !pruneoff !PRUNEOFF !ps !PS !pval !PVAL !pvr !PVR !pvsform !PVSFORM !pvw !PVW !quiet !QUIET !range !RANGE !r !R !read !READ !recode !RECODE !rename !RENAME !repeat !REPEAT !replace !REPLACE !report !REPORT !rescale !RESCALE !residuals !RESIDUALS !response !RESPONSE !restore !RESTORE !rowfac !ROWFAC !rrec !RREC !rskip !RSKIP !s2 !S2 !save !SAVE !scale !SCALE !score !SCORE !screen !SCREEN !section !SECTION !sed !SED !seed !SEED !select !SELECT !self !SELF !seq !seq !SEQ !SEQ !set !SET !setn !SETN !setu !SETU !sin !SIN !skip !skip !SKIP !SKIP !slnform !SLNFORM !slow !SLOW !smx !SMX !sort !SORT !sortall !SORTALL !sortoff !SORTOFF !spatial !SPATIAL !spline !SPLINE !sqrt !SQRT !stats !STATS !step !STEP !sub !SUB !subset !SUBSET !sum !SUM !tabform !TABFORM !time !TIME !tolerance !TOLERANCE !total !TOTAL !twostageweights !TWOSTAGEWEIGHTS !twoway !TWOWAY !txtform !TXTFORM !uniform !UNIFORM !use !USE !v !V !vcc !VCC !vgsectors !VGSECTORS !vpv !VPV !vrb !VRB !wmf !WMF !work !WORK !workspace !WORKSPACE !wt !wt !WT !WT !x !X !xml !XML !y !Y !yhtform !YHTFORM !yvar !YVAR $a $A $b $B $c $C $d $D $e $E $f $F $g $G $h $H $i $I $j $J $s $S predict PREDICT residual RESIDUAL tabulate TABULATE vpredict VPREDICT

" Keywords about terms in the model line. Case is sensitive.
syn keyword asModelTerm mu mv Trait Tr

" Keywords about functions and variance structure. Case is sensitive.
syn keyword asModelFunction ~ * . / aexp aexph aexpv agau agauh agauv ainv and ante ante1 ante2 ante3 ar arv arh ar1 ar1v ar1h ar2 ar2v ar2h ar3 ar3v ar3h arma armah armav at cir chol chol1 chol1c chol2c chol3c con corb corbh corbv corg corgh corgv corr coru coruv coruh cos diag exp fa fa1 fa2 fa3 fac facv facv1 facv2 facv3 gau giv giv1 giv2 giv3 giv4 giv5 giv6 iden id ide idv idh ieuc ieuch ieucv iexp iexph iexpv igau igauh igauv inv leg lin log lvr ma ma1 mah mav ma1h ma1v ma2 ma2h ma2v mbf nrm nrmv own1 own2 own3 own4 pol pow mat1 mat2 mat3 mat4 mat5 sar sarh sarv sar1 sar1v sar1h sar2 sar2v sar2h sat sin spl sph sqrt str uni units us xfa xfa1 xfa2 

setlocal iskeyword+=!
setlocal iskeyword+=$

" Keywords about comment
syn match asComment /#.*/

" Keywords about column names in the data file
syn match asConstant /^\s\w*/

" Keywords about new variants defined by !ASSIGN 
syn match asVariant /\$\w*/

hi def link asQualifierStatement Statement
hi def link asModelTerm PreProc
hi def link asModelFunction Type
hi def link asComment Comment
hi def link asConstant Constant 
hi def link asVariant Special 

