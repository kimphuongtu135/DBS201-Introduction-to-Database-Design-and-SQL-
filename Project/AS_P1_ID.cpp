/*------------------------------------------
Name - ID: GROUP PROJECT #04
Tuan Phong Nguyen #148286180
Kim Phuong Tu #148886179
Luxi Liang #165936188

Date: December 1st, 2019

Purpose: MS1
--------------------------------------------*/
#define _CRT_SECURE_NO_WARNINGS
#include <mysql.h>
#include <iostream>
#include <string>
using namespace std;

struct Employee
{
	int employeeNumber;
	char lastName[50];
	char firstName[50];
	char email[100];
	char phone[50];
	char extension[10];
	char reportsTo[100];
	char jobTitle[50];
	char city[50];
};
int menu(void);
int findEmployee(MYSQL*& conn, int employeeNumber, Employee* emp);
void displayEmployee(MYSQL*& conn, Employee emp);
void displayAllEmployees(MYSQL*& conn);
MYSQL_RES* query(MYSQL*& conn, string query, const char* error = "Execution fail");
void validate(int& val, int min, int max, const char* errorMessage = "", std::istream& is = cin);


int main()
{
	// Create a connection to your MySQL database
	MYSQL* conn;
	// Initialize conn
	conn = mysql_init(0);
	// establish a connection to the MySQL server 
	conn = mysql_real_connect(conn, "mymysql.senecacollege.ca", "db_tpnguyen12", "F41lur3@Reminder", "db_tpnguyen12", 3306, nullptr, 0);

	// check if the connection is successfully established
	if (conn) {
		// If connection to the above database is established successfully
		cout << "successful connection to database" << endl;
		// Declare choice to switch between options in menu
		int choice = 0;
		// Initialize struct Employee
		Employee e = { {0} };
		// loop the menu
		do
		{
			choice = menu(); // menu() returns the chosen option (0 to 5)
			// Calling functions depend on "choice"
			switch (choice)
			{
			// Option 1) display an employee
			case 1:
				displayEmployee(conn, e); // if found an employeeID match the input No, set data members of the found employee to struct Employee e
				break;
			// Option 2) display all employee received from database
			case 2:
				displayAllEmployees(conn);
				break;
			case 3:
				cout << "Comming soon" << endl; // Not in MS1
				break;
			case 4:
				cout << "Comming soon" << endl; // Not in MS1
				break;
			case 5:
				cout << "Comming soon" << endl; // Not in MS1
				break;
			// Option 0) Exit the program
			case 0:
				cout << "[SYSTEM] Exiting... Goodbye!"; 
				break;
			default:
				cout << "[ERROR] Unknown error!" << endl;
				break;
			}
		} while (choice != 0); // "choice" = 0 will stop the loop and exit the program
	}
	else { // if cannot connect to the database ( wrong password, wrong username, etc.)
		cout << "Connection Failed: " << mysql_error(conn) << endl;
	}
	// close the connection
	mysql_close(conn);
	// return control to the caller
	return 0;
}

