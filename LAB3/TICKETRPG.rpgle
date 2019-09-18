     FTICKETDPS CF   E             WORKSTN
       EXFMT GETINFO;
       DOW NOT(*IN03);
       EXSR GETRESULTS;
       *IN99 = *ON;

       IF IMPARED ='Y';
       *IN10 = *ON;
       *IN07 = *ON;
       *IN99 = *OFF;
       DOW (OCC = 0);
       *IN99 = *OFF;
       EXFMT GETINFO;
       EXSR GETRESULTS;
       *IN99 = *ON;
       ENDDO;
       ENDIF;

       WRITE GETINFO;

       EXFMT SHOWRESULT;
       *IN99 = *OFF;
       *IN10 = *OFF;

       IF *IN06 = *ON;
       EXFMT IMPDETAIL;
       ENDIF;

       IF *IN03 = *OFF;
       EXSR CLEAR;
       EXFMT GETINFO;
       ENDIF;
       ENDDO;

       *INLR = *ON;
       RETURN;

       BEGSR GetResults;

         SELECT;
           WHEN DEMERITS >= 15;
           RESULT1 = '==> Suspended license for thirty days';
           WHEN DEMERITS >= 9;
           RESULT1 = '==> Your licence is reviewed for suspension'
             + ' and possible interview request';
           WHEN DEMERITS >= 2;
           RESULT1 = '==> A warning letter is sent';
           WHEN DEMERITS >= 1;
           RESULT1 = '==> No action taken';
         ENDSL;

       IF IMPARED = 'N';

       SELECT;
         WHEN NMTICKET <= 1;
         RESULT2 ='==> No adjustment done';
         NEWRESULT = INSURANCE;
         WHEN NMTICKET <= 3;
         RESULT2 = '==> Rate increased by 10%';
         NEWRESULT = INSURANCE * 1.1;
         WHEN NMTICKET <= 5;
         RESULT2 = '==> Rate increased by 20%';
         NEWRESULT = INSURANCE * 1.2;
         WHEN NMTICKET >= 6;
         *IN23 = *ON;
         RESULT2 = '==> INSURANCE IS CANCELLED';
         NEWRESULT = INSURANCE;
         NEWRESULT = 99999;
       ENDSL;
       ENDIF;

       IF IMPARED = 'Y';
       *IN11 = *ON;

         RESULT2 = '==> Rate increased by 50%';
         NEWRESULT = INSURANCE * 1.5;
           SELECT;
         WHEN OCC = 1;
         RESULT3 ='==> 3-day licence suspension.'
          + ' This can not be appealed';
         OCCRN = '   first   ';
         WHEN OCC = 2;
         RESULT3 ='==> 7-day licence suspension.'
         + ' This can not be appealed';
         OCCRN = '    second    ';
         WHEN OCC >=3;
         RESULT3 ='==> 30-day licence suspension.'
         + ' This can not be appealed';
         OCCRN = 'third or more';
       ENDSL;
       ENDIF;

       ENDSR;

         BEGSR CLEAR;
           *IN23 = *OFF;
           *IN11 =*OFF;
           *IN10 = *OFF;
           *IN07 = *OFF;
           OCC = 0;
           DEMERITS = 0;
           NMTICKET = 0;
           IMPARED = ' ';
           INSURANCE = 0;
           RESULT3 = '';
           RESULT2 = '';
           RESULT1 = '';
           NEWRESULT = 0;

         ENDSR; 