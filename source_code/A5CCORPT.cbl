       identification division.
       program-id. A5CCORPT.
       author. TALENT NYOTA.
       date-written.  07/03/2024.
      *Program Description:
      *
       environment division.
       input-output section.
       file-control.
      *
           select emp-file
               assign to INFILE
               organization is sequential.
      *
           select report-file
               assign to RPTFILE
               organization is sequential.
      *
       data division.
       file section.
      *
       fd emp-file
           data record is emp-rec
           record contains 51 characters.
      *
       01 emp-rec.
           05 emp-rec-num              pic x(3).
           05 emp-rec-name             pic x(12).
           05 emp-rec-calls            pic 999 occurs 12 times.
      *
       fd report-file
           data record is report-line
           record contains 132 characters.
      *
       01 report-line                  pic x(132).
      *
       working-storage section.
      *
      *create the necessary working storage variables
      *
       01 ws-blank-line.
          05 filler                             pic x(132).
       01 ws-constants.
           05 ws-number-of-months               pic 99   value 12.
           05 ws-month-names                    pic x(36)
                value "JULAUGSEPOCTNOVDECJANFEBMARAPRMAYJUN".
                05 ws-month-literals redefines
                   ws-month-names               pic x(3)
                                                occurs 12 times.
      *
       01 ws-calculated-fields.
           05 ws-non-zero-month-count  pic 9(2) value 0.
      *
       01 ws-eof-flag                  pic x    value 'n'.
           88 ws-end-of-file                    value "y".
      *
       01 ws-totals.
           05 ws-grand-total           pic 9(5) value 0.
           05 ws-emp-total             pic 9(5) value 0.
           05 ws-total-no-calls        pic 9(5) value 0.
           05 ws-month-zero-calls      pic 9(5) value 0.
           05 ws-total-mth-calls       pic 9(6) occurs 12 times.
           05 ws-total-mth-ops         pic 9(6) occurs 12 times.
           05 ws-avg-mth-calls         pic 9(6) occurs 12 times.
      *
       01 ws-name-line.
           05 filler                   pic x(5)
               value spaces.
           05 filler                   pic x(25)
               value '      Miguel Stoyke    '.
      *               ----+----1----+----2----+
           05 filler                   pic x(41)
               value '              Assignment 5 '.
      *               ----+----1----+----2----+----
           05 filler                   pic x(5)
               value spaces.
           05 ws-name-line-date        pic 9(6).
           05 filler                   pic x(4)
               value spaces.
           05 ws-name-line-time        pic 9(8).
           05 filler                   pic x(50)
               value spaces.
      *
       01 ws-report-heading.
           05 filler                   pic x(40)
               value spaces.
           05 filler                   pic x(40)
               value 'Call Centre Volumes for July - June     '.
      *               ----+----1----+----2----+----3----+----4
           05 filler                   pic x(40)
               value spaces.
           05 filler                   pic x(12)
               value spaces.
      *
       01 ws-heading-line1.
           05 filler                   pic x(2) value spaces.
           05 filler                   pic x(8) value 'Operator'.
           05 filler                   pic x(2) value spaces.
           05 filler                   pic x(8) value 'Operator'.
           05 filler                   pic x(6) value spaces.
           05 filler                   pic x(3) value 'Jul'.
           05 filler                   pic x(3) value spaces.
           05 filler                   pic x(3) value 'Aug'.
           05 filler                   pic x(3) value spaces.
           05 filler                   pic x(3) value 'Sep'.
           05 filler                   pic x(3) value spaces.
           05 filler                   pic x(3) value 'Oct'.
           05 filler                   pic x(3) value spaces.
           05 filler                   pic x(3) value 'Nov'.
           05 filler                   pic x(3) value spaces.
           05 filler                   pic x(3) value 'Dec'.
           05 filler                   pic x(3) value spaces.
           05 filler                   pic x(3) value 'Jan'.
           05 filler                   pic x(3) value spaces.
           05 filler                   pic x(3) value 'Feb'.
           05 filler                   pic x(3) value spaces.
           05 filler                   pic x(3) value 'Mar'.
           05 filler                   pic x(3) value spaces.
           05 filler                   pic x(3) value 'Apr'.
           05 filler                   pic x(3) value spaces.
           05 filler                   pic x(3) value 'May'.
           05 filler                   pic x(3) value spaces.
           05 filler                   pic x(3) value 'Jun'.
           05 filler                   pic x(4) value spaces.
           05 filler                   pic x(5) value 'Total'.
           05 filler                   pic x(4) value spaces.
           05 filler                   pic x(3) value 'Avg'.
           05 filler                   pic x(3) value spaces.
           05 filler                   pic x(3) value 'Rem'.
           05 filler                   pic x(3) value spaces.

      *
       01 ws-heading-line2.
           05 filler                   pic x(5) value spaces.
           05 filler                   pic x(1) value '#'.
           05 filler                   pic x(8) value spaces.
           05 filler                   pic x(4) value 'Name'.
           05 filler                   pic x(114)
               value spaces.
      *
       01 ws-detail-line.
           05 filler                   pic x(4)
               value spaces.
           05 ws-detail-line-num       pic x(3).
           05 filler                   pic x(6)
               value spaces.
           05 ws-detail-line-name      pic x(12).
           05 filler                   pic x(1)
               value spaces.
           05 ws-detail-line-months-table       occurs 12 times.
                10 ws-detail-line-months        pic zz9.
                10 filler                       pic x(3)
                    value spaces.
           05 filler                   pic x(1)
               value spaces.
           05 ws-detail-line-total     pic zzzz9.
           05 filler                   pic x(1)
               value spaces.
           05 ws-detail-line-avg       pic zzzz9.
           05 ws-detail-line-avg-text  redefines
              ws-detail-line-avg       pic x(5).
           05 filler                   pic x(3)
               value spaces.
           05 ws-detail-line-rem       pic z9.99.
           05 filler                   pic x(84)
               value spaces.
      *

       01 ws-month-ops-line.
           05 filler                   pic x(4)
               value spaces.
           05 filler                   pic x(20)
                value "Operators with calls".
           05 filler                   pic x(4)
               value spaces.
      *    05 ws-monthly-operators
      *         pic 9(5) occurs 12 times value zeros.

       01 ws-month-totals-line.
           05 filler                   pic x(4)
               value spaces.
           05 filler                   pic x(6)
                value "Totals".
           05 filler                   pic x(16)
               value spaces.
      *    05 ws-monthly-totals
      *         pic 9(6) occurs 12 times value zeros.

       01 ws-month-averages-line.
           05 filler                   pic x(4)
               value spaces.
           05 filler                   pic x(8)
                value "Averages".
           05 filler                   pic x(14)
               value spaces.
      *    05 ws-monthly-averages
      *         pic 9(3) occurs 12 times value zeros.


       01 ws-total-line1.
           05 filler                   pic x(6)
               value spaces.
           05 filler                   pic x(35)
               value "Number of operators with no calls: ".
      *               ----+----1----+----2----+----3----+
           05 ws-total-line-no-calls   pic zzzz9.
           05 filler                   pic x(86)
               value spaces.
      *
       01 ws-total-line2.
           05 filler                   pic x(6)
               value spaces.
           05 filler                   pic x(35)
               value "Number of months with no calls:    ".
      *               ----+----1----+----2----+----3----+
           05 ws-total-line-zero-mths  pic zzzz9.
           05 filler                   pic x(86)
               value spaces.
      *
       01 ws-total-line3.
           05 filler                   pic x(6)
               value spaces.
           05 filler                   pic x(35)
               value "Overall total calls:               ".
      *               ----+----1----+----2----+----3----+
           05 ws-total-line-calls      pic zzzz9.
           05 filler                   pic x(86)
               value spaces.

       01 ws-counters.
           05 ws-number-of-records         pic 9(5) value 0.
           05 ws-sub                    pic 99
                value 0.
           05 ws-non-zero-calls         pic 99.

       01 ws-calc.
           05 ws-avg-emp                   pic 9(5).
           05 ws-rem-emp                   pic 99v99.

       01 ws-month-zero-calls-array.
           05 ws-zero-calls-month
                pic 9(5) occurs 12 times value zeros.

      *
       procedure division.
      *
       000-main.
      *
      *open files
           open input  emp-file,
                output report-file.
      *
      *get the current date & time
           accept ws-name-line-date from date.
           accept ws-name-line-time from time.
      *
      *output first headings
           perform 100-print-headings.
      *
      *process input file & output results
           perform 200-read-input-file.
      *
           perform 300-process-records
               until ws-end-of-file.
      *
      *output total lines
           perform 500-print-totals.
      *
      *close files
           close emp-file
                 report-file.
      *
           stop run.
      *
       100-print-headings.
      *
           write report-line from ws-name-line
           write report-line from ws-blank-line.
      *
           write report-line from ws-report-heading
           write report-line from ws-blank-line.
      *
           write report-line from ws-heading-line1
           write report-line from ws-blank-line.
      *
           write report-line from ws-heading-line2
           write report-line from ws-blank-line.
      *
       200-read-input-file.
      *reads a line from input file & stores it in emp-rec
      *-unless eof is encountered in which case it sets ws-eof-flag to y
           read emp-file
                 at end move 'y'         to ws-eof-flag
                 not at end
                    add 1 to ws-number-of-records
           end-read.

       300-process-records.
      * reset totals vertical and horizontal
           move 0                           to ws-emp-total.
           move 0                           to ws-non-zero-calls.
      * TODO: Use Perform Varying to loop through monthly calls
      *       in each record to calculate the required values
      *       for each record and accumulate the required data
      *       for total lines

           perform 400-process-table
                varying ws-sub from 1 by 1
                until ws-sub > ws-number-of-months.

      * TODO: Implement average calculation logic
      *       as outlined in the requirments
           if ws-non-zero-calls > 0
                divide ws-emp-total by ws-non-zero-calls
                giving ws-avg-emp
                remainder ws-rem-emp

           else
                add 1                  to ws-total-no-calls
                move "ZERO"            to ws-detail-line-avg-text
                move 0                 to ws-detail-line-rem
           end-if.



      * TODO: Move required data to detail line for output
      *
           move emp-rec-num            to ws-detail-line-num.
           move emp-rec-name           to ws-detail-line-name.
           move ws-emp-total           to ws-detail-line-total.
           move ws-avg-emp             to ws-detail-line-avg.
           move ws-rem-emp             to ws-detail-line-rem.


      *
      * print detail line
           write report-line from ws-detail-line.
           write report-line from ws-blank-line.
      *
      * TODO: reset fields for next record
           move 0                      to ws-emp-total.
           move 0                      to ws-non-zero-month-count.
           move 0                      to ws-avg-emp.
           move 0                      to ws-rem-emp.


      *
      * read next record (if any)
           perform 200-read-input-file.

      * for the last three total lines
       400-process-table.
           move emp-rec-calls               (ws-sub)
                to ws-detail-line-months    (ws-sub).

           add emp-rec-calls (ws-sub)       to ws-emp-total.
           add emp-rec-calls (ws-sub)       to ws-grand-total.
           if emp-rec-calls (ws-sub) > 0 then
                add 1                   to ws-non-zero-calls
                add emp-rec-calls (ws-sub)
                    to ws-total-mth-calls (ws-sub)
                add 1                   to ws-total-mth-ops (ws-sub)
           else
                add 1 to ws-zero-calls-month (ws-sub)
           end-if.
      *add input-line value to total employee calls and
      *total overall calls.

       500-print-totals.
      *
      * TODO: Move required data to total lines for output
      *

           perform varying ws-sub from 1 by 1
                until ws-sub > ws-number-of-months
                if ws-zero-calls-month (ws-sub) = ws-number-of-records
                    add 1 to ws-month-zero-calls
                end-if
           end-perform.

           move ws-total-no-calls      to ws-total-line-no-calls.
           move ws-grand-total         to ws-total-line-calls.
           move ws-month-zero-calls    to ws-total-line-zero-mths.


      *add the last three total groups - only 1st 3 given

           write report-line from ws-month-ops-line.
           write report-line from ws-blank-line.
           write report-line from ws-month-totals-line.
           write report-line from ws-blank-line.
           write report-line from ws-month-averages-line.
           write report-line from ws-blank-line.
           write report-line from ws-blank-line.
           write report-line from ws-total-line1.
           write report-line from ws-blank-line.
           write report-line from ws-total-line2.
           write report-line from ws-blank-line.
           write report-line from ws-total-line3.
           write report-line from ws-blank-line.
      *
       end program A5CCORPT.