<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin Log In</title>
        
         <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
        <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
        <script src="https://use.fontawesome.com/09901d9403.js"></script>

        <style>
              body, html {
                        height: 100%;
                      }

                      .bg { 
                        /* The image used */
                        background-image: url("https://images.pexels.com/photos/7794486/pexels-photo-7794486.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500");

                        /* Full height */
                        height: 100%; 

                        /* Center and scale the image nicely */
                        background-position: center;
                        background-repeat: no-repeat;
                        background-size: cover;
                      }	

        </style>
    </head>
    <body>
        <div class="container-fluid bg">
		<div class="col-sm-12">
			<div class="row">
				<div class="col-sm-3"></div>
				<div class="col-sm-5">
					<div class="w3-container">
					  <div class="w3-card-4" style="margin-top: 30%; width:100%;">
						<header class="w3-container w3-cyan w3-section">
						  <h1>Log In</h1>
						</header>

                                                <form action="check_admin.jsp" method="post">
                                                    <div class="w3-container">
                                                        <div class="input-group mb-3">
                                                            <div class="input-group-prepend"> 
                                                                    <span class="input-group-text"><i class="fa fa-user"></i></span>
                                                            </div>
                                                            <input type="text" placeholder="Email-id" name="email" class="form-control">
                                                        </div>
                                                        <div class="input-group mb-3">
                                                            <div class="input-group-prepend"> 
                                                                <span class="input-group-text"><i class="fa fa-key"></i></span>
                                                            </div>
                                                            <input type="password" placeholder="Password" name="password" class="form-control">
                                                        </div>
                                                    </div>

                                                    <footer class="w3-container">
                                                      <input type="submit" class="w3-button w3-section w3-cyan" value="Log In">
                                                    </footer>
                                                </form>
					  </div>
					</div>				
				</div>
				<div class="col-sm-4"></div>
			</div>
		</div>
				
	</div>
    </body>
</html>
