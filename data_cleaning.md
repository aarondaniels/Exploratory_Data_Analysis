# Why Is Data Cleaning Important?
Data often comes in a format that is not quite ready for efficient analysis. In fact, to perform an accurate analysis, it is of paramount importance that the data is in a tidy format.
Regardless of the programming language you use, “Data cleaning is the process of detecting and correcting (or removing) corrupt or inaccurate records from a record set, table, or database and refers to identifying incomplete, incorrect, inaccurate or irrelevant parts of the data and then replacing, modifying, or deleting the dirty or coarse data” (Wu, 2013).

# Cleaning Data in SQL
In a similar way as you have seen for Python, cleaning data in SQL includes a set of techniques that are normally performed by developers or programmers when the data doesn’t come in an easy-to-use format.
In this mini-lesson, some of the most common and important ways to clean data are presented.

# Dealing with Different Data Types
As you have learned so far, when a database is presented to you, the most common data types are numeric, string, and datetime. In the case of numeric data types, a problem you may encounter is that the data comes in a numeric data type that does not suit what that property really describes.
For example, suppose you have a table with a column Age and that this column contains floats so that the ages are really written as 10.0, 34.0, etc. In this case, it would be a good idea to convert these values to integers, as it doesn’t make sense to have an age expressed as a float.
Another issue may arise when dealing with zero values. Consider the following example. Suppose that your table also has a column titled BloodPressure, that contains zero values. This doesn’t make sense either, since the blood pressure of a living person cannot be zero. In this case, it would be a good idea to replace the zero values with more meaningful entries, such as the average blood pressure for all the individuals in that table.
In general, it is always important to deal with erroneous or NULL entries to ensure an accurate analysis. Like in Python, the two most common techniques for data cleaning in SQL are:
- Removing the entries containing missing/null values (not recommended)
- Imputing the missing/NULL entries with a numeric value (typically the mean or median of the respective column)
Another situation where you may have problems when dealing with data that is not clean is table joining. Consider the following scenario. Suppose that you want to join two tables, MedicalRecords and Prognosis, on the key PatientID. Assume further that PatientID is in integer format in the first table and in float format in the second one. When you try to join the two tables, you will encounter an error because the data types for the same column in each table are mismatched.

# Dealing with Strings
String values are also very common in databases. An issue you may face is that within the same column, values that are supposed to represent the same value are written in a different way.
For example, in the MedicalRecords table above, you may have a column, CardioExams, which represents the type of exam a patient had to undergo. If this column contains values such as “EKG” or “ECG,” which both describe the same type of exam (electrocardiogram), this may cause inaccuracy when grouping data.

# Dealing with Dates and Times
The most common problem that arises when working with data in a date or time format in SQL is that although the entries appear in date or time format, they are not actually saved as the appropriate data type.
A solution to this is to cast the original entries into the proper format to allow manipulation and analysis.
In general, when cleaning data of any data type in SQL, you must pay attention to the following:
- You must ensure that the data is in a proper format in accordance with the quantity it represents.
- You must make sure that all erroneous, missing, or NULL values are accounted for.
- You must make sure that the data across tables or within each column is consistent.
 
# Reference
Wu, Shaomin. "[A Review on Coarse Warranty Data and Analysis](https://kar.kent.ac.uk/32972/1/LatestVersionV01.pdf)." 2013.

