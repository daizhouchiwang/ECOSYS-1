
      SUBROUTINE outph(I,J,NT,NE,NAX,NDX,NTX,NEX,NHW,NHE,NVN,NVS)
C
C     THIS SUBROUTINE WRITES HOURLY OUTPUT FOR PLANT
C     C, N, P, WATER AND HEAT TO OUTPUT FILES DEPENDING
C     ON SELECTIONS MADE IN OUTPUT CONTROL FILES IN
C     THE RUN SCRIPT
C
      include "parameters.h"
      include "filec.h"
      include "files.h"
      include "blkc.h"
      include "blk1cp.h"
      include "blk1cr.h"
      include "blk1g.h"
      include "blk1n.h"
      include "blk1p.h"
      include "blk3.h"
      include "blk8a.h"
      include "blk8b.h"
      include "blk9a.h"
      include "blk9b.h"
      include "blk9c.h"
      include "blk12a.h"
      include "blk12b.h"
      include "blk14.h"
      CHARACTER*16 DATA(30),DATAC(30,250,250),DATAP(JP,JY,JX)
     2,DATAM(JP,JY,JX),DATAX(JP),DATAY(JP),DATAZ(JP,JY,JX)
     3,OUTS(10),OUTP(10),OUTFILS(10,JY,JX),OUTFILP(10,JP,JY,JX)
      CHARACTER*3 CHOICE(102,20)
      CHARACTER*8 CDATE
      DIMENSION HEAD(50)
      DO 1040 N=21,25
      IF(DATAC(N,NE,NEX).NE.'NO')THEN
      DO 1010 M=1,50
      HEAD(M)=0.0
1010  CONTINUE
      LUN=N+20
      DO 9995 NX=NHW,NHE
      DO 9990 NY=NVN,NVS
      DO 9985 NZ=1,NP(NY,NX)
      IF(IFLGC(NZ,NY,NX).EQ.1)THEN
C
C     WRITE HOURLY CROP DATA TO OUTPUT FILES
C
      M=0
C
C     HOURLY PLANT C OUTPUT
C
      IF(N.EQ.21)THEN
      IF(I.GE.IDATA(N).AND.I.LE.IDATA(N+20))THEN
      DO 1021 K=51,100
      IF(CHOICE(K,N-20).EQ.'YES')THEN
      M=M+1
      IF(K.EQ.51)HEAD(M)=CNET(NZ,NY,NX)/AREA(3,NU(NY,NX),NY,NX)*23.148
      IF(K.EQ.52)HEAD(M)=CARBN(NZ,NY,NX)/AREA(3,NU(NY,NX),NY,NX)
      IF(K.EQ.53)HEAD(M)=TCO2T(NZ,NY,NX)/AREA(3,NU(NY,NX),NY,NX)
      IF(K.EQ.54)HEAD(M)=CCPOLP(NZ,NY,NX)
      IF(K.EQ.55)HEAD(M)=RC(NZ,NY,NX)*1.56*3600.0
      IF(K.EQ.56)HEAD(M)=RA(NZ,NY,NX)*1.34*3600.0
      IF(K.EQ.57)HEAD(M)=CO2Q(NZ,NY,NX)
      IF(K.EQ.58)HEAD(M)=ARLFP(NZ,NY,NX)/AREA(3,NU(NY,NX),NY,NX)
      ENDIF
1021  CONTINUE
      WRITE(LUN,'(A16,F8.3,4X,A8,I8,50E16.7E3)')OUTFILP(N-20,NZ,NY,NX)
     2,DOY,CDATE,J,(HEAD(K),K=1,M)
      ENDIF
      ENDIF
