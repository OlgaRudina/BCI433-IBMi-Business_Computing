       CTL-OPT DatFmt (*USA);
       /COPY LAB10,DATEPROTOS WORKSTN;
       DCL-F WhatDayDsp      WORKSTN;
       DCL-S WorkDay Zoned(1);
       DCL-S WorkDate Date;

       EXFMT Input;
       DOW NOT *IN03;
         WORKDATE =DATEIN;
         WORKDAY = DAYOFWEEK(WORKDATE);
         RESULT1 = 'The day of week ' + %char(workday);
         RESULT2 = 'That is ' + dayname(workday);
         Result3 = ' ';
         *IN90 = *ON;
         WRITE INPUT;
         EXFMT OUTPUT;
         *IN90 = *OFF;
         IF NOT *IN03;
           EXFMT INPUT;
         ENDIF;
       ENDDO;

       *INLR = *ON;
       RETURN; 