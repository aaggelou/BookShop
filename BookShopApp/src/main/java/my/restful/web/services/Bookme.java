package my.restful.web.services;
import java.sql.Blob;
import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.PUT;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import org.json.JSONObject;

import javax.ws.rs.DELETE;
import javax.ws.rs.FormParam;

import java.util.Base64;
import java.util.UUID;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.json.JSONArray;
import java.time.LocalDate;
import java.io.IOException;
import java.math.BigInteger;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;





@Path("BookShopAppService")
public class Bookme {

	static final String JDBC_DRIVER = "com.mysql.jdbc.Driver";
	static final String DB_URL = "jdbc:mysql://localhost/bookshop?autoReconnect=true&useSSL=false&allowPublicKeyRetrieval=true";

	static final String USER ="tonymaster";
	static final String PASS = "pass138";
	
	
	@POST
	@Path("/BookShop/")
	@Produces("text/plain")
	public String insertUserData(@FormParam("uniqueID") String uniqueID, @FormParam("firstname") String firstname, @FormParam("lastname") String lastname, @FormParam("telephone") String telephone, @FormParam("birth") String birth, @FormParam("address") String address,@FormParam("city") String city,@FormParam("postalcode") String postalcode, @FormParam("username1") String username1, @FormParam("password1") String password1, @FormParam("email") String email,  @FormParam("newsletter") String newsletter) {
		Connection conn = null;
		String st="";
		try {
			Class.forName("com.mysql.jdbc.Driver");
			System.out.println("Connecting to database...");
			conn = DriverManager.getConnection(DB_URL, USER, PASS);
			PreparedStatement ps12 = conn.prepareStatement("SELECT * FROM users WHERE Username=? OR Email=?");
			ps12.setString(1, username1);
			ps12.setString(2, email);
			ResultSet rs12 = ps12.executeQuery();
			int i =0;
			
			while(rs12.next()) {
				i=i+1;
			}
			if(i>0) {
			
			System.out.println("The user already exists...");
		
			st = "not ok";
			}
			else {
				
				  Date date=Date.valueOf(birth);	
				  String userStatus= "Active";
				  String newPassword=HashingPass.toHashPassword(password1);
				System.out.println("Inserting data...");
				PreparedStatement ps1 = conn.prepareStatement("INSERT INTO users (UserId, FirstName, LastName, Username, Telephone, Email, DateofBirth, Address, City, PostalCode, Password, Newsletter, UserStatus)VALUES (?, ?, ?, ?, ?, ?, ?,?,?, ?, ?, ?,?)");
				ps1.setString(1, uniqueID);
				ps1.setString(2, firstname);
				ps1.setString(3, lastname);
				ps1.setString(4, username1);
				ps1.setString(5, telephone);
				ps1.setString(6,email);
				ps1.setDate(7, date);
				ps1.setString(8, address);
				ps1.setString(9, city);
				ps1.setString(10, postalcode);
				ps1.setString(11, newPassword);
				ps1.setString(12, newsletter);
				ps1.setString(13, userStatus);
				ps1.executeUpdate();
				System.out.println("Data inserted successfully...");
				ps1.close();
				st = "ok";
				
			}
			ps12.close();
			
		} catch (SQLException | ClassNotFoundException | NoSuchAlgorithmException e ) {
			e.printStackTrace();
		}
		
		
		
		
		
		
		return st;
		
	}
	
	
	
	@POST
	@Path("/BookShopIn/")
	@Produces("text/plain")
	public String loginUser(@FormParam("username1") String username1, @FormParam("password1") String password1) {
		Connection conn = null;
		String st="";
		
		
		
		try {
			Class.forName("com.mysql.jdbc.Driver");
			System.out.println("Connecting to database...");
			String newPassword=HashingPass.toHashPassword(password1);
			conn = DriverManager.getConnection(DB_URL, USER, PASS);
			PreparedStatement ps2 = conn.prepareStatement("SELECT * FROM users WHERE Username=? AND Password=?");
			ps2.setString(1, username1);
			ps2.setString(2, newPassword);
			
			ResultSet rs2 = ps2.executeQuery();
			int i =0;
			String status="";
			while(rs2.next()) {
				status=rs2.getString("UserStatus");
				i=i+1;
			}
		
			if(i>0 && status.equals("Active")) {
			
			System.out.println("The user login...");
		
			st = "go_user";
			}
			else if(i>0 && status.equals("Temporary")) {
				System.out.println("EDO");
				System.out.println("The user has temp password");
				
				st = "go_temp_user";
			}
			else {
				
					
			
				st = "wrong validation";
				
			}
			ps2.close();
			
		} catch (SQLException | ClassNotFoundException | NoSuchAlgorithmException e ) {
			e.printStackTrace();
		}
		
		
		
		
		
		
		return st;
		
	}
	
