---
author: John Doe
lang: en-GB
# can be a real file, just for convenience generating inline
include-before: |
 \begin{filecontents*}{services.csv}
 service provider,service,iaas,paas,saas
 AWS,EC2,Y,N,N
 AWS,DynamoDB,N,Y,N
 GCP,Cloud DNS,N,Y,N
 Azure,Cosmos DB,N,Y,N
 \end{filecontents*}

---

# CSV to table


Here's a cool CSV table:

\pgfplotstabletypeset[
    col sep=comma,
    string type,
    every head row/.style={
        before row={\hline\multicolumn{2}{c}{Cloud service}&\\},
        after row=\hline
    },
    every last row/.style={after row=\hline},
    columns/service provider/.style={column name=Service provider, column type=l},
    columns/service/.style={column name=Service, column type=l},
    columns/iaas/.style={column name=IaaS, column type=c},
    columns/paas/.style={column name=PaaS, column type=c},
    columns/saas/.style={column name=SaaS, column type=c}
    ]{services.csv}
Table 1. Example table, referencing doesn't compute

