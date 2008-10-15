<?php

class RecordsController extends AppController
{
	var $name = 'Records';
	var $paginate = array(
		'limit' => 50,
		'order' => array(
			'Record.id' => 'asc'
			)
		);
	function data(){
		$this->layout = 'data';
		$this->set('institutes', $this->Record->Institute->find('list'));
		$this->set('atomics', $this->Record->Atomic->find('list'));
		$this->set('biologicals', $this->Record->Biological->find('list'));
		$this->set('chemicals', $this->Record->Chemical->find('list'));
		$this->set('buildings', $this->Record->Building->find('list'));
		$this->set('records', $this->Record->findAll());
	}
	function admin_index(){
		$this->set('records', $this->paginate());
	}
	function admin_view($id = null){
		$this->Record->id = $id;
		$this->set('record', $this->Record->read());
		$this->set('institutes', $this->Record->Institute->find('list'));
		$this->set('buildings', $this->Record->Building->find('list'));
		$this->pageTitle = 'View Record';
	}
	function admin_add(){
		$this->set('institutes', $this->Record->Institute->find('list'));
		if (!empty($this->data)){
			if ($this->Record->save($this->data)){
				$this->flash('Your Record has been saved.','/records/edit/'.$this->Record->id);
			}
		}
	}
	function admin_set($id){
		Configure::write('debug', 2);
		$this->set('institute', $this->Record->Institute->find($id));
		$this->set('fields', $this->Record->Field->find('all'));
		$this->set('buildings', $this->Record->Building->find('list'));
		if (!empty($this->data)) {
			$this->Record->create();
			if ($this->Record->saveAll($this->data)) {
				$this->Session->setFlash('Records saved');
				$this->redirect(array('action'=>'index'), null, true);
			} else {
				$this->Session->setFlash('Records could not be saved');
				$this->redirect(array('action'=>'index'), null, true);
			}
		}
	}
	function admin_delete($id){
		$this->Record->del($id);
		$this->flash('The Record with id: '.$id.' has been deleted.', '/admin/records');
	}
	function admin_edit($id = null){
		if (empty($this->data)){
			$this->Record->id = $id;
			$this->data = $this->Record->read();
			$this->set('institutes', $this->Record->Institute->find('list'));
			$insti = $this->Record->Institute->findById($this->data['Record']['institute_id']);
			$this->set('buildings', $insti['Building']);
		}else{
			if ($this->Record->save($this->data)){
				$this->flash('Your Record has been updated.','/admin/records');
			}
		}
	}
}

?>