	@POST
	@Path("/BookShopReset/")
	@Produces("text/plain")
	public String resetUser(@FormParam("email") String email) {
		Connection conn = null;
		String st="";
		
		try {
			Class.forName("com.mysql.jdbc.Driver");
			System.out.println("Connecting to database...");
			
			conn = DriverManager.getConnection(DB_URL, USER, PASS);
			PreparedStatement ps2 = conn.prepareStatement("SELECT * FROM users WHERE Email=?");
			ps2.setString(1, email);
			
			
			ResultSet rs2 = ps2.executeQuery();
			int i =0;
			
			while(rs2.next()) {
			
				i=i+1;
			}
			
			if(i>0) {
			
			System.out.println("The user resets password");
			String tempPass=CreatePassword.giveNewPassword();
			
			String newPassword=HashingPass.toHashPassword(tempPass);
			String ustatus="Temporary";
			System.out.println("Text1 " + tempPass);
			System.out.println("Text2 " + newPassword);
			System.out.println("Updating Password...");
			PreparedStatement ps1 = conn.prepareStatement("UPDATE users SET Password =?, UserStatus=? WHERE Email=?");
			ps1.setString(1, newPassword);
			ps1.setString(2, ustatus);
			ps1.setString(3, email);
			
			ps1.executeUpdate();
			System.out.println("Password has been updated...");
			ps1.close();
			String resultEmail=SendEmail.passwordNotification(tempPass, email);
			
			if(resultEmail.equals("Email sent successfully")) {
				st = "reset_user";
			}
			else {
				st = "problem";
			}
			
			}
		
			else {
				
					
			
				st = "wrong validation";
				
			}
			ps2.close();
			
		} catch (SQLException | ClassNotFoundException | NoSuchAlgorithmException | IOException e ) {
			e.printStackTrace();
		}
		
		
		
		
		
		
		return st;
		
	}
	
	
	
	
	
	
	@PUT
	@Path("/BookShopNewPass/")
	@Produces("text/plain")
	public String newPass(@FormParam("username1") String username, @FormParam("password1") String password) {
		Connection conn = null;
		String st="";
		
		try {
			Class.forName("com.mysql.jdbc.Driver");
			System.out.println("Connecting to database...");
			
			conn = DriverManager.getConnection(DB_URL, USER, PASS);
			PreparedStatement ps2 = conn.prepareStatement("SELECT * FROM users WHERE Username=?");
			ps2.setString(1, username);
		
			System.out.println("EDO");
			
			ResultSet rs2 = ps2.executeQuery();
			int i =0;
			String status="";
			while(rs2.next()) {
			
				status=rs2.getString("UserStatus");
				i=i+1;
			}
			
			if(i>0 && status.equals("Temporary")) {
				
				System.out.println("EDO2");
			System.out.println("The user changes password");
			
			
			String newPassword=HashingPass.toHashPassword(password);
			String ustatus="Active";
			
			System.out.println("Text2 " + newPassword);
			System.out.println("Updating Password...");
			PreparedStatement ps1 = conn.prepareStatement("UPDATE users SET Password =?, UserStatus=? WHERE Username=?");
			ps1.setString(1, newPassword);
			ps1.setString(2, ustatus);
			ps1.setString(3, username);
			
			ps1.executeUpdate();
			System.out.println("Password has been updated...");
			ps1.close();
			
			st = "password ok";
			}
			
			else if(i>0 && status.equals("Active")) {
				System.out.println("The user has active password");
				st = "go_active_user";
			}
				
			
		
			else {
				
					
			
				st = "wrong validation";
				
			}
			ps2.close();
			
		} catch (SQLException | ClassNotFoundException | NoSuchAlgorithmException e ) {
			e.printStackTrace();
		}
		
		
		
		
		
		
		return st;
		
	}
	
	
	@GET
	@Path("/ShowCategories/")
	@Produces("application/json")
	public String showCategory() {
		Connection conn = null;
		
		try {
			Class.forName("com.mysql.jdbc.Driver");
			System.out.println("Connecting to database...");
			conn = DriverManager.getConnection(DB_URL, USER, PASS);
			PreparedStatement ps51 = conn.prepareStatement("SELECT * FROM category");
			
		
		
			ResultSet rs55 = ps51.executeQuery();
			int c = 0;
			JSONArray ja = new JSONArray();
			while(rs55.next()){	
				JSONObject jo = new JSONObject();
				
				jo.put("categoryId", rs55.getString("CategoryID"));
				jo.put("categoryName", rs55.getString("CategoryName"));
				Blob b = rs55.getBlob("CategoryImage");
				byte[] ba = b.getBytes(1, (int) b.length());
				 String img64 = Base64.getEncoder().encodeToString(ba);
				 jo.put("categoryImage", img64);
				jo.put("categoryType", rs55.getString("ImageType"));
				jo.put("categoryDescription", rs55.getString("CategoryDescription"));
				
				ja.put(jo);
				c=c+1;
			}
			
			
			JSONObject mainObj = new JSONObject();
			mainObj.put("category", ja);
			
			
			
			
			
			ps51.close();
			
			return mainObj.toString();
			
			
		} catch (SQLException | ClassNotFoundException e ) {
			e.printStackTrace();
		}
		
		return null;
		
	}
	
	
	
