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
  <h2>User Records</h2>          
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
        <form id="addUserForm" method="post" action="http://localhost:8080/IBMPOC/webapi/myresource">
	      <div class="form-group">
		    <label for="name">Name:</label>
		    <input type="text" class="form-control" id="name" name="name" autofocus required>
		  </div>
		  <div class="form-group">
		    <label for="email">Email:</label>
		    <input type="email" class="form-control" id="email" name="email" required>
		  </div>
		  <div class="form-group">
		    <label for="college_name">College Name:</label>
		    <input type="text" class="form-control" name="college_name" id="college_name" required>
		  </div>
		  
		  <div class="form-group">
		    <label for="marks">Marks:</label>
		    <input type="number" class="form-control" name="marks" id="marks" required>
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
        <form>
        	<input type="hidden" class="form-control" id="edit_id" name="edit_id">
	      <div class="form-group">
		    <label for="name">Name:</label>
		    <input type="text" class="form-control" id="edit_name" name="edit_name" autofocus required>
		  </div>
		  <div class="form-group">
		    <label for="email">Email:</label>
		    <input type="email" class="form-control" id="edit_email" name="edit_email" required>
		  </div>
		  <div class="form-group">
		    <label for="college_name">College Name:</label>
		    <input type="text" class="form-control" name="edit_college_name" id="edit_college_name" required>
		  </div>
		  
		  <div class="form-group">
		    <label for="marks">Marks:</label>
		    <input type="number" class="form-control" name="edit_marks" id="edit_marks" required>
		  </div>
		  
		  <div style="text-align:right;">
			  <button type="button" class="btn btn-default btn-primary" onclick="EditUser()">Edit User</button>
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
		$.ajax({
			type:"GET",
			url:"http://localhost:8080/IBMPOC/webapi/myresource"
		}).done(function(response) {
			console.log(response);
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
					html += "<td>"+response[i]['college_name']+"</td>";
					html += "<td>"+response[i]['marks']+"</td>";
					html += "<td><button type='button' class='btn btn-default' onclick='editUser("+response[i]['roll_no']+")'>Edit User</button>  <button type='button' class='btn btn-danger' onclick='deleteUser("+response[i]['roll_no']+")'>Delete User</button></td>";
					html += "</tr>";					
				}
			}
			
			html += "</tbody></table>";
			
			$("#data").append(html);
		});
	});	
	
	function addUser() {
		$("#addUserForm").submit();
		$("#name").val("");
		$("#email").val("");
		$("#college_name").val("");
		$("#marks").val("");
		$("#addUserModal").modal("hide");
		alert("User added successfully");
		location.reload();
	}
	
	function editUser(id) {
		var name = "";
		var email = "";
		var college_name = "";
		var marks = "";
		
		if(id == null || id == "undefined")
			id = 0;
		//alert(id);
		
		$("#edit_name").val("");
		$("#edit_email").val("");
		$("#edit_college_name").val("");
		$("#edit_marks").val("");
		
		$.ajax({
			type:"GET",
			url:"http://localhost:8080/IBMPOC/webapi/myresource/"+id
		}).done(function(response) {
			console.log(response);
			
			if(response.length > 0){
				name = response[0]['name'];
				email = response[0]['email'];
				college_name = response[0]['college_name'];
				marks = response[0]['marks'];
				
				$("#editUserModal").on('shown.bs.modal', function () {
					$("#edit_id").val(id);
					$("#edit_name").val(name);
					$("#edit_email").val(email);
					$("#edit_college_name").val(college_name);
					$("#edit_marks").val(marks);
		       });
				$("#editUserModal").modal('show');
			}
		});
	}
	
	function deleteUser(id) {
		if(id == null || id == "undefined")
			id = 0;
		
		$.ajax({
			type:"DELETE",
			url:"http://localhost:8080/IBMPOC/webapi/myresource/"+id,
			success:function(){
				alert("User Deleted Successfully");
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
</html>
 -->