C
C     HOURLY PLANT WATER OUTPUT
C
      IF(N.EQ.22)THEN
      IF(I.GE.IDATA(N).AND.I.LE.IDATA(N+20))THEN
      DO 1022 K=51,100
      IF(CHOICE(K,N-20).EQ.'YES')THEN
      M=M+1
      IF(K.EQ.51)HEAD(M)=PSILT(NZ,NY,NX)
      IF(K.EQ.52)HEAD(M)=PSILG(NZ,NY,NX)
      IF(K.EQ.53)HEAD(M)=RC(NZ,NY,NX)*3600.0
      IF(K.EQ.54)HEAD(M)=RA(NZ,NY,NX)*3600.0
      IF(K.EQ.55)HEAD(M)=EP(NZ,NY,NX)*1000.0/AREA(3,NU(NY,NX),NY,NX)
      IF(K.EQ.56)HEAD(M)=OSTR(NZ,NY,NX)
      IF(K.EQ.57)HEAD(M)=PSIRT(1,1,NZ,NY,NX)
      IF(K.EQ.58)HEAD(M)=PSIRT(1,2,NZ,NY,NX)
      IF(K.EQ.59)HEAD(M)=PSIRT(1,3,NZ,NY,NX)
      IF(K.EQ.60)HEAD(M)=PSIRT(1,4,NZ,NY,NX)
      IF(K.EQ.61)HEAD(M)=PSIRT(1,5,NZ,NY,NX)
      IF(K.EQ.62)HEAD(M)=PSIRT(1,6,NZ,NY,NX)
      IF(K.EQ.63)HEAD(M)=PSIRT(1,7,NZ,NY,NX)
      IF(K.EQ.64)HEAD(M)=PSIRT(1,8,NZ,NY,NX)
      IF(K.EQ.65)HEAD(M)=PSIRT(1,9,NZ,NY,NX)
      IF(K.EQ.66)HEAD(M)=PSIRT(1,10,NZ,NY,NX)
      IF(K.EQ.67)HEAD(M)=PSIRT(1,11,NZ,NY,NX)
      IF(K.EQ.68)HEAD(M)=PSIRT(1,12,NZ,NY,NX)
      IF(K.EQ.69)HEAD(M)=PSIRT(1,13,NZ,NY,NX)
      IF(K.EQ.70)HEAD(M)=PSIRT(1,14,NZ,NY,NX)
      IF(K.EQ.71)HEAD(M)=PSIRT(1,15,NZ,NY,NX)
      ENDIF
1022  CONTINUE
      WRITE(LUN,'(A16,F8.3,4X,A8,I8,50E16.7E3)')OUTFILP(N-20,NZ,NY,NX)
     2,DOY,CDATE,J,(HEAD(K),K=1,M)
      ENDIF
      ENDIF
