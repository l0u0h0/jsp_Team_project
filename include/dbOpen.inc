<%
// DB Open: MS SQL Server
// JDBC Driver ·Îµù
Class.forName("org.gjt.mm.mysql.Driver");
// DB Open 
String dbURL = "jdbc:mysql://localhost:3306/mysql29";
conn = DriverManager.getConnection(dbURL, "root", "kbc0924"); 
%>   	
