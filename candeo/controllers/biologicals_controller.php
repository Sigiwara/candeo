<?php

class BiologicalsController extends AppController
{
	var $name = 'Biologicals';
	var $paginate = array(
		'limit' => 50,
		'order' => array(
			'Biological.id' => 'asc'
			)
		);
	function admin_index(){
		$this->set('biologicals', $this->paginate());
	}
	function admin_view($id = null){
		$this->Biological->id = $id;
		$this->set('biological', $this->Biological->read());
		$this->pageTitle = 'View Biological';
	}
	function data(){
		$this->layout = 'data';
		$this->set('biologicals', $this->Biological->findAll());
	}
	function admin_add(){
		if (!empty($this->data)){
			if ($this->Biological->save($this->data)){
				$this->flash('Your Biological has been saved.','/admin/biologicals');
			}
		}
	}
	function admin_delete($id){
		$this->Biological->del($id);
		$this->flash('The Biological with id: '.$id.' has been deleted.', '/admin/biologicals');
	}
	function admin_edit($id = null){
		if (empty($this->data)){
			$this->Biological->id = $id;
			$this->data = $this->Biological->read();
		}else{
			if ($this->Biological->save($this->data['Biological'])){
				$this->flash('Your Biological has been updated.','/admin/biologicals');
			}
		}
	}
}

?>