C
C     HOURLY PLANT N OUTPUT
C
      IF(N.EQ.23)THEN
      IF(I.GE.IDATA(N).AND.I.LE.IDATA(N+20))THEN
      DO 1023 K=51,100
      IF(CHOICE(K,N-20).EQ.'YES')THEN
      M=M+1
      IF(K.EQ.51)HEAD(M)=UPNH4(NZ,NY,NX)/AREA(3,NU(NY,NX),NY,NX)
      IF(K.EQ.52)HEAD(M)=UPNO3(NZ,NY,NX)/AREA(3,NU(NY,NX),NY,NX)
      IF(K.EQ.53)HEAD(M)=UPNF(NZ,NY,NX)/AREA(3,NU(NY,NX),NY,NX)
      IF(K.EQ.54)HEAD(M)=CZPOLP(NZ,NY,NX)
      IF(K.EQ.55)HEAD(M)=RNH3C(NZ,NY,NX)/AREA(3,NU(NY,NX),NY,NX)
      IF(K.EQ.56)HEAD(M)=(RUPNH4(1,1,NZ,NY,NX)+RUPNH4(2,1,NZ,NY,NX)
     2+RUPNHB(1,1,NZ,NY,NX)+RUPNHB(2,1,NZ,NY,NX))/AREA(3,1,NY,NX)
      IF(K.EQ.57)HEAD(M)=(RUPNH4(1,2,NZ,NY,NX)+RUPNH4(2,2,NZ,NY,NX)
     2+RUPNHB(1,2,NZ,NY,NX)+RUPNHB(2,2,NZ,NY,NX))/AREA(3,2,NY,NX)
      IF(K.EQ.58)HEAD(M)=(RUPNH4(1,3,NZ,NY,NX)+RUPNH4(2,3,NZ,NY,NX)
     2+RUPNHB(1,3,NZ,NY,NX)+RUPNHB(2,3,NZ,NY,NX))/AREA(3,3,NY,NX)
      IF(K.EQ.59)HEAD(M)=(RUPNH4(1,4,NZ,NY,NX)+RUPNH4(2,4,NZ,NY,NX)
     2+RUPNHB(1,4,NZ,NY,NX)+RUPNHB(2,4,NZ,NY,NX))/AREA(3,4,NY,NX)
      IF(K.EQ.60)HEAD(M)=(RUPNH4(1,5,NZ,NY,NX)+RUPNH4(2,5,NZ,NY,NX)
     2+RUPNHB(1,5,NZ,NY,NX)+RUPNHB(2,5,NZ,NY,NX))/AREA(3,5,NY,NX)
      IF(K.EQ.61)HEAD(M)=(RUPNH4(1,6,NZ,NY,NX)+RUPNH4(2,6,NZ,NY,NX)
     2+RUPNHB(1,6,NZ,NY,NX)+RUPNHB(2,6,NZ,NY,NX))/AREA(3,6,NY,NX)
      IF(K.EQ.62)HEAD(M)=(RUPNH4(1,7,NZ,NY,NX)+RUPNH4(2,7,NZ,NY,NX)
     2+RUPNHB(1,7,NZ,NY,NX)+RUPNHB(2,7,NZ,NY,NX))/AREA(3,7,NY,NX)
      IF(K.EQ.63)HEAD(M)=(RUPNH4(1,8,NZ,NY,NX)+RUPNH4(2,8,NZ,NY,NX)
     2+RUPNHB(1,8,NZ,NY,NX)+RUPNHB(2,8,NZ,NY,NX))/AREA(3,8,NY,NX)
      IF(K.EQ.64)HEAD(M)=(RUPNH4(1,9,NZ,NY,NX)+RUPNH4(2,9,NZ,NY,NX)
     2+RUPNHB(1,9,NZ,NY,NX)+RUPNHB(2,9,NZ,NY,NX))/AREA(3,9,NY,NX)
      IF(K.EQ.65)HEAD(M)=(RUPNH4(1,10,NZ,NY,NX)+RUPNH4(2,10,NZ,NY,NX)
     2+RUPNHB(1,10,NZ,NY,NX)+RUPNHB(2,10,NZ,NY,NX))/AREA(3,10,NY,NX)
      IF(K.EQ.66)HEAD(M)=(RUPNH4(1,11,NZ,NY,NX)+RUPNH4(2,11,NZ,NY,NX)
     2+RUPNHB(1,11,NZ,NY,NX)+RUPNHB(2,11,NZ,NY,NX))/AREA(3,11,NY,NX)
      IF(K.EQ.67)HEAD(M)=(RUPNH4(1,12,NZ,NY,NX)+RUPNH4(2,12,NZ,NY,NX)
     2+RUPNHB(1,12,NZ,NY,NX)+RUPNHB(2,12,NZ,NY,NX))/AREA(3,12,NY,NX)
      IF(K.EQ.68)HEAD(M)=(RUPNH4(1,13,NZ,NY,NX)+RUPNH4(2,13,NZ,NY,NX)
     2+RUPNHB(1,13,NZ,NY,NX)+RUPNHB(2,13,NZ,NY,NX))/AREA(3,13,NY,NX)
      IF(K.EQ.69)HEAD(M)=(RUPNH4(1,14,NZ,NY,NX)+RUPNH4(2,14,NZ,NY,NX)
     2+RUPNHB(1,14,NZ,NY,NX)+RUPNHB(2,14,NZ,NY,NX))/AREA(3,14,NY,NX)
      IF(K.EQ.70)HEAD(M)=(RUPNH4(1,15,NZ,NY,NX)+RUPNH4(2,15,NZ,NY,NX)
     2+RUPNHB(1,15,NZ,NY,NX)+RUPNHB(2,15,NZ,NY,NX))/AREA(3,15,NY,NX)
      IF(K.EQ.71)HEAD(M)=(RUPNO3(1,1,NZ,NY,NX)+RUPNO3(2,1,NZ,NY,NX)
     2+RUPNOB(1,1,NZ,NY,NX)+RUPNOB(2,1,NZ,NY,NX))/AREA(3,1,NY,NX)
      IF(K.EQ.72)HEAD(M)=(RUPNO3(1,2,NZ,NY,NX)+RUPNO3(2,2,NZ,NY,NX)
     2+RUPNOB(1,2,NZ,NY,NX)+RUPNOB(2,2,NZ,NY,NX))/AREA(3,2,NY,NX)
      IF(K.EQ.73)HEAD(M)=(RUPNO3(1,3,NZ,NY,NX)+RUPNO3(2,3,NZ,NY,NX)
     2+RUPNOB(1,3,NZ,NY,NX)+RUPNOB(2,3,NZ,NY,NX))/AREA(3,3,NY,NX)
      IF(K.EQ.74)HEAD(M)=(RUPNO3(1,4,NZ,NY,NX)+RUPNO3(2,4,NZ,NY,NX)
     2+RUPNOB(1,4,NZ,NY,NX)+RUPNOB(2,4,NZ,NY,NX))/AREA(3,4,NY,NX)
      IF(K.EQ.75)HEAD(M)=(RUPNO3(1,5,NZ,NY,NX)+RUPNO3(2,5,NZ,NY,NX)
     2+RUPNOB(1,5,NZ,NY,NX)+RUPNOB(2,5,NZ,NY,NX))/AREA(3,5,NY,NX)
      IF(K.EQ.76)HEAD(M)=(RUPNO3(1,6,NZ,NY,NX)+RUPNO3(2,6,NZ,NY,NX)
     2+RUPNOB(1,6,NZ,NY,NX)+RUPNOB(2,6,NZ,NY,NX))/AREA(3,6,NY,NX)
      IF(K.EQ.77)HEAD(M)=(RUPNO3(1,7,NZ,NY,NX)+RUPNO3(2,7,NZ,NY,NX)
     2+RUPNOB(1,7,NZ,NY,NX)+RUPNOB(2,7,NZ,NY,NX))/AREA(3,7,NY,NX)
      IF(K.EQ.78)HEAD(M)=(RUPNO3(1,8,NZ,NY,NX)+RUPNO3(2,8,NZ,NY,NX)
     2+RUPNOB(1,8,NZ,NY,NX)+RUPNOB(2,8,NZ,NY,NX))/AREA(3,8,NY,NX)
      IF(K.EQ.79)HEAD(M)=(RUPNO3(1,9,NZ,NY,NX)+RUPNO3(2,9,NZ,NY,NX)
     2+RUPNOB(1,9,NZ,NY,NX)+RUPNOB(2,9,NZ,NY,NX))/AREA(3,9,NY,NX)
      IF(K.EQ.80)HEAD(M)=(RUPNO3(1,10,NZ,NY,NX)+RUPNO3(2,10,NZ,NY,NX)
     2+RUPNOB(1,10,NZ,NY,NX)+RUPNOB(2,10,NZ,NY,NX))/AREA(3,10,NY,NX)
      IF(K.EQ.81)HEAD(M)=(RUPNO3(1,11,NZ,NY,NX)+RUPNO3(2,11,NZ,NY,NX)
     2+RUPNOB(1,11,NZ,NY,NX)+RUPNOB(2,11,NZ,NY,NX))/AREA(3,11,NY,NX)
      IF(K.EQ.82)HEAD(M)=(RUPNO3(1,12,NZ,NY,NX)+RUPNO3(2,12,NZ,NY,NX)
     2+RUPNOB(1,12,NZ,NY,NX)+RUPNOB(2,12,NZ,NY,NX))/AREA(3,12,NY,NX)
      IF(K.EQ.83)HEAD(M)=(RUPNO3(1,13,NZ,NY,NX)+RUPNO3(2,13,NZ,NY,NX)
     2+RUPNOB(1,13,NZ,NY,NX)+RUPNOB(2,13,NZ,NY,NX))/AREA(3,13,NY,NX)
      IF(K.EQ.84)HEAD(M)=(RUPNO3(1,14,NZ,NY,NX)+RUPNO3(2,14,NZ,NY,NX)
     2+RUPNOB(1,14,NZ,NY,NX)+RUPNOB(2,14,NZ,NY,NX))/AREA(3,14,NY,NX)
      IF(K.EQ.85)HEAD(M)=(RUPNO3(1,15,NZ,NY,NX)+RUPNO3(2,15,NZ,NY,NX)
     2+RUPNOB(1,15,NZ,NY,NX)+RUPNOB(2,15,NZ,NY,NX))/AREA(3,15,NY,NX)
      ENDIF
