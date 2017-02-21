package com.chetan.source.IBMPOC;

import java.util.List;

import javax.ws.rs.DELETE;
import javax.ws.rs.DefaultValue;
import javax.ws.rs.FormParam;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.PUT;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

import com.chetan.source.dao.Database;
import com.chetan.source.model.User;

@Path("/myresource")
public class MyResource {
    
    @GET
    @Produces(MediaType.APPLICATION_JSON)
    public List<User> getAllUsers(){
    	  List<User> userList = new Database().getAllUsers();
          return userList;
    }
    
    @GET
    @Path("/{id}")
    @Produces(MediaType.APPLICATION_JSON)
    public User getUser(@PathParam("id")int user_id){
    	User user = new Database().getUser(user_id);
        return user;
    }
    
    @POST
    @Produces(MediaType.APPLICATION_JSON)
    public Response addUser(@FormParam("name")@DefaultValue(" ")String name,
    					@FormParam("email")@DefaultValue(" ")String email,
    					@FormParam("college_name")@DefaultValue(" ")String college_name,
    					@FormParam("marks")@DefaultValue("0.00")String marks){
    	
    	User user= new User();
    	user.setName(name);
    	user.setCollege_name(college_name);
    	user.setEmail(email);
    	user.setMarks(Double.parseDouble(marks));
    	
    	new Database().insertUser(user);
    	return Response.status(201).build();
    }
    
    @PUT
    @Path("/{id}")
    @Produces(MediaType.APPLICATION_JSON)
    public void updateUser(@PathParam("id")int user_id,
    						@FormParam("name")@DefaultValue("")String name,
    					@FormParam("email")@DefaultValue("")String email,
    					@FormParam("college_name")@DefaultValue("")String college_name,
    					@FormParam("marks")@DefaultValue("0.00")String marks){
    	
    	User user= new User();
    	user.setName(name);
    	user.setCollege_name(college_name);
    	user.setEmail(email);
    	user.setMarks(Double.parseDouble(marks));
    	
    	new Database().updateUser(user_id,user);
    	
    }
    
    @DELETE
    @Path("/{id}")
    @Produces(MediaType.APPLICATION_JSON)
    public void deleteUser(@PathParam("id")int user_id){
    	new Database().deleteUser(user_id);
    }
}
