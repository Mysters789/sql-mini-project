# sql-mini-project

At sparta global, we were tasked with writing SQL statements for managing a database. 

RDMS – Relational Database Management System

Database – a place where data is stored.
*	Relational Electronic ones are used to put an organized set of data.
*	Flat file databases are excel sheets for example but aren’t good for large data
*	Big data are used for storage large data that isn’t necessarily object orientated. E.g. Entity – something in real life that can be modelled in a database as a table.
 
* A row is a set of attritubes
* Columns are individual attributes of an object
* Candidate key is all column could be potential primary key
* Composite key is a primary key mixture of two or more columns to breaks a many to many into two one to many
* Remember to delete all references to foreign keys before removing a reference to a PK!
Entity Relationship Diagrams
 
TRUNCATE deletes all references to foreign keys whereas DELETE does not do so.
 
<b>Normalization</b>

Getting rid of database redundancies. 

Normal form:
*	1st: 
   *	Make everything atomic (as small as it can be). 
   *	Make sure there are no repeating groups (aka not multiple entry for a single attribute).

•	2nd: 
   *	It is already in 1st normal form.
   *	all non-key attributes are fully functional dependent on the primary key.

•	3rd: 
   *	It is in 2nd normal form
   *	There is no transitive functional dependency. i.e. when there are no non key column is functionally dependent on another non key column, which is functionally dependent on the primary key.
 
SQL is a declarative language NOT imperative, as in we worry about WHAT and not HOW it does it.
Java is imperative, as we have to write the logic behind it.

<b>SQL IS CASE INCENSITIVE LANGUAGE</b>

* GROUP BY without attgrigate functions is equivalent to DISTINT
* HAVING clause is used to filter the GROUP BY
 
<b> Joins </b> : Join is when we combine two sets of columns from different SQL tables