1023  CONTINUE
      WRITE(LUN,'(A16,F8.3,4X,A8,I8,50E16.7E3)')OUTFILP(N-20,NZ,NY,NX)
     2,DOY,CDATE,J,(HEAD(K),K=1,M)
      ENDIF
      ENDIF
C
C     HOURLY PLANT P OUTPUT
C
      IF(N.EQ.24)THEN
      IF(I.GE.IDATA(N).AND.I.LE.IDATA(N+20))THEN
      DO 1024 K=51,100
      IF(CHOICE(K,N-20).EQ.'YES')THEN
      M=M+1
      IF(K.EQ.51)HEAD(M)=UPH2P(NZ,NY,NX)/AREA(3,NU(NY,NX),NY,NX)
      IF(K.EQ.52)HEAD(M)=CPPOLP(NZ,NY,NX)
      IF(K.EQ.53)HEAD(M)=(RUPH2P(1,1,NZ,NY,NX)+RUPH2P(2,1,NZ,NY,NX)
     2+RUPH2B(1,1,NZ,NY,NX)+RUPH2B(2,1,NZ,NY,NX))/AREA(3,1,NY,NX)
      IF(K.EQ.54)HEAD(M)=(RUPH2P(1,2,NZ,NY,NX)+RUPH2P(2,2,NZ,NY,NX)
     2+RUPH2B(1,2,NZ,NY,NX)+RUPH2B(2,2,NZ,NY,NX))/AREA(3,2,NY,NX)
      IF(K.EQ.55)HEAD(M)=(RUPH2P(1,3,NZ,NY,NX)+RUPH2P(2,3,NZ,NY,NX)
     2+RUPH2B(1,3,NZ,NY,NX)+RUPH2B(2,3,NZ,NY,NX))/AREA(3,3,NY,NX)
      IF(K.EQ.56)HEAD(M)=(RUPH2P(1,4,NZ,NY,NX)+RUPH2P(2,4,NZ,NY,NX)
     2+RUPH2B(1,4,NZ,NY,NX)+RUPH2B(2,4,NZ,NY,NX))/AREA(3,4,NY,NX)
      IF(K.EQ.57)HEAD(M)=(RUPH2P(1,5,NZ,NY,NX)+RUPH2P(2,5,NZ,NY,NX)
     2+RUPH2B(1,5,NZ,NY,NX)+RUPH2B(2,5,NZ,NY,NX))/AREA(3,5,NY,NX)
      IF(K.EQ.58)HEAD(M)=(RUPH2P(1,6,NZ,NY,NX)+RUPH2P(2,6,NZ,NY,NX)
     2+RUPH2B(1,6,NZ,NY,NX)+RUPH2B(2,6,NZ,NY,NX))/AREA(3,6,NY,NX)
      IF(K.EQ.59)HEAD(M)=(RUPH2P(1,7,NZ,NY,NX)+RUPH2P(2,7,NZ,NY,NX)
     2+RUPH2B(1,7,NZ,NY,NX)+RUPH2B(2,7,NZ,NY,NX))/AREA(3,7,NY,NX)
      IF(K.EQ.60)HEAD(M)=(RUPH2P(1,8,NZ,NY,NX)+RUPH2P(2,8,NZ,NY,NX)
     2+RUPH2B(1,8,NZ,NY,NX)+RUPH2B(2,8,NZ,NY,NX))/AREA(3,8,NY,NX)
      IF(K.EQ.61)HEAD(M)=(RUPH2P(1,9,NZ,NY,NX)+RUPH2P(2,9,NZ,NY,NX)
     2+RUPH2B(1,9,NZ,NY,NX)+RUPH2B(2,9,NZ,NY,NX))/AREA(3,9,NY,NX)
      IF(K.EQ.62)HEAD(M)=(RUPH2P(1,10,NZ,NY,NX)+RUPH2P(2,10,NZ,NY,NX)
     2+RUPH2B(1,10,NZ,NY,NX)+RUPH2B(2,10,NZ,NY,NX))/AREA(3,10,NY,NX)
      IF(K.EQ.63)HEAD(M)=(RUPH2P(1,11,NZ,NY,NX)+RUPH2P(2,11,NZ,NY,NX)
     2+RUPH2B(1,11,NZ,NY,NX)+RUPH2B(2,11,NZ,NY,NX))/AREA(3,11,NY,NX)
      IF(K.EQ.64)HEAD(M)=(RUPH2P(1,12,NZ,NY,NX)+RUPH2P(2,12,NZ,NY,NX)
     2+RUPH2B(1,12,NZ,NY,NX)+RUPH2B(2,12,NZ,NY,NX))/AREA(3,12,NY,NX)
      IF(K.EQ.65)HEAD(M)=(RUPH2P(1,13,NZ,NY,NX)+RUPH2P(2,13,NZ,NY,NX)
     2+RUPH2B(1,13,NZ,NY,NX)+RUPH2B(2,13,NZ,NY,NX))/AREA(3,13,NY,NX)
      IF(K.EQ.66)HEAD(M)=(RUPH2P(1,14,NZ,NY,NX)+RUPH2P(2,14,NZ,NY,NX)
     2+RUPH2B(1,14,NZ,NY,NX)+RUPH2B(2,14,NZ,NY,NX))/AREA(3,14,NY,NX)
      IF(K.EQ.67)HEAD(M)=(RUPH2P(1,15,NZ,NY,NX)+RUPH2P(2,15,NZ,NY,NX)
     2+RUPH2B(1,15,NZ,NY,NX)+RUPH2B(2,15,NZ,NY,NX))/AREA(3,15,NY,NX)
      ENDIF
