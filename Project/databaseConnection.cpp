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
MYSQL_RES* query(MYSQL*& conn, string query);
void validate(int& val, int min, int max, const char* errorMessage = "", std::istream& is = cin);


int main()
{
	// Create a connection to your MySQL database
	MYSQL* conn;
	conn = mysql_init(0);
	// establish a connection to the MySQL server 
	conn = mysql_real_connect(conn, "mymysql.senecacollege.ca", "db_tpnguyen12", "F41lur3@Reminder", "db_tpnguyen12", 3306, nullptr, 0);

	// check if the connection is successfully established
	if (conn) {
		cout << "successful connection to database" << endl;
		int choice = 0;
		Employee e = { {0} };
		do
		{
			choice = menu();
			switch (choice)
			{
			case 1:
				displayEmployee(conn, e);
				break;
			case 2:
				displayAllEmployees(conn);
				break;
			case 3:
				cout << "Comming soon" << endl;
				break;
			case 4:
				cout << "Comming soon" << endl;
				break;
			case 5:
				cout << "Comming soon" << endl;
				break;
			case 0:
				cout << "[SYSTEM] Ending program...\n[SYSTEM] Goodbye!";
				break;
			default:
				cout << "Unknown error!" << endl;
				break;
			}
		} while (choice != 0);
	}
	else {
		cout << "Connection Failed" << mysql_error(conn) << endl;
	}
	mysql_close(conn);

	return 0;
}



int menu(void)
{
	char menu[6][100] = {
		"1. Find Employee",
		"2. Employees Report",
		"3. Add Employee",
		"4. Update Employee",
		"5. Remove Employee",
		"0. Exit"
	};
	cout << "********************* HR Menu *********************" << endl;
	for (int i = 0; i < 6; i++)
		cout << menu[i] << endl;
	int choice = 0;
	cout << "> ";
	validate(choice, 0, 5, "[ERROR] Invalid input!\n[SUGGESTION] Value from 0-5\n> ");
	return choice;
}
void validate(int& val, int min, int max, const char* errorMessage, std::istream& is)
{
	bool ok;
	char newline;
	do {
		is >> val;
		newline = is.get();
		if (is.fail() || newline != '\n') {
			ok = false;
			is.clear();
			is.ignore(1000, '\n');
		}
		else {
			ok = val <= max && val >= min;
		}
	} while (!ok && cout << errorMessage);

}
int findEmployee(MYSQL*& conn, int employeeNumber, Employee* emp)
{
	int exist = 0;
	MYSQL_ROW row;
	MYSQL_RES* res = nullptr;
	res = query(conn, "SELECT ee.lastName, ee.firstName, ee.extension, ee.email, ee.jobTitle, concat(er.lastName, \" \", er.firstName) AS manager, city, phone, ee.employeeNumber FROM employees ee LEFT JOIN employees er ON ee.reportsTo = er.employeeNumber LEFT JOIN offices o ON ee.officeCode = o.officeCode;");
	while (row = mysql_fetch_row(res)) {
		if(row[8]) // prevent memory violation
		exist = row[8] == to_string(employeeNumber) ? 1 : 0;
		if (exist == 1) {
			emp->employeeNumber = employeeNumber; // str to int is a pain
			strcpy(emp->lastName, row[0]);
			strcpy(emp->firstName, row[1]);
			strcpy(emp->extension, row[2]);
			strcpy(emp->email, row[3]);
			strcpy(emp->jobTitle, row[4]);
			if (row[5])
				strcpy(emp->reportsTo, row[5]);
			else
				strcpy(emp->reportsTo, "n/a");
			strcpy(emp->city, row[6]);
			strcpy(emp->phone, row[7]);
			break;
		}
	}
	return exist;
}
void displayEmployee(MYSQL*& conn, Employee emp)
{
	int empNo = 0;
	cout << "Employee Number: ";
	validate(empNo, 0, 9999);
	if (findEmployee(conn, empNo, &emp) == 1) {
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
	else
		cout << "Employee " << empNo << " does not exist." << endl;
	cout << "\nPress Enter to continue..." << endl;
	while (cin.get() != '\n');
}
void displayAllEmployees(MYSQL*& conn)
{
	cout.setf(std::ios::left);
	int i = 1000;
	Employee e;
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
	do
	{
		if (findEmployee(conn, i, &e) == 1) {
			cout.width(10);
			cout << e.employeeNumber;
			cout.width(35);
			cout << strcat(e.lastName, e.firstName);
			cout.width(35);
			cout << e.email;
			cout.width(20);
			cout << e.phone;
			cout.width(15);
			cout << e.extension;
			cout.width(35);
			cout << e.reportsTo;
			cout << endl;
		}
		i++;
	} while (i < 2000);
	cout.fill('-');
	cout.width(150);
	cout << "" << endl;
	cout.fill(' ');
	cout << "\nPress Enter to continue..." << endl;
	while (cin.get() != '\n');
}
MYSQL_RES* query(MYSQL*& conn, string query)
{
	const char* q = query.c_str();
	int exequery;
	MYSQL_RES* res = nullptr;
	// execution
	exequery = mysql_query(conn, q);
	// make sure if the query has been executed successfully
	if (!exequery)
		res = mysql_store_result(conn);
	else
		cout << "Execution fail" << endl;
	return res;
}
