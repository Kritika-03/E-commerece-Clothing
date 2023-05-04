<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.*, java.sql.*, java.util.*" %>
<%@ page import="resources.constants" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div>
	<div>
		<h1>Sign Up</h1>
	</div>
	<div>
		<form action="register" method="post" enctype="multipart/form-data">
		<div>
			<label for="firstName">First Name</label><br>
			<input type="text" id="firstName" name="firstName">	
		</div>	
		<div>
			<label for="lastName">Last Name</label><br>
			<input type="text" id="lastName" name="lastName">
		</div>
		<div>		
			<label for="email">Email</label><br>
			<input type="email" id="email" name="email">	
		</div>	
		<div>
			<label for="phone">Phone Number</label><br>
			<input type="text" id="phonenumber" name="phonenumber">	
		</div>
		<div>	
			<label for="password">Password</label><br>
			<input type="password" id="password" name="password">	
		</div>
		<div>	
			<label for="role">Role</label><br>
			<select name="role" id="role">
				<option value="admin">Admin</option>
				<option value="user">User</option>
			</select>
		</div>
		<div>	
			<label for="image">Profile Image</label><br>
			<input type="file" id="image" name="image">
		</div>
		<div>	
			<input type="submit" value="Sign Up" class="submit_btn">
		</div>	
		</form>
	</div>
	</div>
	
<%
	if(request.getMethod().equalsIgnoreCase("post")){
		String first_name = request.getParameter("firstName");
		String last_name = request.getParameter("lastName");
		String email = request.getParameter("email");
		String phonenumber = request.getParameter("phonenumber");
		String password = request.getParameter("password");
		String role = request.getParameter("role");
		
		Part filePart = request.getPart("image");
	    String fileName = filePart.getSubmittedFileName();
	    InputStream fileContent = filePart.getInputStream();
	    
	    String folderPath = getServletContext().getRealPath("/images");
	    File folder = new File(folderPath);
	    if (!folder.exists()) {
	        folder.mkdir();
	    }
	    File imageFile = new File(folder, fileName);
	    try (OutputStream outside = new FileOutputStream(imageFile)) {
	        int read;
	        final byte[] bytes = new byte[1024];
	        while ((read = fileContent.read(bytes)) != -1) {
	            outside.write(bytes, 0, read);
	        }
	    }
		
	}
	
	Class.forName("com.mysql.cj.jdbc.Driver");
	Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/ecommerce_app","root","");
	PreparedStatement ps = con.prepareStatement("INSERT INTO users (first_name, last_name, email, phonenumber, password, role, user_image) VALUES(?,?,?,?,?,?,?)");
	ps.setString(1, first_name);
	ps.setString(2, last_name);
	ps.setString(3, email);
	ps.setString(4, phonenumber);
	ps.setString(5, password);
	ps.setString(6, role);
	ps.setString(7, "/images"+fileName);
	
	
	ps.executeUpdate();
	
	response.sendRedirect("login.jsp");
	
	
%>
</body>
</html>