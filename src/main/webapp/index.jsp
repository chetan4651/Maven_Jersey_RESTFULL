
<!DOCTYPE html>
<html lang="en">
<head>
  <title>Maven Restfull Api</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<body>

<div class="container">
  <h2>User's Record</h2>          
  <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#addUserModal" style="float:right;">Add User</button>
  <div id="data"></div>
</div>


<!-- Modal -->
<div id="addUserModal" class="modal fade" role="dialog">
  <div class="modal-dialog">

   <!--  Modal content -->
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Add New User</h4>
      </div>
      <div class="modal-body">
      	<p id="add_blank" style="display:none;color:red;font-weight: 600;">Fill all Details</p>
      	<p id="add_invalid" style="display:none;color:red;font-weight: 600;">Fill proper Details</p>
        <form id="addUserForm" method="POST" action="">
	      <div class="form-group">
		    <label for="name">Name:</label>
		    <input type="text" class="form-control" id="name" name="name" autofocus pattern="[_A-Za-z]+[0-9]*" title="Enter a name" placeholder="Enter a name" required>
		  </div>
		  <div class="form-group">
		    <label for="email">Email:</label>
		    <input type="email" class="form-control" id="email" name="email" title="Enter a email" placeholder="Enter a email" required>
		  </div>
		  <div class="form-group">
		    <label for="college_name">College Name:</label>
		    <input type="text" class="form-control" name="college_name" id="college_name" pattern="[_A-Za-z]+[0-9]*" title="Enter a college name" placeholder="Enter a college name" required>
		  </div>
		  
		  <div class="form-group">
		    <label for="marks">Marks:</label>
		    <input type="number" class="form-control" name="marks" id="marks" pattern="[0-9]+[.]*[0-9]*" title="Enter marks" placeholder="Enter marks" required>
		  </div>
		  
		  <div style="text-align:right;">
			  <button type="button" class="btn btn-default btn-primary" onclick="addUser()">Add User</button>
			  <button type="reset" class="btn btn-default" data-dismiss="modal">Clear</button>
			  <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
		   </div>
		</form>
      </div>
       
    </div>

  </div>
</div>

<!-- Modal -->
<div id="editUserModal" class="modal fade" role="dialog">
  <div class="modal-dialog">

   <!--  Modal content -->
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Edit User</h4>
      </div>
      <div class="modal-body">
      	<p id="edit_blank" style="display:none;color:red;font-weight: 600;"><b>Fill all Details</b></p>
      	<p id="edit_invalid" style="display:none;color:red;font-weight: 600;"><b>Fill proper Details</b></p>
        <form>
        	<input type="hidden" class="form-control" id="edit_id" name="edit_id">
	      <div class="form-group">
		    <label for="name">Name:</label>
		    <input type="text" class="form-control" id="edit_name" name="edit_name" autofocus pattern="[_A-Za-z]+[0-9]*" title="Enter a name" placeholder="Enter a name" required>
		  </div>
		  <div class="form-group">
		    <label for="email">Email:</label>
		    <input type="email" class="form-control" id="edit_email" name="edit_email" title="Enter a email" placeholder="Enter a email" required>
		  </div>
		  <div class="form-group">
		    <label for="college_name">College Name:</label>
		    <input type="text" class="form-control" name="edit_college_name" id="edit_college_name" pattern="[_A-Za-z]+[0-9]*" title="Enter a college name" placeholder="Enter a college name" required>
		  </div>
		  
		  <div class="form-group">
		    <label for="marks">Marks:</label>
		    <input type="number" class="form-control" name="edit_marks" id="edit_marks" pattern="[0-9]+[.]*[0-9]*" title="Enter marks" placeholder="Enter marks" required>
		  </div>
		  
		  <div style="text-align:right;">
			  <button type="button" class="btn btn-default btn-primary" onclick="updateUser()">Edit User</button>
			  <button type="reset" class="btn btn-default" data-dismiss="modal">Clear</button>
			  <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
		   </div>
		</form>
      </div>
       
    </div>

  </div>
</div>