	@GET
	@Path("/ShowProducts/{categoryId}")
	@Produces("application/json")
	public String showProduct(@PathParam("categoryId") String categoryId) {
		Connection conn = null;
		
		try {
			Class.forName("com.mysql.jdbc.Driver");
			System.out.println("Connecting to database...");
			System.out.println("ID: "+ categoryId);
			conn = DriverManager.getConnection(DB_URL, USER, PASS);
			PreparedStatement ps51 = conn.prepareStatement("SELECT * FROM products WHERE CategoryID = ?");
			ps51.setString(1, categoryId);
		
		
			ResultSet rs55 = ps51.executeQuery();
			int c = 0;
			JSONArray ja = new JSONArray();
			while(rs55.next()){	
				JSONObject jo = new JSONObject();
				
				jo.put("productId", rs55.getString("ProductID"));
				jo.put("productName", rs55.getString("ProductName"));
				jo.put("productPrice", rs55.getString("ProductPrice"));
				
				Blob b = rs55.getBlob("ProductImage");
				byte[] ba = b.getBytes(1, (int) b.length());
				 String img64 = Base64.getEncoder().encodeToString(ba);
				 jo.put("productImage", img64);
				jo.put("productImageType", rs55.getString("ProductImageType"));
				
				
				ja.put(jo);
				c=c+1;
			}
			
			System.out.println("plithos" + c);
			
			JSONObject mainObj = new JSONObject();
			mainObj.put("product", ja);
			
			
			
			
			
			ps51.close();
			
			return mainObj.toString();
			
			
		} catch (SQLException | ClassNotFoundException e ) {
			e.printStackTrace();
		}
		
		return null;
		
	}
	
	

	@GET
	@Path("/ShowProductDetails/{productId}")
	@Produces("application/json")
	public String showProductDetails(@PathParam("productId") String productId) {
		Connection conn = null;
		
		try {
			Class.forName("com.mysql.jdbc.Driver");
			System.out.println("Connecting to database...");
			System.out.println("ID: "+ productId);
			conn = DriverManager.getConnection(DB_URL, USER, PASS);
			PreparedStatement ps51 = conn.prepareStatement("SELECT * " +
                    "FROM products " +
                    "INNER JOIN authors ON products.AuthorID = authors.AuthorID " +
                    "INNER JOIN publishers ON products.PublisherID = publishers.PublisherID " +
                    "WHERE products.ProductID = ?");
			ps51.setString(1, productId);
		
		
			ResultSet rs55 = ps51.executeQuery();
			int c = 0;
			JSONArray ja = new JSONArray();
			while(rs55.next()){	
				JSONObject jo = new JSONObject();
				
				jo.put("productId", rs55.getString("ProductID"));
				jo.put("productName", rs55.getString("ProductName"));
				jo.put("productPrice", rs55.getString("ProductPrice"));
				jo.put("productStock", rs55.getString("ProductStock"));
				jo.put("productDescription", rs55.getString("ProductDescription"));
				jo.put("categoryId", rs55.getString("CategoryID"));
				
				Blob b = rs55.getBlob("ProductImage");
				byte[] ba = b.getBytes(1, (int) b.length());
				 String img64 = Base64.getEncoder().encodeToString(ba);
				 jo.put("productImage", img64);
				jo.put("productImageType", rs55.getString("ProductImageType"));
				jo.put("authorId", rs55.getString("AuthorID"));
				jo.put("publisherId", rs55.getString("PublisherID"));
				jo.put("authorId2", rs55.getString("AuthorID"));
				jo.put("authorName", rs55.getString("AuthorName"));
				jo.put("authorLastname", rs55.getString("AuthorLastname"));
				jo.put("publisherId2", rs55.getString("PublisherID"));
				jo.put("publisherName", rs55.getString("PublisherName"));
				jo.put("publicationYear", rs55.getString("PublicationYear"));
				jo.put("pages", rs55.getString("Pages"));
				ja.put(jo);
				c=c+1;
			}
			
			System.out.println("plithos" + c);
			
			JSONObject mainObj = new JSONObject();
			mainObj.put("productDetails", ja);
			
			
			
			
			
			ps51.close();
			
			return mainObj.toString();
			
			
		} catch (SQLException | ClassNotFoundException e ) {
			e.printStackTrace();
		}
		
		return null;
		
	}
	
	
	
