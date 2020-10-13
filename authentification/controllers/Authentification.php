<?php
    class Authentification{
        public $result;
        function index(){
            $routeur= new Routeur();
            if(!empty($_POST['pseudo']) && !empty($_POST['pass']))
            { 
                $etudiant=new Etudiant($_POST['pseudo'],$_POST['pass']);
                $this->result=$etudiant->authentification();
            }
            else
            {
                header('Location:'.WEBROOT.'Acceuil/index');
            }
            if($this->result=="accepted")
            {
                $routeur->addStudent($etudiant);
                
                header("Location:$etudiant->url");
            }
            if($this->result=="root")
            {
                $routeur->addStudent($etudiant);
				session_start();
				$_SESSION['root']=true;
				header('Location:'.WEBROOT.'Admin/index');
            }
            if($this->result=="inscription")
            {
				session_start();
				$_SESSION['inscription']=true;
				header('Location:'.WEBROOT.'Inscription/index');
            }
        }
    }
?>