// Returning an integer (i.e choice), receive no arguments
int menu(void)
{
	// An array of 6 "strings", each "string" is 99 chars long
	char menu[6][100] = {
		"1. Find Employee",
		"2. Employees Report",
		"3. Add Employee",
		"4. Update Employee",
		"5. Remove Employee",
		"0. Exit"
	};
	// print out the line "HR Menu"
	cout << "********************* HR Menu *********************" << endl;
	// loop the above array "menu" and print out all the 6 strings
	for (int i = 0; i < 6; i++)
		cout << menu[i] << endl;
	// a variable to hold the input from user
	int choice = 0;
	// print out a ">"
	cout << "> ";
	// Validate "choice". Input from user will be stored in variable "choice"
	// "choice" range from 0 to 5 inclusively, if users provide wrong input (e.g. "abcas", -99, 6, ...), it will print out the "ERR" (error)
	validate(choice, 0, 5, "[ERROR] Choices range from 0 to 5: ");
	// Return the integer "choice"
	return choice;
}
// validate integer. Return an integer from user input. Conditions are applied.
void validate(int& val, int min, int max, const char* errorMessage, std::istream& is)
{
	// a bool true or false
	bool ok;
	// to track trailing chars
	char newline;
	// an input loop: if users provide wrong input (e.g. "abcas", -99, 6, ...), it will print out the "ERR" (error) AND get input again
	do {
		// "is" in this case is "cin". cin >> val. Val is an integer received from the client program (in this case: "choice")
		is >> val;
		newline = is.get(); // cin.get() : get ONE next character
		// if users don't give an integer, cin will fail.
		// Also, if newline (from the line above get a char that is not \n (i.e <ENTER>), this means trailing chars exist.
		if (is.fail() || newline != '\n') { 
			// not ok so will loop again
			ok = false;
			// clear the fail state of cin
			is.clear();
			// clear the keyboard
			is.ignore(1000, '\n');
		}
		else {
			// if users input is correct (give an int) AND there is no trailing chars
			// then verify if val ("choice") is in the range of min and max (0 to 5)
			// if val ("choice") is in range, ok will be true
			ok = val <= max && val >= min;
		}
	} while (!ok && cout << errorMessage); // while ok is NOT true, print out error message and loop again

}
// return an int: 0 is not found any employee matches the provided number, 1 is employee found.
int findEmployee(MYSQL*& conn, int employeeNumber, Employee* emp)
{
	// will return exist, the default is "not found"
	int exist = 0;
	// declare a row with class MYSQL_ROW to hold a row from a table from database
	MYSQL_ROW row;
	// declare a pointer res class MYSQL_RES to hold a result (a table from database)
	MYSQL_RES* res = nullptr;
	// query will return a table, stored in res
	res = query(conn, "SELECT ee.lastName, ee.firstName, ee.extension, ee.email, ee.jobTitle, concat(er.lastName, \" \", er.firstName) AS manager, city, phone, ee.employeeNumber FROM employees ee LEFT JOIN employees er ON ee.reportsTo = er.employeeNumber LEFT JOIN offices o ON ee.officeCode = o.officeCode;");
	// mysql_fetch_row() will take a row from "res" and store it in "row"
	row = mysql_fetch_row(res); // first result fetched
	 // if "res", or the table doesn't have any rows (records), "row" will not store any row, thus it will be nullptr
	// if "row" receives a row from mysql_fetch_row 
	if (row != nullptr) {
		// a loop to get the next row in the table, because "row" can only store one record at a time
		do
		{
			// check if row[8] exist (not null). Look at the query above, ee.lastName is row[0], ee.firstName is row[1],...
			// ee.employeeNumber is row[8]
			if (row[8]) 
				// employeeNumber is an int so must be converted to a string to compare with row[8] (ee.employeeNumber from database)
				// if match then exist = 1; else exist = 0;
				exist = row[8] == to_string(employeeNumber) ? 1 : 0;
			// if there is a matching employeeNumber
			if (exist == 1) {
				// Storing the database into struct Employee e
				emp->employeeNumber = employeeNumber; // emp.employeeNumber is an int, but row[8] is a string so it is more convenient to use the parameter
				// if row[0] exist (i.e not a null in database)
				if (row[0])
					// copy row[0] (in this case: lastName) to emp.lastName
					strcpy(emp->lastName, row[0]);
				else
					// if lastName is a null in database, then set emp.lastName to "n/a" string
					strcpy(emp->lastName, "n/a");
				// the rest is the same
				if (row[1])
					strcpy(emp->firstName, row[1]);
				else
					strcpy(emp->firstName, "n/a");
				if (row[2])
					strcpy(emp->extension, row[2]);
				else
					strcpy(emp->extension, "n/a");
				if (row[3])
					strcpy(emp->email, row[3]);
				else
					strcpy(emp->email, "n/a");
				if (row[4])
					strcpy(emp->jobTitle, row[4]);
				else
					strcpy(emp->jobTitle, "n/a");
				if (row[5])
					strcpy(emp->reportsTo, row[5]);
					else
						strcpy(emp->reportsTo, "n/a");
				if (row[6])
					strcpy(emp->city, row[6]);
				else
					strcpy(emp->city, "n/a");
				if (row[7])
					strcpy(emp->phone, row[7]);
				else
					strcpy(emp->phone, "n/a");
				break;
			}
		} while (row = mysql_fetch_row(res)); // while "row" still receive new records from "res" (res stores a table from the database, which is a result of an executed query (SELECT) )
	}
	else // if "row" does not receive anything from "res" (a table)
		cout << "[SYSTEM] The result is empty. " << endl;
	return exist;
}