	@POST
	@Path("/WishList/")
	@Produces("text/plain")
	public String addWishList(@FormParam("productId") String productId, @FormParam("username1") String username1, @FormParam("wishlistId") String wishlistId) {
		Connection conn = null;
		String st="";
		
		
		
		try {
			Class.forName("com.mysql.jdbc.Driver");
			System.out.println("Connecting to database...");
			
			conn = DriverManager.getConnection(DB_URL, USER, PASS);
			PreparedStatement ps2 = conn.prepareStatement("SELECT * FROM users WHERE Username=?");
			ps2.setString(1, username1);
			
			
			ResultSet rs2 = ps2.executeQuery();
			int i =0;
			String userID="";
			while(rs2.next()) {
				userID=rs2.getString("UserID");
				i=i+1;
			}
		
			if(i>0 ) {
				
				PreparedStatement ps3 = conn.prepareStatement("SELECT * FROM whishlist WHERE ProductID=? AND UserID=?");
				ps3.setString(1, productId);
				ps3.setString(2, userID);
				
				
				
				ResultSet rs3 = ps3.executeQuery();
				int y =0;
				
				while(rs3.next()) {
					
					y=y+1;
				}
				
				if(y>0) {
					st="the_product_exists";
				}
				else{
					System.out.println("Add to WishList");
					PreparedStatement ps1 = conn.prepareStatement("INSERT INTO  whishlist (WhishlistID, UserID, ProductID)VALUES (?, ?, ?)");
					ps1.setString(1, wishlistId);
					ps1.setString(2, userID);
					ps1.setString(3, productId);
					
					ps1.executeUpdate();
					System.out.println("Data inserted successfully...");
				
					st = "user_ok";
					ps1.close();
				}
			
			ps3.close();
			}
			
			else {
				
					
			
				st = "no_user";
				
			}
			ps2.close();
			
		} catch (SQLException | ClassNotFoundException e ) {
			e.printStackTrace();
		}
		
		
		
		
		System.out.println(st);
		
		return st;
		
	}
	
	
	@POST
	@Path("/ShowWishList/")
	@Produces("application/json")
	public String showWishList(@FormParam("username1") String username1) {
		Connection conn = null;
		
		try {
			Class.forName("com.mysql.jdbc.Driver");
			System.out.println("Connecting to database...");
			conn = DriverManager.getConnection(DB_URL, USER, PASS);
			
			
			PreparedStatement ps2 = conn.prepareStatement("SELECT * FROM users WHERE Username=?");
			ps2.setString(1, username1);
			
			
			ResultSet rs2 = ps2.executeQuery();
			int i =0;
			String userID="";
			while(rs2.next()) {
				userID=rs2.getString("UserID");
				i=i+1;
			}
			if(i>0) {
				
			
			PreparedStatement ps51 = conn.prepareStatement("SELECT * " +
                    "FROM whishlist " +
                    "INNER JOIN products ON whishlist.ProductID = products.ProductID " +
                    
                    "WHERE whishlist.UserID = ?");
			ps51.setString(1, userID);
			
		
		
			ResultSet rs55 = ps51.executeQuery();
			int c = 0;
			JSONArray ja = new JSONArray();
			while(rs55.next()){	
				JSONObject jo = new JSONObject();
				
				jo.put("wishlistId", rs55.getString("WhishlistID"));
				jo.put("userId", rs55.getString("UserID"));
				jo.put("productId", rs55.getString("ProductID"));
				jo.put("productName", rs55.getString("ProductName"));
				jo.put("productPrice", rs55.getString("ProductPrice"));
				
				Blob b = rs55.getBlob("ProductImage");
				byte[] ba = b.getBytes(1, (int) b.length());
				 String img64 = Base64.getEncoder().encodeToString(ba);
				 jo.put("productImage", img64);
				jo.put("productImageType", rs55.getString("ProductImageType"));
				
				ja.put(jo);
				c=c+1;
			}
			
			
			JSONObject mainObj = new JSONObject();
			mainObj.put("wishlist", ja);
			
			
			
			
			
			ps51.close();
			
			return mainObj.toString();
			}
			ps2.close();
			
		} catch (SQLException | ClassNotFoundException e ) {
			e.printStackTrace();
		}
		
		return null;
		
	}
	
	
	@DELETE
	@Path("/RemoveFromWishList/")
	@Produces("text/plain")
	public String deleteUser(@FormParam("userId") String userId, @FormParam("wishlistId") String wishlistId)  {
		Connection conn = null;
		String st="";
		try {
			Class.forName("com.mysql.jdbc.Driver");
			System.out.println("Connecting to database...");
			conn = DriverManager.getConnection(DB_URL, USER, PASS);
			PreparedStatement ps31 = conn.prepareStatement("SELECT * FROM whishlist WHERE WhishlistID=? AND UserID=?");
			ps31.setString(1, wishlistId);
			ps31.setString(2, userId);
			ResultSet rs31 = ps31.executeQuery();
			int i =0;
			
			while(rs31.next()) {
				i=i+1;
			}
			if(i>0) {
			
			System.out.println("Deleting items...");
			PreparedStatement ps3 = conn.prepareStatement("DELETE  FROM whishlist WHERE WhishlistID=? AND UserID=?");
			ps3.setString(1, wishlistId);
			ps3.setString(2, userId);
			ps3.executeUpdate();
			
			
			/*System.out.println(ps2);*/
			System.out.println("The product has been deleted from wishlist");
			st="delete_ok";
			ps3.close();
			
			}
			else {
				st="delete_not_ok";
			}
			
			ps31.close();
		} catch (SQLException | ClassNotFoundException e ) {
			e.printStackTrace();
		}
		
		
		return st;
	}
	
	
	@DELETE
	@Path("/CloseAccount/")
	@Produces("text/plain")
	public String deleteUser(@FormParam("username1") String username1) {
		Connection conn = null;
		String st="";
		try {
			Class.forName("com.mysql.jdbc.Driver");
			System.out.println("Connecting to database...");
			conn = DriverManager.getConnection(DB_URL, USER, PASS);
			PreparedStatement ps31 = conn.prepareStatement("SELECT * FROM users WHERE username=?");
			ps31.setString(1, username1);
			ResultSet rs31 = ps31.executeQuery();
			int i =0;
			String userID="";
			while(rs31.next()) {
				userID=rs31.getString("UserID");
				
				i=i+1;
			}
			if(i>0) {
			
			System.out.println("Deleting items...");
			PreparedStatement ps3 = conn.prepareStatement("DELETE  FROM whishlist WHERE UserID=?");
			ps3.setString(1, userID);
			ps3.executeUpdate();
			
			
			/*System.out.println(ps2);*/
			System.out.println("Whishlist has been deleted...");
			ps3.close();
			
			PreparedStatement ps4 = conn.prepareStatement("DELETE  FROM donations WHERE DonationUserID=?");
			ps4.setString(1, userID);
			ps4.executeUpdate();
			
			
			/*System.out.println(ps2);*/
			System.out.println("Donations has been deleted...");
			ps4.close();
			
			PreparedStatement ps5 = conn.prepareStatement("SELECT * FROM orders WHERE UserID=?");
			ps5.setString(1, userID);
			ResultSet rs5 = ps5.executeQuery();
			
			int y =0;
			String orderID="";
			while(rs5.next()) {
				orderID=rs5.getString("OrderID");
				
				y=y+1;
			}
			
			if(y>0) {
				PreparedStatement ps6 = conn.prepareStatement("DELETE  FROM order_details WHERE OrderID=?");
				ps6.setString(1, orderID);
				ps6.executeUpdate();
				
				System.out.println("Orders Detail have been deleted...");
				ps6.close();

				PreparedStatement ps7 = conn.prepareStatement("DELETE  FROM orders WHERE OrderID=?");
				ps7.setString(1, orderID);
				ps7.executeUpdate();
				
				System.out.println("Orders have been deleted...");
				ps7.close();
			}
			else {
				System.out.println("No orders found...");
				
			}
			
			ps5.close();
			
			System.out.println("Deleting items...");
			PreparedStatement ps8 = conn.prepareStatement("DELETE  FROM users WHERE UserID=?");
			ps8.setString(1, userID);
			ps8.executeUpdate();
			
			
			/*System.out.println(ps2);*/
			System.out.println("User has been deleted...");
			ps8.close();
			
			
			
			st="delete_ok";
			
			
			}
			
			
			
			
			
			else {
				System.out.println("The user does not exist");
				st = "not_exists";
			}
			ps31.close();
		} catch (SQLException | ClassNotFoundException e ) {
			e.printStackTrace();
		}
		
		
		return st;
	}
	
	
	@POST
	@Path("/Search/")
	@Produces("application/json")
	public String searchProduct(@FormParam("searchText") String searchText) {
		Connection conn = null;
		
		try {
			Class.forName("com.mysql.jdbc.Driver");
			System.out.println("Connecting to database...");
			System.out.println("searchText: "+ searchText);
			conn = DriverManager.getConnection(DB_URL, USER, PASS);
			PreparedStatement ps51 = conn.prepareStatement("SELECT * FROM products WHERE ProductName LIKE ?");
			ps51.setString(1, "%" + searchText + "%");
		
		
			ResultSet rs55 = ps51.executeQuery();
			int c = 0;
			JSONArray ja = new JSONArray();
			while(rs55.next()){	
				JSONObject jo = new JSONObject();
				
				jo.put("productId", rs55.getString("ProductID"));
				jo.put("productName", rs55.getString("ProductName"));
				jo.put("productPrice", rs55.getString("ProductPrice"));
				
				Blob b = rs55.getBlob("ProductImage");
				byte[] ba = b.getBytes(1, (int) b.length());
				 String img64 = Base64.getEncoder().encodeToString(ba);
				 jo.put("productImage", img64);
				jo.put("productImageType", rs55.getString("ProductImageType"));
				
				
				ja.put(jo);
				c=c+1;
			}
			
			System.out.println("plithos" + c);
			
			JSONObject mainObj = new JSONObject();
			mainObj.put("search", ja);
			
			
			
			
			
			ps51.close();
			
			return mainObj.toString();
			
			
		} catch (SQLException | ClassNotFoundException e ) {
			e.printStackTrace();
		}
		
		return null;
		
	}
	
	
	
	
	

