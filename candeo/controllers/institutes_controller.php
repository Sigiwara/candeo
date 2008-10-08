<?php

class InstitutesController extends AppController
{
	var $name = 'Institutes';
	var $paginate = array(
		'limit' => 20,
		'order' => array(
			'Institute.id' => 'asc'
			)
		);
	function data(){
		$this->layout = 'data';
		$this->set('buildings', $this->Institute->Building->find('list'));
		$this->set('records', $this->Institute->Record->find('list'));
		$this->set('institutes', $this->Institute->findAll());
	}
	function admin_index(){
		$this->set('institutes', $this->paginate());
	}
	function admin_view($id = null){
		$this->Institute->id = $id;
		$this->set('institute', $this->Institute->read());
		$this->set('records', $this->Institute->Record->find('list'));
		$this->pageTitle = 'View Institute';
	}
	function admin_add(){
		$this->set('buildings', $this->Institute->Building->find('list'));
		if (!empty($this->data)){
			if ($this->Institute->save($this->data)){
				$this->flash('Your Institute has been saved.','/admin/institutes');
			}
		}
	}
	function admin_delete($id){
		$this->Institute->del($id);
		$this->flash('The Institute with id: '.$id.' has been deleted.', '/admin/institutes');
	}
	function admin_edit($id = null){
		$this->Institute->id = $id;
		if (empty($this->data)){
			$this->data = $this->Institute->read();
			$this->set('buildings', $this->Institute->Building->find('list'));
		}else{
			if ($this->Institute->save($this->data)){
				$this->flash('Your Institute has been updated.','/admin/institutes');
			}
		}
	}
	function admin_home(){
		$this->pageTitle = 'Administration';
		$this->layout = 'admin';
	}
}

?>