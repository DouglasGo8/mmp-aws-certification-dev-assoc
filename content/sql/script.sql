

CREATE TABLE STACK_TECH_TBL (
    ID SERIAL,
    NAME varchar(100),
    COMMENT varchar(500)
);

INSERT INTO STACK_TECH_TBL(NAME, COMMENT) VALUES('Java', 'Best Brand for Enterprise Projects');
INSERT INTO STACK_TECH_TBL(NAME, COMMENT) VALUES('Quarkus', 'Subatomic Faster Framework to Cloud Native');
INSERT INTO STACK_TECH_TBL(NAME, COMMENT) VALUES('Apache Camel', 'Best Integration Framework and EIP Patterns');
INSERT INTO STACK_TECH_TBL(NAME, COMMENT) VALUES('Node.js', 'Powerful Runtime combined with Versatile Javascript');
INSERT INTO STACK_TECH_TBL(NAME, COMMENT) VALUES('React.js', 'Powerful Lib to create performatic Applications Frontend');


SELECT * FROM STACK_TECH_TBL;