<?php

class FieldsController extends AppController
{
	var $name = 'Fields';
	var $paginate = array(
		'limit' => 20,
		'order' => array(
			'Field.id' => 'asc'
			)
		);
	function admin_index(){
		$this->set('fields', $this->paginate());
	}
	function admin_view($id = null){
		$this->pageTitle = 'View Field';
		$this->Field->id = $id;
		$this->set('field', $this->Field->read());
	}
	function admin_add(){
		$this->pageTitle = 'Add Field';
		if (!empty($this->data)){
			if ($this->Field->save($this->data)){
				$this->flash('Your Field has been saved.','/admin/fields');
			}
		}
	}
	function admin_delete($id){
		$this->Field->del($id);
		//$this->flash('The Building with id: '.$id.' has been deleted.', '/buildings');
		$this->redirect('/admin/fields');
	}
	function admin_edit($id = null){
		$this->pageTitle = 'Edit Field';
		if (empty($this->data)){
			$this->Field->id = $id;
			$this->data = $this->Field->read();
		}else{
			if ($this->Field->save($this->data)){
				$this->flash('Your Field has been updated.','/admin/fields');
			}
		}
	}
}

?>