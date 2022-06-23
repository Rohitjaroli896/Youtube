<!--sign up Modal -->
		<div class="modal fade" id="signModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle"
		  aria-hidden="true">

		  <!-- Add .modal-dialog-centered to .modal-dialog to vertically center the modal -->
                  <div class="modal-dialog modal-dialog-centered modal-notify modal-info" role="document">
                    <div class="modal-content">
                              <div class="modal-header" style="background: #87cefa">
                                    <h4 class="modal-title" style="color: white;font-size: 30px">Sign Up</h4>
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                        <span aria-hidden="true" style="color: white">&times;</span>
                                    </button>
                              </div>
                              <div class="modal-body">
                                    <label style="font-size: 20px">Name:</label>
                                    <input type="text" class="form-control w3-border-cyan" placeholder="Name" name="name" id="name"/>
                                      <br>
                                    <label style="font-size: 20px">Email:</label>
                                    <input type="text" class="form-control w3-border-cyan" placeholder="Email-Id" name="email" id="email"/>
                                      <br>
                                    <label style="font-size: 20px">Password:</label>
                                    <input type="password" class="form-control w3-border-cyan" placeholder="Password" name="password" id="password"/>
                                      <br>
                                    <label style="font-size: 20px">Mobile No:</label>
                                    <input type="text" class="form-control w3-border-cyan" placeholder="Mob no" name="mob" id="mob"/>
                                      <br>
                              </div>
                              <div class="modal-footer justify-content-center">
                                    <button name="signup_btn" class="btn btn-info" id="signup_btn">Submit</button>
                                    <button type="button" class="btn btn-outline-info waves-effect" data-dismiss="modal">Close</button>		
                              </div>
                    </div>
		  </div>
		</div>
	<!-- End sign up Modal -->
    
    <!--log in Modal -->
		<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle"
		  aria-hidden="true">

		  <!-- Add .modal-dialog-centered to .modal-dialog to vertically center the modal -->
		<div class="modal-dialog modal-dialog-centered modal-notify modal-info" role="document">
		<div class="modal-content">
			  <div class="modal-header" style="background: #0A93B1">
				<h4 class="modal-title" style="color: white;font-size: 30px">Log In</h4>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true" style="color: white">&times;</span>
                                </button>
			  </div>
			  <div class="modal-body">
				<label style="font-size: 20px">Email:</label>
				<input type="text" class="form-control w3-border-cyan" placeholder="Email-Id" name="email" id="email_id"/>
				  <br>
				<label style="font-size: 20px">Password:</label>
				<input type="password" class="form-control w3-border-cyan" placeholder="Password" name="password" id="pass"/>
				  <br>				
			  </div>
			  <div class="modal-footer justify-content-center">
				<button name="login_btn" class="btn btn-info" id="login_btn">Log In</button>
				<button type="button" class="btn btn-outline-info waves-effect" data-dismiss="modal">Close</button>		
			  </div>
			</div>
		  </div>
		</div>
	<!-- End log in Modal -->
