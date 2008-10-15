<?php

class InstitutesController extends AppController
{
	var $name = 'Institutes';
	var $helpers = array('Html', 'Form','Xml','Csv' );
	var $paginate = array(
		'limit' => 20,
		'order' => array(
			'Institute.id' => 'asc'
			)
		);
	function data(){
		//TODO: die assoziativen models werden automatisch schon mitgegeben oder über recursion abgefragt
		$this->layout = 'data';
		$this->set('buildings', $this->Institute->Building->find('list'));
		$this->set('records', $this->Institute->Record->find('list'));
		$this->set('institutes', $this->Institute->findAll());
	}
	function export(){
		// TODO: zusätzlich die records ins csv integrieren
		$this->layout = 'ajax';
		Configure::write('debug', 0);
		$this->set('data', $this->Institute->find('all'));
	}
	function admin_index(){
		$this->set('institutes', $this->paginate());
	}
	function admin_view($id = null){
		$this->Institute->id = $id;
		$this->set('institute', $this->Institute->read());
		$this->pageTitle = 'View Institute';
	}
	function admin_records($id = null){
		$this->Institute->id = $id;
		$this->set('institute', $this->Institute->read());
		$this->set('records', $this->Institute->Record->find('all'));
		$this->pageTitle = 'View Records';
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