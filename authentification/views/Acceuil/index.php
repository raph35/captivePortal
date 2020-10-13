<!DOCTYPE html>
<html lang="fr">
<link rel="stylesheet" type="text/css" href="/authentification/views/layout/css/macss.css">
<title>Authentification</title>
<body>
    <div class="wrap-login100">
        <form class="login100-form" method="post" action="/authentification/Authentification/index">
            <span class="login100-form-title">
						Authentifiez vous!!!
					</span>


            <div class="wrap-input100 validate-input">
                <input class="input100" type="text" name="pseudo" placeholder="Pseudo">
            </div>


            <div class="wrap-input100 validate-input" data-validate="Password is required">
                <input class="input100" type="password" name="pass" placeholder="Mot de pass">
            </div>

            <div class="container-login100-form-btn">
                <button class="login100-form-btn" type="submit">
							S'authentifier
						</button>
            </div>

        </form>

        <div class="login100-more" style="background-image: url('/authentification/views/layout/images/bg-01.jpg');">
        </div>
    </div>

</body>

</html>