	@POST
	@Path("/GetUserData/")
	@Produces("application/json")
	public String getUserData(@FormParam("username1") String username1) {
		Connection conn = null;
		
		try {
			Class.forName("com.mysql.jdbc.Driver");
			System.out.println("Connecting to database...");
			
			conn = DriverManager.getConnection(DB_URL, USER, PASS);
			PreparedStatement ps51 = conn.prepareStatement("SELECT * FROM users WHERE Username=?");
			ps51.setString(1, username1);
		
		
			ResultSet rs55 = ps51.executeQuery();
			int c = 0;
			JSONArray ja = new JSONArray();
			while(rs55.next()){	
				JSONObject jo = new JSONObject();
				
				jo.put("userID", rs55.getString("UserID"));
				jo.put("firstName", rs55.getString("FirstName"));
				jo.put("lastName", rs55.getString("LastName"));
				
				jo.put("lastName", rs55.getString("LastName"));
				
				jo.put("telephone", rs55.getString("Telephone"));
				
				jo.put("email", rs55.getString("Email"));
										
				ja.put(jo);
				c=c+1;
			}
			
			
			PreparedStatement ps52 = conn.prepareStatement("SELECT * FROM campaigns INNER JOIN  campaign_bebeficiaries ON campaigns.CBeneficiarySSN = campaign_bebeficiaries.CBeneficiarySSN");
			
			
			
			ResultSet rs53 = ps52.executeQuery();
			int y = 0;
			JSONArray ya = new JSONArray();
			while(rs53.next()){	
				JSONObject yo = new JSONObject();
				
				yo.put("campaignID", rs53.getString("CampaignID"));
				yo.put("cBeneficiarySSN", rs53.getString("CBeneficiarySSN"));
				yo.put("campaignTitle", rs53.getString("CampaignTitle"));
				
				yo.put("CBeneficiaryName", rs53.getString("CBeneficiaryName"));
				
		
										
				ya.put(yo);
				y=y+1;
			}
			
		
			if(c>0 && y>0) {
			
			JSONObject mainObj = new JSONObject();
			mainObj.put("userData", ja);
			mainObj.put("campaign", ya);
		
			
			
			ps52.close();
			ps51.close();
			
			return mainObj.toString();
			}
			
		} catch (SQLException | ClassNotFoundException e ) {
			e.printStackTrace();
		}
		
		return null;
		
	}
	
	
	@POST
	@Path("/MakeOrder/")
	@Produces("text/plain")
	public String makeOreder(@FormParam("firstname") String firstname, @FormParam("lastname") String lastname,  @FormParam("telephone") String telephone,  @FormParam("address") String address, @FormParam("city") String city, @FormParam("postalcode") String postalcode, @FormParam("email") String email, @FormParam("cardNumber") String cardNumber, @FormParam("cardType") String cardType, @FormParam("creditCardExpireDate") String creditCardExpireDate, @FormParam("cvv") String cvv, @FormParam("campaign") String campaign,  @FormParam("total_to_pay") String total_to_pay, @FormParam("userID") String userID, @FormParam("totalCart") String totalCart,  @FormParam("uniqueID") String uniqueID) {
		Connection conn = null;
		
		try {
			Class.forName("com.mysql.jdbc.Driver");
			System.out.println("Connecting to database...");
			System.out.println("ok");
			conn = DriverManager.getConnection(DB_URL, USER, PASS);
			PreparedStatement ps51 = conn.prepareStatement("SELECT * FROM products");
			  
			//ps51.setString(1, username1);
			JSONArray tc = new JSONArray(totalCart);
			JSONArray ya = new JSONArray();
			JSONArray ya2 = new JSONArray();
			ResultSet rs55 = ps51.executeQuery();
			int c = 0;
			int counter=0;
			boolean repeat=false;
			String abortBuy="Η αγορά δεν μπορεί να πραγματοποιηθεί για τα βιβλία: ";
			while(rs55.next()){	
				JSONObject yo = new JSONObject();
				JSONObject yo2 = new JSONObject();
				yo2.put("productName", rs55.getString("ProductName"));
				yo2.put("productPrice", rs55.getString("ProductPrice"));
				
				
				System.out.println("ok2");  
				//JSONObject jo = new JSONObject();
				for(int i=0; i < tc.length(); i++)  {
					System.out.println("ok11");
					JSONObject object = tc.getJSONObject(i); 
					System.out.println("test1"+object.getString("prdId"));
					System.out.println("test2" +rs55.getString("ProductID"));
					
					if(object.getString("prdId").equals(rs55.getString("ProductID"))) {
						System.out.println("ok1");  
						yo.put("productID", rs55.getString("ProductID"));
						yo.put("productQuantity", rs55.getString("ProductStock"));
						
						
						int cartProductQty = object.getInt("qty");
						int productStock =  Integer.parseInt(rs55.getString("ProductStock"));
						if(cartProductQty>productStock) {
							abortBuy= abortBuy+rs55.getString("ProductName")+", ";
							counter = counter+1;
						}
						repeat=true;
					}
					//System.out.println(object.getString("title"));  
					//System.out.println(object.getString("price"));  
					//System.out.println(object.getString("qty")); 
					//System.out.println(object.getString("prdId")); 
					
					
					
				}
				if(repeat==true) {
				ya.put(yo);
				}
				
				ya2.put(yo2);
				repeat=false;
				c=c+1;
			}
			
			
			
			if(counter>0)	{
				abortBuy=abortBuy.replaceAll(",\\s*$", "");
				System.out.println("Backend Print: "+abortBuy);
				return abortBuy;
				
			}
			
			else {
				System.out.println("ok3");  
				PreparedStatement ps52 = conn.prepareStatement("SELECT * FROM users WHERE UserID=?");
				ps52.setString(1, userID);
				ResultSet rs56 = ps52.executeQuery();
				 int y=0;
				 String newsletter="";
				 while(rs56.next()){
					 newsletter= rs56.getString("Newsletter");			 
					 y=y+1;
				 }
				
				 if(y>0) {
					 System.out.println(tc.length());  
					 System.out.println(ya.length()); 
					 if(tc.length()==ya.length()) {
						 System.out.println("ok5");  
					 
					 for(int i=0; i < tc.length(); i++)  {
						 System.out.println("ok6");  
						 JSONObject object3 = tc.getJSONObject(i); 
						 JSONObject productObject = ya.getJSONObject(i); 
						 if(object3.getString("prdId").equals(productObject.getString("productID"))) {
					 PreparedStatement ps1 = conn.prepareStatement("UPDATE products SET ProductStock =? WHERE ProductID=?");
					 
					 	int cartProductQty = object3.getInt("qty");
						int productStock =  Integer.parseInt(productObject.getString("productQuantity"));
						int newProductStock = productStock-cartProductQty;
						String finalProductStock = Integer.toString(newProductStock);
						ps1.setString(1,finalProductStock);
						ps1.setString(2, object3.getString("prdId"));
						
						
						ps1.executeUpdate();
						System.out.println("Product "+object3.getString("prdId")+" has been updated...");
						ps1.close();
						 }
				 }
				
					 
					 // Get the current date
				        LocalDate currentDate = LocalDate.now();
				        Date sqlCurrentDate=Date.valueOf(currentDate);
					 
					 Date expireDate=Date.valueOf(creditCardExpireDate);
					 
					// Convert java.sql.Date to LocalDate
				        LocalDate localDate = sqlCurrentDate.toLocalDate();

				        // Increment the date by 3 days
				        LocalDate incrementedDate = localDate.plusDays(3);

				        // Convert back to java.sql.Date
				        Date updatedDate = Date.valueOf(incrementedDate);
				        
				    
				        
				        
				        PreparedStatement ps35 = conn.prepareStatement("INSERT INTO orders (OrderID, UserID, OrderDate, TotalValue, Status, ShipDate, ShipAdress, ShipPostalCode, CreditCardNumber, CreditCardType, CreditCardExpireDate, CreditCardCVV)VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?,?,?)");
				        ps35.setString(1, uniqueID);
				        ps35.setString(2, userID);
				        ps35.setDate(3, sqlCurrentDate);
				        ps35.setString(4, total_to_pay);
				        ps35.setString(5, "Active");
				        ps35.setDate(6, updatedDate);
				        ps35.setString(7, address);
				        ps35.setString(8, postalcode);
				        ps35.setString(9, cardNumber);
				        ps35.setString(10, cardType);
				        ps35.setDate(11, expireDate);
				        ps35.setString(12, cvv);
				    	ps35.executeUpdate();
				    	
				    	System.out.println("Data inserted successfully...");
				    	
				    	ps35.close();
				    	
				    	for(int i=0; i < tc.length(); i++)  {
				    		JSONObject object4 = tc.getJSONObject(i); 
				    		JSONObject productObject2 = ya.getJSONObject(i);
				    		if(object4.getString("prdId").equals(productObject2.getString("productID"))) {
				    		 PreparedStatement ps36 = conn.prepareStatement("INSERT INTO order_details (OrderID, ProductID, Quantity, Price, Discount)VALUES (?, ?, ?, ?, ?)");
				    		
				    		 String input = object4.getString("price");
				    		 String pattern = "\\d+[,.]\\d+";
				    		 
				    		 String newPrice="";
				    		 
				    		Pattern regex = Pattern.compile(pattern);
				    	       Matcher matcher = regex.matcher(input);
				    	       
				    	       
				    	       if (matcher.find()) {
				    	            // Extract the matched word
				    	            String result = matcher.group();
				    	            result = result.replace(',', '.');
				    	            newPrice=result;
				    	            
				    	        } else {
				    	            // Handle the case when the pattern is not found
				    	            System.out.println("Pattern not found in the input string.");
				    	        }
				    	       
				    	       
				    	       ps36.setString(1, uniqueID);
				    	       ps36.setString(2, object4.getString("prdId"));
				    	       ps36.setInt(3, object4.getInt("qty"));
				    	       ps36.setDouble(4, Double.parseDouble(newPrice));
				    	       ps36.setDouble(5, 0.00);
				    	   		ps36.executeUpdate();
				    	   		System.out.println("Data inserted successfully...");
						    	
						    	ps36.close();
				    	       
				    	       
				    	       
				    		}
				    		
				    		
				    		
				    	}
				    	
				    	
				    
				    	System.out.println(!campaign.equals("noCampaign"));
				    	System.out.println(campaign);
				    	if(!campaign.equals("noCampaign")) {
				    		System.out.println("go");
						 String donationID = UUID.randomUUID().toString();
						 donationID = "D"+donationID;
						 
						 
					 System.out.println("Inserting data...");
						PreparedStatement ps2 = conn.prepareStatement("INSERT INTO donations (DonationID, DonationUserID, CampaignID, OrderID, DonationTotal)VALUES (?, ?, ?, ?, ?)");
						 ps2.setString(1, donationID);
						 ps2.setString(2, userID);
						 ps2.setString(3, campaign);
						 ps2.setString(4, uniqueID);
						 ps2.setString(5, total_to_pay);
							System.out.println(uniqueID);
						 ps2.executeUpdate();
						
						System.out.println("Data inserted successfully...");
						ps2.close();
						
					 }
				    	
				    	
				    	
				    	
					 
					 } 
					 else {
						 return "no_same_length_of_products";
						 
					 }
					 
				 }
				
				 else {
					 return "no_user"; 
					 
					 
				 }
				 ps52.close();
				 
				 ps51.close();
				 
				 
				 String resultEmail = SendEmail.receiptNotification(email,total_to_pay,tc);
				if(newsletter.equals("yes")) {
					 System.out.println("SENDING EMAIL AGAIN");
					 String resultEmail2 = SendEmail.newsletterNotification(email,ya2);
					
				}
					
				 return "ok";
					
			}
			
			
			
		} catch (SQLException | ClassNotFoundException | IOException e ) {
			e.printStackTrace();
		}
		
		return "problem";
		
	}
	
	
	
