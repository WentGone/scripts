<%@ page contentType="text/html; charset=utf-8" %> 
<%@ page language="java" %> 
<%@ page import="com.mysql.jdbc.Driver" %> 
<%@ page import="java.sql.*" %> 
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>这是连接MySQL数据库的测试</title>
</head>
<body>
<% 
        //加载驱动程序 
        String driverName="com.mysql.jdbc.Driver"; 
        //定义MySQL数据库端口
        String dbPort="3306";
        //数据库信息
        String userName="root"; 
        //密码 
        String userPasswd="123456"; 
        //数据库名 
        String dbName="mysql"; 
        //表名 
        String tableName="user"; 
        //将数据库信息字符串连接成为一个完整的url（也可以直接写成url，分开写是明了可维护性强） 
         
        String url="jdbc:mysql://localhost:"+dbPort+"/"+dbName+"?user="+userName+"&password="+userPasswd; 
        Class.forName("com.mysql.jdbc.Driver").newInstance(); 
        Connection conn=DriverManager.getConnection(url); 
        Statement stmt = conn.createStatement(); 
        String sql="SELECT user,host FROM "+tableName; 
        ResultSet rs = stmt.executeQuery(sql); 
%>
 
<center>
<table border="1" width="80%">
<tr>
<td>用户</td>
<td>主机</td>
</tr>
 
 
<%      
        while(rs.next()) { 
        String user = rs.getString(1);
        
    
        String host=rs.getString(2); 
        
        
         
%>
<tr>
<td> <%=user%></td>
<td> <%=host%></td>
</tr>
 
<%
        }
%>
</table>
</center>
<%
        out.print("<br>"); 
        out.print("ok， Database Query Successd！"); 
        rs.close(); 
        stmt.close(); 
        conn.close(); 
%>
</body>
</html>
