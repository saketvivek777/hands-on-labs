CREATE TABLE cashupsheet (
    cashupsheet_id INT PRIMARY KEY,
    pendingdeposit FLOAT,
    drafts FLOAT,
    banked FLOAT
);

CREATE TABLE cashupsheetdraft (
    draft_id INT PRIMARY KEY,
    cashupsheet_id INT,
    date DATE,
    time VARCHAR(2),
    epos FLOAT,
    cash FLOAT,
    pdq FLOAT,
    delivery FLOAT,
    difference FLOAT,
    void FLOAT,
    discount FLOAT,
    refund FLOAT,
    status VARCHAR(50),
    action VARCHAR(50),
    FOREIGN KEY (cashupsheet_id) REFERENCES cashupsheet(cashupsheet_id)
);



CREATE TABLE cashupsheetbanked (
    bank_id INT PRIMARY KEY,
    cashupsheet_id INT,
    bankeddate DATE,
    bankedday VARCHAR(2),
    cashup_sheetno INT,
    girono INT,
    bankingtotal FLOAT,
    variance FLOAT,
    sealedby VARCHAR(50),
    action VARCHAR(50),
    FOREIGN KEY (cashupsheet_id) REFERENCES cashupsheet(cashupsheet_id)
);



CREATE TABLE sheetpendingdeposit (
    deposit_id INT PRIMARY KEY,
    cashupsheet_id INT,
    date DATE,
    time VARCHAR(2),
    epos FLOAT,
    cash FLOAT,
    difference FLOAT,
    FOREIGN KEY (cashupsheet_id) REFERENCES cashupsheet(cashupsheet_id)
);






CREATE TABLE thirdparty (
    thirdparty_id INT PRIMARY KEY,
    date DATE,
    time VARCHAR(50),
    zomato FLOAT,
    justeat FLOAT,
    deliveroo FLOAT,
    ubereats FLOAT,
    totalthirdparty FLOAT
);










-- CREATE TABLE editbanking (
--     bank_id INT,
--     date DATE,
--     gironumber INT,
--     bankingtotal FLOAT,
--     bankedtotal FLOAT,
--     sealedby VARCHAR(50),
--     FOREIGN KEY (bank_id) REFERENCES banked(bank_id)
-- );



CREATE TABLE deposit (
    deposit_id INT PRIMARY KEY,
    outstanding FLOAT,
    pendingdeposit FLOAT,
    banked FLOAT
);

CREATE TABLE depobanked (
    banked_id INT PRIMARY KEY,
    bankeddate DATE,
    cashupsheets INT,
    girono INT,
    bankingtotal FLOAT,
    variance FLOAT,
    sealedby VARCHAR(50),
    action VARCHAR(50)
);






CREATE TABLE pendingdeposits (
   pendingdeposits_id INT PRIMARY KEY,
    date DATE,
    epos FLOAT,
    cash FLOAT,
    difference FLOAT
);
CREATE TABLE createnewbanking (
    newbanking_id INT PRIMARY KEY,
     pendingdeposits_id INT,
       deposit_id INT ,
    date DATE,
    giroslipno INT,
    bankingtotal FLOAT,
    bankedtotal FLOAT,
    sealedby VARCHAR(50),
    Selectedsheetdate DATE,
    reason VARCHAR(50),
    bankingdate DATE,
    FOREIGN KEY (pendingdeposits_id) REFERENCES  pendingdeposits(pendingdeposits_id),
	FOREIGN KEY ( deposit_id) REFERENCES sheetpendingdeposit( deposit_id)
);

CREATE TABLE kpis (
    kpis_id INT PRIMARY KEY,
    date DATE,
    time VARCHAR(50),
    totalcover FLOAT,
    totalrefund FLOAT,
    complaint VARCHAR(50),
    banked FLOAT,
    description VARCHAR(50),
    totaldiscount FLOAT
);
CREATE TABLE discountbreakdown (
    discountid INT PRIMARY KEY,
    bilnumbar INT,
    reason VARCHAR(50),
    amount FLOAT,
    totaldiscount FLOAT
);

CREATE TABLE refundbreakdown (
    refund_id INT PRIMARY KEY,
    billnumbar INT,
    reason VARCHAR(50),
    amount FLOAT,
    totalrefund FLOAT
);
CREATE TABLE covers (
    covers_id INT PRIMARY KEY,
    tablecover FLOAT,
    thirdpartycover FLOAT,
    takeaway FLOAT,
    void FLOAT,
    totalcover FLOAT
);


CREATE TABLE epos (
    epos_id INT PRIMARY KEY,
    date DATE,
    time VARCHAR(50),
    vattax FLOAT,
    totaltax FLOAT,
    totaltip FLOAT,
    customer_id INT,
    transaction_id INT,
    emp_id INT
);



CREATE TABLE sales (
    salesid INT PRIMARY KEY,
    epos_id INT,
    food FLOAT,
    drinks FLOAT,
    takeaway FLOAT,
    other FLOAT,
    totalsales FLOAT,
    FOREIGN KEY (epos_id) REFERENCES epos(epos_id)
);




CREATE TABLE tip (
    tip_id INT PRIMARY KEY,
    epos_id INT,
    creditcard FLOAT,
    service FLOAT,
    transaction_id INT,
    totaltip FLOAT,
    transaction_id_ INT,
    FOREIGN KEY (epos_id) REFERENCES epos(epos_id)
);



CREATE TABLE safesummary (
    safesummary_id INT PRIMARY KEY,
    date DATE,
    time VARCHAR(50),
    totalsafe FLOAT,
    witness VARCHAR(50)
);

 CREATE TABLE safe (
    safesummary_id INT,
    Count FLOAT,
    till FLOAT,
    bankedamount FLOAT,
    totalsafe FLOAT,
    FOREIGN KEY (safesummary_id) REFERENCES safesummary(safesummary_id)
);