// Display the information of an employee
void displayEmployee(MYSQL*& conn, Employee emp)
{
	// empNo will store the employee Number from user's input
	int empNo = 0;
	// print out a prompt
	cout << "Employee Number: ";
	// empNo will range from 0 to 9999
	validate(empNo, 0, 9999, "[ERROR] Employee Number 0-9999: ");
	// call the above findEmployee()
	if (findEmployee(conn, empNo, &emp) == 1) { // if that function returns 1 (meaning there is a matching employee)
		// print out all the details about that employee 
		cout << "Employee found!" << endl;
		cout << "EMPLOYEE INFORMATION" << endl;
		cout << "----------------------------------------" << endl;
		cout << "employeeNumber = " << emp.employeeNumber << endl;
		cout << "lastName = " << emp.lastName << endl;
		cout << "firstName = " << emp.firstName << endl;
		cout << "email = " << emp.email << endl;
		cout << "phone = " << emp.phone << endl;
		cout << "extension = " << emp.extension << endl;
		cout << "reportsTo = " << emp.reportsTo << endl;
		cout << "jobTitle = " << emp.jobTitle << endl;
		cout << "city = " << emp.city << endl;
		cout << "----------------------------------------" << endl;
	}
	// If cannot find any employees that match the provided empNo (employee Number)
	else
		cout << "Employee " << empNo << " does not exist." << endl;
	// Press Enter to continue
	cout << "\nPress Enter to continue..." << endl;
	// While the input char is not <ENTER>, clear the keyboard
	while (cin.get() != '\n');
}
void displayAllEmployees(MYSQL*& conn)
{
	// Display all employees from database
	// left justified
	cout.setf(std::ios::left);
	// the search start from 1000 (employee Number 1000 and up)
	int i = 1000;
	// a struct Employee e to hold the employee info from the search
	Employee e;
	// Print out format ----
	cout.width(10);
	cout << "E";
	cout.width(35);
	cout << "Employee Name";
	cout.width(35);
	cout << "Email";
	cout.width(20);
	cout << "Phone";
	cout.width(15);
	cout << "Ext";
	cout.width(35);
	cout << "Manager";
	cout << endl;
	cout.fill('-');
	cout.width(150);
	cout << "" << endl;
	cout.fill(' ');
	// Count the number of found employee
	int count = 0;
	// A loop to find all employee
	do
	{
		// "i" is now 1000.
		// Find the employee with the empNo 1000, if not found then increase "i"
		if (findEmployee(conn, i, &e) == 1) {
			// print out format ---
			cout.width(10);
			cout << e.employeeNumber;
			cout.width(35);
			cout << strcat(strcat(e.firstName, " "), e.lastName);
			cout.width(35);
			cout << e.email;
			cout.width(20);
			cout << e.phone;
			cout.width(15);
			cout << e.extension;
			cout.width(35);
			cout << e.reportsTo;
			cout << endl;
			// increase count if an employee is found
			count++;
		}
		// increase "i" to find the next employee
		i++;
	} while (i < 3000);
	// if after the search there is no matching employees
	if (count == 0)
		cout << "There is no employees’ information to be displayed." << endl;
	// Print out format ---
	cout.fill('-');
	cout.width(150);
	cout << "" << endl;
	cout.fill(' ');
	// Press Enter to continue
	cout << "\nPress Enter to continue..." << endl;
	while (cin.get() != '\n');
}

// a function which is used to execute a query (e.g SELECT, CREATE VIEW, ...)
// return MYSQL_RES* or so we call a table
// receive a string that is a replica to a query in DBS201 (e.g SELECT * FROM employees,...)
MYSQL_RES* query(MYSQL*& conn, string query, const char* error)
{
	// convert the string to an array of characters
	const char* q = query.c_str();
	// hold the result if the query is executed successfully or not
	int exequery;
	// to hold the table from database
	MYSQL_RES* res = nullptr;
	// execution time
	// mysql_query will execute the query "q" and return an integer
	exequery = mysql_query(conn, q);
	// if execute successfully
	if (!exequery)
		// store the result in "res"
		res = mysql_store_result(conn);
	else
		// if not, print out the error message using mysql_error()
		cout << "Error message: " << mysql_error(conn) << ": " << mysql_errno(conn) << endl;
	// return the table.
	return res;
}