<script type="text/javascript">
	$(document).ready(function(){
		
		$("#add_blank").css("display","none");
		$("#add_invalid").css("display","none");
		$("#edit_blank").css("display","none");
		$("#edit_invalid").css("display","none");
		
		$.ajax({
			type:"GET",
			url:"http://localhost:8080/IBMPOC/webapi/myresource"
		}).done(function(response) {
			
			var html = "<table class='table table-striped'>";
				html += "<thead><tr><th>Sr No</th><th>Name</th><th>Email</th><th>College Name</th><th>Marks</th><th>Action</th></tr></thead><tbody>";
			if(response.length == 0)
			{
				html += "<tr>";
				html += "<td colspan='6'><center>no Data found</center></td>";
				html += "</tr>";
				
			}
			else
			{
				for(var i=0;i<response.length;i++)
				{
					html += "<tr>";
					html += "<td>"+(i+1)+"</td>";
					html += "<td>"+response[i]['name']+"</td>";
					html += "<td>"+response[i]['email']+"</td>";
					html += "<td>"+response[i]['college_name']+"</td>"; //data-toggle='modal'
					html += "<td>"+response[i]['marks']+"</td>";
					html += "<td><button type='button' id='editBtn"+response[i]['roll_no']+"' class='btn btn-default' onclick='editUser("+response[i]['roll_no']+")' >Edit User</button>  <button type='button' class='btn btn-danger' onclick='deleteUser("+response[i]['roll_no']+")'>Delete User</button></td>";
					html += "</tr>";					
				}
			}
			
			html += "</tbody></table>";
			
			$("#data").append(html);
		});
	});	
	
	function addUser() {
		
		var name = $("#name").val().trim();
		var email = $("#email").val().trim();
		var college_name = $("#college_name").val().trim();
		var marks = $("#marks").val().trim();
		
		var name_valid = /[_a-z]+[0-9- @]*/.test(name);
		var college_valid = /[_a-z]+[0-9- @]*/.test(college_name);
		
		if(name == "" || email == "" || college_name == "" || marks == ""){
			$("#add_blank").css("display","block");
		}
		else if(!name_valid || !college_valid)
		{		
			$("#add_blank").css("display","none");
			$("#add_invalid").css("display","block");
		}
		else{
			$("#add_blank").css("display","none");
			$("#add_invalid").css("display","none");
			
			$.ajax({
				type:"POST",
				url: "http://localhost:8080/IBMPOC/webapi/myresource",
				data:{"name":$("#name").val(),"email":$("#email").val(),"college_name":$("#college_name").val(),"marks":$("#marks").val()},
				success:function(){
					alert("User added successfully");		
					$("#name").val("");
					$("#email").val("");
					$("#college_name").val("");
					$("#marks").val("");
					$("#addUser").modal("hide");
					location.reload();
				}
			});
		}
	}
	
	function editUser(id) {
		
		$("#editUserModal").modal('hide');
		
		if(id == null || id == "undefined")
			id = 0;
		
		$("#edit_name").val("");
		$("#edit_email").val("");
		$("#edit_college_name").val("");
		$("#edit_marks").val("");
		
		$.ajax({
			type:"GET",
			url:"http://localhost:8080/IBMPOC/webapi/myresource/"+id,
			complete: function (jqXHR, status) {
				var response = jqXHR.responseJSON;
			  	var name = response['name'];
			  	var email = response['email'];
			  	var college_name = response['college_name'];
			  	var marks = response['marks'];
					
				$("#edit_id").val(id);
				$("#edit_name").val(name);
				$("#edit_email").val(email);
				$("#edit_college_name").val(college_name);
				$("#edit_marks").val(marks);
					
				$("#editBtn"+id).attr("data-toggle", "modal");
				$("#editBtn"+id).attr("data-target", "#editUserModal"); 

			  	$("#editUserModal").modal('show');			  
			}
		});
		
		
	}
	
	function updateUser() {
		
		var name = $("#edit_name").val().trim();
		var email = $("#edit_email").val().trim();
		var college_name = $("#edit_college_name").val().trim();
		var marks = $("#edit_marks").val().trim();
		
		var name_valid = /[_a-z]+[0-9- @]*/.test(name);
		var college_valid = /[_a-z]+[0-9- @]*/.test(college_name);
		
		if(name == "" || email == "" || college_name == "" || marks == ""){
			$("#edit_blank").css("display","block");
		}
		else if(!name_valid || !college_valid)
		{		
			$("#edit_blank").css("display","none");
			$("#edit_invalid").css("display","block");
		}
		else{
			$("#edit_blank").css("display","none");
			$("#edit_invalid").css("display","none");
			$.ajax({
				type:"PUT",
				url: "http://localhost:8080/IBMPOC/webapi/myresource/"+$("#edit_id").val(),
				data:{"name":$("#edit_name").val(),"email":$("#edit_email").val(),"college_name":$("#edit_college_name").val(),"marks":$("#edit_marks").val()},
				success:function(){					
					alert("User updated successfully");		
					$("#edit_id").val("");
					$("#edit_name").val("");
					$("#edit_email").val("");
					$("#edit_college_name").val("");
					$("#edit_marks").val("");
					$("#editUserModal").modal("hide");
					location.reload();
				}
			});
		}
	}
	
	function deleteUser(id) {
		
		if(id == null || id == "undefined")
			id = 0;
		
		$.ajax({
			type:"DELETE",
			url:"http://localhost:8080/IBMPOC/webapi/myresource/"+id,
			success:function(){
				alert("User deleted successfully");
			}
		});
		
		location.reload();
	}
</script>

</body>
</html>

<!-- <html>
<body>
    <h2>Jersey RESTful Web Application!</h2>
    <p><a href="webapi/myresource">Jersey resource</a>
    <p>Visit <a href="http://jersey.java.net">Project Jersey website</a>
    for more information on Jersey!
</body>
</html> -->