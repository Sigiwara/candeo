<?php

class AtomicsController extends AppController
{
	var $name = 'Atomics';
	var $paginate = array(
		'limit' => 50,
		'order' => array(
			'Atomic.id' => 'asc'
			)
		);
	function admin_index(){
		$this->set('atomics', $this->paginate());
	}
	function admin_view($id = null){
		$this->Atomic->id = $id;
		$this->set('atomic', $this->Atomic->read());
		$this->pageTitle = 'View Atomic';
	}
	function data(){
		$this->layout = 'data';
		$this->set('atomics', $this->Atomic->findAll());
	}
	function admin_add(){
		if (!empty($this->data)){
			if ($this->Atomic->save($this->data)){
				$this->flash('Your Atomic has been saved.','/admin/atomics');
			}
		}
	}
	function admin_delete($id){
		$this->Atomic->del($id);
		$this->flash('The Atomic with id: '.$id.' has been deleted.', '/admin/atomics');
	}
	function admin_edit($id = null){
		$this->Atomic->id = $id;
		if (empty($this->data)){
			$this->data = $this->Atomic->read();
		}else{
			if ($this->Atomic->save($this->data['Atomic'])){
				$this->flash('Your Atomic has been updated.','/admin/atomics');
			}
		}
	}
}

?>