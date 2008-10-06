<?php

class BuildingsController extends AppController
{
	var $name = 'Buildings';
	var $paginate = array(
		'limit' => 50,
		'order' => array(
			'Building.id' => 'asc'
			)
		);
	function admin_index(){
		$this->set('buildings', $this->paginate());
	}
	function admin_view($id = null){
		$this->pageTitle = 'View Building';
		$this->Building->id = $id;
		$this->set('building', $this->Building->read());
	}
	function data(){
		$this->layout = 'data';
		$this->set('institutes', $this->Building->Institute->find('list'));
		$this->set('buildings', $this->Building->findAll());
	}
	function admin_add(){
		$this->pageTitle = 'Add Building';
		if (!empty($this->data)){
			if ($this->Building->save($this->data)){
				$this->flash('Your Building has been saved.','/admin/buildings');
			}
		}
	}
	function admin_delete($id){
		$this->Building->del($id);
		//$this->flash('The Building with id: '.$id.' has been deleted.', '/buildings');
		$this->redirect('/admin/buildings');
	}
	function admin_edit($id = null){
		$this->pageTitle = 'Edit Building';
		if (empty($this->data)){
			$this->Building->id = $id;
			$this->data = $this->Building->read();
		}else{
			if ($this->Building->save($this->data)){
				$this->flash('Your Building has been updated.','/admin/buildings');
			}
		}
	}
}

?>