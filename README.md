# Getting_and_Cleaning_Data_assignment

Datasets include:

x_train.txt          - measurement data

y_train.txt          - more measurement data

subject_train.txt    - subject ID

subject_test.txt     - more subject ID

x_test.txt           - activity index

y_test.txt           - more activity index

features.txt         - measurement names (headers/column names)

actitivy_labels.txt  - decoder for the actvity index & what the activity was

Desccription of script:

•	The text files are read in.

•	The 2 subject ID files are concatenated together.  The 2 measurement data files are concatenated together.  The 2 activity index files are concatenated together.

•	Add the column names as headers for the measurement types to the measurement data file. 

•	Keep only the columns that have mean or standard deviation data in the measurement data file.

•	Join the activity index file with the activity decoder file.

•	Join all 3 files together: the measurement data file, the activity with the decoder file, and the subject ID file.

•	Melt the data by subject and activity.

•	Split the data by subject and activity while taking the mean by measurement type.

•	Write the output file, tidy_data.txt

Final output:

tidy_data.txt - a file which contains the final tidy dataset
