### 📜 **README.md – Call Center Operations Report**
```markdown
# 📞 Call Center Operations Report

## 📌 Project Overview
The **Call Center Operations Report** is a COBOL-based batch application that processes call volume data for operators over a 12-month period. It calculates total and average call counts, identifies operators with the highest and lowest averages, and generates a structured report. This program runs on a **z/OS mainframe** using **COBOL** and **JCL**.

This project follows industry standards for **modular programming, structured data processing, and formatted reporting**.

---

## 📂 Directory Structure
```
Call-Center-Operations-Report/
│── 📂 source_code/           # COBOL and JCL source files
│   ├── A5CCORPT.cbl          # COBOL program for processing call volumes
│   ├── A5CL.jcl              # JCL script for compilation & linkage
│   ├── A5R.jcl               # JCL script for execution
│── 📂 documentation/         # Project-related documents
│   ├── A5-CallCenterOpReport.docx
│── 📂 test_cases/            # Sample input & expected output
│   ├── sample_input.txt
│   ├── expected_output.txt
│── 📂 results/               # Program execution outputs
│   ├── KC03E9B.DCMAFD01.CCORPT.OUT.pdf
│── README.md                 # Project overview and setup guide
│── .gitignore                # Files to be ignored by Git
```

---

## 🛠️ Technologies Used
- **COBOL** – Business-oriented programming language for mainframe applications.
- **JCL** – Job Control Language for compiling and executing the COBOL program.
- **z/OS Mainframe** – IBM's enterprise operating system.

---

## ⚙️ Features & Functionality
✅ **Processes Call Center Operator Data** – Reads an input file containing monthly call counts.  
✅ **Summarizes Operator Performance** – Calculates total calls, average calls, and remainder.  
✅ **Identifies Key Metrics** – Determines highest/lowest performing operators and busiest month.  
✅ **Handles Missing Data** – Ensures calculations skip months with zero calls.  
✅ **Formatted Call Center Report** – Outputs structured report with operators, totals, and averages.  
✅ **Batch Job Execution** – Uses JCL for automation.  

---

## 🏗️ Setup & Installation

### **1️⃣ Clone the Repository**
```bash
git clone https://github.com/devtalent2030/Call-Center-Operations-Report.git
cd Call-Center-Operations-Report
```

### **2️⃣ Run the Setup Script**
Execute the script to create all required folders and files:
```bash
./setup_a5.sh
```

### **3️⃣ Add COBOL & JCL Code**
- Place the COBOL and JCL files in the **`source_code/`** directory.

### **4️⃣ Compile & Run on Mainframe**
#### **📌 Step 1: Compile the COBOL Program**
```bash
SUBMIT 'KC03YYY.DCMAFD01.A5.JCL(A5CL)'
```
#### **📌 Step 2: Execute the Job**
```bash
SUBMIT 'KC03YYY.DCMAFD01.A5.JCL(A5R)'
```
#### **📌 Step 3: Verify the Output**
The final report will be generated in:
```bash
KC03YYY.DCMAFD01.A5.CCORPT.OUT
```

---

## 📝 Sample Input (Call Volume Data)
```
A12   JOHN        100  129   88   92  111  74   28   43  115   88   11   34
A14   ANNE         92  114  112   77  121  80   17   50  100   91   14   88
B10   ADAM          0    0    0    0    0   0    0    0    0    0    0    0
B12   JOANNE      104  129   88   92    0   0    0    0   55    0    0    8
```

---

## 📝 Expected Output (Formatted Report)
```
           Call Centre Volumes for July - June

Operator  Operator    Jul  Aug  Sep  Oct  Nov  Dec  Jan  Feb  Mar  Apr  May  Jun  Total  Avg REM

    A12      JOHN     100  129   88   92  111   74   92  114  112   77  121   80   1190   99   2
    A14      ANNE      92  114  112   77  121   80  100  129   88   92  111   74   1190   99   2
    B10      ADAM       0    0    0    0    0    0  104  129   88   92    0    0    413  103   1
    B12      JOANNE   104  129   88   92    0    0   65    0   45   67   87  100    777   86   3

Operators with calls    5     4     4     4     4     4     6     5     6     6     5     5

Totals                505   476   368   356   483   349   565   560   528   500   533   495   5718  686  14 

Averages              101   119    92    89   121    87    94   112    88    83   107    99

Number of Operators with No Calls:  1
Number of Months where Operators have No Calls:  18
Operator with the Highest Monthly Average:   B14    105
Operator with the Lowest Monthly Average:    B12     86
Month with the Highest Monthly Average:  5  NOV
Overall Total Calls:  5718
```
For a complete sample report, see the **documentation** folder.

---


## 👨‍💻 Author
**Talent Nyota**  
- **GitHub:** [devtalent2030](https://github.com/devtalent2030)  

---

🚀 **Your Call Center Report is now fully documented!** 🚀  
💡 Let me know if you need improvements or additions! 🎯
```