CREATE TABLE pdqsummary (
    pdq_id INT PRIMARY KEY,
    epostakings FLOAT,
    cashtakings FLOAT,
    pdqtakings FLOAT,
    thirdpartytakings FLOAT,
    difference FLOAT
);


CREATE TABLE cashpdq (
    cashpdq_id INT PRIMARY KEY,
    date DATE,
    time VARCHAR(50),
    totalpettycash FLOAT,
    totaltill FLOAT,
    totalpdq FLOAT,
    totalwageadvance FLOAT
);


CREATE TABLE pettycash (
    petty_id INT PRIMARY KEY,
    fooddrinks FLOAT,
    repairs FLOAT,
    maintenance FLOAT,
    sundries FLOAT,
    totalpettycash FLOAT
);


CREATE TABLE wageadvanced (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    emp_dept VARCHAR(50),
    advanceprovided FLOAT,
    totalwage FLOAT
);


CREATE TABLE pdq (
    pdq_id INT PRIMARY KEY,
    visavoucher FLOAT,
    amexvoucher FLOAT,
    visaizettle FLOAT,
    amexizettle FLOAT,
    totalpdq FLOAT
);



CREATE TABLE till(
till_id INT PRIMARY KEY,
till1 FLOAT,
till2  FLOAT,
totaltill  FLOAT
);


 CREATE TABLE purchaseorder (
    p_order_id INT PRIMARY KEY,
    drafts FLOAT,
    pending FLOAT,
    approved FLOAT,
    rejected FLOAT
);

CREATE TABLE rejected (
    rejected_id INT PRIMARY KEY,
    po_number INT,
    date DATE,
    suppliername VARCHAR(50),
    typeofpo VARCHAR(50),
    value FLOAT,
    rejecteddate DATE,
    action VARCHAR(50)
);

CREATE TABLE approved (
    approved_id INT PRIMARY KEY,
    po_number INT,
    date DATE,
    suppliername VARCHAR(50),
    typeofpo VARCHAR(50),
    value FLOAT,
    status VARCHAR(50),
    action VARCHAR(50),
    items INT
);


CREATE TABLE submitted (
    submitted_id INT PRIMARY KEY,
    po_number INT,
    date DATE,
    suppliername VARCHAR(50),
    typeofpo VARCHAR(50),
    value FLOAT,
    action VARCHAR(50)
);

 CREATE TABLE drafts (
    drafts_id INT PRIMARY KEY,
    po_number INT,
    supplier VARCHAR(50),
    value FLOAT,
    pending_since TIME,
    action VARCHAR(50),
    date DATE,
    typeofpo VARCHAR(50),
    items INT,
    FOREIGN KEY (po_number) REFERENCES purchaseorder(po_number)
);


CREATE TABLE newp_o (
    newp_order_id INT PRIMARY KEY,
    productcode INT,
    productname VARCHAR(50),
    producttype VARCHAR(50),
    unit_measurement VARCHAR(50),
    priceperunit FLOAT,
    qty INT
);


CREATE TABLE reconciliation (
    reconciliation_id INT PRIMARY KEY,
    cash FLOAT,
    card FLOAT,
    thirdparty FLOAT,
    totalamount FLOAT
);


CREATE TABLE cashreconciliation (
    cashreconciliation_id INT,
    cash_id INT PRIMARY KEY,
    bankingdate DATE,
    bankingtotal FLOAT,
    bankedtotal FLOAT,
    difference FLOAT,
    bankingday VARCHAR(50),
    FOREIGN KEY (cashreconciliation_id) REFERENCES reconciliation(reconciliation_id)
);


CREATE TABLE cashdepositdetail (
    cash_id INT,
    cashdeposit_id INT PRIMARY KEY,
    depositdate DATE,
    depositday VARCHAR(50),
    cash FLOAT,
    full_match BOOLEAN,
    partialmatch BOOLEAN,
    notereason VARCHAR(50),
    FOREIGN KEY (cash_id) REFERENCES cashreconciliation(cash_id)
);

CREATE TABLE cardreconciliation (
    card_id INT PRIMARY KEY,
    bankingdate DATE,
    bankingday VARCHAR(50),
    cardamount FLOAT,
    difference FLOAT,
    apitotal FLOAT
);


CREATE TABLE carddepositdetail (
    card_id INT,
    cardtype VARCHAR(50),
    depositdate DATE,
    amount FLOAT,
    apiamount FLOAT,
    full_match BOOLEAN,
    partial_match BOOLEAN,
    notereason VARCHAR(50),
    FOREIGN KEY (card_id) REFERENCES cardreconciliation(card_id)
);


CREATE TABLE thirdpartyreconciliation (
    receiveddate DATE,
    totalpaymentreceived FLOAT,
    thirdpartydate DATE,
    thirdpartyday VARCHAR(50)
);



CREATE TABLE rec_thirdparty (
    thirdparty_id INT PRIMARY KEY,
    uber FLOAT,
    justeat FLOAT,
    zomato FLOAT,
    deliveroo FLOAT
);


CREATE TABLE thirdpartycashupsheet (
    thirdparty_id INT,
	cashupdate DATE,
    amount FLOAT,
    apiamount FLOAT,
    full_match BOOLEAN,
    partialmatch BOOLEAN,
    FOREIGN KEY (thirdparty_id) REFERENCES thirdparty(thirdparty_id)
);


CREATE TABLE periodcovereddetail (
    thirdparty_id INT,
    covereddate DATE,
    thirdpartyamount FLOAT,
    paymentreceived FLOAT,
    notereason VARCHAR(50),
    FOREIGN KEY (thirdparty_id) REFERENCES thirdparty(thirdparty_id)
);