1024  CONTINUE
      WRITE(LUN,'(A16,F8.3,4X,A8,I8,50E16.7E3)')OUTFILP(N-20,NZ,NY,NX)
     2,DOY,CDATE,J,(HEAD(K),K=1,M)
      ENDIF
      ENDIF
C
C     HOURLY PLANT HEAT OUTPUT
C
      IF(N.EQ.25)THEN
      IF(I.GE.IDATA(N).AND.I.LE.IDATA(N+20))THEN
      DO 1025 K=51,100
      IF(CHOICE(K,N-20).EQ.'YES')THEN
      M=M+1
      IF(K.EQ.51)HEAD(M)=277.8*RAD1(NZ,NY,NX)/AREA(3,NU(NY,NX),NY,NX)
      IF(K.EQ.52)HEAD(M)=277.8*EFLXC(NZ,NY,NX)/AREA(3,NU(NY,NX),NY,NX)
      IF(K.EQ.53)HEAD(M)=277.8*SFLXC(NZ,NY,NX)/AREA(3,NU(NY,NX),NY,NX)
      IF(K.EQ.54)HEAD(M)=277.8*HFLXC(NZ,NY,NX)/AREA(3,NU(NY,NX),NY,NX)
      IF(K.EQ.55)HEAD(M)=TCC(NZ,NY,NX)
      IF(K.EQ.56)HEAD(M)=TFN3(NZ,NY,NX)
      ENDIF
1025  CONTINUE
      WRITE(LUN,'(A16,F8.3,4X,A8,I8,50E16.7E3)')OUTFILP(N-20,NZ,NY,NX)
     2,DOY,CDATE,J,(HEAD(K),K=1,M)
      ENDIF
      ENDIF
      ENDIF
9985  CONTINUE
9990  CONTINUE
9995  CONTINUE
      ENDIF
1040  CONTINUE
      RETURN
      END