	@POST
	@Path("/ShoWOrders/")
	@Produces("application/json")
	public String showOrder(@FormParam("username1") String username1) {
		Connection conn = null;
		
		try {
			Class.forName("com.mysql.jdbc.Driver");
			System.out.println("Connecting to database...");
			conn = DriverManager.getConnection(DB_URL, USER, PASS);
			System.out.println("Test");
			PreparedStatement ps2 = conn.prepareStatement("SELECT * FROM users WHERE Username=?");
			ps2.setString(1, username1);
			
			ResultSet rs2 = ps2.executeQuery();
			String userID="";
			int i =0;
			
			while(rs2.next()) {
				userID=rs2.getString("UserID");
				i=i+1;
			}
		
			
			
			
			if(i>0) {
			
			
			PreparedStatement ps51 = conn.prepareStatement("SELECT * FROM orders WHERE UserID=?");
			ps51.setString(1, userID);
		
			
			ResultSet rs55 = ps51.executeQuery();
			int c = 0;
			JSONArray ja = new JSONArray();
			while(rs55.next()){	
				JSONObject jo = new JSONObject();
				
				jo.put("orderID", rs55.getString("OrderID"));
				jo.put("userID", rs55.getString("UserID"));
				
				jo.put("orderDate", rs55.getString("OrderDate"));
				
				jo.put("totalValue", rs55.getString("TotalValue"));
				jo.put("shipDate", rs55.getString("ShipDate"));
				jo.put("status", rs55.getString("Status"));
				jo.put("shipAdress", rs55.getString("ShipAdress"));
				jo.put("shipPostalCode", rs55.getString("ShipPostalCode"));
				
				
				ja.put(jo);
				c=c+1;
			}
			
			
			JSONObject mainObj = new JSONObject();
			mainObj.put("orders", ja);
			
			
			
			
			
			ps51.close();
			ps2.close();
			return mainObj.toString();
		}
			
			
		} catch (SQLException | ClassNotFoundException e ) {
			e.printStackTrace();
		}
		
		return null;
		
	}
	
