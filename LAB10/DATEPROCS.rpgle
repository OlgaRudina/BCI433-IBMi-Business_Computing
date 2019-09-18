        CTL-OPT NOMAIN DatFmt (*USA);
        /COPY LAB10,DATEPROTOS WORKSTN;
        DCL-PROC DAYOFWEEK EXPORT;
          DCL-PI *N ZONED(1);
            WORKDATE DATE;
          END-PI;
          DCL-S ANYSUNDAY DATE INZ(D'04/02/1995');

          DCL-S WORKNUM PACKED(7);
          DCL-S WORKDAY ZONED(1);

          WORKNUM = %DIFF(WORKDATE: ANYSUNDAY : *D);
          WORKDAY = %REM(WORKNUM:7);

             IF WORKDAY < 1;
               WORKDAY = 7;
             ENDIF;
             RETURN WORKDAY;
        END-PROC;

        DCL-PROC DAYNAME EXPORT;
          DCL-PI *N CHAR(9);
            NUMBER ZONED(1);
          END-PI;
          DCL-DS DAYDATA;
            *N CHAR(9) INZ('Monday');
             *N CHAR(9) INZ('Tuesday');
              *N CHAR(9) INZ('Wednesday');
               *N CHAR(9) INZ('Thursday');
                *N CHAR(9) INZ('Friday');
                 *N CHAR(9) INZ('Saturday');
                  *N CHAR(9) INZ('Sunday');
                  DAYARRAY CHAR(9) DIM(7) POS(1);
          END-DS;
          RETURN DAYARRAY(NUMBER);
        END-PROC;

 