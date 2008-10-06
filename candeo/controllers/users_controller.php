<?php
class UsersController extends AppController {
	var $uses = 0;
	var $name = 'Users';
	var $helpers = array('Html', 'Form' );
	
	function login(){
		$this->layout = 'default';
		if(!empty($this->data)){
			if($this->data['User']['name'] != 'admin' or $this->data['User']['password'] != 'cand30'){
				$this->Session->setFlash('Invalid user or password, please try again.');
			}else{
				$this->Session->write('admin', 1);
				$this->redirect('/admin/records/home');
			}
		}
	}
	function admin_logout(){
		$this->redirect(array('admin'=>false, 'controller'=>'users', 'action'=>'login'), 'are you shure?', true);
	}
}
?>