	@POST
	@Path("/GetNewsletterData/")
	@Produces("text/plain")
	public String showNewsletter(@FormParam("username1") String username1) {
		Connection conn = null;
		
		try {
			Class.forName("com.mysql.jdbc.Driver");
			System.out.println("Connecting to database...");
			conn = DriverManager.getConnection(DB_URL, USER, PASS);
			System.out.println("Test");
			PreparedStatement ps2 = conn.prepareStatement("SELECT * FROM users WHERE Username=?");
			ps2.setString(1, username1);
			
			ResultSet rs2 = ps2.executeQuery();
			String newsletter="";
			int i =0;
			
			while(rs2.next()) {
				newsletter=rs2.getString("Newsletter");
				i=i+1;
			}
		
			
			
			
			if(i>0) {
			
			
			return newsletter;
		}
			
			
		} catch (SQLException | ClassNotFoundException e ) {
			e.printStackTrace();
		}
		
		return "no newsletter";
		
	}
	
	

	@PUT
	@Path("/ChangeNewsletters/")
	@Produces("text/plain")
	public String changeNewss(@FormParam("username1") String username1, @FormParam("nstatus") String nstatus) {
		Connection conn = null;
		String st="";
		
		try {
			Class.forName("com.mysql.jdbc.Driver");
			System.out.println("Connecting to database...");
			
			conn = DriverManager.getConnection(DB_URL, USER, PASS);
			PreparedStatement ps2 = conn.prepareStatement("SELECT * FROM users WHERE Username=?");
			ps2.setString(1, username1);
		
			String userID="";
			
			ResultSet rs2 = ps2.executeQuery();
			int i =0;
			
			while(rs2.next()) {
				userID= rs2.getString("UserID");
				i=i+1;
			}
			
			if(i>0) {
				
				
			System.out.println("The user changes newsletters");
			System.out.println(nstatus);
			PreparedStatement ps1 = conn.prepareStatement("UPDATE users SET Newsletter =? WHERE UserID=?");
			ps1.setString(1, nstatus);
			ps1.setString(2, userID);
			
			ps1.executeUpdate();
			System.out.println("Newswletter has been updated...");
			ps1.close();
			
			st = "news_ok";
			}
				
			
		
			else {
			
				st = "news_not_ok";
				
			}
			ps2.close();
			
		} catch (SQLException | ClassNotFoundException e ) {
			e.printStackTrace();
		}
		
		return st;
		
	}
	
	
	@GET
	@Path("/ShowCampaign/")
	@Produces("application/json")
	public String showCampaign() {
		Connection conn = null;
		
		try {
			Class.forName("com.mysql.jdbc.Driver");
			System.out.println("Connecting to database...");
			conn = DriverManager.getConnection(DB_URL, USER, PASS);
			PreparedStatement ps51 = conn.prepareStatement("SELECT * " +
                    "FROM campaigns " +
                    "INNER JOIN campaign_bebeficiaries ON campaigns.CBeneficiarySSN = campaign_bebeficiaries.CBeneficiarySSN");
		;
			
		
		
			ResultSet rs55 = ps51.executeQuery();
			int c = 0;
			JSONArray ja = new JSONArray();
			while(rs55.next()){	
				JSONObject jo = new JSONObject();
				
				jo.put("cBeneficiarySSN", rs55.getString("CBeneficiarySSN"));
				jo.put("campaignTitle", rs55.getString("CampaignTitle"));
				jo.put("cBeneficiaryName", rs55.getString("CBeneficiaryName"));
				jo.put("campaignStartDate", rs55.getString("CampaignStartDate"));
				
				ja.put(jo);
				c=c+1;
			}
			
			
			JSONObject mainObj = new JSONObject();
			mainObj.put("campaign", ja);
			
			
			
			
			
			ps51.close();
			
			return mainObj.toString();
			
			
		} catch (SQLException | ClassNotFoundException e ) {
			e.printStackTrace();
		}
		
		return null;
		
	}
	
	
	
	
	
	
	
	
	
}
